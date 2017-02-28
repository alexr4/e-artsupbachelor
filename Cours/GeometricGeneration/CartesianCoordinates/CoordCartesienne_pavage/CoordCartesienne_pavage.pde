float largeur;
float hauteur;
float x;
float y;

void setup() {
  size(500, 500);
  largeur = 25;
  hauteur = 25;
  x = largeur/2;
  y = hauteur/2;
}

void draw() {
  background(127);
  for (int i=0; i<3; i++) {
    for (int j=0; j<5; j++) {
      float newX = x + j * largeur;
      float newY = y + i * hauteur;
      rect(newX, newY, largeur, hauteur);
    }
  }
}