uniform vec2 worldSize;
uniform float alpha;

varying vec2 currentPosition;


void main(void)
{
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;

    currentPosition = vec2( gl_Vertex.x/worldSize.x, gl_Vertex.y/worldSize.y );
    gl_TexCoord[0] = gl_MultiTexCoord0;
    gl_FrontColor = vec4( gl_Color.rgb, gl_Color.a * alpha );
}
