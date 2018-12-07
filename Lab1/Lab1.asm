
_main:

;Lab1.c,8 :: 		void main() {
;Lab1.c,9 :: 		TRISB = 0x00;  //output
	CLRF       TRISB+0
;Lab1.c,10 :: 		TRISA = 0xFF;  //input
	MOVLW      255
	MOVWF      TRISA+0
;Lab1.c,12 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Lab1.c,13 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Lab1.c,15 :: 		PORTB = 0;
	CLRF       PORTB+0
;Lab1.c,17 :: 		for(i = 0; i < 9; i ++) {
	CLRF       _i+0
	CLRF       _i+1
L_main0:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVLW      9
	SUBWF      _i+0, 0
L__main14:
	BTFSC      STATUS+0, 0
	GOTO       L_main1
;Lab1.c,18 :: 		EEPROM_Write(addresses[i], counter);
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _addresses+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _counter+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Lab1.c,17 :: 		for(i = 0; i < 9; i ++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Lab1.c,19 :: 		}
	GOTO       L_main0
L_main1:
;Lab1.c,21 :: 		while(1){
L_main3:
;Lab1.c,22 :: 		for(i = 0; i < 9; i ++) {
	CLRF       _i+0
	CLRF       _i+1
L_main5:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVLW      9
	SUBWF      _i+0, 0
L__main15:
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;Lab1.c,23 :: 		if(PORTA == values[i]){
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _values+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVF       R1+0, 0
	XORWF      PORTA+0, 0
L__main16:
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;Lab1.c,24 :: 		if(flag){
	MOVF       _flag+0, 0
	IORWF      _flag+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main9
;Lab1.c,25 :: 		flag = 0;
	CLRF       _flag+0
	CLRF       _flag+1
;Lab1.c,26 :: 		PORTB = display[i];
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
;Lab1.c,27 :: 		current = values[i];   //Zacuvaj momentalna vrednost
	MOVF       R0+0, 0
	ADDLW      _values+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      _current+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      _current+1
;Lab1.c,28 :: 		EEPROM_Write(addresses[i], EEPROM_Read(addresses[i])+1); //Zapisi vo memorija
	MOVF       R0+0, 0
	ADDLW      _addresses+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	INCF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _addresses+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	CALL       _EEPROM_Write+0
;Lab1.c,29 :: 		}
	GOTO       L_main10
L_main9:
;Lab1.c,31 :: 		if(values[i] != current) flag = 1;
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _values+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVF       R1+1, 0
	XORWF      _current+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVF       _current+0, 0
	XORWF      R1+0, 0
L__main17:
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVLW      1
	MOVWF      _flag+0
	MOVLW      0
	MOVWF      _flag+1
L_main11:
;Lab1.c,32 :: 		}
L_main10:
;Lab1.c,33 :: 		}
L_main8:
;Lab1.c,22 :: 		for(i = 0; i < 9; i ++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Lab1.c,37 :: 		}
	GOTO       L_main5
L_main6:
;Lab1.c,39 :: 		if(EEPROM_Read(addresses[0]) - 1 == 3) break; //Ignoriraj go prviot count od startuvanje na programata, zatoa -1
	MOVF       _addresses+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVLW      1
	SUBWF      R0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main18
	MOVLW      3
	XORWF      R1+0, 0
L__main18:
	BTFSS      STATUS+0, 2
	GOTO       L_main12
	GOTO       L_main4
L_main12:
;Lab1.c,41 :: 		}
	GOTO       L_main3
L_main4:
;Lab1.c,43 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
