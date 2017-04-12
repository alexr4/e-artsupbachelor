var loc;
var velocity;
var acceleration;

function setup(){
	createCanvas(windowWidth, windowHeight);
	loc = createVector(0, height/2);
	velocity = createVector(0, 0);
	acceleration = createVector(0.1, 0);
}

function draw(){
	background(0);


	velocity.add(acceleration);
	loc.add(velocity);

	ellipse(loc.x, loc.y, 80, 80);

	if(loc.x > width){
		loc.x = 0;
	}

}
