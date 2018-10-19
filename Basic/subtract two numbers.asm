
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV AH, 1
INT 21H

MOV BL, AL
INT 21H

MOV CL, AL

SUB BL, CL ; BL = BL - CL

MOV AH, 2
MOV DL, 10
INT 21H      ; NEW LINE
MOV DL, 13
INT 21H

MOV AH, 2

ADD BL, 48  ; ADD BECAUSE OF ASCII CODE -> '0' IS 48 IN ASCII
MOV DL, BL
INT 21H

ret




