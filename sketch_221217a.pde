/*
read m5stack udp data(object temperature) and display it as a simple chart

*/
import hypermedia.net.*;
import controlP5.*;

UDP udp;
final String IP = "0.0.0.0";

ControlP5 cp5;
Chart chart_tmp;
final int NUM_GRAPH_DATA = 200;

PFont myFont;

float val;

void setup() {

  size(650, 700);
  myFont = createFont("Arial", 20); 
  
  udp = new UDP(this, 3002);
  udp.listen( true );

  frameRate(10);
  cp5 = new ControlP5(this);
  
  chart_tmp = cp5.addChart("tmp sensor");
  chart_tmp.setView(Chart.LINE)                             
            .setRange(20, 35)                         
            .setSize(600, 200)                               
            .setPosition(10, 250)                           
            .setColorCaptionLabel(color(0,0,255))          
            .setStrokeWeight(1.5)                            
            .getColor().setBackground(color(224, 224, 224))  
            ;
  chart_tmp.addDataSet("temp");
  chart_tmp.setData("temp", new float[NUM_GRAPH_DATA]);
  chart_tmp.setColors("temp", color(0, 0, 192), color(255,255,128));

}

void draw() {
  
  background(255);
  fill(0);

  chart_tmp.unshift("temp", val);
}

void receive( byte[] data, String ip, int port ) {
  String message = new String( data );
  println( "received : \""+message+"\" from "+ip+" on port "+port );
  
  String[] matchedTexts = match(message, "[0-9|-]*.[0-9]*$");

  if (matchedTexts != null) {
    println(matchedTexts[0]);
    val = float(matchedTexts[0]);
  }

}
