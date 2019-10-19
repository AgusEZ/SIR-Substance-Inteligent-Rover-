#include <Ultrasonic.h>
#define S0 8
#define S1 9
#define S2 10
#define S3 11
#define sensorOut 2
int frequencyR = 0;
int frequencyG = 0;
int frequencyB = 0;


int eng[4]={2,3,4,5}; //engines (left right)
boolean engp[4]={false,false,false,false};
Ultrasonic sens(13, 12);
int dist;

void setup() {
  Serial.begin(9600);
  for(int i=0;i<4;i++){pinMode(eng[i],OUTPUT);  }//engines definition
 pinMode(6,OUTPUT); pinMode(7,OUTPUT); 
 digitalWrite(6,HIGH);digitalWrite(7,HIGH);
}

void loop() {
  eng_update();
  dist=sens.read();
  Serial.print(engp[0]);Serial.print(engp[1]);Serial.print(engp[2]);
  Serial.print(engp[3]);Serial.print("   ");Serial.println(dist);
  if(dist<25){rright();}else{forward();}
}
