var x;
var y;
var speedX;
var speedY;

function setup(){
	createCanvas(windowWidth, windowHeight);

	x = width/2;
	y = height/2;
	speedX = 0.5;
	speedY = 0.25;
}

function draw(){
	background(127);
	update();

	fill(255);
	stroke(0);
	ellipse(x, y, 100, 100);
}

function update(){
	x += speedX;
	y += speedY;
}