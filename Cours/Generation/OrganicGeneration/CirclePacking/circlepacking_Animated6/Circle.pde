class Circle {
  float x, y;
  float radius;
  boolean growing = true;
  float speed;
  
  ArrayList<Circle> neighbors;

  Circle(float x_, float y_) {
    x = x_;
    y = y_;
    radius = 0;
    speed = random(0.1, 1.0);
    neighbors = new ArrayList<Circle>();
  }

  void grow() {
    if (growing == true) {
      radius += speed;
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
  
  void displayNeighbors(){
    stroke(255);
    for(int i=0; i<neighbors.size(); i++){
      Circle neighbor = neighbors.get(i);
      line(x, y, neighbor.x, neighbor.y);
    }
  }
  
  void addNeighbord(Circle c){
    neighbors.add(c);
  }
}