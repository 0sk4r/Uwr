
#define MIN(a, b) (a < b ? a : b)
#define MAX(a, b) (a > b ? a : b)

#define RECORD 500
#define SAMPLE 10

char sensorPin = A0;
char speakerPin = 9;

char ledRed = 2, ledGreen = 4;

int btnRecord = 6, btnPlay = 7;

double gap = 1.148698355;

short record[RECORD];
short recordLen = 0;
short playPosition = 0;

char btnRecordState = LOW,
     btnPlayState = LOW;

/* Modes: 0 -> normal, 1 -> playing */
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
  pinMode(ledRed, OUTPUT);
  pinMode(ledGreen, OUTPUT);

  digitalWrite(ledRed, HIGH);
  digitalWrite(ledGreen, HIGH);

  while (millis() < 5000) {
    sensorRead = analogRead(sensorPin);
    tone(speakerPin, sensorRead);      // raw tone, calibration helper
    sensorMax = MAX(sensorRead, sensorMax);
    sensorMin = MIN(sensorRead, sensorMin);
    delay(SAMPLE);
  }
  digitalWrite(ledRed, LOW);
  digitalWrite(ledGreen, LOW);
}

inline void setMode(char m)
{
  play = m;
  digitalWrite(ledRed, LOW);
  digitalWrite(ledGreen, LOW);
}

void loop()
{
  /* Check buttons */
  int btnRead = digitalRead(btnRecord);
  //Record
  if (btnRead != btnRecordState) {
    btnRecordState = btnRead;

    if (btnRecordState == HIGH) { // event: record button has been pressed
      setMode(0);               // force normal/recording mode
      if (doRecord == 1) {      // if already recording, turn of
        doRecord = 0;
        digitalWrite(ledRed, LOW);
      }
      else
      {
        lastProbe = 0;
        recordLen = 0;
        doRecord = 1;
        digitalWrite(ledRed, HIGH);
      }
    }
  }

  //Play
  btnRead = digitalRead(btnPlay);
  if (btnRead != btnPlayState) {    // event: play button state has changed
    btnPlayState = btnRead;

    if (btnPlayState == HIGH) {   // event: play button has been pressed
      setMode(1);
      
      lastProbe = 0;
      doRecord = 0;
      playPosition = 0;
      digitalWrite(ledGreen, HIGH);
    }
  }

  if (play == 0) {
    
    sensorRead = analogRead(sensorPin);
    Serial.println(sensorRead);
    
    int thisPitch = map(sensorRead, sensorMin, sensorMax, 150, 1500);

    if (doRecord == 1) {
      probe = millis();
      if (probe - lastProbe > SAMPLE) {
        if (recordLen < RECORD) {
          lastProbe = probe;
          record[recordLen++] = thisPitch;
        } else {
            doRecord = 0;
            digitalWrite(ledRed, LOW);
        }
      }
    }

    tone(speakerPin, thisPitch);
    delay(SAMPLE);
  }

  if (play == 1) {
    if (playPosition < recordLen) {
      tone(speakerPin, record[playPosition]);
      probe = millis();
      if (probe - lastProbe > SAMPLE) {
        lastProbe = probe;
        ++playPosition;
      }
    } else {
      setMode(0);
    }
  }
}
