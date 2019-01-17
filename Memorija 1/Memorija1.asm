
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Memorija1.c,25 :: 		void interrupt(){
;Memorija1.c,26 :: 		if(TMR0IF_bit){
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;Memorija1.c,27 :: 		cnt ++;
	INCF       _cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt+1, 1
;Memorija1.c,28 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;Memorija1.c,29 :: 		TMR0 = 96;
	MOVLW      96
	MOVWF      TMR0+0
;Memorija1.c,30 :: 		}
L_interrupt0:
;Memorija1.c,31 :: 		}
L_end_interrupt:
L__interrupt50:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Memorija1.c,33 :: 		void main() {
;Memorija1.c,34 :: 		steps = 0;
	CLRF       _steps+0
	CLRF       _steps+1
;Memorija1.c,35 :: 		ANSEL = 0x00;
	CLRF       ANSEL+0
;Memorija1.c,36 :: 		ANSELH = 0b010000;
	MOVLW      16
	MOVWF      ANSELH+0
;Memorija1.c,37 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;Memorija1.c,38 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Memorija1.c,39 :: 		TMR0 = 96;
	MOVLW      96
	MOVWF      TMR0+0
;Memorija1.c,40 :: 		INTCON = 0b10100000;
	MOVLW      160
	MOVWF      INTCON+0
;Memorija1.c,41 :: 		OPTION_REG = 0x83; // 1:16 preskaler
	MOVLW      131
	MOVWF      OPTION_REG+0
;Memorija1.c,42 :: 		cnt = 0;
	CLRF       _cnt+0
	CLRF       _cnt+1
;Memorija1.c,43 :: 		x = (2000000 * 25/1000) / (160 * 16); //1:16
	MOVLW      19
	MOVWF      _x+0
	MOVLW      0
	MOVWF      _x+1
;Memorija1.c,44 :: 		i = j = counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
	CLRF       _j+0
	CLRF       _j+1
	CLRF       _i+0
	CLRF       _i+1
;Memorija1.c,45 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;Memorija1.c,46 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Memorija1.c,47 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Memorija1.c,49 :: 		while(1){
L_main1:
;Memorija1.c,50 :: 		do{
L_main3:
;Memorija1.c,51 :: 		kp = 0;
	CLRF       _kp+0
;Memorija1.c,53 :: 		do{    //Se ceka da se klikne
L_main6:
;Memorija1.c,54 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;Memorija1.c,55 :: 		}while(!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
;Memorija1.c,57 :: 		switch(kp){
	GOTO       L_main9
;Memorija1.c,58 :: 		case 1: // NEW
L_main11:
;Memorija1.c,59 :: 		strcpy(message, "READING");
	MOVLW      _message+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr1_Memorija1+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Memorija1.c,60 :: 		Lcd_Out(1,1,message);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Memorija1.c,61 :: 		do{
L_main12:
;Memorija1.c,62 :: 		temp_res = 0;
	CLRF       _temp_res+0
	CLRF       _temp_res+1
;Memorija1.c,63 :: 		while(1){
L_main15:
;Memorija1.c,64 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Memorija1.c,65 :: 		strcpy(message, "Make input now");
	MOVLW      _message+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr2_Memorija1+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Memorija1.c,66 :: 		Lcd_Out(1,1,message);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Memorija1.c,67 :: 		delay_ms(25);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	NOP
;Memorija1.c,71 :: 		temp_res = ADC_Read(12);
	MOVLW      12
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _temp_res+0
	MOVF       R0+1, 0
	MOVWF      _temp_res+1
;Memorija1.c,72 :: 		if(temp_res > 9 && temp_res < 100){
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVF       R0+0, 0
	SUBLW      9
L__main52:
	BTFSC      STATUS+0, 0
	GOTO       L_main20
	MOVLW      128
	XORWF      _temp_res+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVLW      100
	SUBWF      _temp_res+0, 0
L__main53:
	BTFSC      STATUS+0, 0
	GOTO       L_main20
L__main48:
;Memorija1.c,73 :: 		niza[i++] = temp_res;
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
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Memorija1.c,74 :: 		nizaChar[j++] = temp_res/10 + '0';
	MOVF       _j+0, 0
	ADDLW      _nizaChar+0
	MOVWF      FLOC__main+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _temp_res+0, 0
	MOVWF      R0+0
	MOVF       _temp_res+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;Memorija1.c,75 :: 		nizaChar[j++] = temp_res%10 + '0';
	MOVF       _j+0, 0
	ADDLW      _nizaChar+0
	MOVWF      FLOC__main+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _temp_res+0, 0
	MOVWF      R0+0
	MOVF       _temp_res+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;Memorija1.c,76 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;Memorija1.c,77 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Memorija1.c,78 :: 		strcpy(message, "Input made");
	MOVLW      _message+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr3_Memorija1+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Memorija1.c,79 :: 		Lcd_Out(1,1,message);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Memorija1.c,80 :: 		break;
	GOTO       L_main16
;Memorija1.c,81 :: 		}
L_main20:
;Memorija1.c,85 :: 		}
	GOTO       L_main15
L_main16:
;Memorija1.c,86 :: 		if(counter == 6){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVLW      6
	XORWF      _counter+0, 0
L__main54:
	BTFSS      STATUS+0, 2
	GOTO       L_main21
;Memorija1.c,87 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Memorija1.c,88 :: 		Lcd_Out(1,1,nizaChar);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _nizaChar+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Memorija1.c,90 :: 		i = j = counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
	CLRF       _j+0
	CLRF       _j+1
	CLRF       _i+0
	CLRF       _i+1
;Memorija1.c,91 :: 		while(1){
L_main22:
;Memorija1.c,92 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
;Memorija1.c,93 :: 		uart_rd = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;Memorija1.c,94 :: 		if(isdigit(uart_rd)){
	MOVF       R0+0, 0
	MOVWF      FARG_isdigit_character+0
	CALL       _isdigit+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main25
;Memorija1.c,95 :: 		broj = broj * 10 + (uart_rd - '0');
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
;Memorija1.c,96 :: 		}
L_main25:
;Memorija1.c,98 :: 		if(uart_rd == '-'){
	MOVF       _uart_rd+0, 0
	XORLW      45
	BTFSS      STATUS+0, 2
	GOTO       L_main26
;Memorija1.c,99 :: 		if(broj > 99 && broj < 1000){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _broj+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVF       _broj+0, 0
	SUBLW      99
L__main55:
	BTFSC      STATUS+0, 0
	GOTO       L_main29
	MOVLW      128
	XORWF      _broj+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      3
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVLW      232
	SUBWF      _broj+0, 0
L__main56:
	BTFSC      STATUS+0, 0
	GOTO       L_main29
L__main47:
;Memorija1.c,100 :: 		niza2[i++] = broj;
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _niza2+0
	MOVWF      FSR
	MOVF       _broj+0, 0
	MOVWF      INDF+0
	MOVF       _broj+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Memorija1.c,101 :: 		nizaChar2[j++] = broj / 100 + '0';
	MOVF       _j+0, 0
	ADDLW      _nizaChar2+0
	MOVWF      FLOC__main+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _broj+0, 0
	MOVWF      R0+0
	MOVF       _broj+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;Memorija1.c,102 :: 		nizaChar2[j++] = (broj / 10) % 10 + '0';
	MOVF       _j+0, 0
	ADDLW      _nizaChar2+0
	MOVWF      FLOC__main+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _broj+0, 0
	MOVWF      R0+0
	MOVF       _broj+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;Memorija1.c,103 :: 		nizaChar2[j++] = broj % 10 + '0';
	MOVF       _j+0, 0
	ADDLW      _nizaChar2+0
	MOVWF      FLOC__main+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _broj+0, 0
	MOVWF      R0+0
	MOVF       _broj+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;Memorija1.c,104 :: 		counter ++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;Memorija1.c,106 :: 		}
	GOTO       L_main30
L_main29:
;Memorija1.c,108 :: 		i = j = counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
	CLRF       _j+0
	CLRF       _j+1
	CLRF       _i+0
	CLRF       _i+1
;Memorija1.c,109 :: 		strcpy(message, "Error");
	MOVLW      _message+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr4_Memorija1+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Memorija1.c,110 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Memorija1.c,111 :: 		Lcd_Out(1,1,message);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Memorija1.c,112 :: 		delay_ms(25);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	NOP
;Memorija1.c,113 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Memorija1.c,115 :: 		}
L_main30:
;Memorija1.c,116 :: 		}
L_main26:
;Memorija1.c,118 :: 		if(uart_rd == '$'){
	MOVF       _uart_rd+0, 0
	XORLW      36
	BTFSS      STATUS+0, 2
	GOTO       L_main32
;Memorija1.c,119 :: 		if(counter != 4){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      4
	XORWF      _counter+0, 0
L__main57:
	BTFSC      STATUS+0, 2
	GOTO       L_main33
;Memorija1.c,120 :: 		strcpy(message, "Error");
	MOVLW      _message+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr5_Memorija1+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Memorija1.c,121 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Memorija1.c,122 :: 		Lcd_Out(1,1,message);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Memorija1.c,123 :: 		delay_ms(25);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	NOP
;Memorija1.c,124 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Memorija1.c,125 :: 		}
	GOTO       L_main35
L_main33:
;Memorija1.c,127 :: 		break;
	GOTO       L_main23
;Memorija1.c,128 :: 		}
L_main35:
;Memorija1.c,129 :: 		}
L_main32:
;Memorija1.c,130 :: 		}
L_main24:
;Memorija1.c,132 :: 		}
	GOTO       L_main22
L_main23:
;Memorija1.c,133 :: 		}
L_main21:
;Memorija1.c,137 :: 		}while(1);
	GOTO       L_main12
;Memorija1.c,142 :: 		case 2: // <-
L_main36:
;Memorija1.c,143 :: 		steps --;
	MOVLW      1
	SUBWF      _steps+0, 1
	BTFSS      STATUS+0, 0
	DECF       _steps+1, 1
;Memorija1.c,144 :: 		break;
	GOTO       L_main10
;Memorija1.c,146 :: 		case 5: //Enter
L_main37:
;Memorija1.c,147 :: 		strcpy(message, "START");
	MOVLW      _message+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr6_Memorija1+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Memorija1.c,148 :: 		Lcd_Out(2,1,message);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Memorija1.c,149 :: 		break;
	GOTO       L_main10
;Memorija1.c,151 :: 		case 6: //++
L_main38:
;Memorija1.c,152 :: 		niza[steps]++;
	MOVF       _steps+0, 0
	MOVWF      R0+0
	MOVF       _steps+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _niza+0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Memorija1.c,153 :: 		nizaChar[steps] = niza[steps] + '0';
	MOVF       _steps+0, 0
	ADDLW      _nizaChar+0
	MOVWF      R3+0
	MOVF       _steps+0, 0
	MOVWF      R0+0
	MOVF       _steps+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _niza+0
	MOVWF      FSR
	MOVLW      48
	ADDWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Memorija1.c,154 :: 		Lcd_Chr(1,steps+1,nizaChar[steps]);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       _steps+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _steps+0, 0
	ADDLW      _nizaChar+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Memorija1.c,155 :: 		break;
	GOTO       L_main10
;Memorija1.c,157 :: 		case 9: //END
L_main39:
;Memorija1.c,158 :: 		counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
;Memorija1.c,159 :: 		for(i = 0; i < 17; i ++) {
	CLRF       _i+0
	CLRF       _i+1
L_main40:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVLW      17
	SUBWF      _i+0, 0
L__main58:
	BTFSC      STATUS+0, 0
	GOTO       L_main41
;Memorija1.c,160 :: 		if(niza[i] != niza2[i]){
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
	MOVF       INDF+0, 0
	MOVWF      R3+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R3+1
	MOVF       R0+0, 0
	ADDLW      _niza2+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVF       R3+1, 0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVF       R1+0, 0
	XORWF      R3+0, 0
L__main59:
	BTFSC      STATUS+0, 2
	GOTO       L_main43
;Memorija1.c,161 :: 		counter ++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;Memorija1.c,162 :: 		}
L_main43:
;Memorija1.c,159 :: 		for(i = 0; i < 17; i ++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Memorija1.c,163 :: 		}
	GOTO       L_main40
L_main41:
;Memorija1.c,164 :: 		strcpy(message, "Error");
	MOVLW      _message+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr7_Memorija1+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Memorija1.c,165 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Memorija1.c,166 :: 		Lcd_Out(1,1,message);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Memorija1.c,167 :: 		IntToStr(counter, message);
	MOVF       _counter+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _counter+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _message+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Memorija1.c,168 :: 		Lcd_Out(2,1,message);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _message+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Memorija1.c,169 :: 		counter = 99;
	MOVLW      99
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;Memorija1.c,170 :: 		break;
	GOTO       L_main10
;Memorija1.c,172 :: 		case 10: //--
L_main44:
;Memorija1.c,173 :: 		niza[steps]--;
	MOVF       _steps+0, 0
	MOVWF      R0+0
	MOVF       _steps+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _niza+0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVLW      1
	SUBWF      R0+0, 1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Memorija1.c,174 :: 		nizaChar[steps] = niza[steps] + '0';
	MOVF       _steps+0, 0
	ADDLW      _nizaChar+0
	MOVWF      R3+0
	MOVF       _steps+0, 0
	MOVWF      R0+0
	MOVF       _steps+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _niza+0
	MOVWF      FSR
	MOVLW      48
	ADDWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Memorija1.c,175 :: 		Lcd_Chr(1,steps+1,nizaChar[steps]);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       _steps+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _steps+0, 0
	ADDLW      _nizaChar+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Memorija1.c,176 :: 		break;
	GOTO       L_main10
;Memorija1.c,178 :: 		case 14: // ->
L_main45:
;Memorija1.c,179 :: 		steps ++;
	INCF       _steps+0, 1
	BTFSC      STATUS+0, 2
	INCF       _steps+1, 1
;Memorija1.c,180 :: 		break;
	GOTO       L_main10
;Memorija1.c,181 :: 		}
L_main9:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main36
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main37
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main38
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main39
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main44
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main45
L_main10:
;Memorija1.c,183 :: 		if(counter == 99){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      99
	XORWF      _counter+0, 0
L__main60:
	BTFSS      STATUS+0, 2
	GOTO       L_main46
;Memorija1.c,184 :: 		break;
	GOTO       L_main4
;Memorija1.c,185 :: 		}
L_main46:
;Memorija1.c,187 :: 		}while(1);
	GOTO       L_main3
L_main4:
;Memorija1.c,189 :: 		}
	GOTO       L_main1
;Memorija1.c,190 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
