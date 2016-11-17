int pinX = 0;
int pinY = 1;
int led[] = {2, 3, 4, 5};

int valX, valY;

const int acceptTime = 1500;
const int DelayTime = 200;

int ledNo;

unsigned int startTime;
unsigned int roundStartTime;
unsigned int gameTime;
unsigned int time;
unsigned int totalPoints = 0;

boolean isInRange(int val, int x, int y)
{
  return val >= x && val <= y;
}

void initNewGame()
{
  int input = 0;
  Serial.println("Wpisz s aby rozpoczac");
  while (input != 's' && input != 'S') {
    if (Serial.available())
      input = Serial.read();
    delay(10);
  }

  input = 0;
  Serial.println("Podaj czas gry?");
  while (input <= 0) {
    while (!Serial.available()) delay(10); // wait for input
    input = Serial.parseInt();
  }
  Serial.print("Rozpoczynam nowa gre");
  gameTime = input * 1000;
  startTime = millis();

  totalPoints = 0;
}

void nextRound()
{
  valX = analogRead(pinX);
  valY = analogRead(pinY);
  for (int i = 0; i < 4; i++)
    digitalWrite(led[i], LOW);
  while (!isInRange(valX, 490, 540) || !isInRange(valY, 490, 540)) {
    valX = analogRead(pinX);
    valY = analogRead(pinY);
  }
  delay(DelayTime);

  ledNo = random(4);
  digitalWrite(led[ledNo], HIGH);
  roundStartTime = millis();
}

void setup()
{
  Serial.begin(9600);
  randomSeed(analogRead(5));

  for (int i = 0; i < 4; i++) {
    pinMode(led[i], OUTPUT);
    digitalWrite(led[i], LOW);
  }

  initNewGame();
  nextRound();
}

void loop()
{
  valX = analogRead(pinX);
  valY = analogRead(pinY);
  time = millis();

  if (
    (ledNo == 0 && valX > 870 && isInRange(valY, 490, 530)) ||  // +x
    (ledNo == 3 && valX < 20  && isInRange(valY, 490, 530)) ||  // -x
    (ledNo == 1 && valY > 870 && isInRange(valX, 490, 530)) ||  // +y
    (ledNo == 2 && valY < 20  && isInRange(valX, 490, 530))    // -y
  ) {

    int difference = time - roundStartTime;
    int points = acceptTime - difference;
    if (points < 0) {
      Serial.println("Przekroczyles czas!");
      points = 0;
    }
    else {
      totalPoints += points;

      Serial.print(" Otrzymujesz ");
      Serial.print(points);
      Serial.println(" punktow.");
      Serial.print("Pozostalo czas do konca: ");
      Serial.println((gameTime - (time - startTime)) / 1000);
    }

    nextRound();
  }

  if (time - startTime > gameTime) {
    Serial.println("###########################");
    Serial.println("Koniec gry!");
    Serial.print("Zdobyles: ");
    Serial.print(totalPoints);
    Serial.println(" punktow.");

    digitalWrite(led[ledNo], LOW);
    initNewGame();
    nextRound();
  }
}
