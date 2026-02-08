uniform sampler2D sampler0;
uniform sampler2D lightmap;
uniform sampler2D vismap;
uniform sampler2D vismapPrevious;
uniform sampler2D observers;
uniform sampler2D outdoors;

uniform float vismapBlend;
uniform int blackAndWhite;
uniform int noTexture;
uniform int renderFow;
uniform float bitDepth;
uniform float overcast;
uniform float heatwave;
uniform int cullIndoors;

varying vec2 currentPosition;



// ============================================================================
// Main function

void main(void)
{
    vec4 lightMapSample = texture2D( lightmap, currentPosition );
    
    vec4 finalColor = gl_Color * lightMapSample;   

    if( noTexture == 0 )
    {
        vec4 spriteSample = texture2D( sampler0, gl_TexCoord[0].xy );    
        finalColor *= spriteSample;
    }


    //
    // Greyscale based on vismap
	// Or on B&W overlay for flashbacks
	
    float magnitude = 1.0;                                //(visMapSample.r + visMapSample.g + visMapSample.b) / 3.0;
	if( blackAndWhite == 1 ) magnitude = 0.1;
    

	//
	// Take the colour out the outdoor cells if the weather is overcast

	if( overcast > 0.0) 
	{
		vec4 outdoorMapSample = texture2D( outdoors, currentPosition );		
		magnitude = 1.0 - (overcast * 0.5 * outdoorMapSample.r );
	}
	
    if( magnitude < 0.99 )
    {
        // Reduce colour bit depth

        if( blackAndWhite == 1 )
        {
            finalColor.r = float( int( finalColor.r * bitDepth )) / bitDepth;
            finalColor.g = float( int( finalColor.g * bitDepth )) / bitDepth;
            finalColor.b = float( int( finalColor.b * bitDepth )) / bitDepth;
        }

        // Grey out final colour

        float average = (finalColor.r + finalColor.g + finalColor.b) / 3.0;        
        average *= 0.85;

        finalColor.r = finalColor.r * magnitude + average * (1.0-magnitude);
        finalColor.g = finalColor.g * magnitude + average * (1.0-magnitude);
        finalColor.b = finalColor.b * magnitude + average * (1.0-magnitude);       
    }
    

	//
	// Heatwave makes the outdoor look brighter

    if( heatwave > 0.0 && texture2D( outdoors, currentPosition ).r > 0.5)
    {
        vec4 heatwaveColour;
        heatwaveColour.r = 1.0;
        heatwaveColour.g = 0.98;
        heatwaveColour.b = 0.6;
        
        finalColor.r = finalColor.r + (heatwaveColour.r * 0.175 * heatwave);
		finalColor.g = finalColor.g + (heatwaveColour.g * 0.175 * heatwave);
		finalColor.b = finalColor.b + (heatwaveColour.b * 0.175 * heatwave);

        if( finalColor.r > 1.0 ) finalColor.r = 1.0;
        if( finalColor.g > 1.0 ) finalColor.g = 1.0;
        if( finalColor.b > 1.0 ) finalColor.b = 1.0;
    }



    //
    // Darken/greyscale areas that are under fog of war
    // Our vismap sample is a blend of the current vismap and the previous
    if ( renderFow == 1 )
    {
        vec4 observerSample = texture2D( observers, vec2(currentPosition.x, 1.0-currentPosition.y) );

        vec4 visMapSample = (texture2D( vismap,          currentPosition ) * vismapBlend)
                          + (texture2D( vismapPrevious,  currentPosition ) * ( 1.0 - vismapBlend ));

        if( visMapSample[3] > 0.0 )
        {
            float magnitude = 1.0 - visMapSample[3];
            
            // Take into account view cones
            magnitude += observerSample[0];
            if( magnitude > 1.0 ) magnitude = 1.0;
            
            float average = (finalColor.r + finalColor.g + finalColor.b) / 3.0;        
            average *= 0.5;

            finalColor.r = finalColor.r * magnitude + average * (1.0-magnitude);
            finalColor.g = finalColor.g * magnitude + average * (1.0-magnitude);
            finalColor.b = finalColor.b * magnitude + average * (1.0-magnitude);
        }
    }
    
    if( cullIndoors == 1 )
    {
        vec4 outdoorMapSample = texture2D( outdoors, currentPosition );
        finalColor.a *= outdoorMapSample.r;
    }
        
    gl_FragColor = finalColor;

}

