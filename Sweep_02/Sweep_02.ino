#include <Servo.h>

Servo varilla;  // create servo object to control a servo
                  // twelve servo objects can be created on most boards
int pos = 0;    // variable to store the servo position
int joyX = A0;
int joyY = A1;

int joyX_value;
int joyY_value;

void setup() {
  varilla.attach(9);  // attaches the servo on pin 9 to the servo object
  Serial.begin(115200);
}

void loop() {
  
 joyX_value = analogRead(joyX);   // 0 -1024
 joyY_value = analogRead(joyY);
 
 joyX_value = map(joyX_value, 0, 1024, 0, 180 ); 
 varilla.write(joyX_value);   // 0 - 180

 Serial.println(joyY_value); 

 delay(10);
}

