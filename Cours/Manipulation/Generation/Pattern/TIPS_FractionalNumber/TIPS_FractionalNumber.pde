void setup() {
  size(500, 500);
}

void draw() {
  background(255);

  beginShape();
  for (int x=0; x<width; x++) {
    float theta = norm(x, 0, width) * TWO_PI;
    float sinT = sin(theta);
    float ampl = 100.0;
    float gamma = sinT * ampl;
    float fract = gamma % 1.0;
    float y = height/2.0 + gamma;// * 100;
    vertex(x, y);
  }
  endShape();
}