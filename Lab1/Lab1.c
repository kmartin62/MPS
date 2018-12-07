
unsigned int display[] = {0x79,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07}; //Vrednosti za prikaz
unsigned int values[] = {0x00,0x08,0x10,0x18,0x20,0x28,0x30,0x38};   //Vrednosti na PORTA
unsigned int addresses[] = {0x00,0x02,0x04,0x06,0x08,0x10,0x12,0x14};  //Adresi
unsigned int counter = 0;
int i, newValue, current, flag = 1;

void main() {
TRISB = 0x00;  //output
TRISA = 0xFF;  //input

ANSEL = 0;
ANSELH = 0;

PORTB = 0;

for(i = 0; i < 9; i ++) {
      EEPROM_Write(addresses[i], counter);
}

while(1){
    for(i = 0; i < 9; i ++) {
          if(PORTA == values[i]){
                   if(flag){
                   flag = 0;
                   PORTB = display[i];
                   current = values[i];   //Zacuvaj momentalna vrednost
                   EEPROM_Write(addresses[i], EEPROM_Read(addresses[i])+1); //Zapisi vo memorija
          }
          else {
               if(values[i] != current) flag = 1;
          }
          }
          
          

    }
    
    if(EEPROM_Read(addresses[0]) - 1 == 3) break; //Ignoriraj go prviot count od startuvanje na programata, zatoa -1

}

}