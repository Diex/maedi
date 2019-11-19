// Processing code for this example

//  This example code is in the public domain.

import processing.serial.*;

float redValue = 0;        // red value
float greenValue = 0;      // green value
float blueValue = 0;       // blue value

Serial myPort;

void setup() {
  size(200, 200);

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  
    
  myPort = new Serial(this, Serial.list()[2], 9600);
  
  
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
}




void draw() {
  // set the background color with the color values:
  background(redValue, greenValue, blueValue);
}




void serialEvent(Serial myPort) {
 
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    
    inString = trim(inString);
    
    float[] colors = float(split(inString, ","));
    
    if (colors.length >=3) {
    
      redValue = map(colors[0], 0, 1023, 0, 255);
      greenValue = map(colors[1], 0, 1023, 0, 255);
      blueValue = map(colors[2], 0, 1023, 0, 255);
    
  }
  }
}