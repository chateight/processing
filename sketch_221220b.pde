/*
read m5stack udp data(IMU data ; pitch, roll, yaw) and move the imaginary object

*/
import hypermedia.net.*;

UDP udp;
final String IP = "0.0.0.0";

PFont myFont;

float[] pry = new float[3];      // pitch, roll, yaw store work


void setup() {
  
  udp = new UDP(this, 3002);
  udp.listen( true );

  size(500,500,P3D);
  frameRate(30);
  loop();
}

void draw() {
  background(0);
 
  translate(width/2, height/2);
  rotateX(radians(-pry[1]));
  rotateY(radians(pry[0]));
  rotateZ(radians(-pry[2]));
  box(150, 150, 50);
}

void receive( byte[] data, String ip, int port ) {
  String message = new String( data );
  println( "received : \""+message+"\" from "+ip+" on port "+port );
  
  String[][] matchedTexts = matchAll(message, "[0-9|-]+.[0-9]+");

  if (matchedTexts != null) {
    int index = 0;
    for (String[] matchedText : matchedTexts){
      pry[index] = float(matchedText[0]);
      index++;
    }
  }
  println(pry[0], pry[1], pry[2]);    // pitch, roll, yaw
  
}
