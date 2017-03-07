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


char sensor = A0;
int lenght = 0;
unsigned long time;
String morse_code = "";

void setup() {
  pinMode(sensor, INPUT);
  Serial.begin(9600);
}
void loop() {
  int reading = analogRead(sensor );
  //Serial.println(reading);
  if (lenght > 0 && millis() - time > 40)
  {
    if (lenght > 4)
    {
      //Serial.println(morse_code);
      Serial.println("Nie ma takiego kodu!");
      lenght = 0;
      morse_code = "";
    }
    else
    {
      //Serial.println(morse_code);
      for (int i = 0; i < 26; i++) {
        if (mors[i] == morse_code) {
          Serial.print(alfabet[i]);
        }
      }
      lenght = 0;
      morse_code = "";
    }
  }



      if (reading > 500) {
        if (millis() - time > 2000) Serial.print(" ");
        time = millis();
        while (analogRead(sensor) > 500) {}
        if (millis() - time > 7) {
          morse_code += "-";
        }
        else {
          morse_code += ".";
        }
        lenght++;
      }
    }

