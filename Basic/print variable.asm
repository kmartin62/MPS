
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.DATA
VAR1 DB 4  ;VAR1 = 5

.CODE
MOV AX, @DATA ; INITIALIZE DATA
MOV DS, AX

MOV AH, 2
ADD VAR1, 48  ; ADD 48 BECAUSE OF ASCII CODE
MOV DL, VAR1  ; STORE VAR1 IN DATALOW
INT 21H

ret




