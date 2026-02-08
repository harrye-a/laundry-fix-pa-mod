uniform lowp sampler2D sampler0;
uniform lowp vec4 fixedColour;

varying highp vec2 texCoordVarying;


// ============================================================================
// Main function

void main(void)
{
    highp float texSample = texture2D( sampler0, texCoordVarying ).a;
    gl_FragColor = vec4( texSample, texSample, texSample, texSample ) * fixedColour;
}

