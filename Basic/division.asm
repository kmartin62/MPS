
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV AX, 0081H       ; 80 VO AL
MOV BL, 2           ; 2 VO BL
DIV BL              ; 40 VO AL, 1 VO AH. OSTATOKOT (REMAINDER) ODI VO AH

ret




