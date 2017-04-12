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
  aggregatedPointList.add(walker.copy());
}

void draw() {
  background(0);

  walker = new PVector(random(width), random(height));



  //show and update Aggregated points
  noFill();
  stroke(255);
  for (int i=0; i<aggregatedPointList.size(); i++) {
    PVector pos = aggregatedPointList.get(i);
    float distance = PVector.dist(walker, pos);
    if (distance <= radius * 2) {
      PVector newPos = PVector.sub(walker, pos).setMag(radius * 2).add(pos);
      aggregatedPointList.add(newPos.copy());
      break;
    }
  }

  //show aggregated point 
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