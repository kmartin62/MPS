
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV DX, 0H
MOV AX, 0081H    ; VO SLUCAJOV VO AL E REZULTATOT A OSTATOKOT E VO DX REGISTEROT
MOV BX, 2
DIV BX

ret




