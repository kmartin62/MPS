// Setup pins for LCD
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

short ifinterrupt = 0;
char text1[20], text2[20];

void interrupt(){
     if(INTF_bit == 1){
                  ifinterrupt ++;
                  INTF_bit = 0;
     }
}

void main() {
    ANSEL = 0;
    ANSELH = 0;
    
//    C1ON_bit = 0;
//    C2ON_bit = 0;
    
    PORTB = 0x00;
    TRISB = 0x01;
    
    INTCON = 0x90;
    
    strcpy(text1,"Before click");
    strcpy(text2, "After click");
    
    Lcd_Init();
    Lcd_Cmd(_LCD_CURSOR_OFF);
    
//    Lcd_Out(1,1,text1);
    
    while(1){

             while(ifinterrupt == 0){
             }
             Lcd_Cmd(_LCD_CLEAR);
             Lcd_Out(1,1,text1);
//             Lcd_Cmd(_LCD_CLEAR);
             while(ifinterrupt == 1) {
             }
             Lcd_Cmd(_LCD_CLEAR);
             Lcd_Out(1,1,text2);
             
//             Lcd_Cmd(_LCD_CLEAR);
             
             ifinterrupt = 0;

    }
}