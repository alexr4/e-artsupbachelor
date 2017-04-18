#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 i_resolution;

uniform vec3 colorA;
uniform vec3 colorB;

in vec4 vertTexCoord;
out vec4 fragColor;


float plot(vec2 st, float pct){
	return smoothstep(pct - 0.005, pct, st.y) - smoothstep(pct, pct + 0.005, st.y);
}

void main(){
	vec2 uv = gl_FragCoord.xy / i_resolution.xy;
	vec3 pct = vec3(uv.x);

	//create trhee differnte curve for RGB mix
	pct.r = smoothstep(0.0, 1.0, uv.x);
	pct.g = sin(uv.x * PI * 1.0);// * 0.5 + 0.5;
	pct.b = pow(uv.x, 0.5);


	vec3 finalColor = mix(colorA, colorB, pct);

	//draw curves
	finalColor = mix(finalColor, vec3(1.0, 0.0, 0.0), vec3(plot(uv, pct.r)));
	finalColor = mix(finalColor, vec3(0.0, 1.0, 0.0), vec3(plot(uv, pct.g)));
	finalColor = mix(finalColor, vec3(0.0, 0.0, 1.0), vec3(plot(uv, pct.b)));

	fragColor = vec4(finalColor.rgb, 1.0);	
}