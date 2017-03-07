//based on Diffusion-Limited Aggregation : http://paulbourke.net/fractals/dla/
PVector walker;
float radius;
boolean stuck;
float walkerRadius;
float walkerAngle;
float walkerSpeed;

//Aggregated Point$
ArrayList<PVector> aggregatedPointList;

void setup() {
  size(1280, 720, P2D);
  smooth(8);
  radius = 10;

  walker = defineNewWalkerPosition();
  aggregatedPointList = new ArrayList<PVector>();
  aggregatedPointList.add(new PVector(width/2, height/2));
}

void draw() {
  background(0);
  noFill();
  updateWalkerPosition();
  //random Walk on scene
  for (int i=0; i<aggregatedPointList.size(); i++) {
    PVector pos = aggregatedPointList.get(i);
    float distance = PVector.dist(walker, pos);
    if (distance <= radius * 2) {
      PVector newPos = PVector.sub(walker, pos).setMag(radius * 2).add(pos);
      aggregatedPointList.add(newPos.copy());
      defineNewWalkerPosition();
      break;
    } else {
    }
  }

  //show aggregated point 
  stroke(255);
  for (int i=0; i<aggregatedPointList.size(); i++) {
    PVector pos = aggregatedPointList.get(i);
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }

  //show Walker
  noFill();
  stroke(255, 255, 0);
  ellipse(walker.x, walker.y, radius * 2, radius * 2);

  println(frameCount);
}

void updateWalkerPosition() {
  walkerRadius -= walkerSpeed;
  walker.x = width/2 + cos(walkerAngle) * walkerRadius;
  walker.y = height/2 + sin(walkerAngle) * walkerRadius;
}

PVector defineNewWalkerPosition() {
  walkerRadius = height/2;
  walkerAngle = random(TWO_PI);
  walkerSpeed = random(5, 10);
  float x = width/2 + cos(walkerAngle) * walkerRadius;
  float y = height/2 + sin(walkerAngle) * walkerRadius;

  return new PVector(x, y);
}