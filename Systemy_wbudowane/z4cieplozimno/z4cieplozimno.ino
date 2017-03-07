const int sensorPin = A0;
const int speakerPin = 9;
const int ledPin = 6;
const int buttonPin = 8;

unsigned int sensorValue = 0;
unsigned int delayTime = 0;
unsigned int target = 0;
unsigned int buttonState = 0;
unsigned int current_status = 0;

void setup() {
  pinMode(ledPin, OUTPUT);      
  pinMode(speakerPin, OUTPUT);
  pinMode(buttonPin, INPUT);
  
  randomSeed(analogRead(1));
  
  resetr();
  
  Serial.begin(9600);
}

void resetr() {
  target = random(100, 900);
  current_status = 0;
  digitalWrite(ledPin, LOW);
}

void loop(){
  sensorValue = analogRead(sensorPin);
  buttonState = digitalRead(buttonPin);
  /*
  Serial.print("sensor = ");
  Serial.print(sensorValue);
   
  Serial.print("   target = ");
  Serial.print(target);
  
  Serial.print("  button = ");
  Serial.print(buttonState);
  Serial.print("\n");
  */
  
  if (buttonState == 1) {
    resetr();
  }
  
  if (current_status == 0) {    
    if ((sensorValue >= (target-5)) && ((sensorValue <= (target + 5))))  {
      current_status = 1;
      digitalWrite(ledPin, HIGH);
    } else {
      sensorValue = constrain(sensorValue, 1, target);
      delayTime = map(sensorValue, 1, target, 1000, 20);
      tone(speakerPin, 500, 10);
      delay(delayTime);
    }
  } else {
    tone(speakerPin, 2000, 200);
    delay(200);
  }
}
