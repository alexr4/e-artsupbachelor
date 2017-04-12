class Circle {
  float x, y;
  float radius;
  boolean growing = true;

  Circle(float x_, float y_) {
    x = x_;
    y = y_;
    radius = 0;
  }

  void grow() {
    if (growing == true) {
      radius += 1;
    }
  }

  boolean edges() {
    if (x + radius > width || x - radius < 0 || y + radius > height || y - radius < 0) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    stroke(255);
    noFill();
    ellipse(x, y, radius * 2, radius * 2);
  }
}