
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Lab2.c,20 :: 		void interrupt(){
;Lab2.c,21 :: 		if(INTF_bit == 1) {
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;Lab2.c,22 :: 		ifClicked ++;
	INCF       _ifClicked+0, 1
;Lab2.c,23 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Lab2.c,24 :: 		}
L_interrupt0:
;Lab2.c,26 :: 		if(TMR0IF_bit){
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt1
;Lab2.c,27 :: 		cnt ++;
	INCF       _cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt+1, 1
;Lab2.c,28 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;Lab2.c,29 :: 		TMR0 = 96;
	MOVLW      96
	MOVWF      TMR0+0
;Lab2.c,30 :: 		}
L_interrupt1:
;Lab2.c,36 :: 		}
L_end_interrupt:
L__interrupt13:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Lab2.c,38 :: 		void main() {
;Lab2.c,40 :: 		OPTION_REG = 0x03; // 011
	MOVLW      3
	MOVWF      OPTION_REG+0
;Lab2.c,42 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Lab2.c,43 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Lab2.c,45 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Lab2.c,46 :: 		TRISB = 0x01;
	MOVLW      1
	MOVWF      TRISB+0
;Lab2.c,48 :: 		INTCON = 0b10110000;
	MOVLW      176
	MOVWF      INTCON+0
;Lab2.c,49 :: 		TMR0 = 96;
	MOVLW      96
	MOVWF      TMR0+0
;Lab2.c,51 :: 		while(ifClicked == 0 ) {
L_main2:
	MOVF       _ifClicked+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;Lab2.c,52 :: 		}
	GOTO       L_main2
L_main3:
;Lab2.c,53 :: 		ifClicked --;
	DECF       _ifClicked+0, 1
;Lab2.c,55 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Lab2.c,56 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lab2.c,57 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lab2.c,59 :: 		strcpy(name, "Martin");
	MOVLW      _name+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr1_Lab2+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Lab2.c,61 :: 		while(1){
L_main4:
;Lab2.c,63 :: 		if(ifClicked % 2 == 0){
	MOVLW      2
	MOVWF      R4+0
	MOVF       _ifClicked+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;Lab2.c,64 :: 		Lcd_Out(1,11,name);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _name+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab2.c,65 :: 		}
	GOTO       L_main7
L_main6:
;Lab2.c,67 :: 		else if(ifClicked % 2 == 1){
	MOVLW      2
	MOVWF      R4+0
	MOVF       _ifClicked+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;Lab2.c,68 :: 		counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
;Lab2.c,69 :: 		while(ifClicked %2 == 1){
L_main9:
	MOVLW      2
	MOVWF      R4+0
	MOVF       _ifClicked+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;Lab2.c,70 :: 		if(cnt >= 26){
	MOVLW      0
	SUBWF      _cnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVLW      26
	SUBWF      _cnt+0, 0
L__main15:
	BTFSS      STATUS+0, 0
	GOTO       L_main11
;Lab2.c,71 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lab2.c,72 :: 		IntToStr(counter, broj);
	MOVF       _counter+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _counter+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab2.c,73 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab2.c,75 :: 		counter += 5;
	MOVLW      5
	ADDWF      _counter+0, 1
	BTFSC      STATUS+0, 0
	INCF       _counter+1, 1
;Lab2.c,76 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lab2.c,77 :: 		}
L_main11:
;Lab2.c,78 :: 		}
	GOTO       L_main9
L_main10:
;Lab2.c,80 :: 		}
L_main8:
L_main7:
;Lab2.c,84 :: 		}
	GOTO       L_main4
;Lab2.c,88 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
