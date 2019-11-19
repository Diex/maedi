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
Escamas escamas2;
Escamas escamas3;
Escamas escamas4;


void setup() {
  //size(800, 600, P3D);
  fullScreen(P3D);

  escamas1 = new Escamas("k1");
  escamas2 = new Escamas("k2");
  escamas3 = new Escamas("k3");
  escamas4 = new Escamas("k4");

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


  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();

  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  wave = new Oscil( 440, 0.5f, Waves.SINE );
  // patch the Oscil to the output
  //wave.patch( out );
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

void soundControl()
{
  // usually when setting the amplitude and frequency of an Oscil
  // you will want to patch something to the amplitude and frequency inputs
  // but this is a quick and easy way to turn the screen into
  // an x-y control for them.

  //float amp = map( ypr.x, -180, 180, 1, 0.1 );
  //wave.setAmplitude( amp );

  //float freq = map( ypr.z, -180, 180, 110, 880 );
  //wave.setFrequency( freq );
}





void draw() {

  //background(255);

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


  //soundControl();

  popMatrix();

  //plotAngle();

  noStroke();
  //fill(255,1);
  //rect(-10,-10, width+10, height+10);
}

void keyPressed()
{ 
  
    if(key == ' ') background(255);
    
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
