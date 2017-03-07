
#define MIN(a, b) (a <  b ? a : b)
#define MAX(a, b) (a > b ? a : b)

#define RECORD 500
#define SAMPLE 10

char sensorPin = A0;
char speakerPin = 9;

char ledPlay = 2, ledRecord = 3;

int btnRecord = 6, btnPlay = 7;

short record[RECORD];
short recordLen = 0;
short playPosition = 0;

char btnRecordState = LOW,
     btnPlayState = LOW;

char play = 0;
char doRecord = 0;

short sensorMin = 1000;
short sensorMax = 0;

short i, sensorRead, btnRead;
long probe, lastProbe = 0;

void setup()
{
  Serial.begin(9600);
  pinMode(speakerPin, OUTPUT);
  pinMode(ledPlay, OUTPUT);
  pinMode(ledRecord, OUTPUT);

  digitalWrite(ledPlay, HIGH);
  digitalWrite(ledRecord, HIGH);

  while (millis() < 5000) {
    sensorRead = analogRead(sensorPin);
    tone(speakerPin, sensorRead);      // raw tone, calibration helper
    sensorMax = MAX(sensorRead, sensorMax);
    sensorMin = MIN(sensorRead, sensorMin);
    delay(SAMPLE);
  }
  digitalWrite(ledPlay, LOW);
  digitalWrite(ledRecord, LOW);
}

inline void setMode(char m)
{
  play = m;
  digitalWrite(ledPlay, LOW);
  digitalWrite(ledRecord, LOW);
}

void loop()
{
  int btnRead = digitalRead(btnRecord);
  
  //Nagrywanie
  if (btnRead != btnRecordState) {
    btnRecordState = btnRead;

    if (btnRecordState == HIGH) { 
      play = 0;
      digitalWrite(ledRecord,LOW);
      //wylacz nagrywanie jezeli juz nagrywa
      if (doRecord == 1) {
        doRecord = 0;
        digitalWrite(ledPlay, LOW);
      }
      else
      //wlacz nagrywanie
      {
        lastProbe = 0;
        recordLen = 0;
        doRecord = 1;
        digitalWrite(ledPlay, HIGH);
      }
    }
  }

  //Odtwarzanie
  btnRead = digitalRead(btnPlay);
  
  if (btnRead != btnPlayState) {
    btnPlayState = btnRead;

    if (btnPlayState == HIGH) {  
      play = 1;     
      lastProbe = 0;
      doRecord = 0;
      playPosition = 0;
      digitalWrite(ledPlay,LOW);
      digitalWrite(ledRecord, HIGH);
    }
  }

  if (play == 0) {
    
    sensorRead = analogRead(sensorPin);
    //Serial.println(sensorRead);

    int thisPitch = map(sensorRead, sensorMin, sensorMax, 150, 1500);

    //nagrywanie
    if (doRecord == 1) {
      //zapisujemy wartosci co okreslana ilosc czasu
      probe = millis();
      if (probe - lastProbe > SAMPLE) {
        if (recordLen < RECORD) {
          lastProbe = probe;
          record[recordLen++] = thisPitch;
        } else {
            doRecord = 0;
        }
      }
    }

    tone(speakerPin, thisPitch);
    delay(SAMPLE);
  }

  //odtwarzanie
  if (play == 1) {
    if (playPosition < recordLen) {
      tone(speakerPin, record[playPosition]);
      probe = millis();
      if (probe - lastProbe > SAMPLE) {
        lastProbe = probe;
        ++playPosition;
      }
    } else {
      play = 0;
      digitalWrite(ledPlay,LOW);
      digitalWrite(ledRecord,LOW);
    }
    delay(SAMPLE);
  }
}
