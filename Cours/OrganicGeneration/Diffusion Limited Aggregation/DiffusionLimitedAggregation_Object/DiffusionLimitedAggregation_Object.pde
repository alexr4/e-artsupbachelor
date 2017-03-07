//based on Diffusion-Limited Aggregation : http://paulbourke.net/fractals/dla/


//Aggregated Point
PVector center;
Walker walker;
ArrayList<Walker> aggregatedPointList;

void setup() {
  size(1280, 720, P2D);
  smooth(8);

  center = new PVector(width/2, height/2);
  walker = new Walker(center, height/2, random(TWO_PI), random(20, 50));
  Walker first = new Walker(center, 0, 0, 0);
  first.stuck = true;
  aggregatedPointList = new ArrayList<Walker>();
  aggregatedPointList.add(first);
}

void draw() {
  background(0);
  noFill();
  walker.updateWalkerPosition();

  for (int i=0; i<aggregatedPointList.size(); i++) {
    Walker w = aggregatedPointList.get(i);
    if (w.isStuck(walker)) {
      aggregatedPointList.add(walker);
      walker = new Walker(center, height/2, random(TWO_PI), random(10, 20));
      break;
    }
  }

  //display
  for (int i=0; i<aggregatedPointList.size(); i++) {
    Walker w = aggregatedPointList.get(i);
    w.displayRect();
    w.display();
    w.displayLinesBetweenNeighbor();
    w.displayLinesBetweenLatestNeighbor();
  }

  walker.display();
  println(frameCount);
}

void keyPressed() {
  walker = new Walker(center, height/2, random(TWO_PI), random(10, 20));
  Walker first = new Walker(center, 0, 0, 0);
  first.stuck = true;
  aggregatedPointList = new ArrayList<Walker>();
  aggregatedPointList.add(first);
}