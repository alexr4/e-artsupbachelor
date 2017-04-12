var loc;
var velocity;

function setup(){
	createCanvas(windowWidth, windowHeight);
	loc = createVector(0, height/2);
	velocity = createVector(1, 0);
}

function draw(){
	background(0);

	//random velocity
	//velocity = createVector(random(-1, 1), random(-1, 1));
	//velocity = createVector(1, -1 + noise(frameCount * 0.1) * 2);

	loc.add(velocity);

	ellipse(loc.x, loc.y, 80, 80);

}
