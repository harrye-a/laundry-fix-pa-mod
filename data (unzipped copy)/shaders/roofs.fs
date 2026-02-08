uniform sampler2D sampler0;
uniform sampler2D vismap;
uniform sampler2D vismapPrevious;
uniform sampler2D observers;

uniform float vismapBlend;

uniform vec2 worldSize;
uniform vec2 mousePos;

varying vec2 currentPosition;


// ============================================================================
// Main function

void main(void)
{
    vec4 spriteSample = texture2D( sampler0, gl_TexCoord[0].xy );        
    vec4 observersSample = texture2D( observers, vec2(currentPosition.x, 1.0-currentPosition.y) );

    //
    // Our vismap sample is a blend of the current vismap and the previous

    vec4 visMapSample = (texture2D( vismap,          currentPosition ) * vismapBlend)
                      + (texture2D( vismapPrevious,  currentPosition ) * ( 1.0 - vismapBlend ));
        

    //
    // Let us see through the roof if the mouse is nearby

    //float mouseDistance = distance(vec2(currentPosition.x*worldSize.x,currentPosition.y*worldSize.y), mousePos);    
    //if( mouseDistance < 3.0 )
    //{
    //    float newAlpha = visMapSample[3] * ( mouseDistance / 3.0 );
    //    if( newAlpha < 0.0 ) newAlpha = 0.0;
    //    if( newAlpha > 1.0 ) newAlpha = 1.0;
    //    visMapSample[3] = newAlpha;
    //}


    //
    // Observer cones from cctv let us see throughh

    float observerAlpha = 1.0 - observersSample[0];

    if( observerAlpha < visMapSample[3] )
    {
        visMapSample[3] = observerAlpha;
    }
        
    vec4 finalColor = gl_Color * spriteSample * visMapSample;

    gl_FragColor = finalColor;
}

