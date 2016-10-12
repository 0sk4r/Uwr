const int sensor = A0;
const int speaker = 8;
const int led = 10;
const int button = 9;

unsigned int sensorValue = 0;
unsigned int delayTime = 0;
unsigned int ledConstraint = 0;
unsigned int buttonState = 0;
unsigned int current_status = 0;

void setup() {
  pinMode(led, OUTPUT);      
  pinMode(speaker, OUTPUT);
  
  pinMode(button, INPUT);
  
  randomSeed(analogRead(1));
  
  reset_program();
//  current_status = 1;
  
  Serial.begin(9600);
}

void reset_program() {
  ledConstraint = random(600, 900);
  current_status = 0;
  digitalWrite(led, LOW);
}

void debug_info() {
  Serial.print("SENSOR = ");
  Serial.print(sensorValue);
  
  Serial.print(" | DELAY = ");
  Serial.print(delayTime);
  
  Serial.print(" | CONS = ");
  Serial.print(ledConstraint);
  
  Serial.print(" | BTN = ");
  Serial.print(buttonState);
  
  Serial.println("");
}

void loop(){
  sensorValue = analogRead(sensor);
  buttonPress = digitalRead(button);
  debug_info();
  
  if (buttonPress == 1) {
    reset_program();
  }
  
  if (current_status == 0) {    
    if (sensorValue >= ledConstraint) {
      current_status = 1;
      digitalWrite(led, HIGH);
    } else {
      sensorValue = constrain(sensorValue, 1, ledConstraint);
      delayTime = map(sensorValue, 1, ledConstraint, 1000, 20);
      tone(speaker, 500, 10);
      delay(delayTime);
    }
  } else {
    tone(speaker, 2000, 200);
    delay(200);
  }
}
