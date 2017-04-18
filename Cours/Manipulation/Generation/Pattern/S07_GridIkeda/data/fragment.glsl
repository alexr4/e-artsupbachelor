#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 i_resolution;
uniform float i_time;


in vec4 vertTexCoord;
out vec4 fragColor;

float random2D(vec2 uv){	
	float dotProduct = dot(uv, vec2(12.9898, 78.233));
	float sinAngle = sin(dotProduct) * 43758.5453123;
	float fractionalNumber = fract(sinAngle);
	return fractionalNumber;
}

float random1D(float u){	
	float sinAngle = sin(u) * 1e4;
	float fractionalNumber = fract(sinAngle);
	return fractionalNumber;
}

float getRandomChannel(float limit, vec2 uv, vec2 vel) {
	vec2 p = floor(uv + vel);
	return step(limit, random2D(100.0 + p * 0.000001) + random1D(p.x * 0.5));
}

void main(){
	vec2 uv = gl_FragCoord.xy / i_resolution.xy;

	// - 1 Create a grid from the normalized UV
	vec2 rowcol = vec2(100.0, 25.0);
	uv *= rowcol;
	float orientation = -1 + mod(floor(uv.y), 2) * 2;

	// - 2 Convert it into integer grid & fractional grid
	vec2 fuv = fract(uv);
	vec2 iuv = floor(uv);

	// - 3 Compute a velocity from i_time
	// Add inverted orientation based on y and add random speed
	vec2 velocity = vec2(i_time * 10.0);
	velocity *= vec2(orientation, 0.0) * random1D(1.0 + iuv.y);

	// - 4 Create a vec2 offset for chroma offset
	// Define an angle based on i_time and compute its sin value (sin wave between -1 & 1)
	vec2 offset = vec2(0.15, 0.0);
	float angle = mod(i_time, PI);
	float limit = (sin(angle) * 0.5 + 0.5);

	// - 5 Compute Red, Blue and Green Channel
	float red = getRandomChannel(limit, uv + offset, velocity);
	float blue = getRandomChannel(limit, uv, velocity);
	float green = getRandomChannel(limit, uv - offset, velocity);
	vec3 color = vec3(1.0) - vec3(red, blue, green);

	// - 6 Compute random grain
	vec3 grain = vec3(random2D(uv * i_time));

	// - 7 Mix color and grain
	vec3 Albedo = mix(color, grain, 0.15);

	// - 8 Compute vignetage
	float margin = 0.35;
	float limitMargin = 0.35;
	vec2 screenCenter = vec2(0.5, 0.5);
	float distanceFromCenter = distance(gl_FragCoord.xy / i_resolution.xy, screenCenter);

	float distIfBlur = 1.0 - smoothstep(limitMargin, limitMargin+margin, distanceFromCenter);

	fragColor = vec4(Albedo * distIfBlur, 1.0);	
}