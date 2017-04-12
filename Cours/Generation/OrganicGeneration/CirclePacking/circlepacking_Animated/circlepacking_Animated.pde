ArrayList<Circle> circleList;
float overlappingMargin;
float minRadius;
float maxRadius;

void setup() {
  size(1280, 720, P2D);
  smooth(8);
  circleList = new ArrayList<Circle>();
  overlappingMargin = 2;
  minRadius = 100;
  maxRadius = 300;
}

void draw() {
  background(20);

  int total = 100;
  int count = 0;
  int maxnumber = 60;

  while (count < total) {
    Circle newCircle = getNewCircle();
    if (newCircle != null) {
      circleList.add(newCircle);
      count ++;
    }
    if (frameCount >= maxnumber) {
      println("Packing Finished");
      noLoop();
      break;
    } else {
      println("Frame : "+frameCount);
    }
  }

  for (int i=0; i<circleList.size(); i++) {
    Circle circle = circleList.get(i);
    if (circle.growing) {
      if (circle.edges() == true) {
        circle.growing = false;
      } else {
        for (int j=0; j<circleList.size(); j++) {
          Circle otherCircle = circleList.get(j);
          if (circle != otherCircle) {
            float d = dist(circle.x, circle.y, otherCircle.x, otherCircle.y);
            if (d - overlappingMargin < (circle.radius + otherCircle.radius)) {
              circle.growing = false;
              break;
            }
          }
        }
      }
    }
    circle.display();
    circle.grow();
  }
}

Circle getNewCircle() {
  float radius = random(minRadius, maxRadius);
  float angle = random(TWO_PI);

  float x_ = width/2 + cos(angle) * radius;
  float y_ = height/2 + sin(angle) * radius;

  boolean validCircle = true;
  for (int i=0; i<circleList.size(); i++) {
    Circle circle = circleList.get(i);
    float distance = dist(x_, y_, circle.x, circle.y);
    if (distance < circle.radius) {
      validCircle = false;
      break;
    }
  }
  if (validCircle == true) {
    return new Circle(x_, y_);
  } else {
    return null;
  }
}


void keyPressed() {
  if (key == 's' || key == 'S') {
    save("img_"+year()+""+month()+""+day()+""+hour()+""+minute()+""+second()+""+millis()+".tif");
  }
}