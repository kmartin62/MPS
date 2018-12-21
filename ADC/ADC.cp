#line 1 "C:/Users/MARTIN/Desktop/MPS/ADC/ADC.c"
unsigned int temp_res;
void main()
{
ANSEL=0x04;
ANSELH=0;
TRISA=0xFF;
TRISC=0x3F;
TRISB=0;
do {
 temp_res=ADC_Read(2);
 PORTB=temp_res;
 PORTC=temp_res>>2;
}while(1);
}
