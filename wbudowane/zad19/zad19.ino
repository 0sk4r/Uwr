short pinX = 1;
short pinY = 0;

short pinB = 8;
short pinR = 9;

short pinButton = 6;

short valueBlue;
short valueRed;

unsigned long time;
unsigned long timeDifference = 0;
bool changed = true;

short tolerance = 20;

bool gameOver = false;

void setup() {
  Serial.begin(9600);
  pinMode(pinX, INPUT);
  pinMode(pinY, INPUT);
  
  pinMode(pinB, OUTPUT);
  pinMode(pinR, OUTPUT);
  
  pinMode(pinButton, INPUT);
  
  randomSeed(analogRead(2));

  valueBlue = random(256);
  valueRed = random(256);
    
  analogWrite(pinB, valueBlue);
  analogWrite(pinR, valueRed);
  
  delay(1000);
  
  time = millis();
  
  analogWrite(pinB, 0);
  analogWrite(pinR, 0);
}

short y;
short x;

short currentValueBlue = 0;
short currentValueRed = 0;

short maxChangeX;
short maxChangeY;

void loop() {  
  if (digitalRead(pinButton) != HIGH) {
    analogWrite(pinB, valueBlue);
    analogWrite(pinR, valueRed);
    return;
  }

  analogWrite(pinB, currentValueBlue);
  analogWrite(pinR, currentValueRed);
  
  if (gameOver) {
    Serial.println("koniec");
    migniecie();
    valueBlue = random(256);
    valueRed = random(256);
    gameOver = false;
  }

  y = analogRead(pinY);
  x = analogRead(pinX);
  
  x -= 450;
  x = map(x, 0, 512, 0, 255);
  
  y -= 450;
  y = map(y, 0, 512, 0, 255);
  
  if (x > 0 && y > 0) {
    maxChangeX = max(x, maxChangeX);
    maxChangeY = max(y, maxChangeY);
    
    time = millis();
    changed = false;
  }
  
  if (millis() - time > 500 && changed == false) {
   
    currentValueBlue = (maxChangeY);    
    currentValueRed = (maxChangeX);
    
    Serial.print(valueRed);
    Serial.print(" ");
    Serial.print(valueBlue);
    Serial.print(" => ");
    
    Serial.print(currentValueRed);    
    Serial.print(" ");
    Serial.println(currentValueBlue);   

    if (wPrzedziale(currentValueRed, valueRed - tolerance, valueRed + tolerance) && 
        wPrzedziale(currentValueBlue, valueBlue - tolerance, valueBlue + tolerance)) {
        gameOver = true;
        migniecie();
    }

    changed = true;
    maxChangeX = 0;
    maxChangeY = 0;
  }
}

bool wPrzedziale(short val, short minimum, short maximum) 
{
  minimum = max(0, minimum);
  maximum = min(255, maximum);
  
  return val >= minimum && val <= maximum;
}

void migniecie()
{
  analogWrite(pinB,currentValueBlue);
  analogWrite(pinR,currentValueRed);
  delay(100);  
  analogWrite(pinB,0);
  analogWrite(pinR,0);
  delay(100);
  analogWrite(pinB, currentValueBlue);
  analogWrite(pinR, currentValueRed);
  delay(100);
  analogWrite(pinB,0);
  analogWrite(pinR,0);
  delay(100);
}
