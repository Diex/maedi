#include <limits.h>
#include "RTClib.h"
#include <SPI.h>
#include <SD.h>
#include "colors.h"


const int chipSelect = 10;
RTC_DS1307 rtc;
File dataFile;
char filename[12];

#define GREENPIN 6
#define REDPIN  5
#define BLUEPIN 3


void setup() {
  Serial.begin(115200);
  // put your setup code here, to run once:
  pinMode(A0, INPUT);
  setupRTC();

  Serial.print("Initializing SD card...");

  // see if the card is present and can be initialized:
  if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
  Serial.println("card initialized.");
  DateTime now = rtc.now();

  char val[6];

  strcat(filename, itoa(now.year(), val, 10));
  strcat(filename, "-");
  strcat(filename, itoa(now.month(), val, 10));
  strcat(filename, "-");
  strcat(filename, itoa(now.day(), val, 10));
  strcat(filename, ".txt");
  Serial.println(filename);
  dataFile = SD.open(filename, FILE_WRITE);

}

float beat = 0;

float ease(float cur, float prev, float f) {
  return (cur * f) + (prev * (1.0f - f));
}

int  saveRate = 1E3;  // 10 samples por segundo
unsigned long lastSave = 0;


float r = 0;
float g = 0;
float b = 0;

int currentTime = 0;

int firstHour = 11 * 60; // 8AM * 60 min
int lastHour = 21 * 60; // 22
int extra = 0;


void loop() { 
  beat = ease(digitalRead(A0) * 1024.0, beat, .001);

  if (millis() > lastSave + saveRate) {
    log();
  }

 int currentColorId = constrain(map(currentTime, firstHour, lastHour, 0, 60), 0, 60);
 
float timestep = millis() * .0005;
  
//  g = constrain(colors[currentColorId][0] * ( (sin(timestep ) + 1) / 2.0 * beat ),0,255);
//  r = constrain(colors[currentColorId][1] * ( (sin(timestep ) + 1) / 2.0 * beat ),0,255);
//  b = constrain(colors[currentColorId][2] * ( (sin(timestep ) + 1) / 2.0 * beat ),0, 255);

  g = constrain(colors[currentColorId][0] * beat ,0,255);
  r = constrain(colors[currentColorId][1] * beat ,0,255);
  b = constrain(colors[currentColorId][2] * beat ,0, 255);
  
  analogWrite(REDPIN, r);
  analogWrite(GREENPIN, g);
  analogWrite(BLUEPIN, b);
  
    plot();

  delay(1);


}

void log() {
  if (dataFile) {
    DateTime now = rtc.now();
    long utc = now.unixtime();

    lastSave = millis();
    dataFile.print(utc);
    dataFile.print(',');
    dataFile.println(beat);
    dataFile.flush();
  } else {
    Serial.println("error opening file.txt");
  }
}


void plot() {
  Serial.print(0);
  Serial.print(" ");
  Serial.print(analogRead(A3));
  Serial.print(" ");
  Serial.print(beat);
  Serial.print(" ");
  Serial.print(1024);
  Serial.println(" ");
}

void setupRTC() {
  if (! rtc.begin()) {
    Serial.println("Couldn't find RTC");
    while (1);
  }

  if (! rtc.isrunning()) {
    Serial.println("RTC is NOT running!");
    // following line sets the RTC to the date & time this sketch was compiled
    // rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
    // This line sets the RTC with an explicit date & time, for example to set
    // January 21, 2014 at 3am you would call:
    //     rtc.adjust(DateTime(2019, 8, 3, 13, 40, 0));
  }
}
