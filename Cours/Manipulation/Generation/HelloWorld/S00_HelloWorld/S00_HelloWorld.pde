PShader sh;

void setup() {
  size(500, 500, P3D);
  sh = loadShader("fragment.glsl");
}

void draw() {
  background(0);
  shader(sh);
  rect(0, 0, width, height);
}