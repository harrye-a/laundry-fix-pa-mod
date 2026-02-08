#ifdef USE_TEXTURE
uniform lowp sampler2D sampler0;
#endif
uniform lowp sampler2D lightmap;
uniform lowp sampler2D vismap;
uniform lowp sampler2D vismapPrevious;
uniform lowp sampler2D observers;

uniform highp float vismapBlend;

varying highp vec2 currentPosition;
#ifdef USE_TEXTURE
varying highp vec2 texCoordVarying;
#endif
#ifdef USE_VERTEX_COLOUR
varying lowp vec4 colourVarying;
#else
uniform lowp vec4 fixedColour;
#endif



// ============================================================================
// Main function

void main(void)
{
    lowp vec4 lightMapSample = texture2D( lightmap, currentPosition );
#ifdef USE_TEXTURE
    lowp vec4 spriteSample = texture2D( sampler0, texCoordVarying );
#endif
    lowp vec4 finalColor = lightMapSample
#ifdef USE_VERTEX_COLOUR
        * colourVarying
#else
        * fixedColour
#endif
#ifdef USE_TEXTURE
        * spriteSample
#endif
        ;


#ifdef USE_BW
    //
    // Greyscale based on B&W overlay for flashbacks

    {
        const highp float magnitude = 0.1;
        const lowp vec3 luminanceScale = vec3( 0.299, 0.587, 0.114 ) * 0.85 * (1.0-magnitude);
        lowp float grey = dot( finalColor.rgb, luminanceScale );

        // Note: in this specific case, assignment by components is 1 cycle
        // faster than "finalColor.rgb = ..." according to PVRUniSCo.
        finalColor.r = finalColor.r * magnitude + grey;
        finalColor.g = finalColor.g * magnitude + grey;
        finalColor.b = finalColor.b * magnitude + grey;
    }
#endif


#ifdef USE_FOW
    //
    // Darken/greyscale areas that are under fog of war
    // Our vismap sample is a blend of the current vismap and the previous
    highp float observerSample = texture2D( observers, vec2(currentPosition.x, 1.0 - currentPosition.y) )[0];

    highp float visMapSample = mix( texture2D( vismapPrevious, currentPosition ).a,
                                    texture2D( vismap,         currentPosition ).a,
                                    vismapBlend );

    if( visMapSample > 0.0 )
    {
        highp float magnitude = 1.0 - visMapSample;

        // Take into account view cones
        magnitude = min( magnitude + observerSample, 1.0 );

        const lowp vec3 luminanceScale = vec3( 0.299, 0.587, 0.114 ) * 0.5;
        lowp float luminance = dot( finalColor.rgb, luminanceScale );
        lowp float grey = luminance * (1.0-magnitude);

        finalColor.rgb = finalColor.rgb * magnitude + grey;
    }
#endif

    gl_FragColor = finalColor;

}

