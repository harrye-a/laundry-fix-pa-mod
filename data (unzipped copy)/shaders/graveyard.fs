// D11.Giang
// MIT Licence-d shader from shadertoy
// https://www.shadertoy.com/view/WdGcRh
// https://www.shadertoy.com/view/XtK3W3
// https://www.shadertoy.com/view/Xdl3D8

#define COLOR_GRADING
//#define FILM_STRIPES
#define FILM_VIGNETTE
#define FILM_GRAIN
#define DESATURATION
#define GLITCH
#define BLOTCHES

uniform sampler2D fboTexture;
uniform float time;

// Set to false to have vignette and colour grading only,
// true to have extra stuff: glitches, stripes, blotches
uniform int brokenSignal;

float luma(vec3 colour)
{
	return dot(colour, vec3(0.2126, 0.7152, 0.0722));
}

vec3 saturate(vec3 colour, float adjustment)
{
	float lu = luma(colour);
	vec3 intensity = vec3(lu, lu, lu);
	return mix(intensity, colour, adjustment);
}

float flicker(float time, vec2 uv, float amount)
{
	uv *= 0.0001;
	return mix(pow(cos(uv.y * 100.2 + time * 80.), 0.4), 1., 1. - amount);
}

float filmStripes(float time, vec2 uv, float amount)
{
    float stripes = 0.;
    float mask = cos(uv.x - cos(uv.y + time) + sin(uv.x * 10.2) - cos(uv.x * 60. + time)) + sin(uv.y * 2.);
    mask += flicker(time, uv, 1.);
    
    if(fract(uv.x + time) >= 0.928 && fract(uv.x + time) <= 0.929) 
    {
    	stripes = sin(uv.x * 4300. * sin(uv.x * 102.)) * mask;
    }
    if(fract(uv.x + fract(1. - time)) >= 0.98 + fract(time) && fract(uv.x + fract(time / 2. + sin(time / 2.))) <= 0.97 + fract(time + 0.2)) 
    {
    	stripes = sin(uv.x * 4300. * sin(uv.x * 102.)) * mask;
    }
    if(fract(uv.x + fract(- time * 1. + sin(time / 2.))) >= 0.96 + fract(time) && fract(uv.x + fract(time / 2. + sin(time / 2.))) <= 0.95 + fract(time + 0.2)) 
    {
    	stripes = sin(uv.x * 4300. * sin(uv.x * 102.)) * mask;
    }
    if(fract(uv.x + fract(- time * 1. + sin(time / 2.))) >= 0.99 + fract(time) && fract(uv.x + fract(time / 2. + sin(time / 2.))) <= 0.98 + fract(time + 0.2)) 
    {
    	stripes = sin(uv.x * 4300. * sin(uv.x * 102.)) * mask;
    }
    
    stripes = 1. - stripes;
    
   	return mix(1., stripes, amount);
}

float filmGrain(float time, vec2 uv, float amount)
{
	float grain = fract(sin(uv.x * 100. * uv.y * 524. + fract(time)) * 5000.);
	float w = 1.;
	return mix(w, grain, amount);
}

float vignette(vec2 uv)
{
	uv *= 1.0 - uv.yx;
	float vig = uv.x * uv.y * 20.0;
	return clamp(pow(vig, 1.) * 1., 0., 1.);
}

//----
// Sheer black magic
vec3 mod289(vec3 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec2 mod289(vec2 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 permute(vec3 x) {
    return mod289(((x*34.0)+1.0)*x);
}

float snoise(vec2 v)
{
    const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                        0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                        -0.577350269189626,  // -1.0 + 2.0 * C.x
                        0.024390243902439); // 1.0 / 41.0
    // First corner
    vec2 i  = floor(v + dot(v, C.yy) );
    vec2 x0 = v -   i + dot(i, C.xx);

    // Other corners
    vec2 i1;
    //i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
    //i1.y = 1.0 - i1.x;
    i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    // x0 = x0 - 0.0 + 0.0 * C.xx ;
    // x1 = x0 - i1 + 1.0 * C.xx ;
    // x2 = x0 - 1.0 + 2.0 * C.xx ;
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;

    // Permutations
    i = mod289(i); // Avoid truncation effects in permutation
    vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
        + i.x + vec3(0.0, i1.x, 1.0 ));

    vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
    m = m*m ;
    m = m*m ;

    // Gradients: 41 points uniformly over a line, mapped onto a diamond.
    // The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;

    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt( a0*a0 + h*h );
    m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );

    // Compute final noise value at P
    vec3 g;
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}

