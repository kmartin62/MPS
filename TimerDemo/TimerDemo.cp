#line 1 "C:/Users/MARTIN/Desktop/MPS/TimerDemo/TimerDemo.c"
unsigned cnt;
void interrupt() {
 if (TMR0IF_bit) {

 TMR0IF_bit = 0;
 TMR0 = 96;
 }
}

void main() {
OPTION_REG = 0x84;

ANSEL = 0;
ANSELH = 0;

C1ON_bit = 0;
C2ON_bit = 0;

TRISB = 0;

PORTB = 0xFF;

TMR0 = 96;

INTCON = 0xA0;

cnt = 0;
do {
 if (cnt >= 391) {
 PORTB = ~PORTB;
 cnt = 0;
 }
 else { cnt ++; }

} while(1);
}
