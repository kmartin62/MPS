
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;InterruptsDemo.c,4 :: 		void interrupt(){
;InterruptsDemo.c,5 :: 		if (INTF_bit==1){   //Dokolku RB0==1
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;InterruptsDemo.c,6 :: 		ifinterupt++;
	INCF       _ifinterupt+0, 1
;InterruptsDemo.c,7 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;InterruptsDemo.c,8 :: 		}
L_interrupt0:
;InterruptsDemo.c,9 :: 		}
L_end_interrupt:
L__interrupt6:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;InterruptsDemo.c,10 :: 		int main(){
;InterruptsDemo.c,11 :: 		ANSEL=0;
	CLRF       ANSEL+0
;InterruptsDemo.c,12 :: 		ANSELH=0;                 //Postavi analogno
	CLRF       ANSELH+0
;InterruptsDemo.c,14 :: 		PORTB=0x00;
	CLRF       PORTB+0
;InterruptsDemo.c,15 :: 		TRISB=0x01;       //Postavi go RB0 na vlezen pin
	MOVLW      1
	MOVWF      TRISB+0
;InterruptsDemo.c,16 :: 		INTCON=0x90;       //Setiraj register za ovozmozuvanje na prekin od RB0
	MOVLW      144
	MOVWF      INTCON+0
;InterruptsDemo.c,18 :: 		while(ifinterupt==0){
L_main1:
	MOVF       _ifinterupt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;InterruptsDemo.c,19 :: 		}
	GOTO       L_main1
L_main2:
;InterruptsDemo.c,20 :: 		EEPROM_Write(0x00,'a');
	CLRF       FARG_EEPROM_Write_Address+0
	MOVLW      97
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;InterruptsDemo.c,21 :: 		while(ifinterupt==1){
L_main3:
	MOVF       _ifinterupt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;InterruptsDemo.c,22 :: 		}
	GOTO       L_main3
L_main4:
;InterruptsDemo.c,23 :: 		znak='b';
	MOVLW      98
	MOVWF      _znak+0
;InterruptsDemo.c,24 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;InterruptsDemo.c,25 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
