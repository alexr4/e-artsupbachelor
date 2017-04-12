//Création des paramètres de la grille cartésienne
float largeur;
float hauteur;
float margin; //marges X,Y
float rows; //nombre d'element en Y
float cols; //nombre d'element en X

int counter;

void setup() {
  size(1280, 560, P2D);
  smooth(8);
  //définition des paramètres
  largeur = 20;
  hauteur = 20;
  margin = 20;
  rows = (height - (margin * 2)) / hauteur;
  cols = (width - (margin * 2)) / largeur;
}

void draw() {
  background(20);
  rectMode(CENTER);
  noFill();
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      //definition de la position x,y de chaque point
      float x = margin + j * largeur + largeur/2;
      float y = margin + i * hauteur + hauteur / 2;
      stroke(127);
      //rect(x, y, largeur, hauteur);

      //definition de l'angle selon un aléatoire perlin
      float angle = 0;
      if (counter == 0) {
        angle = noise(i * 0.1) * TWO_PI; //1Dimension, l'aleatoire renvoyé est différent pour chaque ligne et identique pour chaque colonne et n'est pas animé car i est identique à chaque frame
      } else if (counter == 1) {
        angle = noise(i * 0.1, j * 0.1) * TWO_PI; //2Dimension, l'aleatoire renvoyé est différent pour chaque ligne et différent pour chaque colonne et n'est pas animé car i et j sont identiques à chaque frame
      } else if (counter == 2) {
        angle = noise(i * 0.1, j * 0.1, (i+j) * 0.1) * TWO_PI; //3Dimension, l'aleatoire renvoyé est différent pour chaque ligne et différent pour chaque colonne et n'est pas animé car i et j sont identiques à chaque frame
      }
      float endx = x + cos(angle) * largeur/2;
      float endy = y + sin(angle) * hauteur/2; 
      stroke(255);
      line(x, y, endx, endy);
    }
  }
  // noLoop();
}

void mousePressed() {
  if (counter < 3) {
    counter++;
  } else {
    counter = 0;
  }

  println(counter);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    save("img_"+year()+""+month()+""+day()+""+hour()+""+minute()+""+second()+""+millis()+".tif");
  }
}