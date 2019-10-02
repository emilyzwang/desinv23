int switchPin1 = 2;
int switchPin2 = 4;

int piezo = 8;

long freqIn;
long blow1;
long blow2;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  pinMode(switchPin1, INPUT_PULLUP);
  pinMode(switchPin2, INPUT_PULLUP);

  pinMode(piezo, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatesdly:
  Serial.println(10 + digitalRead(switchPin1));
  Serial.println(20 + digitalRead(switchPin2));

  delay(1000);

  if (Serial.available() > 0) {
    float dist = Serial.read();
    
    // launch
    freqIn = 200;
    for(int i = 0; i < dist; i++) {
      piezoTone(100000/freqIn, 10);
      freqIn += 2;
    }
    
    // explosion
    for(int k = 0; k < 100; k++){
      blow1 = random(500,1000);
      blow2 = random(1,5);
      piezoTone(blow1,blow2);
    }  
  }
}

/*
 * source: code for firework sounds from http://learn.olympiacircuits.com/410-piezo-fireworks.html
 */

void piezoTone(long freq, long duration) {
  long aSecond = 1000000;
  long period = aSecond/freq;
  duration = duration*1000;
  duration = duration/period;
  for(long k = 0; k < duration; k++){
    digitalWrite(piezo,HIGH);
    delayMicroseconds(period/2);
    digitalWrite(piezo,LOW);
    delayMicroseconds(period/2);
  }
}
