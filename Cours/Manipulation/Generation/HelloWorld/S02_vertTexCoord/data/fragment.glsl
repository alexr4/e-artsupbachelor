#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 i_resolution;
uniform float mouseX;

in vec4 vertTexCoord;
out vec4 fragColor;

void main(){
	vec2 uvCoord = gl_FragCoord.st / i_resolution;
	vec2 invertecUvCoord = vertTexCoord.st; //vertTexCoord is the normalize pixel position on screen and seems to be inverted in Processing
	float normalStep = mouseX / i_resolution.x;

	vec4 color = vec4(uvCoord.xy, 0.0, 1.0);
	vec4 invertedColor = vec4(invertecUvCoord.xy, 0.0, 1.0);
	vec4 stepVector = vec4(normalStep, normalStep, normalStep, 1.0);

	vec4 Albedo = mix(color, invertedColor, stepVector);
	fragColor = Albedo;	
}