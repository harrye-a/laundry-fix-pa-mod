uniform lowp sampler2D sampler0;
uniform lowp sampler2D vismap;
uniform lowp sampler2D vismapPrevious;
uniform lowp sampler2D observers;

uniform highp float vismapBlend;

varying highp vec2 currentPosition;
varying highp vec2 texCoordVarying;


void main(void)
{
    lowp vec4 lightMapSample = texture2D( sampler0, texCoordVarying );
    highp float visMapSample = mix( texture2D( vismapPrevious, texCoordVarying ).a,
                                    texture2D( vismap,         texCoordVarying ).a,
                                    vismapBlend );
    highp float observerSample = texture2D( observers, vec2(texCoordVarying.x, 1.0 - texCoordVarying.y) )[0];
    highp float hideLevel = max( visMapSample - observerSample, 0.0 );

    highp float scale = 1.0 - (hideLevel * 0.5);
    gl_FragColor = lightMapSample * vec4( scale, scale, scale, 1.0 );
}
