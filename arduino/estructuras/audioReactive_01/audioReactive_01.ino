int redPin = 10;
int greenPin = 9;
int bluePin = 6;


void setup() {
  Serial.begin(115200);
}

float valorPromedio = 0;

void loop() {
  
  int valorLeido =  analogRead(A0);
  
  float valorNormalizado = valorLeido * 1.0 / 1024.0;

  float valorExpandido = valorNormalizado * 1000; 
  valorPromedio = (valorPromedio+valorNormalizado)/2;
  
  


//  Serial.print(0);  // To freeze the lower limit
//  Serial.print(" ");
//  Serial.print(1000);  // To freeze the upper limit
//  Serial.print(" ");
//  Serial.print(valorExpandido);
//  Serial.print(" ");
//  Serial.print(valorPromedio * 1000);

  int valorLuz = valorPromedio * 255;
  Serial.println(valorLuz);  
  
  analogWrite(redPin, valorLuz);
  analogWrite(greenPin, valorLuz);
  analogWrite(bluePin, valorLuz);

//  Serial.println(valorAmplificado);
}
