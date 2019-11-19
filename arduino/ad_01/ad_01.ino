#include <limits.h>

void setup() {
  Serial.begin(115200);
  // put your setup code here, to run once:
  pinMode(A0, INPUT);
}

float beat = 0;

float ease(float cur, float prev, float f){
  return (cur * f) + (prev * (1.0f - f));
}

void loop() {
 
  beat = ease(digitalRead(A0) * 1024.0, beat, .01);
 
  plot();
  
  delay(1);
  
  
  // put your main code here, to run repeatedly:

}

void plot(){
  Serial.print(0);
  Serial.print(" ");
  Serial.print(analogRead(A3));
  Serial.print(" ");
  Serial.print(beat);
  Serial.print(" ");
  Serial.print(1024);
  Serial.println(" ");
}
}

