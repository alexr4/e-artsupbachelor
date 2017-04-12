float staticx = 0;
float dynamicx;
float incNoise = 0.1;

//debug
float square = 100;
int incSquare = 2;

void setup() {
  size(500, 500, P2D);
  smooth(8);
  surface.setLocation(0, 0);
}

void draw() {
  background(0);
  noStroke();
  textAlign(CENTER);  
  rectMode(CENTER);
  //Noise de x où x est static renvera toujours la même valeur noise(x) à toute les frames
  float noiseStaticX = noise(staticx);

  /*noise de x où x est evolutif renverra des valeurs aléatoire proche des valeurs précédentes à chaque frame
   On notera que l'aleatoire perlin est très sensible à l'increment de par son comportement entre 0 et 1. 
   Ainsi pour une evolution lente nous incrementerons la valeur soumise au noise d'un tres faible valeur 
   et inversement pour un comportement rapide (chaotique) proche du bruit brownien
   */
  float noiseDynamicX = noise(dynamicx);
  dynamicx += 0.01;


  //Un aléatoire perlin est toujours compris entre 0 et 1.0 ainsi il servira d'increment à une position, une couleur ou toute autre variables


  fill(255);
  text("noiseStaticX : "+noiseStaticX, width * 1/4, height * 0.5/4 - 10);
  fill(255 * noiseStaticX);
  rect(width * 1/4, height * 1/4, square, square);
  
  fill(255);
  text("noiseDynamicX : "+nf(noiseDynamicX, 1, 7), width * 3/4, height * 0.5/4 - 10);
  fill(255 * noiseDynamicX);
  rect(width * 3/4, height * 1/4, square, square);

  /*Le bruit perlin est un bruit à plusieurs dimensions,
   c'est à dire que nous pouvons lui donner plus de variation ajoutant des dimensions.
   Il possède jusqu'à 3 dimensions
   */
  fill(255);
  text("noise 1D : ", width * 1/6, height * 2/4 - 10);
  //bruit à 1 dimension
  for (int i=0; i<square; i+=incSquare) {
    for (int j=0; j<square; j+=incSquare) {
      float x = i * incNoise;
      float noise = noise(x + dynamicx);
      fill(255 * noise);
      rect(width * 1/6 + i - square/2, height * 2/4 + j, incSquare, incSquare);
    }
  }

  //bruit à 2 dimensions
  fill(255);
  text("noise 2D : ", width * 3/6, height * 2/4 - 10);
  for (int i=0; i<square; i+=incSquare) {
    for (int j=0; j<square; j+=incSquare) {
      float x = i * incNoise;
      float y = j * incNoise; 
      float noise = noise(x + dynamicx, y + dynamicx);
      fill(255 * noise);
      rect(width * 3/6 + i - square/2, height * 2/4 + j, incSquare, incSquare);
    }
  }

  //bruit à 2 dimensions
  fill(255);
  text("noise 3D : ", width * 5/6, height * 2/4 - 10);
  for (int i=0; i<square; i+=incSquare) {
    for (int j=0; j<square; j+=incSquare) {
      float x = i * incNoise;
      float y = j * incNoise; 
      float noise = noise(x + dynamicx, y + dynamicx, dynamicx);
      fill(255 * noise);
      rect(width * 5/6 + i - square/2, height * 2/4 + j, incSquare, incSquare);
    }
  }
  
  //Le bruit perlin peut être utile dans la génération de mouvements naturels
  fill(255);
  float x1D = noise(dynamicx);
  float y1D = noise(dynamicx + 0.1);
  ellipse(width * 1/6 + x1D * square - square/2, height * 3/4, 20, 20);
  ellipse(width * 1/6 + x1D * square - square/2, height * 3.5/4 + y1D * square - square/2, 20, 20);
  
  float x2D = noise(dynamicx, dynamicx);
  float y2D = noise(dynamicx + 0.1, dynamicx + 0.1);
  ellipse(width * 3/6 + x2D * square - square/2, height * 3/4, 20, 20);
  ellipse(width * 3/6 + x2D * square - square/2, height * 3.5/4 + y2D * square - square/2, 20, 20);
  
  float x3D = noise(dynamicx, dynamicx, dynamicx);
  float y3D = noise(dynamicx + 0.1, dynamicx + 0.1, dynamicx + 0.1);
  ellipse(width * 5/6 + x3D * square - square/2, height * 3/4, 20, 20);
  ellipse(width * 5/6 + x3D * square - square/2, height * 3.5/4 + y3D * square - square/2, 20, 20);
}