void setup() {
  size(500, 500);
}

void draw() {
  background(255);

  beginShape();
  for (int x=0; x<width; x++) {
    float theta = norm(x, 0, width) * PI;
    float sinT = sin(theta);
    float ampl = 10000.0;
    float gamma = sinT * ampl;
    float fract = gamma % 1.0;
    float y = height/2.0 + fract * 100;
    vertex(x, y);
  }
  endShape();
}