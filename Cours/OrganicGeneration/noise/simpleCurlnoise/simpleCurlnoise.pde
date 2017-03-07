//simple curl : use noise to draw a simple curl noise on 2D screen
PVector pointer;
ArrayList<PVector> pointList;
int lod;
float offset;

void setup() {
  size(1280, 560, P2D);
  smooth(8);
  initVariables();
}

void draw() {
  background(0);
  moveCurl(pointer, 10);

  noFill();
  stroke(255);
  beginShape(); //Start drawing shape by vertex
  for (int i=0; i<pointList.size(); i++) {
    PVector v = pointList.get(i);
    vertex(v.x, v.y);
  }
  endShape();//close drawing shape

  //draw pointer
  fill(255, 255, 0);
  noStroke();
  //ellipse(pointer.x, pointer.y, 20, 20);
}

void initVariables() {
  pointer = new PVector(width/2, height/2);
  pointList = new ArrayList<PVector>();
  lod = (int) random(0, 1000); 
  offset = random(0.45, 0.5);
  noiseDetail(lod, offset);
}

void moveCurl(PVector pos, float offset) { 
  float mx = (-1 + noise(pos.y * 0.01, pos.y * 0.01) * 2) * offset;
  float my = (-1 + noise(pos.x * 0.01, pos.x * 0.01) * 2) * offset;
  pos.x = pos.x + mx;
  pos.y = pos.y + my;
  pointList.add(pos.copy());

  if (pos.x < 0 || pos.x > width || pos.y <0 || pos.y > height) {
    initVariables();
  }
}
void keyPressed() {
  if (key == 's' || key == 'S') {
    save("img_"+year()+""+month()+""+day()+""+hour()+""+minute()+""+second()+""+millis()+".tif");
  }
}