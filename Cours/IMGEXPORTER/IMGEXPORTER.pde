void setup() {
  size(1280, 720, P3D);
}

void draw() {
  background(0);
  if (export) {
    bufferDone = false;
    saveImage(frameCount, g.get(), "Test", "" );
    saveInterface(export);
  }
}
void keyPressed() {
  if (key == 's' || key == 'S') {
    export = !export;
    if (export) {
      initSequenceAt(25);
    }
  }
}