/**
 * oscP5parsing by andreas schlegel
 * example shows how to parse incoming osc messages "by hand".
 * it is recommended to take a look at oscP5plug for an
 * alternative and more convenient way to parse messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PShape plane;
PVector orientation = new PVector();

import toxi.geom.*;
import toxi.processing.*;


float[] q = new float[4];
Quaternion quat = new Quaternion(1, 0, 0, 0);


void setup() {
  size(800,800, P3D);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
  plane = loadShape("18709_US_carrier-based_fighter_ww2_v1.obj");
  plane.scale(10);
  //plane.rotateX(HALF_PI);
  
  
 // plane.rotateZ(0);//
}


void draw() {
  background(0);
  lights();
  //scale(2.0);
  translate(width/2, height/2);
  translate(plane.width / 2, plane.height/2, plane.depth/2);
  
  float[] axis = quat.toAxisAngle();
    rotate(axis[0], -axis[1], axis[3], axis[2]);

  //rotateX(orientation.y);
  //rotateY(orientation.x);
  //rotateZ(orientation.z);
    
   shape(plane, 0, 0 ); 
   
   println(orientation);
}






void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  if(theOscMessage.checkAddrPattern("/1/ypr")==true) {
    //orientation.x = theOscMessage.get(0).floatValue() ;     
    //orientation.y = theOscMessage.get(1).floatValue() ;
    //orientation.z = theOscMessage.get(2).floatValue() ;
  }
  
  
  if(theOscMessage.checkAddrPattern("/1/quat")==true) {
    //println(theOscMessage );
    quat.w = theOscMessage.get(0).floatValue() ;
    quat.x = theOscMessage.get(1).floatValue() ;
    quat.y = theOscMessage.get(2).floatValue() ;
    quat.z = theOscMessage.get(3).floatValue() ;
    println(quat);
  }
  
  if(theOscMessage.checkAddrPattern("/1/rot")==true) {
    //println(theOscMessage.get(0).intValue() );     
    //println(theOscMessage.get(1).intValue() );
    //println(theOscMessage.get(2).intValue() );
    
    //orientation.x = theOscMessage.get(0).intValue() ;     
    //orientation.y = theOscMessage.get(1).intValue() ;
    //orientation.x = theOscMessage.get(2).intValue() ;
  }
  
   //if(theOscMessage.checkAddrPattern("/1/rot")==true) {
  //  orientation.x = theOscMessage.get(0).intValue() ; 
    
  //  orientation.y = theOscMessage.get(1).intValue() ;
  //  orientation.x = theOscMessage.get(2).intValue() ;
  //}
  
}
