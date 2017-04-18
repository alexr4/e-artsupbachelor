#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 i_resolution;
uniform vec2 i_mouse;

uniform vec3 colorA;
uniform vec3 colorB;

in vec4 vertTexCoord;
out vec4 fragColor;



void main(){
	vec2 uv = gl_FragCoord.xy / i_resolution.xy;
	vec2 mouse = i_mouse / i_resolution;
	vec3 finalColor = mix(colorA, colorB, vec3(mouse.xy, 0.5));

	fragColor = vec4(finalColor.rgb, 1.0);	
}