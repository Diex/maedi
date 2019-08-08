int contador = 0;

int redPin = 10;
int greenPin = 9;
int bluePin = 6;

void setup() {
  Serial.begin(115200);
}

int annoying = 0;

long tiempoDemora = 2; // ms
long ultimaLectura = 0; 


void loop() {
  
  int valorSensor = analogRead(A0);

  if(valorSensor > 512){
     annoying = constrain(annoying + 1, 0, 1024);
  }

  

  if(millis() - ultimaLectura > tiempoDemora){
    ultimaLectura = millis();
    // hago algo...
     annoying = constrain(annoying - 1, 0, 1024);
  }

  analogWrite(redPin, map(annoying, 0, 1024, 0, 255));
  analogWrite(greenPin, map(annoying, 0, 1024, 255, 0));
  
}