float rand(vec2 co)
{
    return fract(sin(dot(co.xy,vec2(12.9898,78.233))) * 43758.5453);
}

float rand(float c)
{
	return rand(vec2(c,1.0));
}

//----

vec2 glitchPos(float time, vec2 uv, float noise)
{
    
    // Create large, incidental noise waves
    
    // Offset by smaller, constant noise waves
    noise = noise + (snoise(vec2(time*10.0, uv.y * 2.4)) - 0.5) * 0.15;
    
    // Apply the noise as x displacement for every line
    float xpos = uv.x - noise * noise * 0.25;
    return vec2(xpos, uv.y);
}

float randomBlotch(vec2 uv, float seed)
{
	float x = rand(seed);
	float y = rand(seed+1.0);
	float s = 0.01 * rand(seed+2.0);
	
	vec2 p = vec2(x,y) - uv;
	p.x *= 16. / 9.;
	float a = atan(p.y,p.x);
	float v = 1.0;
	float ss = s*s * (sin(6.2831*a*x)*0.1 + 1.0);
	
	if ( dot(p,p) < ss ) v = 0.2;
	else
		v = pow(dot(p,p) - ss, 1.0/16.0);
	
	return mix(0.3 + 0.2 * (1.0 - (s / 0.02)), 1.0, v);
}

float genBlotch(float time, vec2 uv)
{
    int s = int( max(8.0 * rand(time+18.0) -2.0, 0.0 ));

    float vI = 1.0;
    if ( 0 < s ) vI *= randomBlotch(uv, time+6.0+19.* float(0));
    if ( 1 < s ) vI *= randomBlotch(uv, time+6.0+19.* float(1));
    if ( 2 < s ) vI *= randomBlotch(uv, time+6.0+19.* float(2));
    if ( 3 < s ) vI *= randomBlotch(uv, time+6.0+19.* float(3));
    if ( 4 < s ) vI *= randomBlotch(uv, time+6.0+19.* float(4));
    if ( 5 < s ) vI *= randomBlotch(uv, time+6.0+19.* float(5));
    return vI;
}

void main(void)
{
    vec2 inTexCoord = gl_TexCoord[0].st;

#if defined(GLITCH)
    float noise = max(0.0, snoise(vec2(time, inTexCoord.y * 0.3)) - 0.3) * (1.0 / 0.7);
    if (brokenSignal != 0)
    {
        inTexCoord = glitchPos(time, inTexCoord, noise);
    }
#endif

	vec3 colour = texture2D(fboTexture, inTexCoord).rgb;

#if defined(GLITCH)
    if (brokenSignal != 0)
    {
        // Mix in some random interference for lines
        vec3 randomColour = vec3(rand(vec2(inTexCoord.y * time)));
        vec3 mixColour = vec3(mix(colour.r, randomColour.r, noise * 0.3),
                              mix(colour.g, randomColour.g, noise * 0.3),
                              mix(colour.b, randomColour.b, noise * 0.3));
        colour = mixColour;  
        
        // // Apply a line pattern every 4 pixels
        // if (floor(mod(fragCoord.y * 0.25, 2.0)) == 0.0)
        // {
        //     colour.rgb *= 1.0 - (0.15 * noise);
        // }
    }
#endif

#if defined(COLOR_GRADING)
	colour *= luma(colour);
	colour *= 1.9;
	colour = colour / 1.8 + 0.12;
#endif

#if defined(FILM_STRIPES)
    if (brokenSignal != 0)
    {
	    colour += 1. - filmStripes(time, inTexCoord, 0.014);
	    colour += 1. - filmStripes(time, inTexCoord + inTexCoord, 0.01);
    }
#endif

#if defined(FILM_VIGNETTE)
	colour *= vignette(inTexCoord) * 1.3;
#endif

#if defined(FILM_GRAIN)
	colour *= filmGrain(time, inTexCoord, 0.16);
#endif

#if defined(BLOTCHES)
    if (brokenSignal != 0)
    {
        colour *= genBlotch(time, inTexCoord);
    }
#endif

#if defined(DESATURATION)
	const float desaturationLevel = 0.83;
	colour = saturate(colour, desaturationLevel);
#endif

#if defined(COLOR_GRADING)
	colour.r *= 1.01;
	colour.g *= 1.09;
#endif

	// Output to screen
	gl_FragColor = vec4(colour, 1.);
}
