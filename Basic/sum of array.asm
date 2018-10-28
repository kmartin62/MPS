
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data
array: db 1,2,3,4,5,6

.code
mov si, 0
mov cx, 6
mov ax, 0

sumList:
    add al, array[si]
    inc si
    loop sumList

ret




