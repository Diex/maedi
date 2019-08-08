int red = 10;
int green = 9;
int blue = 6;

void setup() {
  // put your setup code here, to run once:
  
}

void loop() {
  delay(1000);
  analogWrite(red, random(255));
  analogWrite(green, random(255));
  analogWrite(blue, random(255));
}
