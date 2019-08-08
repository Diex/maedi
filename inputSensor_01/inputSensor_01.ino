#define SENSOR 8
#define LED 13
#define POTE A0

void setup() {
  pinMode(SENSOR, INPUT);
  pinMode(LED, OUTPUT);
  pinMode(POTE, INPUT);
  
  Serial.begin(115200);
  
}

void loop() {
  digitalWrite(LED, digitalRead(SENSOR));

  int valorPote = 0;
  valorPote = analogRead(POTE);

  Serial.println(valorPote);
  
}
