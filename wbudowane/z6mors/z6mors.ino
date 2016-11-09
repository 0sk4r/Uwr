int led = 3;
int speaker = 6;

String mors[] = {
  ".-",    // a
  "-...",  // b
  "-.-.",  // c
  "-..",   // d
  ".",     // e
  "..-.",  // f
  "--.",   // g
  "....",  // h
  "..",    // i
  ".---",  // j
  "-.-",   // k
  ".-..",  // l
  "--",    // m
  "-.",    // n
  "---",   // o
  ".--.",  // p
  "--.-",  // q
  ".-.",   // r
  "...",   // s
  "-",     // t
  "..-",   // u
  "...-",  // v
  ".--",   // w
  "-..-",  // x
  "-.--",  // y
  "--.."   // z
};

void short_signal()
{
  tone(speaker,700,100);
  digitalWrite(led, HIGH);
  delay(100);
  digitalWrite(led, LOW);
  delay(150);
}

void long_signal()
{
  tone(speaker,700,300);
  digitalWrite(led, HIGH);
  delay(300);
  digitalWrite(led, LOW);
  delay(150);
}

void setup()
{
  pinMode(led, OUTPUT);
  pinMode(speaker, OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  char character;
  if (Serial.available() > 0) {
    character = Serial.read();
    Serial.print("Recived: ");
    Serial.println(character);
    character -= 97;

    int i = 0;
    while (mors[character][i] == '.' || mors[character][i] == '-')
    {
      if (mors[character][i] == '.') {
        short_signal();
      }
      else {
        long_signal();
      }
      i++;
    }
    delay(50);
  }
}
