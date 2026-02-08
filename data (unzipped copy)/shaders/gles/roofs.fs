uniform lowp sampler2D sampler0;
uniform lowp sampler2D vismap;
uniform lowp sampler2D vismapPrevious;
uniform lowp sampler2D observers;

uniform lowp vec4 fixedColour;
uniform highp float vismapBlend;

uniform highp vec2 worldSize;
uniform highp vec2 mousePos;

varying highp vec2 currentPosition;
varying highp vec2 texCoordVarying;


// ============================================================================
// Main function

void main(void)
{
    lowp vec4 spriteSample = texture2D( sampler0, texCoordVarying.xy );
    lowp vec4 observersSample = texture2D( observers, vec2(currentPosition.x, 1.0-currentPosition.y) );

    //
    // Our vismap sample is a blend of the current vismap and the previous

    lowp vec4 visMapSample = (texture2D( vismap,          currentPosition ) * vismapBlend)
                           + (texture2D( vismapPrevious,  currentPosition ) * ( 1.0 - vismapBlend ));


    //
    // Let us see through the roof if the mouse is nearby

    //highp float mouseDistance = distance(vec2(currentPosition.x*worldSize.x,currentPosition.y*worldSize.y), mousePos);
    //if( mouseDistance < 3.0 )
    //{
    //    highp float newAlpha = visMapSample[3] * ( mouseDistance / 3.0 );
    //    if( newAlpha < 0.0 ) newAlpha = 0.0;
    //    if( newAlpha > 1.0 ) newAlpha = 1.0;
    //    visMapSample[3] = newAlpha;
    //}


    //
    // Observer cones from cctv let us see throughh

    lowp float observerAlpha = 1.0 - observersSample[0];

    if( observerAlpha < visMapSample[3] )
    {
        visMapSample[3] = observerAlpha;
    }

    highp vec4 finalColor = fixedColour * spriteSample * visMapSample;

    gl_FragColor = finalColor;
}

