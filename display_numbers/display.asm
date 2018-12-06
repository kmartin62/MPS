
_main:

;display.c,4 :: 		void main() {
;display.c,6 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;display.c,7 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;display.c,9 :: 		for(;;){
L_main0:
;display.c,10 :: 		for(i = 0; i < 10; i ++){
	CLRF       _i+0
	CLRF       _i+1
L_main3:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVLW      10
	SUBWF      _i+0, 0
L__main9:
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;display.c,11 :: 		PORTB = display[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;display.c,12 :: 		delay_ms(15);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
;display.c,14 :: 		if(PORTB.RE2 == 0xFF){
	BTFSS      PORTB+0, 2
	GOTO       L_main7
;display.c,15 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;display.c,16 :: 		}
L_main7:
;display.c,10 :: 		for(i = 0; i < 10; i ++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;display.c,17 :: 		}
	GOTO       L_main3
L_main4:
;display.c,18 :: 		}
	GOTO       L_main0
;display.c,20 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
