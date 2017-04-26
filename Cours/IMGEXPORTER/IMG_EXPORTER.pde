import com.sun.image.codec.jpeg.*;
import java.io.*;
//sequencer
String exportPath = "";
String exportFolder = "";
int frame = 0;
boolean bufferDone;
boolean export;
int topSave;
int desiredFPS = 25;
int framePassed;
int sequenceTimeSecond;
int sequenceTimeMinute;
int topMillis;
int millisPassed;
int topSec;
int millisToSec;
int secPassed;
int minPassed;
int hourPassed;
PFont titleFont;
PFont paragraphFont;
PImage tmp;
String exportpath;
String fileName;
String extension;
int lastFrame;

public void initFont(float sizet, float sizep) {
}

void initSequenceAt(int fps_)
{
  topSave = frameCount;
  topMillis = millis();
  topSec = topMillis;
  desiredFPS = fps_;
  sequenceTimeSecond = 0;
  sequenceTimeMinute = 0;
  secPassed = 0;
  minPassed = 0;
  hourPassed = 0;
}

public void sequenceTime() {
  
  framePassed = frameCount - topSave;
  millisPassed = millis() - topMillis;
  millisToSec = millis() - topSec;

  //Count Frame
  if (framePassed%desiredFPS == 0) {
    sequenceTimeSecond++;
  }
  if (sequenceTimeSecond%60 == 0 && sequenceTimeSecond > 0) {
    sequenceTimeMinute ++;
    sequenceTimeSecond = 0;
  }

  //countTime
  int s = round(millisToSec/1000);
  int timeRef = 60;
  if (s % timeRef == 0 && s > 0) {
    if (secPassed% (timeRef-1) == 0 && secPassed > 0) {
      minPassed ++;
    }
    if (minPassed%timeRef == 0 && minPassed > 0) {
      hourPassed ++;
    }
    secPassed = 0;
    topSec = millis();
  } else {
    secPassed = s;
  }
  
  frame ++;
}

public void saveInterface(boolean e) {
  if (e) {
    pushStyle();
    stroke(255, 255, 0);
    fill(0, 220);
    rectMode(CENTER);
    rect(width/2, height/2, width, 150);
    fill(255);
    noStroke();
    textAlign(CENTER);
    text("Image : "+(frameCount-topSave)+" saved.", width/2, height/2-25);
    text("Sequence Time : "+sequenceTimeMinute+" : "+sequenceTimeSecond+" sec.\nExport time : "+hourPassed+" : "+minPassed+" : "+secPassed, width/2, height/2 + 15);
    popStyle();
  }
}

public void saveImage(int frame_, PImage tmp_, String fileName_, String path_) {
  tmp = tmp_;

  //Integer newframe = new Integer(frame_);
  fileName = fileName_;  
  exportpath = path_+"/"+fileName_+"/";
  extension = "_"+frame_+".tif";

  Thread saveImgThread = new Thread(new Runnable() {
    public void run() {
      try {
        //save(tmp, path, 1.0);
        tmp.save(exportpath+fileName+extension); //slow because we have to make a get inside CPU
        bufferDone = true;
      }
      catch (Exception ex) {
        ex.printStackTrace();
        Thread.currentThread().interrupt();
      }
    }
  }
  );
  saveImgThread.start();
}

void export(int frame_, String name, String path) {
  if (export) {
    bufferDone = false;
    sequenceTime();
    saveImage(frame_ - topSave, g.get(), path, name);
    saveInterface(export);
  }
}

void launchExport() {
  export = !export;
  if (export) {
    initSequenceAt(25);
  }
}