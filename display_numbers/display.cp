#line 1 "C:/Users/pc/Desktop/mikroC/display_numbers/display.c"
int i;
unsigned int display[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};

void main() {

 TRISB = 0x00;
 PORTB = 0x00;

 for(;;){
 for(i = 0; i < 10; i ++){
 PORTB = display[i];
 delay_ms(15);

 if(PORTB.RE2 == 0xFF){
 PORTB = 0x00;
 }
 }
 }

}
