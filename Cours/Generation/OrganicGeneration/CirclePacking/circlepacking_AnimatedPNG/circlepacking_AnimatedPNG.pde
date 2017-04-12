ArrayList<Circle> circleList;
float overlappingMarrgin = 2;
ArrayList<PVector> brightPixelLocation;
PImage logo;

void setup() {
  size(1280, 720, P2D);
  smooth(8);
  circleList = new ArrayList<Circle>();
  brightPixelLocation = new ArrayList<PVector>();
  logo = loadImage("logo.png");
  logo.loadPixels();

  for (int x=0; x<logo.width; x++) {
    for (int y =0; y<logo.height; y++) {
      int pixel = x + y * logo.width;
      color pixelColor = logo.pixels[pixel];
      float brightness = brightness(pixelColor);
      if (brightness > 1) {
        brightPixelLocation.add(new PVector(x, y));
      }
    }
  }
}

void draw() {
  background(20);
  //image(logo, 0, 0);
  
  int total = 500;
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
      //println("Frame : "+frameCount);
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
  int index = int(random(0, brightPixelLocation.size()));
  PVector position = brightPixelLocation.get(index); 
  float x_ = position.x;
  float y_ = position.y;

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