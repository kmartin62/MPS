#line 1 "C:/Users/MARTIN/Desktop/MPS/Lab2/Lab2.c"

sbit LCD_RS at RA4_bit;
sbit LCD_EN at RA5_bit;
sbit LCD_D4 at RA0_bit;
sbit LCD_D5 at RA1_bit;
sbit LCD_D6 at RA2_bit;
sbit LCD_D7 at RA3_bit;
sbit LCD_RS_Direction at TRISA4_bit;
sbit LCD_EN_Direction at TRISA5_bit;
sbit LCD_D4_Direction at TRISA0_bit;
sbit LCD_D5_Direction at TRISA1_bit;
sbit LCD_D6_Direction at TRISA2_bit;
sbit LCD_D7_Direction at TRISA3_bit;

short ifClicked = 0;
char name[20], broj[10];
int counter = 0;
unsigned cnt = 0;

void interrupt(){
 if(INTF_bit == 1) {
 ifClicked ++;
 INTF_bit = 0;
 }

 if(TMR0IF_bit){
 cnt ++;
 TMR0IF_bit = 0;
 TMR0 = 96;
 }





}

void main() {

 OPTION_REG = 0x03;

 ANSEL = 0;
 ANSELH = 0;

 PORTB = 0x00;
 TRISB = 0x01;

 INTCON = 0b10110000;
 TMR0 = 96;

 while(ifClicked == 0 ) {
 }
 ifClicked --;

 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);

 strcpy(name, "Martin");

 while(1){

 if(ifClicked % 2 == 0){
 Lcd_Out(1,11,name);
 }

 else if(ifClicked % 2 == 1){
 counter = 0;
 while(ifClicked %2 == 1){
 if(cnt >= 26){
 Lcd_Cmd(_LCD_CLEAR);
 IntToStr(counter, broj);
 Lcd_Out(1,1,broj);

 counter += 5;
 Lcd_Cmd(_LCD_CLEAR);
 }
 }

 }



 }



}
