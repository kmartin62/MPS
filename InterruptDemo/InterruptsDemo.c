short ifinterupt=0;
short znak=0;

void interrupt(){
if (INTF_bit==1){   //Dokolku RB0==1
 ifinterupt++;
 INTF_bit = 0;
 }
}
int main(){
 ANSEL=0;
 ANSELH=0;                 //Postavi analogno
 
 PORTB=0x00;
 TRISB=0x01;       //Postavi go RB0 na vlezen pin
 INTCON=0x90;       //Setiraj register za ovozmozuvanje na prekin od RB0
 
 while(ifinterupt==0){
 }
 EEPROM_Write(0x00,'a');
 while(ifinterupt==1){
 }
 znak='b';
 return 0;
}
