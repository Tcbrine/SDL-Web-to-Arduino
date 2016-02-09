import processing.serial.*;
import java.io.*;
String oldText = "";
String text = "";
Serial myPort;

void setup(){
 
   //Open the serial port for communication with the Arduino
   //Make sure the COM port is correct
   myPort = new Serial(this, "/dev/cu.usbserial-A702MUU2", 9600);
}

void draw() {
  /*The readData function can be found later in the code.
  This is the call to read a CSV file on the computer hard-drive. */
  readData("/users/tcbrine/Desktop/test.txt");
  if(!text.equals(oldText)){
    myPort.write(text);
    oldText = text;
  }
} 


/* The following function will read from a CSV or TXT file */
void readData(String myFileName){
   File file = new File(myFileName);
   BufferedReader br = null;
 
   try{
     br=new BufferedReader(new FileReader(file));
     text = br.readLine();
   }  
   catch(FileNotFoundException e){
     e.printStackTrace();
   }
   catch(IOException e){
     e.printStackTrace();
   }
   finally{
     try {
       if (br != null){
         br.close();
       }
     } 
     catch (IOException e) {
       e.printStackTrace();
     }
   }
}