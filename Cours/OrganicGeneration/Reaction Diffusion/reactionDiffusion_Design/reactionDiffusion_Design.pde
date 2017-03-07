//Reaction diffusion tutorial from :  http://www.karlsims.com/rd.html
/*
Each cell has an amount of chemical
 per cell :
 Particle A is add at a feed rate
 2 particles B convert an A int B as A wa a food
 B is remove at a kill rate
 
 Gray Scott model formula :
 A_ = A + (dA * Laplace(A) - (A*B*B) + f(1 - A)) * deltaTime
 B_ = B + (dB * Laplace(B) + (A*B*B) - B(k + f)) * deltaTime
 */
int rows, cols;
int resX, resY;
Cell[][] cellList;
Cell[][] nextCellList;

//GrayScott Model :
float dA = 1.0;
float dB = 0.5;
float feedRate = 0.055;
float killRate = 0.062;

//Laplacian smooth
float near = 0.2;
float far = 0.05;

void settings() {
  float scale = 0.5;
  size(int(1280 * scale), int(560 * scale), P2D);
}
void setup() {

  resX = 1;
  resY = 1;
  rows = height;// / resY;
  cols = width;// / resX;
  cellList = new Cell[rows][cols];
  nextCellList = new Cell[rows][cols];
  //start by creating a grid
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      int x = j * resX;
      int y = i * resY;
      cellList[i][j] = new Cell(x, y, resX, resY);
      nextCellList[i][j] = new Cell(x, y, resX, resY);
      //fill the first and next grid with chemical a = 1.0
      cellList[i][j].a = 1.0;
      nextCellList[i][j].a = 1.0;
      float randomChemicalB = random(1);
      if (randomChemicalB < 1.0/10.0) {
        // cellList[i][j].b = 1.0;
      }
    }
  }

  int nbFeedPoint = 10;
  for (int i=0; i<nbFeedPoint; i++) {
    float radius = random(height/3, height/3.5);
    float angle = norm(i, 0, nbFeedPoint) * TWO_PI;
    int ii = floor(width/2 + cos(angle) * radius);
    int jj = floor(height/2 + sin(angle) * radius);
    int resX_ = 20;
    int resY_ = 20;
    for (int x=0; x<resX_; x++) {
      for (int y=0; y<resY_; y++) {
        int x_ = jj - resX_/2 + x; 
        int y_ = ii - resY_/2 + y;
        cellList[x_][y_].b = 1.0;
      }
    }
  }

  frameRate(1000); 
  surface.setLocation(0, 0);
}

void draw() {
  background(127); 

  //Gray-Scott Reaction Diffusion 
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      Cell c = cellList[i][j]; 
      Cell n = nextCellList[i][j]; 

      //variation of feed and kill rate
      //basis 
      feedRate = 0.04; 
      killRate = 0.06; 

      //wandering bubble Skin
      //feedRate = 0.012;
      //killRate = 0.05;

      //Wave
      //feedRate = 0.025;
      //killRate = 0.05;

      //Coral Growth
      //feedRate = 0.0545;
      //killRate = 0.062;

      //mitosis
      //feedRate = 0.0367;
      //killRate = 0.0649;

      //Bubble Skin
      //feedRate = 0.098;
      //killRate = 0.057;

      //Worm Skin
      //feedRate = 0.058;
      //killRate = 0.065;

      //finger Skin
      //feedRate = 0.037;
      //killRate = 0.06;

      //reaction formula      
      //gray-scott model
      // A_ = A + (dA * Laplace(A) - (A*B*B) + f(1 - A)) * deltaTime
      //B_ = B + (dB * Laplace(B) + (A*B*B) - B(k + f)) * deltaTime
      n.a = c.a + (dA * laplace(i, j, 0) - (c.a * c.b * c.b) + feedRate * (1.0 - c.a)); 
      n.b = c.b + (dB * laplace(i, j, 1) + (c.a * c.b * c.b) - c.b * (killRate + feedRate)); 
      //constrain reaction
      n.a = constrain(n.a, 0, 1); 
      n.b = constrain(n.b, 0, 1);
    }
  }
  swapGrid(); 
  loadPixels(); 
  //Display grid
  for (int i=1; i<rows-1; i++) {
    for (int j=1; j<cols-1; j++) {
      Cell c = cellList[i][j]; 
      float a = c.a; 
      float b = c.b; 
      int index = j + i * width; 
      pixels[index] = color(255 * (1 - (a-b)));
    }
  }
  updatePixels(); 

  surface.setTitle("FPS : "+round(frameRate));
}

void swapGrid() {
  //swap grid
  //Next become actual and actual become next...
  Cell[][] tmpGrid = cellList; 
  cellList = nextCellList; 
  nextCellList = tmpGrid;
}

float laplace(int i, int j, int chemical) {
  float sum = 0; 
  sum += cellList[i][j].getChemical(chemical) * -1; 
  //nearest neighbors
  if (i > 1 && i < rows-1 && j > 1 && j < cols-1) {
    sum += cellList[i-1][j].getChemical(chemical) * near; 
    sum += cellList[i+1][j].getChemical(chemical) * near; 
    sum += cellList[i][j-1].getChemical(chemical) * near; 
    sum += cellList[i][j+1].getChemical(chemical) * near; 
    //Farest neighbors
    sum += cellList[i-1][j-1].getChemical(chemical) * far; 
    sum += cellList[i+1][j-1].getChemical(chemical) * far; 
    sum += cellList[i+1][j+1].getChemical(chemical) * far; 
    sum += cellList[i-1][j+1].getChemical(chemical) * far;
  }

  return sum;
}