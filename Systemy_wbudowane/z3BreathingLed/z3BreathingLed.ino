int pin1 = 3;
int pin2 = 5;
int pin3 = 6;

int lastcolor;

int colors[][3]{
  {255,255,255},
  {255,0,0},
  {0,255,0},
  {0,0,255},
  {255,255,0},
  {255,0,255},
  {0,255,255}
};

void setup(){
  randomSeed(analogRead(0));
  pinMode(pin1, OUTPUT);
  pinMode(pin2, OUTPUT);
  pinMode(pin3, OUTPUT);
}


void loop(){
  int n, x,y,z;
  while (lastcolor==( n = random(0, sizeof(colors)/sizeof(colors[0]))));
  lastcolor = n;
  x = colors[n][0];
  y = colors[n][1];
  z = colors[n][2];
  for(int mult = 0; mult < 255; mult++){
    analogWrite(pin1,((x*mult)/255));
    analogWrite(pin2,((y*mult)/255));
    analogWrite(pin3,((z*mult)/255));
    delay(6);
  }
  for(int mult = 255; mult > 0; mult--){
    analogWrite(pin1,((x*mult)/255));
    analogWrite(pin2,((y*mult)/255));
    analogWrite(pin3,((z*mult)/255));
    delay(6);
  }
  delay(1000);
}
