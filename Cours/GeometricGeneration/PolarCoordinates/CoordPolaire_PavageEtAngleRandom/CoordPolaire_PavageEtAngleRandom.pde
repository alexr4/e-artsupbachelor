float largeur;
float hauteur;
float rayonRef;
float x;
float y;

void setup() {
  size(500, 500);
  largeur = 4;
  hauteur = 4;
  rayonRef = 25;
  x = width/2;
  y = height/2;
}

void draw() {
  background(127);
  noStroke();
  for (int i=0; i<4; i++) {
    float rayon = rayonRef + rayonRef * i;
    for (int j=0; j<40; j++) {
      float angle = radians(360/40 * j);
      float newX = x + cos(angle) * (rayon + random(25));
      float newY = y + sin(angle) * (rayon + random(25));
      pushMatrix();
      translate(newX, newY);
      rotate(angle);
      rectMode(CENTER);
      rect(0, 0, largeur, hauteur);
      popMatrix();
    }
  }
  
  noLoop();
}