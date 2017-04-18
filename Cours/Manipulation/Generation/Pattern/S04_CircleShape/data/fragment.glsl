#ifdef GL_ES
precision mediump float;
#endif
#define TWO_PI 6.28318530718

uniform vec2 i_resolution;
uniform float i_time;
uniform float i_blur;
uniform float i_radius;
uniform float i_petal;
uniform float i_size;


in vec4 vertTexCoord;
out vec4 fragColor;

void main(){
	vec2 uv = gl_FragCoord.xy / i_resolution.xy;
	vec2 center = vec2(0.5);
	vec2 target = center - uv;
	float r = length(target) * 2.0;
	float a = TWO_PI / 2.0 + atan(target.x, target.y) + i_time;

	float f = cos(mod(a, TWO_PI) * i_petal) * sin(mod(a, TWO_PI/2.0) * i_petal * 5.0);
	f = abs(f) * i_size + i_radius;

	vec3 color = vec3(1.0 - smoothstep(f, f+i_blur, r));
	

	
	fragColor = vec4(color, 1.0);	
}