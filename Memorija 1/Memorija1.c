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

int niza[13], niza2[13];
int i, j, counter;
char nizaChar[13], nizaChar2[13], message[20];
int x, broj, steps;
char kp, uart_rd;
int temp_res;
unsigned cnt;

void interrupt(){
    if(TMR0IF_bit){
                   cnt ++;
                   TMR0IF_bit = 0;
                   TMR0 = 96;
    }
}

void main() {
steps = 0;
ANSEL = 0x00;
ANSELH = 0b010000;
TRISB = 0xFF;
UART1_Init(9600);
TMR0 = 96;
INTCON = 0b10100000;
OPTION_REG = 0x83; // 1:16 preskaler
cnt = 0;
x = (2000000 * 25/1000) / (160 * 16); //1:16
i = j = counter = 0;
Keypad_Init();
Lcd_Init();
Lcd_Cmd(_LCD_CURSOR_OFF);

while(1){
do{
                 kp = 0;

                 do{    //Se ceka da se klikne
                    kp = Keypad_Key_Click();
                 }while(!kp);

                switch(kp){
                case 1: // NEW
                     strcpy(message, "READING");
                     Lcd_Out(1,1,message);
                                          do{
                                          temp_res = 0;
                                          while(1){
                                          Lcd_Cmd(_LCD_CLEAR);
                                          strcpy(message, "Make input now");
                                          Lcd_Out(1,1,message);
                                          delay_ms(25);
//                                                   if(cnt >= x){
//                                                          break;
//                                                   }
                                                   temp_res = ADC_Read(12);
                                                   if(temp_res > 9 && temp_res < 100){
                                                               niza[i++] = temp_res;
                                                               nizaChar[j++] = temp_res/10 + '0';
                                                               nizaChar[j++] = temp_res%10 + '0';
                                                               counter++;
                                                               Lcd_Cmd(_LCD_CLEAR);
                                                               strcpy(message, "Input made");
                                                               Lcd_Out(1,1,message);
                                                               break;
                                                   }
                                                   
                                                   

                                          }
                                          if(counter == 6){
                                                     Lcd_Cmd(_LCD_CLEAR);
                                                     Lcd_Out(1,1,nizaChar);
                                                     
                                                     i = j = counter = 0;
                                          while(1){
                                              if(UART1_Data_Ready()){
                                                                     uart_rd = UART1_Read();
                                                                     if(isdigit(uart_rd)){
                                                                        broj = broj * 10 + (uart_rd - '0');
                                                                     }

                                                                     if(uart_rd == '-'){
                                                                                if(broj > 99 && broj < 1000){
                                                                                     niza2[i++] = broj;
                                                                                     nizaChar2[j++] = broj / 100 + '0';
                                                                                     nizaChar2[j++] = (broj / 10) % 10 + '0';
                                                                                     nizaChar2[j++] = broj % 10 + '0';
                                                                                     counter ++;
//                                                                                     Lcd_Out(1,1,nizaChar2);
                                                                                }
                                                                                else {
                                                                                     i = j = counter = 0;
                                                                                     strcpy(message, "Error");
                                                                                     Lcd_Cmd(_LCD_CLEAR);
                                                                                     Lcd_Out(1,1,message);
                                                                                     delay_ms(25);
                                                                                     Lcd_Cmd(_LCD_CLEAR);

                                                                                }
                                                                     }
                                                                     
                                                                     if(uart_rd == '$'){
                                                                                if(counter != 4){
                                                                                   strcpy(message, "Error");
                                                                                     Lcd_Cmd(_LCD_CLEAR);
                                                                                     Lcd_Out(1,1,message);
                                                                                     delay_ms(25);
                                                                                     Lcd_Cmd(_LCD_CLEAR);
                                                                                }
                                                                                else {
                                                                                     break;
                                                                                }
                                                                     }
                                              }

                                          }
                                          }

                                          }while(1);
                                          
                                          
                     break;
                     
                     case 2: // <-
                        steps --;
                     break;
                     
                     case 5: //Enter
                          strcpy(message, "START");
                          Lcd_Out(2,1,message);
                     break;
                     
                     case 6: //++
                          niza[steps]++;
                          nizaChar[steps] = niza[steps] + '0';
                          Lcd_Chr(1,steps+1,nizaChar[steps]);
                     break;
                     
                     case 9: //END
                     counter = 0;
                          for(i = 0; i < 17; i ++) {
                              if(niza[i] != niza2[i]){
                                         counter ++;
                              }
                          }
                          strcpy(message, "Error");
                          Lcd_Cmd(_LCD_CLEAR);
                          Lcd_Out(1,1,message);
                          IntToStr(counter, message);
                          Lcd_Out(2,1,message);
                          counter = 99;
                     break;
                     
                     case 10: //--
                          niza[steps]--;
                          nizaChar[steps] = niza[steps] + '0';
                          Lcd_Chr(1,steps+1,nizaChar[steps]);
                     break;
                     
                     case 14: // ->
                         steps ++;
                     break;
             }
             
             if(counter == 99){
                        break;
             }
             
            }while(1);

 }
}