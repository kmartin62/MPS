#line 1 "C:/Users/MARTIN/Desktop/MPS/LCDdemo/LCDdemo.c"

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

const int len = 16;
char ch;
int i, broj;
char text[20], text2[20], text3[20], niza[10];
void main() {
ANSEL = 0;
ANSELH = 0;

Lcd_Init();

strcpy(text3,"Demo text1");
Lcd_Out(1,1,text3);

Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
Lcd_Cmd(_LCD_CLEAR);

strcpy(text,"Demo text");
Lcd_Out(1,2,text);

strcpy(text2,"Second line");
Lcd_Out(2,5,text2);

Lcd_Cmd(_LCD_CLEAR);
broj = 123;
IntToStr(broj, niza);
Lcd_Out(1,1,niza);
}
