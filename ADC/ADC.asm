
_main:

;ADC.c,2 :: 		void main()
;ADC.c,4 :: 		ANSEL=0x04;
	MOVLW      4
	MOVWF      ANSEL+0
;ADC.c,5 :: 		ANSELH=0;
	CLRF       ANSELH+0
;ADC.c,6 :: 		TRISA=0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;ADC.c,7 :: 		TRISC=0x3F;
	MOVLW      63
	MOVWF      TRISC+0
;ADC.c,8 :: 		TRISB=0;
	CLRF       TRISB+0
;ADC.c,9 :: 		do {
L_main0:
;ADC.c,10 :: 		temp_res=ADC_Read(2);//????? 10 ???? ?? ??????? ???????? ???–?2
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _temp_res+0
	MOVF       R0+1, 0
	MOVWF      _temp_res+1
;ADC.c,11 :: 		PORTB=temp_res;
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;ADC.c,12 :: 		PORTC=temp_res>>2;
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	MOVF       R2+0, 0
	MOVWF      PORTC+0
;ADC.c,13 :: 		}while(1);
	GOTO       L_main0
;ADC.c,14 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
