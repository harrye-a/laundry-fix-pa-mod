uniform sampler2D fboTexture;
uniform float time;
uniform int offset;
uniform float lightIntensity;

float filmGrain(float time, vec2 uv, float amount)
{
	float grain = fract(sin(uv.x * 100. * uv.y * 524. + fract(time)) * 5000.);
	float w = 1.;
	return mix(w, grain, amount);
}

float vignette(vec2 uv, float time) 
{
    uv *=  1.0 - uv.yx;   
    float vig = uv.x*uv.y * 15.0;
    float t = sin(time * 23.) * cos(time * 8. + .5);
    vig = clamp(pow(vig, 1. + t * .1), 0., 1.);
    return vig;
}

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


vec2 moveImage(vec2 uv, float time) 
{
    uv.x += .002 * (cos(time * 3.) * sin(time * 12. + .25));
    uv.y += .002 * (sin(time * 1. + .5) * cos(time * 15. + .25));
    return uv;
}

vec2 pan(vec2 texCoords, float time, int offset)
{
    vec2 panTex = moveImage(texCoords, time * 5.0);
    float zoom = 0.4;
    
    float panX = (sin(time + offset) + 1.0) * .5;
    float panY = (cos(time + offset) + 1.0) * .5;
    vec2 scaleCenter = vec2(panX ,panY);
    panTex = (panTex - scaleCenter) * zoom + scaleCenter;
    
    return panTex;
}

void main(void)
{
    vec2 inTexCoord = gl_TexCoord[0].st;

	vec3 lightColour = vec3(1,1,1);
	vec3 ambient = lightColour * lightIntensity;

	vec3 colour = texture2D(fboTexture, pan(inTexCoord,time * 0.2, offset)).rgb;

	colour *= filmGrain(time, inTexCoord, 0.45);

	const float desaturationLevel = 0.7;
	colour = saturate(colour.rgb, desaturationLevel);

	// Output to screen
	float alpha = vignette(inTexCoord, time) * 1.1;
	vec3 result = (colour * ambient) + (lightColour * 0.5);
	//result *= alpha * 0.5;

	gl_FragColor = vec4(result, alpha);
}
