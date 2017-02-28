float largeur;
float hauteur;
float margin;
float rows;
float cols;
float denominateur;

void setup() {
  size(1280, 720, P2D);
  smooth(8);
  largeur = 20;
  hauteur = 20;
  margin = 20;
  rows = (height - (margin * 2)) / hauteur;
  cols = (width - (margin * 2)) / largeur;
  denominateur  = 2;
}

void draw() {
  background(20);
  rectMode(CENTER);
  noFill();
  stroke(255);
  rect(width/2, height/2, width - (margin * 0.75), height - (margin * 0.75));
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      float newX = margin + j * largeur + largeur/2;
      float newY = margin + i * hauteur + hauteur/2;
      int randomIndex = int(random(1) * denominateur);
      float randomColor = random(1) * 255;

      if (randomIndex % denominateur == 0) {
        noStroke();
        fill(255, randomColor);
        rect(newX, newY, largeur/3, hauteur/3);
        noFill();
        stroke(255, randomColor);
        rect(newX, newY, largeur - 1, hauteur - 1);
      } else {
        noFill();
        stroke(255, randomColor);
        float angle = HALF_PI/2;//random(1) * TWO_PI;
        float px = cos(angle) * (largeur/4);
        float py = sin(angle) * (hauteur/4);
        line(newX + px, newY + py, newX - px, newY - py);
        line(newX - px, newY + py, newX + px, newY - py);
        //wireframe
      }
    }
  }
  stroke(255);
  noFill();
  rect(width/2, height/2, width - margin * 2, height - margin * 2);

  noLoop();
}

void mousePressed() {
  redraw();
}