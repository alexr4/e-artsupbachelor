//Création des paramètres de la grille cartésienne
float radiusLine;
float nbRadius;
int nbAngles;
float incRad;


void setup() {
  size(1280, 560, P2D);
  smooth(8);
  //définition des paramètres
  radiusLine = 5;
  nbRadius = (height/2 - 50) / radiusLine;
  nbAngles = int(360 / (radiusLine * 6));
  colorMode(HSB, 1, 1, 1, 1);
}

void draw() {
  background(20);
  noFill();
  noStroke();
  incRad += 0.025;
  for (int i=0; i<nbRadius; i++) {
    float phi = cos(norm(i, 0, nbRadius) * TWO_PI + incRad + radians(frameCount * 0.1));
    float incrad = phi * (i+2) * 0.015;
    float newRadius = radiusLine + radiusLine * i + incrad * (radiusLine * (i+1) * 0.1);
    int nbIteration = (i+1) * nbAngles;
    for (int j=0; j<nbIteration; j++) {
      float normj = (norm(j, 0, nbIteration) * PI) * 10;
      float angle = map(j, 0, nbIteration, 0, TWO_PI);
      float noise = noise(angle, i*0.1, (angle * i) * 0.01 + frameCount * 0.01);
      float blobNoise = noise(angle + angle/4, i * 0.5, (angle * i) + frameCount * 0.01);
      float blobAmpli = 25;
      float blobDeform = blobNoise * blobAmpli;
      //definition de la position x,y de chaque point
      float x = width/2 + cos(angle) * (newRadius +  blobDeform);
      float y = height/2 + sin(angle) * (newRadius + blobDeform);

      float lengthRadius = 0.75;
      float noiseangle = noise * TWO_PI; //3Dimension, l'aleatoire renvoyé est différent pour chaque ligne et différent pour chaque colonne et  est animé par l'ajout de frameCount à chaque boucle
      float endx = cos(noiseangle) * ((radiusLine/lengthRadius) * noise + phi * (radiusLine/lengthRadius));
      float endy = sin(noiseangle) *  ((radiusLine/lengthRadius) * noise + phi * (radiusLine/lengthRadius)); 
      float startx = -cos(noiseangle) * ((radiusLine/lengthRadius) * noise + phi * (radiusLine/lengthRadius));
      float starty = -sin(noiseangle) *  ((radiusLine/lengthRadius) * noise + phi * (radiusLine/lengthRadius)); 
      float incStroke = pow(constrain(noise * incrad, 0, 1), 10) * 2;

      pushMatrix();
      translate(x, y);
      rotate(angle);
      stroke(noise, 1, 1, 0.5 + incStroke);
      line(startx, starty, endx, endy);
      //rectMode(CENTER);
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
  println(lod, offset);
}
void keyPressed() {
  if (key == 's' || key == 'S') {
    save("img_"+year()+""+month()+""+day()+""+hour()+""+minute()+""+second()+""+millis()+".tif");
  }
}