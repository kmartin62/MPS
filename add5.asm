
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h 
 
.DATA 
a DB "Vnesi go prviot broj: $ "
b DB "Vnesen e brojot: $ "

.CODE
; VCITAJ EDEN BROJ
MOV AH, 1
INT 21H
MOV BL, AL

; DODAJ MU 5 NA BROJOT
ADD BX, 5

; DODAJ NOVA LINIJA, NEWLINE
MOV AH, 2
MOV DL, 10
INT 21H
MOV DL, 13
INT 21H

; ISPECATI GO BROJOT
MOV AH, 2
MOV DL, BL
INT 21H


ret




