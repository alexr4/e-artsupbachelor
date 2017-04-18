#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 i_resolution;
uniform float i_time;
uniform float i_margin;
uniform float i_blur;


in vec4 vertTexCoord;
out vec4 fragColor;

void main(){
	vec2 uv = gl_FragCoord.xy / i_resolution.xy;
	vec3 color = vec3(0.0);

	float left = step(i_margin, uv.x); //equal to if(uv.x > 0.25)
	float bottom = step(i_margin, uv.y);

	//use this method as a vec2
	//vec2 bottomLeft = step(vec2(i_margin), uv);
	//vec2 topRight = step(vec2(i_margin), vec2(1.0) - uv);
	vec2 bottomLeft = smoothstep(vec2(i_margin), vec2(i_margin + i_blur), uv);
	vec2 topRight = smoothstep(vec2(i_margin), vec2(i_margin + i_blur), vec2(1.0) - uv);

	color = vec3(bottomLeft.x * bottomLeft.y * topRight.x * topRight.y);

	fragColor = vec4(color, 1.0);	
}