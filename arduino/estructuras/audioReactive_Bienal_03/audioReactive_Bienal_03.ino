#include <limits.h>
#include "RTClib.h"
#include <SPI.h>
#include <SD.h>
#include "colors.h"
#include "gamma8.h"

/************
 * leer: https://learn.adafruit.com/led-tricks-gamma-correction/the-issue
 * 
 */
const int chipSelect = 10;
RTC_DS1307 rtc;
File dataFile;
char filename[12];

#define GREENPIN 6
#define REDPIN  5
#define BLUEPIN 3


void setup() {
  Serial.begin(115200);
  pinMode(A0, INPUT);
  pinMode(A3, INPUT);
  setupRTC();
  setupSD();
  setupLogFile();
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
int currentColorId = 0;
DateTime now;
void loop() {
  
  beat = digitalRead(A0) > 0 ? ease(1, beat, .03)  : ease(0, beat, .0001); 
  
  if (millis() > lastSave + saveRate) {    
    now = rtc.now();
    currentTime = now.hour() * 60 + now.minute();
    currentColorId = constrain(map(currentTime, firstHour, lastHour, 0, 60), 0, 60);
    
    log();
    Serial.println(currentTime);
    Serial.println(currentColorId);
  }

  
  // modulo 1
//  g = constrain(colors[currentColorId][0] * 1.0 * beat ,0,255);
//  r = constrain(colors[currentColorId][1] * 1.0 * beat ,0,255);
//  b = constrain(colors[currentColorId][2] * 1.0 * beat ,0, 255);

// modulo 2
  g = constrain(colors[60 - currentColorId][0] * 1.0 * beat ,0, 255);
  r = constrain(colors[60 - currentColorId][1] * 1.0 * beat ,0, 255);
  b = constrain(colors[60 - currentColorId][2] * 1.0 * beat ,0, 255);

  uint8_t gg = pgm_read_byte(&gamma8[(uint8_t) g]);
  uint8_t rr = pgm_read_byte(&gamma8[(uint8_t) r]);
  uint8_t bb = pgm_read_byte(&gamma8[(uint8_t) b]);
  
  analogWrite(REDPIN, rr);
  analogWrite(GREENPIN, gg);
  analogWrite(BLUEPIN, bb);

//  plot();
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
  Serial.println("-> RTC");
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

void setupSD() {
  Serial.println("-> SD");
  Serial.print("Initializing SD card...");
  // see if the card is present and can be initialized:
  if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
  Serial.println("card initialized.");
}


void setupLogFile() {
  Serial.println("-> LogFile");
  
  char str[6];
  strcat(filename, itoa(now.year(), str, 10));
  strcat(filename, "-");
  strcat(filename, itoa(now.month(), str, 10));
  strcat(filename, "-");
  strcat(filename, itoa(now.day(), str, 10));
  strcat(filename, ".txt");
  Serial.println(filename);
  dataFile = SD.open(filename, FILE_WRITE);

}
