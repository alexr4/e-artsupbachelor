//based on Diffusion-Limited Aggregation : http://paulbourke.net/fractals/dla/
PVector walker;
float radius;
boolean stuck;

//Aggregated Point$
ArrayList<PVector> aggregatedPointList;

void setup() {
  size(1280, 720, P2D);
  smooth(8);
  radius = 20;

  walker = new PVector(random(width), random(height));
  aggregatedPointList = new ArrayList<PVector>();
  aggregatedPointList.add(new PVector(width/2, height/2));
}

void draw() {
  background(0);
  noFill();
  //random Walk on scene
  int counter= 10;  
  for (int j=0; j<counter; j++) {
    PVector vel = PVector.random2D().mult(radius);
    walker.add(vel);
    walker.x = constrain(walker.x, 0, width);
    walker.y = constrain(walker.y, 0, height);
    for (int i=0; i<aggregatedPointList.size(); i++) {
      PVector pos = aggregatedPointList.get(i);
      float distance = PVector.dist(walker, pos);
      if (distance <= radius * 2) {
        PVector newPos = PVector.sub(walker, pos).setMag(radius * 2).add(pos);
        aggregatedPointList.add(newPos.copy());
        walker = new PVector(random(width), random(height));
        break;
      } else {
      }
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

boolean isStuck(PVector walker_, PVector point_) {
  float distance = PVector.dist(walker_, point_);
  if (distance <= radius * 2) {
    return true;
  } else {
    return false;
  }
}