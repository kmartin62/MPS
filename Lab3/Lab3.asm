
_main:

;Lab3.c,21 :: 		void main()
;Lab3.c,24 :: 		ANSEL = 0x01;
	MOVLW      1
	MOVWF      ANSEL+0
;Lab3.c,25 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Lab3.c,26 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;Lab3.c,28 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;Lab3.c,30 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Lab3.c,31 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lab3.c,32 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Lab3.c,34 :: 		do
L_main0:
;Lab3.c,36 :: 		kp = 0;
	CLRF       _kp+0
;Lab3.c,37 :: 		do
L_main3:
;Lab3.c,38 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Lab3.c,39 :: 		while (!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;Lab3.c,40 :: 		switch (kp)
	GOTO       L_main6
;Lab3.c,42 :: 		case 1:
L_main8:
;Lab3.c,43 :: 		kp_cifra = 1;
	MOVLW      1
	MOVWF      _kp_cifra+0
	MOVLW      0
	MOVWF      _kp_cifra+1
;Lab3.c,44 :: 		IntToStr(kp_cifra, broj);
	MOVLW      1
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,45 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,47 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main46
	MOVF       _tmp+0, 0
	SUBLW      255
L__main46:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
;Lab3.c,48 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 1
	MOVF       _kp_cifra+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	MOVWF      _tmp+1
;Lab3.c,49 :: 		IntToStr(tmp, broj);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,50 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,51 :: 		}
	GOTO       L_main10
L_main9:
;Lab3.c,53 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,54 :: 		}
L_main10:
;Lab3.c,56 :: 		break; // 1
	GOTO       L_main7
;Lab3.c,58 :: 		case 2:
L_main11:
;Lab3.c,59 :: 		kp_cifra = 4;
	MOVLW      4
	MOVWF      _kp_cifra+0
	MOVLW      0
	MOVWF      _kp_cifra+1
;Lab3.c,60 :: 		IntToStr(kp_cifra, broj);
	MOVLW      4
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,61 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,63 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main47
	MOVF       _tmp+0, 0
	SUBLW      255
L__main47:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
;Lab3.c,65 :: 		Lcd_Out(1,2,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,66 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,67 :: 		}
	GOTO       L_main13
L_main12:
;Lab3.c,69 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,70 :: 		}
L_main13:
;Lab3.c,72 :: 		break; // 4
	GOTO       L_main7
;Lab3.c,74 :: 		case 3:
L_main14:
;Lab3.c,75 :: 		kp_cifra = 7;
	MOVLW      7
	MOVWF      _kp_cifra+0
	MOVLW      0
	MOVWF      _kp_cifra+1
;Lab3.c,76 :: 		IntToStr(kp_cifra, broj);
	MOVLW      7
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,77 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,79 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVF       _tmp+0, 0
	SUBLW      255
L__main48:
	BTFSC      STATUS+0, 0
	GOTO       L_main15
;Lab3.c,81 :: 		Lcd_Out(1,2,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,82 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,83 :: 		}
	GOTO       L_main16
L_main15:
;Lab3.c,85 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,86 :: 		}
L_main16:
;Lab3.c,87 :: 		break; // 7
	GOTO       L_main7
;Lab3.c,89 :: 		case 5:
L_main17:
;Lab3.c,90 :: 		kp_cifra = 2;
	MOVLW      2
	MOVWF      _kp_cifra+0
	MOVLW      0
	MOVWF      _kp_cifra+1
;Lab3.c,91 :: 		IntToStr(kp_cifra, broj);
	MOVLW      2
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,92 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,94 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVF       _tmp+0, 0
	SUBLW      255
L__main49:
	BTFSC      STATUS+0, 0
	GOTO       L_main18
;Lab3.c,96 :: 		Lcd_Out(1,2,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,97 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,98 :: 		}
	GOTO       L_main19
L_main18:
;Lab3.c,100 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,101 :: 		}
L_main19:
;Lab3.c,102 :: 		break; // 2
	GOTO       L_main7
