
_main:

;LCDdemo.c,19 :: 		void main() {
;LCDdemo.c,20 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;LCDdemo.c,21 :: 		ANSELH = 0;           // Analog -> Digital
	CLRF       ANSELH+0
;LCDdemo.c,23 :: 		Lcd_Init();                 // Initial LCD
	CALL       _Lcd_Init+0
;LCDdemo.c,25 :: 		strcpy(text3,"Demo text1");
	MOVLW      _text3+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr1_LCDdemo+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;LCDdemo.c,26 :: 		Lcd_Out(1,1,text3);            // Prikazi text3 pocnuvajki od pozicija [1,1]
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCDdemo.c,28 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);     // Kursorot neka blinka
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCDdemo.c,29 :: 		Lcd_Cmd(_LCD_CLEAR);               // Iscisti go displayot
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCDdemo.c,31 :: 		strcpy(text,"Demo text");         // Prikazi text pocnuvajki od pozicija [1,2]
	MOVLW      _text+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr2_LCDdemo+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;LCDdemo.c,32 :: 		Lcd_Out(1,2,text);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCDdemo.c,34 :: 		strcpy(text2,"Second line");     // Prikazi text2 pocnuvajki od pozicija [2,5]
	MOVLW      _text2+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr3_LCDdemo+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;LCDdemo.c,35 :: 		Lcd_Out(2,5,text2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCDdemo.c,37 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCDdemo.c,38 :: 		broj = 123;
	MOVLW      123
	MOVWF      _broj+0
	MOVLW      0
	MOVWF      _broj+1
;LCDdemo.c,39 :: 		IntToStr(broj, niza);
	MOVLW      123
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _niza+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;LCDdemo.c,40 :: 		Lcd_Out(1,1,niza);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _niza+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCDdemo.c,41 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
