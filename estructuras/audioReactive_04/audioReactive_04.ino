int contador = 0;

int redPin = 10;
int greenPin = 9;
int bluePin = 6;

int redValue = 0;
int greenValue = 0;
int blueValue = 0;

HCSR04 hcsr04(TRIG_PIN, ECHO_PIN, 20, 4000);

void setup() {
  Serial.begin(115200);
}

int annoying = 0;

long tiempoDemora = 2; // ms
long ultimaLectura = 0; 

int rojos [] = { 211, 147, 13, 13};
int verdes[] = { 51, 13, 147, 63};
int azules[] = { 51, 13, 30, 147};

void loop() {

  Serial.println(hcsr04.ToString());

  int valorSensor = hcsr04;

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
    int cual = random(0,4);
    
    redValue =  rojos[cual];
    greenValue = verdes[cual];
    blueValue = azules[cual];
  }

  analogWrite(redPin, map(annoying/4, 0, 255, 0, redValue));
  analogWrite(greenPin, map(annoying/4, 0, 255, 0, greenValue));
  analogWrite(bluePin, map(annoying/4, 0, 255, 0, blueValue));
  
}
