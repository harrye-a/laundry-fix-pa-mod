uniform sampler2D fboTexture;
//varying vec2 texCoord;

void main(void)
{
    gl_Position = gl_ProjectionMatrix * gl_Vertex;
    gl_TexCoord[0] = gl_MultiTexCoord0;
    //gl_FrontColor = gl_Color;
    //texCoord = (inTexCoord + 1.0) / 2.0;
    //texCoord = gl_TexCoord[0];
}