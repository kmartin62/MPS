
_main:

;KeyPad.c,20 :: 		void main()
;KeyPad.c,22 :: 		cnt = 0; // ?? ???????? ???????? ?? ???? ?????????????? ?????????? ???????
	CLRF       _cnt+0
	CLRF       _cnt+1
;KeyPad.c,23 :: 		Keypad_Init(); // ??????????????? keypad
	CALL       _Keypad_Init+0
;KeyPad.c,24 :: 		ANSEL = 0; // AN ???????? ?? ????????????? ?? ?????????
	CLRF       ANSEL+0
;KeyPad.c,25 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;KeyPad.c,26 :: 		Lcd_Init(); // ??????????????? ?? LCD
	CALL       _Lcd_Init+0
;KeyPad.c,27 :: 		Lcd_Cmd(_LCD_CLEAR); // ??????? ?? ?????
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;KeyPad.c,28 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // ?? ????????? ????????
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;KeyPad.c,29 :: 		Lcd_Out(1, 1, "Key :"); // ?? ?????? ?????? ?? LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_KeyPad+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;KeyPad.c,30 :: 		Lcd_Out(2, 1, "Times:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_KeyPad+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;KeyPad.c,31 :: 		do // ?? ????????? ????????? ?????????? ?? ???? ??????
L_main0:
;KeyPad.c,33 :: 		kp = 0; // ?? ???????? kp ?? ???? ?? ???? ????? ?? ???????????? ??????
	CLRF       _kp+0
;KeyPad.c,35 :: 		do
L_main3:
;KeyPad.c,36 :: 		kp = Keypad_Key_Click(); // ?? ???? ????? ?? ???????? ?? kp
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;KeyPad.c,37 :: 		while (!kp); //kp ?? ???? 0 ??? ?? ? ????????? ??????
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;KeyPad.c,39 :: 		switch (kp)
	GOTO       L_main6
;KeyPad.c,41 :: 		case 1: kp = 49; break; // 1
L_main8:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,42 :: 		case 2: kp = 50; break; // 2
L_main9:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,43 :: 		case 3: kp = 51; break; // 3
L_main10:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,44 :: 		case 4: kp = 65; break; // A
L_main11:
	MOVLW      65
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,45 :: 		case 5: kp = 52; break; // 4
L_main12:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,46 :: 		case 6: kp = 53; break; // 5
L_main13:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,47 :: 		case 7: kp = 54; break; // 6
L_main14:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,48 :: 		case 8: kp = 66; break; // B
L_main15:
	MOVLW      66
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,49 :: 		case 9: kp = 55; break; // 7
L_main16:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,50 :: 		case 10: kp = 56; break; // 8
L_main17:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,51 :: 		case 11: kp = 57; break; // 9
L_main18:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,52 :: 		case 12: kp = 67; break; // C
L_main19:
	MOVLW      67
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,53 :: 		case 13: kp = 42; break; // *
L_main20:
	MOVLW      42
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,54 :: 		case 14: kp = 48; break; // 0
L_main21:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,55 :: 		case 15: kp = 35; break; // #
L_main22:
	MOVLW      35
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,56 :: 		case 16: kp = 68; break; // D
L_main23:
	MOVLW      68
	MOVWF      _kp+0
	GOTO       L_main7
;KeyPad.c,57 :: 		}
L_main6:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main15
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_main23
L_main7:
;KeyPad.c,58 :: 		if (kp != oldstate)
	MOVF       _kp+0, 0
	XORWF      _oldstate+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
;KeyPad.c,61 :: 		cnt = 1;
	MOVLW      1
	MOVWF      _cnt+0
	MOVLW      0
	MOVWF      _cnt+1
;KeyPad.c,62 :: 		oldstate = kp;
	MOVF       _kp+0, 0
	MOVWF      _oldstate+0
;KeyPad.c,63 :: 		}
	GOTO       L_main25
L_main24:
;KeyPad.c,67 :: 		cnt++;
	INCF       _cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt+1, 1
;KeyPad.c,68 :: 		}
L_main25:
;KeyPad.c,69 :: 		Lcd_Chr(1, 10, kp); // ?? ?????? ASCII ????? ?? LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _kp+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;KeyPad.c,70 :: 		if (cnt == 255)
	MOVLW      0
	XORWF      _cnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main28
	MOVLW      255
	XORWF      _cnt+0, 0
L__main28:
	BTFSS      STATUS+0, 2
	GOTO       L_main26
;KeyPad.c,73 :: 		cnt = 0;
	CLRF       _cnt+0
	CLRF       _cnt+1
;KeyPad.c,74 :: 		Lcd_Out(2, 10, " ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_KeyPad+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;KeyPad.c,75 :: 		}
L_main26:
;KeyPad.c,76 :: 		WordToStr(cnt, txt); // ?? ???????????? ????????? ?? ???????? ?? ??????
	MOVF       _cnt+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       _cnt+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;KeyPad.c,77 :: 		Lcd_Out(2, 10, txt); // ?? ????????? ???????? ?? LCD
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;KeyPad.c,78 :: 		} while (1);
	GOTO       L_main0
;KeyPad.c,79 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