;Lab3.c,104 :: 		case 6:
L_main20:
;Lab3.c,105 :: 		kp_cifra = 5;
	MOVLW      5
	MOVWF      _kp_cifra+0
	MOVLW      0
	MOVWF      _kp_cifra+1
;Lab3.c,106 :: 		IntToStr(kp_cifra, broj);
	MOVLW      5
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,107 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,109 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVF       _tmp+0, 0
	SUBLW      255
L__main50:
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;Lab3.c,111 :: 		Lcd_Out(1,2,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,112 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,113 :: 		}
	GOTO       L_main22
L_main21:
;Lab3.c,115 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,116 :: 		}
L_main22:
;Lab3.c,117 :: 		break; // 5
	GOTO       L_main7
;Lab3.c,119 :: 		case 7:
L_main23:
;Lab3.c,120 :: 		kp_cifra = 8;
	MOVLW      8
	MOVWF      _kp_cifra+0
	MOVLW      0
	MOVWF      _kp_cifra+1
;Lab3.c,121 :: 		IntToStr(kp_cifra, broj);
	MOVLW      8
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,122 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,124 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVF       _tmp+0, 0
	SUBLW      255
L__main51:
	BTFSC      STATUS+0, 0
	GOTO       L_main24
;Lab3.c,126 :: 		Lcd_Out(1,2,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,127 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,128 :: 		}
	GOTO       L_main25
L_main24:
;Lab3.c,130 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,131 :: 		}
L_main25:
;Lab3.c,132 :: 		break; // 8      // 54 = 6
	GOTO       L_main7
;Lab3.c,134 :: 		case 8:
L_main26:
;Lab3.c,135 :: 		kp_cifra = 0;
	CLRF       _kp_cifra+0
	CLRF       _kp_cifra+1
;Lab3.c,136 :: 		IntToStr(kp_cifra, broj);
	CLRF       FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,137 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,139 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVF       _tmp+0, 0
	SUBLW      255
L__main52:
	BTFSC      STATUS+0, 0
	GOTO       L_main27
;Lab3.c,141 :: 		Lcd_Out(1,2,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,142 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,143 :: 		}
	GOTO       L_main28
L_main27:
;Lab3.c,145 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,146 :: 		}
L_main28:
;Lab3.c,147 :: 		break; // 0
	GOTO       L_main7
;Lab3.c,149 :: 		case 9:
L_main29:
;Lab3.c,150 :: 		kp_cifra = 3;
	MOVLW      3
	MOVWF      _kp_cifra+0
	MOVLW      0
	MOVWF      _kp_cifra+1
;Lab3.c,151 :: 		IntToStr(kp_cifra, broj);
	MOVLW      3
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,152 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,154 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVF       _tmp+0, 0
	SUBLW      255
L__main53:
	BTFSC      STATUS+0, 0
	GOTO       L_main30
;Lab3.c,156 :: 		Lcd_Out(1,2,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,157 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,158 :: 		}
	GOTO       L_main31
L_main30:
;Lab3.c,160 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,161 :: 		}
L_main31:
;Lab3.c,162 :: 		break; // 3
	GOTO       L_main7
;Lab3.c,164 :: 		case 10:
L_main32:
;Lab3.c,165 :: 		kp_cifra = 6;
	MOVLW      6
	MOVWF      _kp_cifra+0
	MOVLW      0
	MOVWF      _kp_cifra+1
;Lab3.c,166 :: 		IntToStr(kp_cifra, broj);
	MOVLW      6
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,167 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,169 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVF       _tmp+0, 0
	SUBLW      255
L__main54:
	BTFSC      STATUS+0, 0
	GOTO       L_main33
;Lab3.c,171 :: 		Lcd_Out(1,2,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,172 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,173 :: 		}
	GOTO       L_main34
L_main33:
;Lab3.c,175 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,176 :: 		}
L_main34:
;Lab3.c,177 :: 		break; // 6
	GOTO       L_main7
