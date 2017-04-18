PShader sh;

void setup() {
  size(500, 500, P3D);
  sh = loadShader("fragment.glsl");
}

void draw() {
  sh.set("i_resolution", (float) width, (float) height);
  sh.set("i_mouse", (float) mouseX, (float) mouseY);
  sh.set("i_time", (float) frameCount * 0.01);
  
  background(0);
  shader(sh);
  rect(0, 0, width, height);
}