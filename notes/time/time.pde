/*
* Time Exercise
* Emily Wang
* 6.17.19
*/

long millis;
int sec;
int min;
int hour;
int day;
int month;
int year;

void setup() {
  fullScreen();
  
}

void draw() {
  clear();
  background(0);
  millis = millis();
  sec = second();
  min = minute();
  hour = hour();
  day = day();
  month = month();
  year = year();
  textSize(100);
  text(millis, 100, 100);
  
  rect(100, 100, sec * 5, 50);
  rect(300, 200, 200 * cos(radians(sec * 60)), 50);
}
