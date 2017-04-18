import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class S02_Circle extends PApplet {

PShader sh;

public void setup() {
  
  
  sh = loadShader("fragment.glsl");
  
}

public void draw() {
  sh.set("i_resolution", (float) width, (float) height);
  sh.set("i_time", millis( )/ 1000.0f);
  sh.set("i_margin", 0.59f);
  sh.set("i_blur", 0.01f);


  background(0);
  shader(sh);
  rect(0, 0, width, height);

  surface.setTitle("FPS " + frameRate);
}
  public void settings() {  size(500, 500, P3D);  smooth(8); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "S02_Circle" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
