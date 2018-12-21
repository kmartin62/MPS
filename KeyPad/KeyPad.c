
char keypadPort at PORTD;          // Sekoj klik od PORTD zacuvaj go vo keypad

// Initial LCD
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

int cnt;
char kp,oldstate;
char txt[30];
void main()
{
cnt = 0; // Postavi counter na 0
Keypad_Init(); // Init Keypad

ANSEL = 0; // Analog -> Digital
ANSELH = 0;

Lcd_Init(); // Init LCD
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_Out(1, 1, "Key :");
Lcd_Out(2, 1, "Times:");

do // Repeat
{
kp = 0; // Se postavuva kp na nekliknat (ako e nekliknat vrednosta mu e 0)

do
kp = Keypad_Key_Click(); // Vrednosta na kliknatiot key zacuvaj ja vo kp

while (!kp); // Ako nisto ne e kliknato zaglavi tuka t.e ako kp == 0

// Ascii kodovite na kopcinjata postaveni na keypadot
switch (kp)
{
case 1: kp = 49; break; // 1
case 2: kp = 50; break; // 2
case 3: kp = 51; break; // 3
case 4: kp = 65; break; // A
case 5: kp = 52; break; // 4
case 6: kp = 53; break; // 5
case 7: kp = 54; break; // 6
case 8: kp = 66; break; // B
case 9: kp = 55; break; // 7
case 10: kp = 56; break; // 8
case 11: kp = 57; break; // 9
case 12: kp = 67; break; // C
case 13: kp = 42; break; // *
case 14: kp = 48; break; // 0
case 15: kp = 35; break; // #
case 16: kp = 68; break; // D
}
if (kp != oldstate)
{
cnt = 1;
oldstate = kp;     // Ako pritisnatiot taster e razlicen od prethodniot t.e sme kliknale drug taster
}
else
{
cnt++;            // counter++
}
Lcd_Chr(1, 10, kp); // Pecati go znakot na LCD
if (cnt == 255)
{
cnt = 0;          // Ako nastanal overflow, resetiraj counter
Lcd_Out(2, 10, " ");
}
WordToStr(cnt, txt); // Pretvori go counter od int vo String
Lcd_Out(2, 10, txt); // Ispecati go counterot na LCD
} while (1);
}