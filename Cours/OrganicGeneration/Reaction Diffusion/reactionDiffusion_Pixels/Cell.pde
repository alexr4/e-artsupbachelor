class Cell {
  float cellWidth, cellHeight;
  float x, y;

  //chemical
  float a, b;

  Cell(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    cellWidth = w_;
    cellHeight = h_;
  }

  void display() {
    noStroke();
    fill((a - b) * 255);
    rect(x, y, cellWidth, cellHeight);
  }

  float getChemical(int chemical) {
    if (chemical == 0) {
      return a;
    } else {
      return b;
    }
  }
}