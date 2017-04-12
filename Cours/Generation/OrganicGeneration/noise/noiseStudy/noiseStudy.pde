PVector pos;
ArrayList<PVector> l;
float noiseSeed;
void setup() {
  size(1280, 720, P3D);
  background(0);
  smooth(8);
  pos = new PVector(0, height/2);
  l = new ArrayList<PVector>();
  noiseSeed = (int) random(1000);
}

void draw() {  
  background(0);

  //noiseDetail(1000); 
 //noiseSeed = noise(frameCount * 0.01) * 1.5;
  //noiseSeed((int) noiseSeed);
  noiseMove(pos, 1);
  //strokeWeight(4);
  stroke(255);
  point(pos.x, pos.y);
  noFill();
  beginShape();
  for (PVector v : l) {
    vertex(v.x, v.y);
  }
  endShape();
}

void noiseMove(PVector xy, float offset) {
  float mx = (-1 + noise(xy.y * 0.01, xy.y * 0.01) * 2) * offset;
  float my = (-1 + noise(xy.x * 0.01, xy.x * 0.01) * 2) * offset;

  xy.x ++;//= xy.x + mx;
  xy.y = xy.y + my;

  l.add(xy.copy());
 // noiseSeed((int) random(1000));

  if (xy.x < 0 || xy.x > width || xy.y <0 || xy.y > height) {
    pos = new PVector(0, height/2);
    l = new ArrayList<PVector>();
    noiseDetail((int) random(10, 1000), random(10.0));
  }
}