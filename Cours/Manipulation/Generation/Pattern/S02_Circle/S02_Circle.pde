PShader sh;

void setup() {
  size(500, 500, P3D);
  smooth(8);
  sh = loadShader("fragment.glsl");
  
}

void draw() {
  sh.set("i_resolution", (float) width, (float) height);
  sh.set("i_time", millis( )/ 1000.0);
  sh.set("i_margin", 0.59);
  sh.set("i_blur", 0.01);


  background(0);
  shader(sh);
  rect(0, 0, width, height);

  surface.setTitle("FPS " + frameRate);
}