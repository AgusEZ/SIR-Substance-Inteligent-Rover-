import controlP5.*;
import hypermedia.net.*;
import processing.serial.*;
PImage cam;
Serial port;
char tempData = ' ';
String entryValue = "";
int timer=second();
int t=0;

Element[] elements = new Element[] {
  new Element("Helio", new Color(30, 30, 30)),
  new Element("Carbono", new Color(60, 60, 60)),
  new Element("Hierro", new Color(90, 90, 90)),
  new Element("Calcio", new Color(120, 120, 120)),
  new Element("Litio", new Color(150, 150, 150)),
  new Element("Sodio", new Color(180, 180, 180)),
  new Element("Oxigeno", new Color(210, 210, 210))
};

Slider[] sliders = new Slider[elements.length];

Slider[] rgbSliders = new Slider[3];


public class Element{
  public final String name;
  public Color col;
  public float finalPercent = 0;
  
  public Element(String name, Color col){
     this.name = name;
     this.col = col;
  }
  
  public void CalculatePercentValue(char[] rgbElementValues){
    int[] rgbIntColor = new int[3];
    float sumPercentValue = 0;
    for(int i = 0; i < rgbElementValues.length; i++){
      rgbIntColor[i] = Character.getNumericValue(rgbElementValues[i]);
      sumPercentValue += rgbIntColor[i];
    }
    float maxColorValue = this.col.r + this.col.g + this.col.b; 
    finalPercent = map((finalPercent - 40) ,finalPercent, maxColorValue, 0, 100);
  }
  
}

public class Color{
  public int r, g, b;
  
  public Color(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
}


/////// Start of Main Program  ///////////////

ControlP5 cp5;
UDP udpPort;

void setup()
{
  //port = new Serial(this,"COM11", 9600);
  udpPort = new UDP(this, 4023); // ! -> (si no es this utilizar "localhost", Quizás haga falta la IP desde donde lee los datos,determinar el puerto a utilizar)
  
  size(1024,720);
  cp5 = new ControlP5(this);
  
  for (int i = 0; i < elements.length; i++){
    sliders[i] = cp5.addSlider(elements[i].name)
      .setRange(0, 100)
      .setPosition (20, 20 + (i * 20))
      .setSize(250, 19);
  }
  
  /*rgbSliders[0] = cp5.addSlider("Red");
  rgbSliders[1] = cp5.addSlider("Green");
  rgbSliders[2] = cp5.addSlider("Blue");
  
  for (int i = 0; i < rgbSliders.length; i++){
    rgbSliders[i]
      .setRange(0, 100)
      .setPosition (400, 20 + (i * 20))
      .setSize(250, 19);
  }*/
}

void keyPressed(){
  if (key == '1' && keyPressed){
    for (Slider slider : sliders){
      slider.shuffle();
    }
  }
}


void draw(){
  cam=loadImage("http://192.168.0.3:8080/shot.jpg");
  image(cam,0,0,width,height*2);
  if(second()!=timer){t++;}
  timer=second();
   if(t>10) { t=0; for (Slider slider : sliders){ slider.shuffle(); }}
  
  //data();

}

void ReceivedDataUDP(){
  
  println(entryValue);
}

void DataToRGB(char charReceivedDataUDP){
  char[] rgb = new char[3];
  for(int i = 0; i <= 3; i++){
    rgb[i] = charReceivedDataUDP;
  }
  CalculateElementPercentValue(rgb);
}

void CalculateElementPercentValue(char[] RGBvalues){
    for(int i = 0; i <= elements.length; i++){
      elements[i].CalculatePercentValue(RGBvalues);
      rgbSliders[i].setValue(elements[i].finalPercent);
  }
}
