float largeur;
float hauteur;
float rayonRef;
float x;
float y;

void setup() {
  size(500, 500);
  largeur = 25;
  hauteur = 25;
  rayonRef = 100;
  x = width/2;
  y = height/2;
}

void draw() {
  background(127);
  
  for (int i=0; i<2; i++) {
    float rayon = rayonRef + rayonRef * i;
    for (int j=0; j<8; j++) {
      float angle = radians(360/8 * j);
      float newX = x + cos(angle) * rayon;
      float newY = y + sin(angle) * rayon;
      pushMatrix();
      translate(newX, newY);
      rotate(angle);
      rect(0, 0, largeur, hauteur);
      popMatrix();
    }
  }
}