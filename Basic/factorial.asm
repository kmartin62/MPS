
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

mov cx, 4
mov ax, 1

fact:
    mul cx
    loop fact
    

ret




