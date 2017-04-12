var vectorA;
var vectorB;

function setup(){
	createCanvas(windowWidth, windowHeight);
	vectorA = createVector(150, 200);
	vectorB = createVector(40, 60);
}

function draw(){
	background(0);

	var lAx = 10;
	var lAy = 10;

	stroke(255, 0, 0);
	line(lAx, lAy, lAx + vectorA.x, lAy + vectorA.y);

	var lBx = 50;
	var lBy = 10;

	stroke(0, 255, 0);
	line(lBx, lBy, lBx + vectorB.x, lBy + vectorB.y);

	//Addition de vecteur
	var addX = 120;
	var addY = 10;

	var vectorC = p5.Vector.add(vectorA, vectorB);

	stroke(255, 255, 0);
	line(addX, addY, addX + vectorC.x, addY + vectorC.y);

	//Sustraction de vecteur
	var addX = 140;
	var addY = 10;

	var vectorC = p5.Vector.sub(vectorA, vectorB);

	stroke(255, 0, 255);
	line(addX, addY, addX + vectorC.x, addY + vectorC.y);


	//multiplication de vecteur
	var addX = 160;
	var addY = 10;
	var scalaire = 2.0;

	var vectorC = p5.Vector.mult(vectorA, scalaire);

	stroke(0, 255, 255);
	line(addX, addY, addX + vectorC.x, addY + vectorC.y);

	//magnitude
	var magnitudeA = vectorA.mag();
	fill(255);
	noStroke();
	text("Magnitude A = "+magnitudeA, 10, 200);

	//nmalisation de vecteur
	var addX = 180;
	var addY = 10;
	var scalaire = 2.0;

	var vectorC = vectorA.copy().normalize(vectorA);

	stroke(255, 255, 255);
	line(addX, addY, addX + vectorC.x, addY + vectorC.y);
}
