ArrayList<Circle> circleList;
float overlappingMargin;
float minRadius;
float maxRadius;
float radius;
float angle;

void setup() {
  size(1280, 720, P2D);
  smooth(8);
  circleList = new ArrayList<Circle>();
  overlappingMargin = 2;
  minRadius = 150;
  maxRadius = 300;
  radius = minRadius;
  angle = 0;
}

void draw() {
  background(20);

  Circle newCircle = getNewCircle();
  if (newCircle != null) {
    circleList.add(newCircle);
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
              circle.addNeighbord(otherCircle);
              break;
            }
          }
        }
      }
    }
    circle.grow();
    //circle.display();
    circle.displayNeighbors();
  }
}

Circle getNewCircle() {
  float radius = random(minRadius, maxRadius);
  float theta = angle;
  angle += 0.01;

  float x_ = width/2 + cos(theta) * radius;
  float y_ = height/2 + sin(theta) * radius;

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