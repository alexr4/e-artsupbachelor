#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 i_resolution;
uniform vec2 i_mouse;
uniform float i_time;

out vec4 fragColor;

void main(){
	vec2 normMouse = i_mouse.xy / i_resolution;
	vec4 mouseColor = vec4(0.0, normMouse.xy, 1.0);

	float absoluteSin = abs(sin(i_time));
	vec4 color = vec4(absoluteSin, 0.0, 0.0, 1.0);
	fragColor = color + mouseColor;	
}