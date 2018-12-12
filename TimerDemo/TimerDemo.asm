
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TimerDemo.c,2 :: 		void interrupt() {
;TimerDemo.c,3 :: 		if (TMR0IF_bit) {  // Dokolku nastanal interrupt od TMR0
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;TimerDemo.c,5 :: 		TMR0IF_bit = 0;    // Reset TMR0IF
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;TimerDemo.c,6 :: 		TMR0 = 96;         // Initial
	MOVLW      96
	MOVWF      TMR0+0
;TimerDemo.c,7 :: 		}
L_interrupt0:
;TimerDemo.c,8 :: 		}
L_end_interrupt:
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TimerDemo.c,10 :: 		void main() {
;TimerDemo.c,11 :: 		OPTION_REG = 0x84;      // Dodeli Prescaller na PS2
	MOVLW      132
	MOVWF      OPTION_REG+0
;TimerDemo.c,13 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;TimerDemo.c,14 :: 		ANSELH = 0;            // Analogni -> Digitalni
	CLRF       ANSELH+0
;TimerDemo.c,16 :: 		C1ON_bit = 0;
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;TimerDemo.c,17 :: 		C2ON_bit = 0;          // Iskluci komparatori
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;TimerDemo.c,19 :: 		TRISB = 0;             // Postavi PORTB kako izlez
	CLRF       TRISB+0
;TimerDemo.c,21 :: 		PORTB = 0xFF;          // Initial PORTB=1
	MOVLW      255
	MOVWF      PORTB+0
;TimerDemo.c,23 :: 		TMR0 = 96;             // Initial TMR0 = 96
	MOVLW      96
	MOVWF      TMR0+0
;TimerDemo.c,25 :: 		INTCON = 0xA0;        // Ovozmozi GIE & T0IE
	MOVLW      160
	MOVWF      INTCON+0
;TimerDemo.c,27 :: 		cnt = 0;              // Initial counter
	CLRF       _cnt+0
	CLRF       _cnt+1
;TimerDemo.c,28 :: 		do {
L_main1:
;TimerDemo.c,29 :: 		if (cnt >= 391) {
	MOVLW      1
	SUBWF      _cnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVLW      135
	SUBWF      _cnt+0, 0
L__main9:
	BTFSS      STATUS+0, 0
	GOTO       L_main4
;TimerDemo.c,30 :: 		PORTB = ~PORTB;      // PORTB = -PORTB
	COMF       PORTB+0, 1
;TimerDemo.c,31 :: 		cnt = 0;
	CLRF       _cnt+0
	CLRF       _cnt+1
;TimerDemo.c,32 :: 		}
	GOTO       L_main5
L_main4:
;TimerDemo.c,33 :: 		else { cnt ++; }     // ++
	INCF       _cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt+1, 1
L_main5:
;TimerDemo.c,35 :: 		} while(1);
	GOTO       L_main1
;TimerDemo.c,36 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
