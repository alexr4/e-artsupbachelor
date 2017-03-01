void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(45));
  rect(0,0, 40,40);
  popMatrix();
}