char keypadPort at PORTD;

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

int temp_res, i = 0, prosek = 0, j, kp_cifra, tmp = 0;
char broj[10], kp;
int niza[20];

void main()
{

ANSEL = 0x01;
ANSELH = 0;
TRISA = 0xFF;

Keypad_Init();

Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);

do
{
kp = 0;
do
kp = Keypad_Key_Click();
while (!kp);
switch (kp)
{
case 1: 
kp_cifra = 1;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       tmp = tmp * 10 + kp_cifra;
       IntToStr(tmp, broj);
       Lcd_Out(1,1,broj);
}
else {
tmp = kp_cifra;
}

break; // 1

case 2: 
kp_cifra = 4;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       Lcd_Out(1,2,broj);
       tmp = tmp * 10 + kp_cifra;
}
else {
tmp = kp_cifra;
}

 break; // 4
 
case 3: 
kp_cifra = 7;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       Lcd_Out(1,2,broj);
       tmp = tmp * 10 + kp_cifra;
}
else {
tmp = kp_cifra;
}
 break; // 7

case 5: 
kp_cifra = 2;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       Lcd_Out(1,2,broj);
       tmp = tmp * 10 + kp_cifra;
}
else {
tmp = kp_cifra;
}
 break; // 2
 
case 6: 
kp_cifra = 5;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       Lcd_Out(1,2,broj);
       tmp = tmp * 10 + kp_cifra;
}
else {
tmp = kp_cifra;
}
 break; // 5
 
case 7: 
kp_cifra = 8;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       Lcd_Out(1,2,broj);
       tmp = tmp * 10 + kp_cifra;
}
else {
tmp = kp_cifra;
}
 break; // 8      // 54 = 6
 
case 8: 
kp_cifra = 0;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       Lcd_Out(1,2,broj);
       tmp = tmp * 10 + kp_cifra;
}
else {
tmp = kp_cifra;
}
 break; // 0
 
case 9: 
kp_cifra = 3;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       Lcd_Out(1,2,broj);
       tmp = tmp * 10 + kp_cifra;
}
else {
tmp = kp_cifra;
}
 break; // 3
 
case 10:
kp_cifra = 6;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       Lcd_Out(1,2,broj);
       tmp = tmp * 10 + kp_cifra;
}
else {
tmp = kp_cifra;
}
 break; // 6
 
case 11:
kp_cifra = 9;
IntToStr(kp_cifra, broj);
Lcd_Out(1,1,broj);

if(tmp > -1){
       Lcd_Out(1,2,broj);
       tmp = tmp * 10 + kp_cifra;
}
else {
tmp = kp_cifra;
}
 break; // 9
 

case 13: 
     temp_res = ADC_Read(0);
     IntToStr(temp_res, broj);
     Lcd_Out(1,1,broj);
     niza[i] = temp_res;
     i ++;
 break; // MERI
 
case 14:


if(tmp > 20) {
       strcpy(broj, "Greshka");
       Lcd_Out(1,1,broj);
       tmp = 0;
}

IntToStr(niza[tmp], broj);
Lcd_Out(1,1,broj);
tmp = 0;


 break; // PRIKAZI
 
case 15: 
          for(j = 0; j < i; j ++) {
                prosek += niza[j];
          }
          
          prosek = prosek / i;
          
          IntToStr(prosek, broj);
          Lcd_Out(1,1,broj);
 break; // PROSEK

}
} while (1);
}