
float radius;

void setup() {
  size(500, 500, P2D);
  radius = 150;
}

void draw() {
  background(20);
  int nbElement = 40;
  for (int j=0; j<4; j++) {
    float newradius = radius + 25 * j;
    for (int i=0; i<nbElement; i++) {
      float angle =  radians(360/nbElement * i + frameCount*(j+1)*0.5);
      float x = cos(angle) * newradius+width/2;
      float y = sin(angle) * newradius + height/2;
      pushMatrix();
      translate(x, y);
      rotate(angle);
      rectMode(CENTER);
      rect(0, 0, 20, 20);
      popMatrix();
    }
  }
}