float x, y;

void setup() {
  size(1280, 560);
  //noiseDetail(497, 0.47327647);
  x = width/2;
  y = height/2;
  frameRate(200);
  background(0);
  smooth(8);
}

void draw() {
  //background(0);
  float mx = map(noise(y * .01, y * 0.01), 0, 1, -4, 4);
  float my =  map(noise(x * .01, x * 0.01), 0, 1, -4, 4);

  x = x+ mx;
  y = y+ my;

  noStroke();
  ellipse(x, y, 1, 1);
  if (x < 0 || x > width || y <0 || y > height) {
    x = random(width);
    y = random(height);
    int lod = (int) random(0, 1000); 
    float offset = random(0.35, 0.55);
    noiseDetail(lod, offset);
  }
}

void mousePressed() {
  int lod = (int) random(0, 1000); 
  float offset = random(0.35, 0.55);
  noiseDetail(lod, offset);
}