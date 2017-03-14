var ball;

function setup(){
	createCanvas(windowWidth, windowHeight);
	ball = new Ball(width/2, height/2);
}

function draw(){
	background(127);
	ball.update();
	ball.checkEdges();
	ball.draw();
}

var Ball = function(x_, y_){
	this.x = x_;
	this.y = y_;
	this.speedX = random(-5, 5);
	this.speedY = random(-5, 5);
	this.radius = random(50, 100);

	this.update = function(){
		this.x += this.speedX;
		this.y += this.speedY;
	}

	this.checkEdges = function(){
		if(this.x < this.radius || this.x > width-this.radius){
			this.speedX *= -1;
		}
		if(this.y < this.radius || this.y > height-this.radius){
			this.speedY *= -1;
		}
	}

	this.draw = function(){
		fill(255);
		stroke(0);
		ellipse(this.x, this.y, this.radius * 2, this.radius * 2);
	}
}