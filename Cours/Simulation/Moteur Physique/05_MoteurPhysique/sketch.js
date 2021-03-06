var mover;

function setup(){
	createCanvas(windowWidth, windowHeight);
	mover = new Ball(width/2, height/2, 50);
}

function draw(){
	background(127);

	//define dforce
	var wind = createVector(0.01, 0.0);
	var gravity = createVector(0.0, 0.25);
	gravity.mult(mover.mass);

	var friction = mover.velocity.copy();
	var coef = 0.1;
	var normal = 1.0;
	var frictionMag = coef * normal;
	friction.mult(-1);
	friction.normalize();
	friction.mult(frictionMag);

	mover.applyForce(wind);
	mover.applyForce(gravity);
	mover.applyForce(friction);
	

	mover.checkEdges();
	mover.update();
	mover.draw();
}

var Ball = function(x_, y_, radius_){
	this.location = createVector(x_, y_);
	this.velocity = createVector(0, 0);
	this.acceleration = createVector(0., 0.);
	this.radius = radius_;
	this.maxVel = 10.0;
	this.mass = 5.0;

	this.applyForce = function(force){
		force.div(this.mass);
		this.acceleration.add(force);
	}

	this.update = function(){
		this.velocity.add(this.acceleration);
		this.velocity.limit(this.maxVel);
		this.location.add(this.velocity);
		this.acceleration.mult(0);
	}

	this.checkEdges = function(){
		if(this.location.x <= this.radius || this.location.x >= width-this.radius){
			this.velocity.x *= -1;
		}
		if(this.location.y <= this.radius || this.location.y >= height-this.radius){
			this.velocity.y *= -1;
		}
	}

	this.checkOtherEdges = function(othersList){
		for(var i=0; i<othersList.length; i++){
			var other = othersList[i];
			if(other != this){
				var distance = dist(this.location.x, this.location.y, other.location.x, other.location.y);
				if(distance <= other.radius + this.radius){
					this.velocity.mult(-1);
					break;
				}
			}
		}
	}

	this.draw = function(){
		fill(255);
		noFill();
		stroke(0);
		line(this.location.x, this.location.y - 4, this.location.x, this.location.y + 4);
		line(this.location.x - 4, this.location.y, this.location.x + 4, this.location.y);
		ellipse(this.location.x, this.location.y, this.radius * 2, this.radius * 2);

		//draw vector
		var len = 10;
		line(this.location.x, this.location.y, this.location.x + this.velocity.x * len, this.location.y + this.velocity.y * len);
	}
}