const int ledPin = 6;
const int buttonPin = 8;

int i = 0;
int remember[100] = {0};

void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT);
}
void loop() {
  digitalWrite(ledPin, remember[i]);
  remember[i] = digitalRead(buttonPin);
  i++;
  i = i % 100;
  delay(10);
}
