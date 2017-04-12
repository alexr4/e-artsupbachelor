ArrayList<Circle> circleList;
float overlappingMarrgin = 2;

void setup() {
  size(1280, 720, P2D);
  smooth(8);
  circleList = new ArrayList<Circle>();
}

void draw() {
  background(20);

  int total = 10;
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
            if (d - overlappingMarrgin < (circle.radius + otherCircle.radius)) {
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
  float x_ = random(width);
  float y_= random(height);

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