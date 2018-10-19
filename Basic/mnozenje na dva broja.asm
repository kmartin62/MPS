
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV AL, 3 ; AL = 4
MOV BH, 3 ; BH = 2
MUL BH ; AL = BH * AL, MUL OPERACIJATA SEKOGAS SE MNOZI SO AL, PO AVTOMATIZAM
MOV DL, AL

ADD DL, 30H ; DA GO POKAZE DEKADEN BROJOT

MOV AH, 2
INT 21H

ret




