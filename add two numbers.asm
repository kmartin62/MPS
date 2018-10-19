
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV AH, 1
INT 21H

MOV BL, AL
INT 21H

MOV CL, AL

ADD BL, CL ; BL = BL + CL

MOV AH, 2
MOV DL, 10
INT 21H      ; NEW LINE
MOV DL, 13
INT 21H

MOV AH, 2

SUB BL, 48
MOV DL, BL
INT 21H

ret




