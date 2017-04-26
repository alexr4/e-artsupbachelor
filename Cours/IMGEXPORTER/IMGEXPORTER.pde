void setup() {
  size(1280, 720, P3D);
}

void draw() {
  background(0);

  export(frameCount, "Test", "Hello");
}


void keyPressed() {
  if (key == 's' || key == 'S') {
    launchExport();
  }
}