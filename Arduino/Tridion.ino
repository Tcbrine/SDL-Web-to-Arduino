// Load the LiquidCrystal library, which will give us commands to interface to the LCD:
#include <LiquidCrystal.h>
LiquidCrystal lcd(12,11,5,4,3,2);
// We'll use this flag later to determine if we should wipe our LCD
bool reset = false;

void setup() { 
  // Turn the Serial Protocol ON so we can communicate digitally with our Arduino
  Serial.begin(9600);
  // Set out the layout we're using on our LCD, in this case 16 characters per line, 2 lines 
  lcd.begin(16, 2);
  // Before we start we make sure we've wiped our LCD clean from previous code
  lcd.clear();
}

// Run a continual loop
void loop() {
  // This char will hold the most recent character returned by the serial stream we'll
  // be recieving from the buffered reader in Processing
  char charRead;
  
  // Check if data has been sent from Processing
  if (Serial.available() > 0) {
    // check if the file has been republished, in which case we wipe our LCD screen clear
    if(reset){
      lcd.clear();
      reset = false;
    }
      // Read the most recent byte
      charRead = Serial.read();
      // Print the most recent byte to our LCD
      lcd.print(charRead);
      //Delay 1 second to help account for some multi thread trickiness
      delay(100);
  }
  // If there are no additional characters to be written then this will evaluate true
  // This means all contents of the file have been processed and when there are new
  // characters available the page must have been republished, meaning we should clear the LCD
  if(Serial.available() < 1){
      reset = true;
  }
}
