; Welcome my Lord. Make me wet this time, you can do it! At least once

org 100h

.data

arr db 20 dup(?)

.code
mov ax, @data
mov ds, ax

mov ah, 01h
int 21h
;and al, 0Fh       ; and al, 0Fh == sub al, 48
sub al, 48         ; Kolku e brojot na elementi. Odzemi 48 (0 ascii)
mov bl, al         ; za da se dobie vistinskata vrednost

mov cl, al
mov si, 0          ; index = 0

input:
int 21h
cmp al, 24h
jz kraj                     ; Ako e znakot $, idi na kraj
mov arr[si], al            ; arr[i] = input (al)
inc si                     ; i ++
loop input                 ; CL--, loop se dodeka CX ne e 0
          
mov cl, bl                  ; count = bl (al)
mov si, 0                   ; index = 0
mov ah, 02h                 ; pecati
output:
mov dl, arr[si]             ; dl = arr[i]
int 21h
inc si                      ; i ++
loop output                 ; while cl != 0

kraj:

ret




