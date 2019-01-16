#line 1 "C:/Users/MARTIN/Desktop/MPS/Mini podmornica/Mini_podmornica.c"
char keypadPort at PORTD;

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

unsigned cnt;
int steps, round, points, i;
char kp;
int podmornici[16], broj;
char niza[30];
int x = 120, y;
char uart_rd;

void interrupt(){
 if(TMR0IF_bit){
 cnt++;
 TMR0IF_bit = 0;
 TMR0 = 96;
 }
}

void main()
{
ANSEL = 0;
ANSELH = 0;
Keypad_Init();
UART1_Init(9600);
TMR0 = 96;
INTCON = 0b10100000;
OPTION_REG = 0x83;
Lcd_Init();
Lcd_Cmd(_LCD_CURSOR_OFF);
cnt = 0;
steps = 1;
round = 0;
points = 0;
broj = 0;
y = (2000000 * x/1000) / (160 * 16);
while(1){
 if(!PORTB.B4){
 strcpy(niza, "Start game");
 Lcd_Out(1,1,niza);
 while(!PORTB.B4);
 Lcd_Cmd(_LCD_CLEAR);
 strcpy(niza, "Initialization");
 Lcd_Out(1,1,niza);

 do{
 if(cnt >= y){
 break;
 }

 if(UART1_Data_Ready()){
 uart_rd = UART1_Read();
 if(isdigit(uart_rd)){
 broj = broj * 10 + (uart_rd - '0');
 }else{
 if(broj >= 1 && broj <= 16){
 podmornici[broj] = 1;
 }
 broj = 0;
 }
 }
 }while(1);

 if(broj >= 1 && broj <= 16){
 podmornici[broj] = 1;
 }

 strcpy(niza, "New game");
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,niza);

 do{
 kp = 0;

 do{
 kp = Keypad_Key_Click();
 }while(!kp);

 switch(kp){
 case 2:
 steps--;
 if(steps <= 0){
 steps = 1;
 }
 break;


 case 5:
 Lcd_Cmd(_LCD_CLEAR);
 break;


 case 6:
 if(podmornici[steps] == 1){
 strcpy(niza, "*");
 Lcd_Out(1,steps,niza);
 points += 3;
 }
 else {
 strcpy(niza, "X");
 Lcd_Out(1,steps,niza);
 points -= 2;
 }
 steps = 1;
 round ++;
 break;


 case 10:
 steps ++;
 break;
 }

 if(round == 3){
 delay_ms(10);
 Lcd_Cmd(_LCD_CLEAR);
 strcpy(niza, "Points:");
 Lcd_Out(1,1,niza);
 IntToStr(points, niza);
 Lcd_Out(1,11,niza);
 break;
 }

 }while(1);

 for(i = 1; i < 16; i ++){
 if(podmornici[i] == 1){
 Lcd_Out(2,i,"*");
 }
 }

 delay_ms(10);
 PORTB.B4 = 0;

 }

}
}
