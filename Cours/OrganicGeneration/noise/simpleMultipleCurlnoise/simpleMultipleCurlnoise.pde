//simple curl : use noise to draw a simple curl noise on 2D screen
PVector pointer;
ArrayList<ArrayList> pointList;
int index;
int lod;
float offset;

void setup() {
  size(1280, 560, P2D);
  smooth(8);
  initVariables();
}

void draw() {
  background(0);
  int count = 0;
  int counter = 100;
  while (count < counter) {
    moveCurl(pointer, 10);
    count ++;
  }

  for (int i=0; i<pointList.size(); i++) {
    ArrayList<PVector> vList = pointList.get(i);
    noFill();
    stroke(255);
    beginShape(POINTS); //Start drawing shape by vertex
    for (int j=0; j<vList.size(); j++) {
      PVector v = vList.get(j);
      vertex(v.x, v.y);
    }
    endShape();//close drawing shape
  }

  //draw pointer
  fill(255, 255, 0);
  noStroke();
 // ellipse(pointer.x, pointer.y, 20, 20);
}

void initVariables() {
  index = 0;
  pointer = new PVector(width/2, height/2);
  pointList = new ArrayList<ArrayList>();
  pointList.add(new ArrayList<PVector>());
  lod = (int) random(0, 1000); 
    offset = random(0.45, 0.55);
  noiseDetail(lod, offset);
}

void moveCurl(PVector pos, float offset) { 
  float mx = (-1 + noise(pos.y * 0.015, pos.y * 0.015) * 2) * offset;
  float my = (-1 + noise(pos.x * 0.015, pos.x * 0.015) * 2) * offset;
  pos.x = pos.x + mx;
  pos.y = pos.y + my;
  pointList.get(index).add(pos.copy());

  if (pos.x < 0 || pos.x > width || pos.y <0 || pos.y > height) {
    pointer = new PVector(random(width), random(height), 0);
    //pointer = new PVector(width/2 + random(-offset, offset), height/2 + random(-offset, offset));
    lod = (int) random(0, 1000); 
    offset = random(0.45, 0.55);
    pointList.add(new ArrayList<PVector>());
    index ++;
   // noiseSeed(lod);
    noiseDetail(lod, offset);
  }
}

void mousePressed() {
  initVariables();
}


void keyPressed() {
  if (key == 's' || key == 'S') {
    save("img_"+year()+""+month()+""+day()+""+hour()+""+minute()+""+second()+""+millis()+".tif");
  }
}