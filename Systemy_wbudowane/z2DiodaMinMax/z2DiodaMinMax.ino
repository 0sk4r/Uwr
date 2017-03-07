int ledPin = 3;
int photoresistor = 0;
int minPin=4;
int maxPin=2;
float sensorVal, maxVal=0, minVal=0;

void setup()  {
  pinMode(ledPin, OUTPUT);
  pinMode(minPin,INPUT);
  pinMode(maxPin,INPUT);
  Serial.begin(9600);

}
 
 
void loop()  {
   if (digitalRead(minPin) == HIGH) {
    minVal = analogRead(photoresistor)/4;
    Serial.println(minVal);
   }
   if (digitalRead(maxPin) == HIGH) {
    maxVal = analogRead(photoresistor)/4;
    Serial.println(maxVal);
   }
  sensorVal = (255-(analogRead(photoresistor)/4))*((maxVal-minVal)/255); 
  Serial.println(sensorVal);
  analogWrite(ledPin, sensorVal);  

  
  delay(20);                            
}
