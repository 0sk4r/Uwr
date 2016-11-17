int pin[5] = {2, 3, 4, 5, 6};

int len = 18;
bool letter[18][5] = {

  {1, 1, 1, 1, 1},
  {1, 0, 0, 0, 1},
  {1, 0, 0, 0, 1},
  {1, 1, 1, 1, 1},

  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0},

  {1, 1, 1, 1, 1},
  {0, 0, 1, 0, 0},
  {0, 1, 0, 1, 0},
  {1, 0, 0, 0, 1},

  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0},

  {1, 1, 1, 1, 1},
  {1, 0, 0, 0, 1},
  {1, 0, 0, 0, 1},
  {1, 1, 1, 1, 1},
};


int time = 10;
int iterator = 0;
int right = true;

void setup() {
  for (int i = 0; i < 5; i++) {
    pinMode(pin[i], OUTPUT);
  }
}

void loop() {
  for (int i = 0; i < 5; i++) {
    digitalWrite(pin[i], letter[iterator][i]);
  }


  if (right) {
    iterator++;
  } else {
    iterator--;
  }

  if (iterator == len) {
    right = false;
  }
  if (iterator < 0) {
    right = true;
    iterator = 1;
  }

  delay(time);
}
