var ballList = [];

function setup(){
	createCanvas(windowWidth, windowHeight);
	initMover(50);
}

function draw(){
	background(127);
	for(var i=0; i<ballList.length; i++){
		var ball = ballList[i];
		ball.checkEdges();
		ball.checkOtherEdges(ballList);
		ball.update();
		ball.draw();
	}
}

function initMover(numberOfMovers){
    var firstBall = new Ball(width/2, height/2, 5);
	ballList.push(firstBall);

	for(var i=0; i<numberOfMovers; i++){
		var ball = getNewBall();
		if(ball != null){
			ballList.push(ball);
		}
	}
}

function getNewBall(){
	var radius_ = random(5, 25);
	var x_ = random(radius_ * 2, width - radius_ * 2);
	var y_ = random(radius_ * 2, height - radius_ * 2);
	var validCircle = true;
	for(var i=0; i<ballList.length; i++){
		var other = ballList[i];
		var distance = dist(x_, y_, other.x, other.y);
		if(distance <= other.radius + radius_){
			validCircle = false;
			break;
		}
	}
	if(validCircle){
		return new Ball(x_, y_, radius_);
	}else{
		return null;
	}
}

var Ball = function(x_, y_, radius_){
	this.speedX = random(-2, 2);
	this.speedY = random(-2, 2);
	this.radius = radius_;
	this.x = x_;
	this.y = y_;


	this.update = function(){
		this.x += this.speedX;
		this.y += this.speedY;
	}

	this.checkEdges = function(){
		if(this.x <= this.radius || this.x >= width-this.radius){
			this.speedX *= -1;
		}
		if(this.y <= this.radius || this.y >= height-this.radius){
			this.speedY *= -1;
		}
	}

	this.checkOtherEdges = function(othersList){
		for(var i=0; i<othersList.length; i++){
			var other = othersList[i];
			if(other != this){
				var distance = dist(this.x, this.y, other.x, other.y);
				if(distance <= other.radius + this.radius){
					this.speedX *= -1;
					this.speedY *= -1;
					break;
				}
			}
		}
	}

	this.draw = function(){
		fill(255);
		noFill();
		stroke(0);
		line(this.x, this.y - 4, this.x, this.y + 4);
		line(this.x - 4, this.y, this.x + 4, this.y);
		ellipse(this.x, this.y, this.radius * 2, this.radius * 2);
	}
}