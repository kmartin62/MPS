
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Mini_podmornica.c,25 :: 		void interrupt(){
;Mini_podmornica.c,26 :: 		if(TMR0IF_bit){
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;Mini_podmornica.c,27 :: 		cnt++;
	INCF       _cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt+1, 1
;Mini_podmornica.c,28 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;Mini_podmornica.c,29 :: 		TMR0 = 96;
	MOVLW      96
	MOVWF      TMR0+0
;Mini_podmornica.c,30 :: 		}
L_interrupt0:
;Mini_podmornica.c,31 :: 		}
L_end_interrupt:
L__interrupt44:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Mini_podmornica.c,33 :: 		void main()
;Mini_podmornica.c,35 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Mini_podmornica.c,36 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Mini_podmornica.c,37 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;Mini_podmornica.c,38 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Mini_podmornica.c,39 :: 		TMR0 = 96;
	MOVLW      96
	MOVWF      TMR0+0
;Mini_podmornica.c,40 :: 		INTCON = 0b10100000;
	MOVLW      160
	MOVWF      INTCON+0
;Mini_podmornica.c,41 :: 		OPTION_REG = 0x83; //011 1:16
	MOVLW      131
	MOVWF      OPTION_REG+0
;Mini_podmornica.c,42 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Mini_podmornica.c,43 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Mini_podmornica.c,44 :: 		cnt = 0;
	CLRF       _cnt+0
	CLRF       _cnt+1
;Mini_podmornica.c,45 :: 		steps = 1;
	MOVLW      1
	MOVWF      _steps+0
	MOVLW      0
	MOVWF      _steps+1
;Mini_podmornica.c,46 :: 		round = 0;
	CLRF       _round+0
	CLRF       _round+1
;Mini_podmornica.c,47 :: 		points = 0;
	CLRF       _points+0
	CLRF       _points+1
;Mini_podmornica.c,48 :: 		broj = 0;
	CLRF       _broj+0
	CLRF       _broj+1
;Mini_podmornica.c,49 :: 		y = (2000000 * x/1000) / (160 * 16);    // 1:16
	MOVLW      128
	MOVWF      R0+0
	MOVLW      132
	MOVWF      R0+1
	MOVLW      30
	MOVWF      R0+2
	MOVLW      0
	MOVWF      R0+3
	MOVF       _x+0, 0
	MOVWF      R4+0
	MOVF       _x+1, 0
	MOVWF      R4+1
	MOVLW      0
	BTFSC      R4+1, 7
	MOVLW      255
	MOVWF      R4+2
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      10
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _y+0
	MOVF       R0+1, 0
	MOVWF      _y+1
