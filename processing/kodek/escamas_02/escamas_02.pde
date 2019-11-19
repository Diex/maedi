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

import ddf.minim.*;
import ddf.minim.ugens.*;


OscP5 oscP5;




Minim       minim;
AudioOutput out;
Oscil       wave;




Escamas escamas1;

PVector acc = new PVector();
PVector ypr = new PVector();

Quaternion quat = new Quaternion();

void setup() {
  size(800, 600, P3D);

  escamas1 = new Escamas();

  /* start oscP5, listening for incoming messages at port 9999 */
  oscP5 = new OscP5(this, 9999);

  oscP5.plug(this, "imu", "/k4/imuquat");
  oscP5.plug(this, "realacc", "/k4/realacc");
  oscP5.plug(this, "ypr", "/k4/ypr");


  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();

  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  wave = new Oscil( 440, 0.5f, Waves.SINE );
  // patch the Oscil to the output
  //wave.patch( out );
}


public void imu(float quant_w, float quant_x, float quant_y, float quant_z) {
  //println(quant_w, quant_x, quant_y, quant_z);
  quat.set(quant_w, quant_x, quant_y, quant_z);
   
}

public void realacc(float quant_x, float quant_y, float quant_z) {
  //println(quant_w, quant_x, quant_y, quant_z);
  acc.set(quant_x, quant_y, quant_z);
}

public void ypr(float quant_x, float quant_y, float quant_z) {
  //println(quant_w, quant_x, quant_y, quant_z);
  //ypr.set(degrees(quant_x), degrees(quant_y), degrees(quant_z));
  //println(ypr);
}


void plotAngle() {


  pushStyle();
  rectMode(CENTER);
  fill(255);
  rect(100, 100, 100, 100);

  float rad = 25;
  stroke(0);


  float x = cos(radians(ypr.y)) *rad;
  float y = sin(radians(ypr.y)) *rad;

  line(100, 100, 100+x, 100+y);
  popStyle();
}

void soundControl()
{
  // usually when setting the amplitude and frequency of an Oscil
  // you will want to patch something to the amplitude and frequency inputs
  // but this is a quick and easy way to turn the screen into
  // an x-y control for them.

  float amp = map( ypr.x, -180, 180, 1, 0.1 );
  wave.setAmplitude( amp );

  float freq = map( ypr.z, -180, 180, 110, 880 );
  wave.setFrequency( freq );
}





void draw() {
 
  background(255);
  //ypr.set(360 * noise(value,1,1), 360 * noise(1,value,1),360 * noise(1,1,value));
  //acc.set(1000 * noise(value,2,2), 1000 * noise(2,value,2), 1000 * noise(2,2,value));
  
  //float value = frameCount * 0.0001;
  //float acc2 = 100 * (mouseX - pmouseX);
  
  //escamas1.c2 = map(abs(acc2), 0, 2000, 50, 255);
  //println(ypr, acc2);
  
  pushMatrix();
  translate(width/2, height/2);
  fill(0);
  
  ellipse(0,0, 10, 10);
  
  //rotateX(radians(ypr.x));
  //rotateY(radians(ypr.y));
  //rotateZ(radians(ypr.z));
  
  //float[] axis = quat.toAxisAngle();
  //rotate(-axis[0], -axis[1], -axis[3], axis[2]);
  escamas1.update();
  escamas1.dibujar();
  
  
  //soundControl();
  //escamas1.angle(ypr.y);
  //escamas1.update();
  
  //translate(width/2, height/2);
  
  
  popMatrix();
  
  //plotAngle();
  
  noStroke();
  //fill(255,1);
  //rect(-10,-10, width+10, height+10);
}

void keyPressed()
{ 
  switch( key )
  {
  case '1': 
    wave.setWaveform( Waves.SINE );
    break;

  case '2':
    wave.setWaveform( Waves.TRIANGLE );
    break;

  case '3':
    wave.setWaveform( Waves.SAW );
    break;

  case '4':
    wave.setWaveform( Waves.SQUARE );
    break;

  case '5':
    wave.setWaveform( Waves.QUARTERPULSE );
    break;

  default: 
    break;
  }
}
