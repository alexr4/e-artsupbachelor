//based on Diffusion-Limited Aggregation : http://paulbourke.net/fractals/dla/


//Aggregated Point
PVector center;
Walker walker;
ArrayList<Walker> aggregatedPointList;
float maxRadius;
float speedRadius;
float hypotenuse;

void setup() {
  size(1280, 720, P2D);
  smooth(8);

  hypotenuse = sqrt(width * width + height * height);
  aggregatedPointList = new ArrayList<Walker>();
  init(new PVector(width/2, height/2));
}

void draw() {
  background(240);
  noFill();

  //computation
  walker.updateWalkerPosition();

  if (maxRadius <= 4) {
    init(new PVector(random(width), random(height)));
  }

  for (int i=0; i<aggregatedPointList.size(); i++) {
    Walker w = aggregatedPointList.get(i);
    if (w.isStuck(walker)) {
      aggregatedPointList.add(walker);
      maxRadius -= speedRadius;
      walker = new Walker(center, height, random(TWO_PI), random(25, 50), maxRadius);
      break;
    }
  }

  //Define angle for light
  float angle = radians(frameCount*0.5);
  float lx = width/2 + cos(angle) * 200;
  float ly = height/2 + sin(angle) * 200;

  //displayShadow
  for (int i=0; i<aggregatedPointList.size(); i++) {
    Walker w = aggregatedPointList.get(i);
    //w.displayShadowRect(3, angle);
    w.displayRealShadowRectFromLight(2, new PVector(lx, ly), 0.25);
  }

  //display shape
  for (int i=0; i<aggregatedPointList.size(); i++) {
    Walker w = aggregatedPointList.get(i);
    w.display();
  }

  walker.display();
  walker.displayRealShadowRectFromLight(2, new PVector(lx, ly), 0.25);


  //dfisplay light

  fill(20);
  noStroke();
  ellipse(lx, ly, 20, 20);

  println(frameCount);
}

void init(PVector c_) {
  center = c_.copy();
  maxRadius = 20;
  speedRadius = 1;
  walker = new Walker(center, height, random(TWO_PI), random(25, 50), maxRadius);
  Walker first = new Walker(center, 0, 0, 0, maxRadius);
  first.stuck = true;
  aggregatedPointList.add(first);
}

void keyPressed() { 
  if (key == 's' || key == 'S') {
    save("img_"+year()+""+month()+""+day()+""+hour()+""+minute()+""+second()+""+millis()+".tif");
  } else {
    aggregatedPointList = new ArrayList<Walker>();
    init(new PVector(width/2, height/2));
  }
}