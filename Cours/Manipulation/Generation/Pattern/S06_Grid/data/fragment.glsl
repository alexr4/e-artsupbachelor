#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 i_resolution;
uniform float i_time;


in vec4 vertTexCoord;
out vec4 fragColor;


void main(){
	vec2 uv = gl_FragCoord.xy / i_resolution.xy;
	//fract() method return the decimal of the number. It's equal to mod(x, 1)
	//our uv coordinate is alreayd normalize (between 0, 1) so if we need to create a grid we need to multiply it by a vec2 or a scalar
	vec2 rowcol = vec2(4.0, 4.0);
	uv *= rowcol;
	uv = fract(uv);
	
	vec3 color = vec3(uv, 0.0);
	fragColor = vec4(color, 1.0);	
}