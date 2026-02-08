uniform vec2 worldSize;
uniform float alpha;

varying vec3 N;
varying vec3 v;
uniform vec2 worldPosition;
varying vec2 currentPosition;


void main(void)
{
    v = vec3(gl_ModelViewMatrix * gl_Vertex);       
    N = normalize(gl_NormalMatrix * gl_Normal);

    gl_Position = ftransform();//gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;
    gl_TexCoord[0] = gl_MultiTexCoord0;
    gl_FrontColor = vec4( gl_Color.rgb, gl_Color.a * alpha );

	currentPosition = vec2( worldPosition.x/worldSize.x, worldPosition.y/worldSize.y );

    // Walls do not have a currentPosition value
    
    if( worldPosition.x < 0.1 && worldPosition.y < 0.1 )
    {
        currentPosition = vec2(gl_Vertex.x/worldSize.x, gl_Vertex.y/worldSize.y );
    }
}