;Lab3.c,179 :: 		case 11:
L_main35:
;Lab3.c,180 :: 		kp_cifra = 9;
	MOVLW      9
	MOVWF      _kp_cifra+0
	MOVLW      0
	MOVWF      _kp_cifra+1
;Lab3.c,181 :: 		IntToStr(kp_cifra, broj);
	MOVLW      9
	MOVWF      FARG_IntToStr_input+0
	MOVLW      0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,182 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,184 :: 		if(tmp > -1){
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVF       _tmp+0, 0
	SUBLW      255
L__main55:
	BTFSC      STATUS+0, 0
	GOTO       L_main36
;Lab3.c,186 :: 		Lcd_Out(1,2,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,187 :: 		tmp = tmp * 10 + kp_cifra;
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp_cifra+0, 0
	ADDWF      R0+0, 0
	MOVWF      _tmp+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,188 :: 		}
	GOTO       L_main37
L_main36:
;Lab3.c,190 :: 		tmp = kp_cifra;
	MOVF       _kp_cifra+0, 0
	MOVWF      _tmp+0
	MOVF       _kp_cifra+1, 0
	MOVWF      _tmp+1
;Lab3.c,191 :: 		}
L_main37:
;Lab3.c,192 :: 		break; // 9
	GOTO       L_main7
;Lab3.c,195 :: 		case 13:
L_main38:
;Lab3.c,196 :: 		temp_res = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _temp_res+0
	MOVF       R0+1, 0
	MOVWF      _temp_res+1
;Lab3.c,197 :: 		IntToStr(temp_res, broj);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,198 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,199 :: 		niza[i] = temp_res;
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _niza+0
	MOVWF      FSR
	MOVF       _temp_res+0, 0
	MOVWF      INDF+0
	MOVF       _temp_res+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Lab3.c,200 :: 		i ++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Lab3.c,201 :: 		break; // MERI
	GOTO       L_main7
;Lab3.c,203 :: 		case 14:
L_main39:
;Lab3.c,208 :: 		if(tmp > 20) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tmp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVF       _tmp+0, 0
	SUBLW      20
L__main56:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
;Lab3.c,209 :: 		strcpy(broj, "Greshka");
	MOVLW      _broj+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr1_Lab3+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Lab3.c,210 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,211 :: 		}
L_main40:
;Lab3.c,213 :: 		IntToStr(niza[tmp], broj);
	MOVF       _tmp+0, 0
	MOVWF      R0+0
	MOVF       _tmp+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _niza+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,214 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,217 :: 		break; // PRIKAZI
	GOTO       L_main7
;Lab3.c,219 :: 		case 15:
L_main41:
;Lab3.c,220 :: 		for(j = 0; j < i; j ++) {
	CLRF       _j+0
	CLRF       _j+1
L_main42:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVF       _i+0, 0
	SUBWF      _j+0, 0
L__main57:
	BTFSC      STATUS+0, 0
	GOTO       L_main43
;Lab3.c,221 :: 		prosek += niza[j];
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _niza+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      _prosek+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _prosek+1, 1
;Lab3.c,220 :: 		for(j = 0; j < i; j ++) {
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;Lab3.c,222 :: 		}
	GOTO       L_main42
L_main43:
;Lab3.c,224 :: 		prosek = prosek / i;
	MOVF       _i+0, 0
	MOVWF      R4+0
	MOVF       _i+1, 0
	MOVWF      R4+1
	MOVF       _prosek+0, 0
	MOVWF      R0+0
	MOVF       _prosek+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _prosek+0
	MOVF       R0+1, 0
	MOVWF      _prosek+1
;Lab3.c,226 :: 		IntToStr(prosek, broj);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _broj+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Lab3.c,227 :: 		Lcd_Out(1,1,broj);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _broj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Lab3.c,228 :: 		break; // PROSEK
	GOTO       L_main7
;Lab3.c,230 :: 		}
L_main6:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main32
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main35
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main38
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main39
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main41
L_main7:
;Lab3.c,250 :: 		} while (1);
	GOTO       L_main0
;Lab3.c,251 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
