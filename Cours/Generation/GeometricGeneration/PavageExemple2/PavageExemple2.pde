float largeur;
float hauteur;
float margin;
float rows;
float cols;
float denominateur;
float speedNoiseX;
float speedNoiseY;
float speedNoiseZ;

void setup() {
  size(1280, 560, P2D);
  smooth(8);
  largeur = 20;
  hauteur = 20;
  margin = 20;
  rows = (height - (margin * 2)) / hauteur;
  cols = (width - (margin * 2)) / largeur;
  denominateur  = 2;
  speedNoiseX = random(0.01);
  speedNoiseY = random(0.01);
  speedNoiseZ = random(0.01);
}

void draw() {
  //speedNoiseZ = norm(mouseX, 0, width) * 0.1;
  background(20);
  rectMode(CENTER);
  noFill();
  stroke(255);
  rect(width/2, height/2, width - (margin * 0.75), height - (margin * 0.75));
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      float newX = margin + j * largeur + largeur/2;
      float newY = margin + i * hauteur + hauteur/2;
      int randomIndex = int(noise(i * 0.1 + frameCount * speedNoiseX, j * 0.1 + frameCount * speedNoiseY, frameCount * speedNoiseZ) * denominateur);
      float randomColor = noise(frameCount * speedNoiseX, i+ frameCount * speedNoiseY, j + frameCount * speedNoiseZ) * 255;

      if (randomIndex % denominateur == 0) {
        noStroke();
        fill(255, randomColor);
        rect(newX, newY, largeur/4, hauteur/4);
        noFill();
        stroke(255, randomColor);
        rect(newX, newY, largeur - 1, hauteur - 1);
      } else {
        noFill();
        stroke(255, randomColor);
        float angle = noise(noise(i+ frameCount * speedNoiseY, frameCount * speedNoiseX, j + frameCount * speedNoiseZ)) * TWO_PI;//random(1) * TWO_PI;
        float linelength = noise(noise(j * 0.1 + frameCount * speedNoiseY, frameCount * speedNoiseX, i * 0.1 + frameCount * speedNoiseZ)) * (largeur/3);
        float px = cos(HALF_PI/2) * linelength;
        float py = sin(HALF_PI/2) * linelength;
        pushMatrix();
        translate(newX, newY);
        rotate(angle);
        line(px, py, -px, -py);
        line(-px, py, px, -py);
        popMatrix();
      }
    }
  }
  stroke(255);
  noFill();
  rect(width/2, height/2, width - margin * 2, height - margin * 2);

  //noLoop();
}
void mousePressed() {
  
  speedNoiseX = random(0.01);
  speedNoiseY = random(0.01);
  speedNoiseZ = random(0.01);
}
void keyPressed() {
  redraw();
  saveFrame("pavage_"+year()+""+month()+""+day()+""+hour()+""+minute()+""+second()+""+millis()+".tif");
}