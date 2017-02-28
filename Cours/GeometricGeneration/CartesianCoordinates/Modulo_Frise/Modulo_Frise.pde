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
  for (int i=1; i<5; i++) {
    float newX = x + i * largeur;
    rect(newX, y, largeur, hauteur);
  }
}