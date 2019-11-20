import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import oscP5.*;
import netP5.*;
import processing.sound.*;


OscP5 oscP5;

Escamas escamas1;
Escamas escamas2;
Escamas escamas3;
Escamas escamas4;


SoundFile [] backgrounds = new SoundFile[3];
TimeoutThread timeout;
boolean canReset = false;

int resetTimer = 10; // minutos.


String rand = "";


void setup() {
  size(1280, 800, P3D);
  //fullScreen(P3D);
  

  backgrounds[0] = new SoundFile(this, "back 1.wav");
  backgrounds[1] = new SoundFile(this, "back 2.wav");
  backgrounds[2] = new SoundFile(this, "back 3.wav");

  
  escamas1 = new Escamas("k1", new SoundFile(this, "action 4.wav"));
  escamas2 = new Escamas("k2", new SoundFile(this, "action 3.wav"));
  escamas3 = new Escamas("k3", new SoundFile(this, "action 2.wav"));
  escamas4 = new Escamas("k4", new SoundFile(this, "action 1 B.wav"));




  /* start oscP5, listening for incoming messages at port 9999 */
  oscP5 = new OscP5(this, 9999);

  oscP5.plug(escamas4, "imu", "/k4/imuquat");
  oscP5.plug(escamas4, "realacc", "/k4/realacc");

  oscP5.plug(escamas3, "imu", "/k3/imuquat");
  oscP5.plug(escamas3, "realacc", "/k3/realacc");

  oscP5.plug(escamas2, "imu", "/k2/imuquat");
  oscP5.plug(escamas2, "realacc", "/k2/realacc");

  oscP5.plug(escamas1, "imu", "/k1/imuquat");
  oscP5.plug(escamas1, "realacc", "/k1/realacc");

  


  reset();
  
  timeout = new TimeoutThread(this, "doReset", (int) (resetTimer * 60E3), true);
}

public void doReset(){
  canReset = true;
}

int colorPallet = 0;

color colorPallets[][] = {
  {#ffdfdf, #fbc1bc, #315b96, #233567, #3c4245}, 
  {#4baea0, #b6e6bd, #f1f0cf, #f0c9c9, #d2fafb},
  {#202040, #202060, #602080, #b030b0, #ecfcff},
  {#eafbea, #6f9a8d, #1f6650, #ea5e5e, #ffdc34},
  {#ffe7d1, #f6c89f, #4b8e8d, #396362, #c2e8ce},
  {#ffd369, #e26241, #940a37, #5b0909, #9d0b0b}
};



public void reset() {

  for(int bg = 0; bg < backgrounds.length; bg++){
    backgrounds[bg].stop();
  }
  
  int newbg = (int) random(backgrounds.length);  
  backgrounds[newbg].loop();
  backgrounds[newbg].amp(0.6);
  
  

  colorPallet = (int) random(colorPallets.length);


  escamas1.reset(colorPallets[this.colorPallet][0]);
  escamas2.reset(colorPallets[this.colorPallet][1]);
  escamas3.reset(colorPallets[this.colorPallet][2]);
  escamas4.reset(colorPallets[this.colorPallet][3]);

  rand = "";
  frameNumber = 0;
  
  for (int i = 0; i < 8; i++) {
    rand += (char) random(97, 122);
  }
  
  
  background(colorPallets[this.colorPallet][4]);
}



void plotAngle() {


  pushStyle();
  rectMode(CENTER);
  fill(255);
  rect(100, 100, 100, 100);

  float rad = 25;

  stroke(0);
  popStyle();
}





int frameNumber = 0;

void draw() {
  
  if(canReset){
    reset();
    canReset = false;
  }
  
  pushMatrix();
  translate(width/2, height/2);
  fill(0);


  escamas1.update();
  escamas1.dibujar();

  escamas2.update();
  escamas2.dibujar();

  escamas3.update();
  escamas3.dibujar();

  escamas4.update();
  escamas4.dibujar();

  popMatrix();
  //plotAngle();
  noStroke();
  //fill(255,1);
  //rect(-10,-10, width+10, height+10);
  
  if(frameCount % 60 == 0) {    
    saveFrame("./images/" + rand + "/" + frameNumber + ".jpg");
    frameNumber++;
  }
}

void keyPressed()
{ 

  if (key == ' ') {
    reset();
  }
}
