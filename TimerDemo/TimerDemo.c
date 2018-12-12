unsigned cnt;
void interrupt() {
 if (TMR0IF_bit) {  // Dokolku nastanal interrupt od TMR0
// cnt++;             // cnt++
 TMR0IF_bit = 0;    // Reset TMR0IF
 TMR0 = 96;         // Initial
 }
}

void main() {
OPTION_REG = 0x84;      // Dodeli Prescaller na PS2

ANSEL = 0;
ANSELH = 0;            // Analogni -> Digitalni

C1ON_bit = 0;
C2ON_bit = 0;          // Iskluci komparatori

TRISB = 0;             // Postavi PORTB kako izlez

PORTB = 0xFF;          // Initial PORTB=1

TMR0 = 96;             // Initial TMR0 = 96

INTCON = 0xA0;        // Ovozmozi GIE & T0IE

cnt = 0;              // Initial counter
do {
 if (cnt >= 391) {
 PORTB = ~PORTB;      // PORTB = -PORTB
 cnt = 0;
 }
 else { cnt ++; }     // ++

} while(1);
}