;Mini_podmornica.c,50 :: 		while(1){
L_main1:
;Mini_podmornica.c,51 :: 		if(!PORTB.B4){
	BTFSC      PORTB+0, 4
	GOTO       L_main3
;Mini_podmornica.c,52 :: 		strcpy(niza, "Start game");
	MOVLW      _niza+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr1_Mini_podmornica+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Mini_podmornica.c,53 :: 		Lcd_Out(1,1,niza);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _niza+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Mini_podmornica.c,54 :: 		while(!PORTB.B4);
L_main4:
	BTFSC      PORTB+0, 4
	GOTO       L_main5
	GOTO       L_main4
L_main5:
;Mini_podmornica.c,55 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Mini_podmornica.c,56 :: 		strcpy(niza, "Initialization");
	MOVLW      _niza+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr2_Mini_podmornica+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Mini_podmornica.c,57 :: 		Lcd_Out(1,1,niza);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _niza+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Mini_podmornica.c,59 :: 		do{
L_main6:
;Mini_podmornica.c,60 :: 		if(cnt >= y){        // make input for Xms
	MOVF       _y+1, 0
	SUBWF      _cnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main46
	MOVF       _y+0, 0
	SUBWF      _cnt+0, 0
L__main46:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
;Mini_podmornica.c,61 :: 		break;
	GOTO       L_main7
;Mini_podmornica.c,62 :: 		}
L_main9:
;Mini_podmornica.c,64 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
;Mini_podmornica.c,65 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Mini_podmornica.c,66 :: 		if(isdigit(uart_rd)){
	MOVF       R0+0, 0
	MOVWF      FARG_isdigit_character+0
	CALL       _isdigit+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main11
;Mini_podmornica.c,67 :: 		broj = broj * 10 + (uart_rd - '0');
	MOVF       _broj+0, 0
	MOVWF      R0+0
	MOVF       _broj+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      48
	SUBWF      _uart_rd+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	BTFSS      STATUS+0, 0
	DECF       R2+1, 1
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      _broj+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      _broj+1
;Mini_podmornica.c,68 :: 		}else{
	GOTO       L_main12
L_main11:
;Mini_podmornica.c,69 :: 		if(broj >= 1 && broj <= 16){
	MOVLW      128
	XORWF      _broj+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main47
	MOVLW      1
	SUBWF      _broj+0, 0
L__main47:
	BTFSS      STATUS+0, 0
	GOTO       L_main15
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _broj+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVF       _broj+0, 0
	SUBLW      16
L__main48:
	BTFSS      STATUS+0, 0
	GOTO       L_main15
L__main42:
;Mini_podmornica.c,70 :: 		podmornici[broj] = 1;
	MOVF       _broj+0, 0
	MOVWF      R0+0
	MOVF       _broj+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _podmornici+0
	MOVWF      FSR
	MOVLW      1
	MOVWF      INDF+0
	MOVLW      0
	INCF       FSR, 1
	MOVWF      INDF+0
;Mini_podmornica.c,71 :: 		}
L_main15:
;Mini_podmornica.c,72 :: 		broj = 0;
	CLRF       _broj+0
	CLRF       _broj+1
;Mini_podmornica.c,73 :: 		}
L_main12:
;Mini_podmornica.c,74 :: 		}
L_main10:
;Mini_podmornica.c,75 :: 		}while(1);
	GOTO       L_main6
L_main7:
;Mini_podmornica.c,77 :: 		if(broj >= 1 && broj <= 16){
	MOVLW      128
	XORWF      _broj+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      1
	SUBWF      _broj+0, 0
L__main49:
	BTFSS      STATUS+0, 0
	GOTO       L_main18
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _broj+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVF       _broj+0, 0
	SUBLW      16
L__main50:
	BTFSS      STATUS+0, 0
	GOTO       L_main18
L__main41:
;Mini_podmornica.c,78 :: 		podmornici[broj] = 1;
	MOVF       _broj+0, 0
	MOVWF      R0+0
	MOVF       _broj+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _podmornici+0
	MOVWF      FSR
	MOVLW      1
	MOVWF      INDF+0
	MOVLW      0
	INCF       FSR, 1
	MOVWF      INDF+0
;Mini_podmornica.c,79 :: 		}
L_main18:
;Mini_podmornica.c,81 :: 		strcpy(niza, "New game");
	MOVLW      _niza+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr3_Mini_podmornica+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Mini_podmornica.c,82 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Mini_podmornica.c,83 :: 		Lcd_Out(1,1,niza);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _niza+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Mini_podmornica.c,85 :: 		do{
L_main19:
;Mini_podmornica.c,86 :: 		kp = 0;
	CLRF       _kp+0
;Mini_podmornica.c,88 :: 		do{    //Se ceka da se klikne
L_main22:
;Mini_podmornica.c,89 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Mini_podmornica.c,90 :: 		}while(!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main22
;Mini_podmornica.c,92 :: 		switch(kp){
	GOTO       L_main25
;Mini_podmornica.c,93 :: 		case 2:   //<-
L_main27:
;Mini_podmornica.c,94 :: 		steps--;
	MOVLW      1
	SUBWF      _steps+0, 1
	BTFSS      STATUS+0, 0
	DECF       _steps+1, 1
;Mini_podmornica.c,95 :: 		if(steps <= 0){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _steps+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVF       _steps+0, 0
	SUBLW      0
L__main51:
	BTFSS      STATUS+0, 0
	GOTO       L_main28
;Mini_podmornica.c,96 :: 		steps = 1;
	MOVLW      1
	MOVWF      _steps+0
	MOVLW      0
	MOVWF      _steps+1
;Mini_podmornica.c,97 :: 		}
L_main28:
;Mini_podmornica.c,98 :: 		break;
	GOTO       L_main26
;Mini_podmornica.c,101 :: 		case 5:   //NEW
L_main29:
;Mini_podmornica.c,102 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Mini_podmornica.c,103 :: 		break;
	GOTO       L_main26
;Mini_podmornica.c,106 :: 		case 6:   //ENTER
L_main30:
;Mini_podmornica.c,107 :: 		if(podmornici[steps] == 1){
	MOVF       _steps+0, 0
	MOVWF      R0+0
	MOVF       _steps+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _podmornici+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVLW      1
	XORWF      R1+0, 0
L__main52:
	BTFSS      STATUS+0, 2
	GOTO       L_main31
;Mini_podmornica.c,108 :: 		strcpy(niza, "*");
	MOVLW      _niza+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr4_Mini_podmornica+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Mini_podmornica.c,109 :: 		Lcd_Out(1,steps,niza);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       _steps+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _niza+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Mini_podmornica.c,110 :: 		points += 3;
	MOVLW      3
	ADDWF      _points+0, 1
	BTFSC      STATUS+0, 0
	INCF       _points+1, 1
;Mini_podmornica.c,111 :: 		}
	GOTO       L_main32
L_main31:
;Mini_podmornica.c,113 :: 		strcpy(niza, "X");
	MOVLW      _niza+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr5_Mini_podmornica+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Mini_podmornica.c,114 :: 		Lcd_Out(1,steps,niza);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       _steps+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _niza+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Mini_podmornica.c,115 :: 		points -= 2;
	MOVLW      2
	SUBWF      _points+0, 1
	BTFSS      STATUS+0, 0
	DECF       _points+1, 1
;Mini_podmornica.c,116 :: 		}
L_main32:
;Mini_podmornica.c,117 :: 		steps = 1;
	MOVLW      1
	MOVWF      _steps+0
	MOVLW      0
	MOVWF      _steps+1
;Mini_podmornica.c,118 :: 		round ++;
	INCF       _round+0, 1
	BTFSC      STATUS+0, 2
	INCF       _round+1, 1
;Mini_podmornica.c,119 :: 		break;
	GOTO       L_main26
;Mini_podmornica.c,122 :: 		case 10:   //->
L_main33:
;Mini_podmornica.c,123 :: 		steps ++;
	INCF       _steps+0, 1
	BTFSC      STATUS+0, 2
	INCF       _steps+1, 1
;Mini_podmornica.c,124 :: 		break;
	GOTO       L_main26
;Mini_podmornica.c,125 :: 		}
L_main25:
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main33
L_main26:
;Mini_podmornica.c,127 :: 		if(round == 3){
	MOVLW      0
	XORWF      _round+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVLW      3
	XORWF      _round+0, 0
L__main53:
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;Mini_podmornica.c,128 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	NOP
;Mini_podmornica.c,129 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Mini_podmornica.c,130 :: 		strcpy(niza, "Points:");
	MOVLW      _niza+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr6_Mini_podmornica+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Mini_podmornica.c,131 :: 		Lcd_Out(1,1,niza);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _niza+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Mini_podmornica.c,132 :: 		IntToStr(points, niza);
	MOVF       _points+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _points+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _niza+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Mini_podmornica.c,133 :: 		Lcd_Out(1,11,niza);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _niza+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Mini_podmornica.c,134 :: 		break;
	GOTO       L_main20
;Mini_podmornica.c,135 :: 		}
L_main34:
;Mini_podmornica.c,137 :: 		}while(1);
	GOTO       L_main19
L_main20:
;Mini_podmornica.c,139 :: 		for(i = 1; i < 16; i ++){
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main36:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVLW      16
	SUBWF      _i+0, 0
L__main54:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
;Mini_podmornica.c,140 :: 		if(podmornici[i] == 1){
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _podmornici+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      1
	XORWF      R1+0, 0
L__main55:
	BTFSS      STATUS+0, 2
	GOTO       L_main39
;Mini_podmornica.c,141 :: 		Lcd_Out(2,i,"*");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_Mini_podmornica+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Mini_podmornica.c,142 :: 		}
L_main39:
;Mini_podmornica.c,139 :: 		for(i = 1; i < 16; i ++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Mini_podmornica.c,143 :: 		}
	GOTO       L_main36
L_main37:
;Mini_podmornica.c,145 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	NOP
;Mini_podmornica.c,146 :: 		PORTB.B4 = 0;
	BCF        PORTB+0, 4
;Mini_podmornica.c,148 :: 		}
L_main3:
;Mini_podmornica.c,150 :: 		}
	GOTO       L_main1
;Mini_podmornica.c,151 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
