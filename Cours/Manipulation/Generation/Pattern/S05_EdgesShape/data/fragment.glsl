
// Reference to
// http://thndl.com/square-shaped-shaders.html

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 i_resolution;
uniform float i_time;
uniform float i_blur;
uniform float i_radius;
uniform int i_edges;


in vec4 vertTexCoord;
out vec4 fragColor;

void main(){
	vec2 uv = gl_FragCoord.xy / i_resolution.xy;
	vec2 center = vec2(0.5);
	
	//remap space between -1, 1
	uv = uv * 2.0 - 1.0;

	//define number of sides
	int N = i_edges;

	//find angle and radius from current pixel to target
	float angle = PI + atan(uv.x, uv.y);
	angle = mod(angle + i_time, TWO_PI);
	float radius = TWO_PI/float(N);

	//shaping function tht modulate the distance
	float dist = cos(floor(0.5 + angle / radius) * radius - angle) * length(uv);

	vec3 color = vec3(1.0 - smoothstep(i_radius, i_radius+i_blur, dist));
	
	fragColor = vec4(color, 1.0);	
}