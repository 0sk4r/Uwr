int led = 8;
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
  digitalWrite(led, HIGH);
  delay(5);
  digitalWrite(led, LOW);
  delay(20);
}

void long_signal()
{
  digitalWrite(led, HIGH);
  delay(10);
  digitalWrite(led, LOW);
  delay(20);
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
    character -= 'a';

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
