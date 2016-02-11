import processing.serial.*;
import java.io.*;
String oldText = "";
String text = "";
Serial myPort;

void setup(){
   //Open the serial port for communication with the Arduino
   //Make sure the COM port matches the Arduino
   myPort = new Serial(this, "COM3", 9600);
}

// In Processing code draw is the equivalent of loop()
// All code within will repeat continually
void draw() {
  //The readData function can be found later in the code.
  //This is the call to read a text file on the computer hard-drive.
  readData("C:/web/website1/arduino.txt");
  // If the text from readData doesn't match the most recently stored
  // text we replace it and write to our port, sending the string
  // to our Arduino
  if(!text.equals(oldText)){
    myPort.write(text);
    oldText = text;
  }
} 


// The following function will read from a TXT file
// Takes in the file name and sets a global string with the contents of the file
void readData(String myFileName){
  // Create a new File based on the input file name
   File file = new File(myFileName);
   // Create a new buffered reader
   BufferedReader br = null;
 
 // Try to use our buffered reader to read our file
 // Catch a FileNotFoundException when the filename is incorrect or the file is missing
 // Catch an IO exception and print out the stack trace to determine what the cause is
 // Finally try to close our buffered reader, catching another IO exception and
 // printing the error to determine the issue
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