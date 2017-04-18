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
	vec2 center = vec2(0.5);
	float distanceFromeCenter = distance(uv, center);

	/*Or
	vec2 target = center - uv;
	float d = length(target);
	*/

	float distIf = step(i_margin, distanceFromeCenter);
	float distIfBlur = smoothstep(i_margin, i_margin+i_blur, distanceFromeCenter);
	vec3 color = vec3(1.0 - (1.0 * distIfBlur));


	fragColor = vec4(color, 1.0);	
}