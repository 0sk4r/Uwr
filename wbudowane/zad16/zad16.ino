
short pins = 4;
short pin[] = {5, 4, 3, 2};
short pinTone = 9;

int melody[] = {
  659,
  0,
  698,
  659,
  659,
  0,
  659,
  659,
  698,
  659,
  659,
  659,
  622,
  659,
  659,
  659,
  659,
  0,
  698,
  659,
  659,
  0,
  698,
  659,
  698,
  659,
  659,
  659,
  622,
  659,
  659,
  659,
  587,
  0,
  659,
  587,
  587,
  0,
  659,
  587,
  659,
  587,
  587,
  587,
  523,
  587,
  587,
  587,
  587,
  0,
  659,
  587,
  587,
  0,
  659,
  587,
  659,
  587,
  587,
  587,
  523,
  587,
  587,
  587
};

int time[] = {
  120,
  120,//
  120,
  120,
  120,
  120,//
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,//
  120,
  120,
  120,
  120,//
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,//
  120,
  120,
  120,
  120,//
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,//
  120,
  120,
  120,
  120,//
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120,
  120
};

void setup() 
{
  Serial.begin(9600);
  for (short i = 0; i < pins; i++) {
    pinMode(pin[i], OUTPUT);
    analogWrite(pin[i], 0);
  }
}

bool toDown = false;
short prevActivePin = 0;
short activePin = 0;
short active[] = {0, 0, 0, 0};

short i = 0;

void loop() 
{     
  if (i > 63) {
    i = 0;
  }
  
  //  muzyka
  if (melody[i] == 0) {
    noTone(pinTone);
  } else {
    tone(pinTone, melody[i]);
  }
  delay(time[i]);
  i++;
  
  //  diody
  for (short i = 0; i < pins; i++) {
    active[i] = 0;
  }
  active[prevActivePin] = 50;
  active[activePin] = 255;
  
  prevActivePin = activePin;
  if (toDown) {
    activePin--;
  } else {
    activePin++;
  }
  
  if (activePin < 0) {
    toDown = false;
    prevActivePin = 0;
    activePin = activePin + 2;
  }
  
  if (activePin >= pins) {
    toDown = true;
    prevActivePin = pins - 1;
    activePin = activePin - 2;
  }
  
  for (short i = 0; i < pins; i++) {
    analogWrite(pin[i], active[i]);
  }
}

