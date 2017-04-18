PShader sh;
boolean orientation;

void setup() {
  size(500, 500, P3D);
  smooth(8);
  sh = loadShader("fragment.glsl");
  
  color A = color(0, 255, 255);
  color B = color(255, 0, 0);
  
  float[] colorAArray = getGLSLColor(A);
  float[] colorBArray = getGLSLColor(B);
  
  sh.set("colorA", colorAArray[0], colorAArray[1], colorAArray[2]);
  sh.set("colorB", colorBArray[0], colorBArray[1], colorBArray[2]);
}

void draw() {
  sh.set("i_resolution", (float) width, (float) height);
  sh.set("i_mouse", (float) mouseX, (float) mouseY);


  background(0);
  shader(sh);
  rect(0, 0, width, height);

  surface.setTitle("FPS " + frameRate);
}

void keyPressed() {
  orientation = !orientation;
}

float[] getGLSLColor(color argb) {
  float[] colorArray = new float[3];
  //extract data from color
  int a = (argb >> 24) & 0xFF;
  int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
  int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
  int b = argb & 0xFF;          // Faster way of getting blue(argb)
  //stock into arry
  colorArray[0] = (r / 255.0);
  colorArray[1] = (g / 255.0);
  colorArray[2] = (b / 255.0);
  
  return colorArray;
}