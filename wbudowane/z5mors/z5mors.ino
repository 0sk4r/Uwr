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
String alfabet[] = {
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z"
};
int button = 2;
int led = 3;
int speaker = 6;
int lenght = 0;
unsigned long time;
String morse_code = "";
void setup() {
  pinMode(button, INPUT);
  pinMode(speaker, OUTPUT);
  Serial.begin(9600);
}
void loop() {
  if (lenght > 0 && millis() - time > 2000)
  {
    if (lenght > 4)
    {
      Serial.println(morse_code);
      Serial.println("Nie ma takiego kodu!");
      lenght = 0;
      morse_code = "";
    }
    else
    {
      Serial.println(morse_code);
      for (int i = 0; i < 26; i++) {
        if (mors[i] == morse_code) {
          Serial.print(alfabet[i]);
        }
      }
      lenght = 0;
      morse_code = "";
    }
  }
  if (digitalRead(button) == HIGH)
  {
    if (millis() - time > 5000) Serial.print(" ");
    digitalWrite(speaker, HIGH);
    tone(speaker,700);
    time = millis();
    while (digitalRead(button) == HIGH) {}
    if (millis() - time > 300) {
      morse_code += "-";
    }
    else {
      morse_code += ".";
    }
    lenght++;
    digitalWrite(speaker, LOW);
    noTone(speaker);
  }
}

