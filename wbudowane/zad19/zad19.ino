short pinX = 1;
short pinY = 0;

short pinB = 13;
short pinR = 12;

short pinButton = 2;

short valueBlue;
short valueRed;

unsigned long time;
unsigned long timeDifference = 0;
bool changed = true;

short tolerance = 10;

bool gameOver = false;

void setup() {
  // put your setup code here, to run once:
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
  
  analogWrite(pinB, 255);
  analogWrite(pinR, 255);
}

short y;
short x;

short currentValueBlue = 0;
short currentValueRed = 0;

short maxChangeX;
short maxChangeY;

void loop() {  
  if (digitalRead(pinButton) == HIGH) {
    analogWrite(pinB, valueBlue);
    analogWrite(pinR, valueRed);
    return;
  }

  //analogWrite(pinB, 255 - currentValueBlue);
  //analogWrite(pinR, 255 - currentValueRed);
  
  if (gameOver) {
    return;
  }

  y = analogRead(pinY);
  x = analogRead(pinX); 
  //Serial.println(y);
  
  
  
  x -= 450;
  x = map(x, 0, 512, 0, 255);
  
  y -= 450;
  y = map(y, 0, 512, 0, 255);
  //Serial.println(x);
  
  if (x > 0 && y > 0) {
    maxChangeX = max(x, maxChangeX);
    maxChangeY = max(y, maxChangeY);
    //Serial.println("lol");
    time = millis();
    changed = false;
  }
  
  if (millis() - time > 500 && changed == false) {
   
    currentValueBlue = (currentValueBlue + maxChangeY) % 255;    
    currentValueRed = (currentValueRed + maxChangeX) % 255;
    
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
  analogWrite(pinB, 255 - currentValueBlue);
  analogWrite(pinR, 255 - currentValueRed);
  delay(100);  
  analogWrite(pinB, 255);
  analogWrite(pinR, 255);
  delay(100);
  analogWrite(pinB, 255 - currentValueBlue);
  analogWrite(pinR, 255 - currentValueRed);
  delay(100);
  analogWrite(pinB, 255);
  analogWrite(pinR, 255);
  delay(100);
}
