//Création des paramètres de la grille cartésienne
float largeur;
float hauteur;
float margin; //marges X,Y
float rows; //nombre d'element en Y
float cols; //nombre d'element en X


void setup() {
  size(1280, 560, P2D);
  smooth(8);
  //définition des paramètres
  largeur = 8;
  hauteur = 8;
  margin = 20;
  rows = (height - (margin * 2)) / hauteur;
  cols = (width - (margin * 2)) / largeur;
  surface.setLocation(10, 10);
}

void draw() {
  background(20);
  noFill();
  noStroke();
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      //definition de la position x,y de chaque point
      float x = margin + j * largeur + largeur/2;
      float y = margin + i * hauteur + hauteur / 2;

      float noise = noise(i * 0.1, j * 0.1, (i+j) * 0.1);
      //rect(x, y, largeur, hauteur);

      float angle = noise * TWO_PI; //3Dimension, l'aleatoire renvoyé est différent pour chaque ligne et différent pour chaque colonne et  est animé par l'ajout de frameCount à chaque boucle
      float endx = x + cos(angle) * largeur;
      float endy = y + sin(angle) * hauteur; 

      stroke(255);
      line(x, y, endx, endy);
    }
  }
  // noLoop();
}

void mousePressed() {
  int seed = (int)random(1000);
  noiseSeed(seed);
  println(seed);
}