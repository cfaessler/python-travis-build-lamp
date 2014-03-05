/*
  Blink
 Turns on an LED on for one second, then off for one second, repeatedly.
 
 This example code is in the public domain.
 */

// Pin 13 has an LED connected on most Arduino boards.
// give it a name:
// the setup routine runs once when you press reset:

int relais = 12;
char buffer[4];

void setup() {                
  // initialize the digital pin as an output.
  Serial.begin(9600);
  Serial.setTimeout(10000);
  Serial.println("Enter command to toggle LED; 'on' or 'off' followed by carriage return (\\r)");
  Serial.print("$:");
  pinMode(relais, OUTPUT);
}

// the loop routine runs over and over again forever:
void loop() {

  int read_bytes = Serial.readBytesUntil(13, buffer, 4);

  //Input command received
  if(read_bytes >= 2){
    int command = get_command(buffer);

    switch(command){
    case 0: 
      Serial.println("switching LED off");
      digitalWrite(relais, LOW); 
      break;

    case 1: 
      Serial.println("switching LED on");
      digitalWrite(relais, HIGH); 
      break;

    default:
      Serial.println("invalid command");
      break;        
    }

    // clear buffer
    memset(buffer, 0, sizeof(buffer));
    //    clear_buffer(buffer, 4);
    Serial.print("$:");
  }

}

int get_command(char * buffer){
  if(buffer[0]=='o' && buffer[1] == 'n') return 1;
  if(buffer[0]=='o' && buffer[1] == 'f' && buffer[2] == 'f') return 0;
  return -1;
}

void clear_buffer(char * buffer, int len){
  for(int i = 0; i<len; ++i){
    buffer[i]=0;
  }
}





