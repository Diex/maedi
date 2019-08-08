void setup() {
  
  Serial.begin(115200);
//  analogReference(INTERNAL);
}

void loop() {
  delayMicroseconds(100);
//  Serial.print(0);  // To freeze the lower limit
//  Serial.print(" ");
//  Serial.print(1023);  // To freeze the upper limit
//  Serial.print(" ");
  int valorAmplificado = map(analogRead(A0), 450, 600, 100, 1000);
  Serial.println(valorAmplificado);  // To send all three 'data' points to the plotter
}
