#ifdef GL_ES
precision mediump float;
#endif

#define TWO_PI 6.28318530718

uniform vec2 i_resolution;
uniform float i_radius;
uniform float i_time;


in vec4 vertTexCoord;
out vec4 fragColor;


void main(){
	vec2 uv = gl_FragCoord.xy / i_resolution.xy;
	vec2 screenCenter = vec2(0.5, 0.5);

	//define vector frome pixel to target
	vec2 toCenter = screenCenter - uv;
	float theta = atan(toCenter.y, toCenter.x); //return an angle between -Pi & Pi
	float radius = length(toCenter) * i_radius;

	//add PI to that in order to chnage its range from -Pi, Pi to 0, 2*Pi
	//Add to in order to turn
	float gamma = TWO_PI / 2.0 + theta + i_time;

	//map theta angle from -Pi, Pi to 0, 1
	//float mapTheta = theta / TWO_PI + 0.5;
	//Use to in order to count TurnArround angle
	float mapTheta = mod(gamma, TWO_PI) / TWO_PI;


	vec3 finalColor = vec3(mapTheta);

	fragColor = vec4(finalColor, 1.0);	
}