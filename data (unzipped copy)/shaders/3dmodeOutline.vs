
uniform float outlineSize;

varying vec3 N;
varying vec3 v;


void main(void)
{
    v = vec3(gl_ModelViewMatrix * gl_Vertex);       
    N = normalize(gl_NormalMatrix * gl_Normal);

    gl_Position = ftransform() + (vec4(gl_Normal * outlineSize,0));
    gl_TexCoord[0] = gl_MultiTexCoord0;
    gl_FrontColor = vec4( gl_Color );
}
