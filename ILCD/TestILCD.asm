
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TestILCD.c,18 :: 		void interrupt(){
;TestILCD.c,19 :: 		if(INTF_bit == 1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;TestILCD.c,20 :: 		ifinterrupt ++;
	INCF       _ifinterrupt+0, 1
;TestILCD.c,21 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;TestILCD.c,22 :: 		}
L_interrupt0:
;TestILCD.c,23 :: 		}
L_end_interrupt:
L__interrupt8:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TestILCD.c,25 :: 		void main() {
;TestILCD.c,26 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;TestILCD.c,27 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;TestILCD.c,32 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;TestILCD.c,33 :: 		TRISB = 0x01;
	MOVLW      1
	MOVWF      TRISB+0
;TestILCD.c,35 :: 		INTCON = 0x90;
	MOVLW      144
	MOVWF      INTCON+0
;TestILCD.c,37 :: 		strcpy(text1,"Before click");
	MOVLW      _text1+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr1_TestILCD+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;TestILCD.c,38 :: 		strcpy(text2, "After click");
	MOVLW      _text2+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr2_TestILCD+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;TestILCD.c,40 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;TestILCD.c,41 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TestILCD.c,45 :: 		while(1){
L_main1:
;TestILCD.c,47 :: 		while(ifinterrupt == 0){
L_main3:
	MOVF       _ifinterrupt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;TestILCD.c,48 :: 		}
	GOTO       L_main3
L_main4:
;TestILCD.c,49 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TestILCD.c,50 :: 		Lcd_Out(1,1,text1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TestILCD.c,52 :: 		while(ifinterrupt == 1) {
L_main5:
	MOVF       _ifinterrupt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;TestILCD.c,53 :: 		}
	GOTO       L_main5
L_main6:
;TestILCD.c,54 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TestILCD.c,55 :: 		Lcd_Out(1,1,text2);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TestILCD.c,59 :: 		ifinterrupt = 0;
	CLRF       _ifinterrupt+0
;TestILCD.c,61 :: 		}
	GOTO       L_main1
;TestILCD.c,62 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
