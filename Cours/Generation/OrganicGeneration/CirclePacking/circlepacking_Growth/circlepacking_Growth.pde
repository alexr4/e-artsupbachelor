Circle c;

ArrayList<Circle> circleList;

void setup(){
  size(1280, 720, P2D);
  smooth(8);
  c = new Circle(200, 200);
  circleList = new ArrayList<Circle>();
}

void draw(){
  background(20);
  
  Circle circle = new Circle(random(width), random(height));
  circleList.add(circle);
  
  for(int i=0; i<circleList.size(); i++){
    Circle c = circleList.get(i);
    if(c.edges() == true){
      c.growing = false;
    }
    c.display();
    c.grow();
  }
}