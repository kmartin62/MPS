
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data
ocena1 dw 5
ocena2 dw 5
ocena3 dw 4

vkupno db 3

.code
mov ax, @data
mov ds, ax

mov ax, ocena1
add ax, ocena2
add ax, ocena3

mov bl, vkupno

div bl


ret




