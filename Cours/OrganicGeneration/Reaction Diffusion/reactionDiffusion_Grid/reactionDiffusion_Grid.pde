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
float feedRate = 0.05;
float killRate = 0.062;

//Laplacian smooth
float near = 0.2;
float far = 0.05;

void setup() {
  size(1280, 560, P2D);

  resX = 5;
  resY = 5;
  rows = height / resY;
  cols = width / resX;
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

      //fill the first grid with chemical b ofor random 1/3 of the grid
      float randomChemicalB = random(1);
      if (randomChemicalB < 1.0/100.0) {
        cellList[i][j].b = 1.0;
      }
    }
  }
}

void draw() {
  background(0);
  //Gray-Scott Reaction Diffusion 
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      Cell c = cellList[i][j];
      Cell n = nextCellList[i][j];

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

  //Display grid
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      Cell c = cellList[i][j];
      c.display();
    }
  }
  
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