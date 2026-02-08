// ============================================================================
// Main function

void main(void)
{
    // The alpha value changes over time. (darker shadows at midday).
    // Alpha is handled in the vertex shader.
    gl_FragColor = gl_Color;
}

