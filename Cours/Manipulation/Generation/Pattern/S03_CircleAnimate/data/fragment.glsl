#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 i_resolution;
uniform float i_time;
uniform float i_margin;
uniform float i_blur;
uniform float i_weight;


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

	//create a stripe distance field
	vec2 target = center - uv;
	float dist = length(target);
	vec3 stripe = vec3(fract(dist * 20.0));

	//create a ring
	vec3 ring = vec3(step(i_margin, dist) * step(dist, i_margin * i_weight));
	vec3 ringBlur = vec3(
		smoothstep(i_margin, i_margin+i_blur, dist) * 
		smoothstep((i_margin+i_blur) * i_weight, i_margin * i_weight, dist)
	);

	fragColor = vec4(ringBlur, 1.0);	
}