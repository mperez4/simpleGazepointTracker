/*a simple gazepoint api sketch. This sketch will allow you to create a client using the gazepoint default server on port 4242.

  Miguel Perez 2013           
--------------------------------------------------------------------------------------------------------------------------------
  */


import processing.net.*; 
Client myClient; 
String myIP = "your.ip.adress.here";

void setup() { 
  size(200, 200); 
  //we need to write to the Client(Gazepoint Tracker app) the commands:
  myClient = new Client(this, myIP, 4242); //gazepoint uses port 4242 by default  
} 

void draw()
{
 if (myClient.available() > 0 ) {
    String inString = myClient.readStringUntil('\n');
    println(inString);//instring is the data being trasnmitted from POG_LEFT and POG_RIGHT. You can then parce the data if you want.
  } 
}
void keyPressed(){
  if (key == ' '){
    calibrate(true);
  }else if (key == '1'){
    DATA_TRANSMISSION(true); 
  }
}

//gazepointAPI calibration commands
void calibrate(int state)
{
  String CALIBRATE_START =  "<SET ID=\"CALIBRATE_START\" STATE=\"" + state + "\" />" ;  
  String CALIBRATE_SHOW =  "<SET ID=\"CALIBRATE_SHOW\" STATE=\"" + state + "\" />";
  myClient.write(CALIBRATE_START);
  myClient.write("\r\n");
  myClient.write(CALIBRATE_SHOW);
  myClient.write("\r\n");
}


void DATA_TRANSMISSION(int state)
{  //sends left and right eye point of gaze. 
   //see api documentation for reference on commands
  String POG_LEFT = "<SET ID=\"ENABLE_SEND_POG_LEFT\" STATE=\"" + state + "\" />" ;
  String POG_RIGHT = "<SET ID=\"ENABLE_SEND_POG_RIGHT\" STATE=\"" + state + "\" />" ;
  String SEND_DATA = "<SET ID=\"ENABLE_SEND_DATA\" STATE=\"" + state + "\" />" ;
  myClient.write(POG_LEFT);
  myClient.write("\r\n");  
  myClient.write(POG_RIGHT);
  myClient.write("\r\n");  
  myClient.write(SEND_DATA);
  myClient.write("\r\n");
}