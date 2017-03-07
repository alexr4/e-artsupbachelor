//Création des paramètres de la grille cartésienne
float largeur;
float hauteur;
float margin; //marges X,Y
float rows; //nombre d'element en Y
float cols; //nombre d'element en X
float phi;
float phiOffset;
float dPhi;


void setup() {
  size(1280, 560, P2D);
  smooth(8);
  //définition des paramètres
  largeur = 8;
  hauteur = 8;
  margin = 20;
  rows = (height - (margin * 2)) / hauteur;
  cols = (width - (margin * 2)) / largeur;
  phi = (1 + sqrt(5))/2;
  phiOffset = random(0.05, 0.1);
  dPhi = (TWO_PI / (cols * hauteur)) * 7.57;
}

void draw() {
  background(20);
  rectMode(CENTER);
  noFill();
  phi += phiOffset;
  float theta = phi;
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      //definition de l'aléatoire perlin

      //definition de la position x,y de chaque point
      float yOffset = sin(theta);
      float x = margin + j * largeur + largeur/2;
      float y = margin + i * hauteur + hauteur / 2 + yOffset * hauteur;

      float aj = map(j, 0, rows-1, 0, TWO_PI);
      float ai = map(i, 0, cols-1, 0, TWO_PI);
      float noise = noise(i * 0.1, j * 0.1, frameCount * 0.01 + yOffset * 0.5);
      float noiseR = noise(i * 0.125, j * 0.125, frameCount * 0.0125 + yOffset * 0.25);
      float noiseG = noise(i * 0.15, j * 0.15, frameCount * 0.015 + yOffset * 0.5);
      float noiseB = noise(i * 0.175, j * 0.175, frameCount * 0.0175 + yOffset * 0.75);
      //rect(x, y, largeur, hauteur);

      float angle = noise * TWO_PI; //3Dimension, l'aleatoire renvoyé est différent pour chaque ligne et différent pour chaque colonne et  est animé par l'ajout de frameCount à chaque boucle
      float normX = cos(angle);
      float normY = sin(angle);
      float pow = pow(sin((angle + angle / 4) * noise), 4);
      float rad = largeur/2;
      float startx = x - normX * (rad + pow * largeur);
      float starty = y - normY * (rad + pow * largeur); 
      float endx = x + normX * (rad + pow * largeur);
      float endy = y + normY * (rad + pow * largeur); 
      stroke(255 * noiseR, 255 * noiseG, 255 * noiseB);
      line(startx, starty, endx, endy);
      theta += dPhi;
    }
  }
  // noLoop();
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    save("img_"+year()+""+month()+""+day()+""+hour()+""+minute()+""+second()+""+millis()+".tif");
  }
}