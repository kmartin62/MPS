#line 1 "C:/Users/MARTIN/Desktop/MPS/InterruptDemo/InterruptsDemo.c"
short ifinterupt=0;
short znak=0;

void interrupt(){
if (INTF_bit==1){
 ifinterupt++;
 INTF_bit = 0;
 }
}
int main(){
 ANSEL=0;
 ANSELH=0;

 PORTB=0x00;
 TRISB=0x01;
 INTCON=0x90;

 while(ifinterupt==0){
 }
 EEPROM_Write(0x00,'a');
 while(ifinterupt==1){
 }
 znak='b';
 return 0;
}
