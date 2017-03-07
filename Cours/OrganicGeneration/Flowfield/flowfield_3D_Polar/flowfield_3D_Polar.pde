//Création des paramètres de la grille cartésienne
float radiusLine;
float nbRadius;
int nbAngles;


void setup() {
  size(1280, 560, P2D);
  smooth(8);
  //définition des paramètres
  radiusLine = 10;
  nbRadius = (height/2) / radiusLine;
  nbAngles = int(360 / (radiusLine * 6));
}

void draw() {
  background(20);
  noFill();
  noStroke();

  for (int i=0; i<nbRadius; i++) {
    float newRadius = radiusLine + radiusLine * i;
    int nbIteration = (i+1) * nbAngles;
    for (int j=0; j<nbIteration; j++) {
      float angle = map(j, 0, nbIteration, 0, TWO_PI);

      //definition de la position x,y de chaque point
      float x = width/2 + cos(angle) * newRadius;
      float y = height/2 + sin(angle) * newRadius;

      float noise = noise(angle, i*0.1, (angle * i) * 0.01 + frameCount * 0.01);
      //rect(x, y, largeur, hauteur);

      float noiseangle = noise * TWO_PI; //3Dimension, l'aleatoire renvoyé est différent pour chaque ligne et différent pour chaque colonne et  est animé par l'ajout de frameCount à chaque boucle
      float endx = x + cos(noiseangle) * (radiusLine/2) * noise;
      float endy = y + sin(noiseangle) *  (radiusLine/2) * noise; 
      float startx = x - cos(noiseangle) * (radiusLine/2) * noise;
      float starty = y - sin(noiseangle) *  (radiusLine/2) * noise; 
      stroke(255 * noise);
      line(startx, starty, endx, endy);

      pushMatrix();
      translate(x, y);
      rotate(angle);
      rectMode(CENTER);
      stroke(50);
      //rect(0, 0, radiusLine, radiusLine);
      popMatrix();
    }
  }
  // noLoop();
}

void mousePressed() {
  int lod = (int)random(10);
  float offset = random(1.0);

  noiseDetail(lod, offset);
  // println(lod, offset);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    save("img_"+year()+""+month()+""+day()+""+hour()+""+minute()+""+second()+""+millis()+".tif");
  }
}