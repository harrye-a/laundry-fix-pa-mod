uniform highp mat4 transformMatrix;
uniform highp vec2 worldSize;

attribute highp vec3 position;

#ifndef OMIT_CURRENT_POSITION
varying highp vec2 currentPosition;
#endif

#ifdef USE_TEXTURE
attribute highp vec2 texCoord;
varying highp vec2 texCoordVarying;
#endif

#ifdef USE_VERTEX_COLOUR
uniform lowp float alpha;
attribute lowp vec4 colour;
varying lowp vec4 colourVarying;
#endif


void main(void)
{
    gl_Position = transformMatrix * vec4(position, 1.0);

#ifndef OMIT_CURRENT_POSITION
    currentPosition = vec2( position.x/worldSize.x, position.y/worldSize.y );
#endif
#ifdef USE_TEXTURE
    texCoordVarying = texCoord;
#endif
#ifdef USE_VERTEX_COLOUR
    colourVarying = vec4( colour.rgb, colour.a * alpha );
#endif
}
