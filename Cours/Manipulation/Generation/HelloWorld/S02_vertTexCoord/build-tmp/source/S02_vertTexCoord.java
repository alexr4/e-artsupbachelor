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

public class S02_vertTexCoord extends PApplet {

PShader sh;

public void setup() {
  
  sh = loadShader("fragment.glsl");
}

public void draw() {
  sh.set("i_resolution", (float) width, (float) height);
  sh.set("mouseX", (float) mouseX);
  
  background(0);
  shader(sh);
  rect(0, 0, width, height);
}
  public void settings() {  size(500, 500, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "S02_vertTexCoord" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
