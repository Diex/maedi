#include <limits.h>
#include "RTClib.h"
#include <SPI.h>
#include <SD.h>

const int chipSelect = 10;
RTC_DS1307 rtc;
char daysOfTheWeek[7][12] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

// open the file. note that only one file can be open at a time,
// so you have to close this one before opening another.
File dataFile;
char filename[12];

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

void loop() { 
  //  return;
  beat = ease(digitalRead(A0) * 1024.0, beat, .01);

  if (millis() > lastSave + saveRate) {
    log();
  }


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

