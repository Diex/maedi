int contador = 0;

int redPin = 10;
int greenPin = 9;
int bluePin = 6;

int redValue = 0;
int greenValue = 0;
int blueValue = 0;

void setup() {
  Serial.begin(115200);
}

int annoying = 0;

long tiempoDemora = 2; // ms
long ultimaLectura = 0; 


void loop() {
  
  int valorSensor = analogRead(A0);

  // incremento el valor brillo...
  if(valorSensor > 512){
     annoying = constrain(annoying + 1, 0, 1024);
  }
  // decremento ese valor de brillo
  if(millis() - ultimaLectura > tiempoDemora){
    ultimaLectura = millis();
     annoying = constrain(annoying - 1, 0, 1024);
  }

  if(annoying == 0){
    redValue = random(255);
    greenValue = random(128, 200);
    blueValue = random(0);
  }

  analogWrite(redPin, map(annoying/4, 0, 255, 0, redValue));
  analogWrite(greenPin, map(annoying/4, 0, 255, 0, greenValue));
  analogWrite(bluePin, map(annoying/4, 0, 255, 0, blueValue));
  
}
