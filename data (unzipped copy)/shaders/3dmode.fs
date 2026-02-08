uniform sampler2D sampler0;
uniform sampler2D lightmap;
uniform sampler2D vismap;
uniform sampler2D vismapPrevious;
uniform sampler2D observers;

uniform float vismapBlend;
uniform int blackAndWhite;
uniform int noTexture;
uniform int renderFow;
uniform float bitDepth;

varying vec2 currentPosition;



//
// Lighting

varying vec3 N;
varying vec3 v; 
#define MAX_LIGHTS 3 

vec4 DoLighting(void)
{
   vec4 finalColor = vec4(0.0, 0.0, 0.0, 0.0);
   
   for (int i=0;i<MAX_LIGHTS;i++)
   {
      vec3 L = normalize(gl_LightSource[i].position.xyz - v); 
      vec3 E = normalize(-v); // we are in Eye Coordinates, so EyePos is (0,0,0) 
      vec3 R = normalize(-reflect(L,N)); 
   
      //calculate Ambient Term: 
      vec4 Iamb = gl_FrontLightProduct[i].ambient; 
      //calculate Diffuse Term: 
      vec4 Idiff = gl_FrontLightProduct[i].diffuse * max(dot(N,L), 0.0);
      Idiff = clamp(Idiff, 0.0, 1.0); 
   
      // calculate Specular Term:
      vec4 Ispec = gl_FrontLightProduct[i].specular 
             * pow(max(dot(R,E),0.0),0.3*gl_FrontMaterial.shininess);
      Ispec = clamp(Ispec, 0.0, 1.0); 
   
      finalColor += Iamb + Idiff + Ispec;
   }

   return finalColor;
}


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
	// Lighting	

	finalColor *= DoLighting();



    //
    // Greyscale based on vismap
	// Or on B&W overlay for flashbacks
	
	
    float magnitude = 1.0;                                //(visMapSample.r + visMapSample.g + visMapSample.b) / 3.0;
	if( blackAndWhite == 1 ) magnitude = 0.1;
	
    if( magnitude < 0.99 )
    {
        // Reduce colour bit depth

        finalColor.r = float( int( finalColor.r * bitDepth )) / bitDepth;
        finalColor.g = float( int( finalColor.g * bitDepth )) / bitDepth;
        finalColor.b = float( int( finalColor.b * bitDepth )) / bitDepth;


        // Grey out final colour

        float average = (finalColor.r + finalColor.g + finalColor.b) / 3.0;        
        average *= 0.85;

        finalColor.r = finalColor.r * magnitude + average * (1.0-magnitude);
        finalColor.g = finalColor.g * magnitude + average * (1.0-magnitude);
        finalColor.b = finalColor.b * magnitude + average * (1.0-magnitude);       
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
	
	

    gl_FragColor = finalColor;

}

