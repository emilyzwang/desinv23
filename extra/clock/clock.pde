/*
* practice with shapes, time, and draw()
* Emily Wang
* 6.17.19
*/

PFont mono;
int textX;
int textY;
int textW;
color dark = #2E2C2A;
color light = #625D58;
int screenX;
int screenY;
int screenW;
int screenL;
double wait, stopmin, pause, stophr, stopsec, pauseSec;
int h, m, s;
String ampm;
boolean changeAMPM;

void setup() {
  size(800, 800);
  mono = createFont("BPmono.ttf", height/3 - 20);
  wait = 200;
  stopsec = Double.POSITIVE_INFINITY;
  stopmin = Double.POSITIVE_INFINITY;
  stophr = Double.POSITIVE_INFINITY;
  changeAMPM = false;
  textFont(mono);
  color c = #E0DAED;
  background(c);
  colorMode(HSB);
  drawShadow(color(hue(c), saturation(c), brightness(c) - 20), 
              width/8 - 50, height/3, width * 3/4 + 100, height/3);
  drawClock(#836648, width/16, height/3, width * 7/8, height/3);
  h = hour();
  m = minute();
  s = second();
  writeMinHr(m, h);
  writeSec(s);
  writeAMPM(h);
}

void writeMinHr(int m, int h) {
  fill(255);
  textSize(height/4);
  text(nf(civTime(h), 2), textX, textY);
  text(nf(m, 2), textX + textW, textY);
  writeAMPM(h);
  pause = Double.POSITIVE_INFINITY;
}

void writeSec(int s) {
  fill(255);
  textSize(65);
  text(nf(s, 2), textX + 2 * textW - 14, textY + 10);
  pauseSec = Double.POSITIVE_INFINITY;
}

void writeAMPM(int h) {
  ampm = update(h);
  fill(255);
  textSize(65);
  text(ampm, textX + 2 * textW - 14, textY - 95);
}

String update(int h) {
  if (h < 12) {
    return "AM";
  } else {
    return "PM";
  }
}

int civTime(int h) {
  if (h == 0) {
    return 12;
  }
  else if (h <= 12) {
    return h;
  } else {
    return h - 12;
  }
}

void draw() {
  if (hour() != h) {
    drawTop(dark, screenX + 10, screenY + 10, screenW/2 - 65, screenL/2 - 10);
    stophr = millis() + wait;
    h = hour();
    if (ampm != update(h)) {
      changeAMPM = true;
      drawTop(dark, screenX + screenW - 100, screenY + 10, 90, screenL/4 - 10);
    }
  }
  if (minute() != m) {
    drawTop(dark, screenX + screenW/2 - 45, screenY + 10, screenW/2 - 65, screenL/2 - 10);
    stopmin = millis() + wait;
    m = minute();
  }
  if (second() != s) {
    drawTop(dark, screenX + screenW - 100, screenY + screenL/2 + 5, 90, screenL/4 - 10);
    stopsec = millis() + wait;
    s = second();
  }
  if (stopsec < millis()) {
    drawBottom(light, screenX + screenW - 100, screenY + (screenL * 3/4) - 5, 90, screenL/4 - 5);
    pause = millis() + wait;
    stopsec = Double.POSITIVE_INFINITY;
  }
  if (stopmin < millis()) {
    drawBottom(light, screenX + screenW/2 - 45, screenY + screenL/2, screenW/2 - 65, screenL/2 - 10);
    stopmin = Double.POSITIVE_INFINITY;
  }
  if (stophr < millis()) {
    drawBottom(light, screenX + 10, screenY + screenL/2, screenW/2 - 65, screenL/2 - 10);
    stophr = Double.POSITIVE_INFINITY;
    if (changeAMPM) {
      drawBottom(light, screenX + screenW - 100, screenY + screenL/4, 90, screenL/4 - 5);
      changeAMPM = false;
    }
  }
  if (pause < millis()) {
    writeSec(s);
    writeMinHr(m, h);
  }
  line(textX - 10, height/2, textX + textW - 25, height/2);
  line(textX + textW - 15, height/2, textX + 2 * textW - 30, height/2);
}

void drawClock(color c, int x, int y, int w, int l) {
  drawLegs(0, x, y + l, w);
  stroke(c);
  fill(c);
  rect(x, y, w, l);
  c = color(hue(c), saturation(c), brightness(c) - 20);
  stroke(c);
  fill(c);
  quad(x, y, x + w, y, x + w - 50, y - 20, x + 50, y - 20);
  line(x, y, x + 20, y + 20);
  line(x, y + l, x + 20, y + l - 20);
  line(x + w, y, x + w - 20, y + 20);
  line(x + w, y + l, x + w - 20, y + l - 20);
  drawScreen(#D8D8D8, x + 20, y + 20, w - 40, l - 40);
}

void drawShadow(color c, int x, int y, int w, int l) {
  stroke(c);
  fill(c);
  quad(x, y + l, x + w, y, x + w + width/2, y + height/2, x + width/2, y + l + height/2);
}

void drawLegs(color c, int x, int y, int w) {
  stroke(c);
  fill(c);
  drawLeg(x + 30, y);
  drawLeg(x + w - 50, y);
}

void drawLeg(int x, int y) {
  quad(x, y, x + 20, y, x + 15, y + 10, x + 5, y + 10);
}

void drawScreen(color c, int x, int y, int w, int l) {
  stroke(c);
  strokeWeight(3);
  fill(255);
  rect(x, y, w, l);
  screenX = x;
  screenY = y;
  screenW = w;
  screenL = l;
  drawTop(dark, x + 10, y + 10, w/2 - 65, l/2 - 10);
  drawTop(dark, x + w/2 - 45, y + 10, w/2 - 65, l/2 - 10);
  drawBottom(light, x + 10, y + l/2, w/2 - 65, l/2 - 10);
  drawBottom(light, x + w/2 - 45, y + l/2, w/2 - 65, l/2 - 10);
  textX = x + 20;
  textY = y + l - 50;
  textW = w/2 - 50;
  drawTop(dark, x + w - 100, y + 10, 90, l/4 - 10);
  drawBottom(light, x + w - 100, y + l/4, 90, l/4 - 5);
  drawTop(dark, x + w - 100, y + l/2 + 5, 90, l/4 - 10);
  drawBottom(light, x + w - 100, y + (l * 3/4) - 5, 90, l/4 - 5);
}

void drawTop(color c, int x, int y, int w, int l) {
  stroke(c);
  fill(c);
  rect(x, y, w, l, 10, 10, 0, 0);
}

void drawBottom(color c, int x, int y, int w, int l) {
  fill(c);
  rect(x, y, w, l, 0, 0, 10, 10);
}
