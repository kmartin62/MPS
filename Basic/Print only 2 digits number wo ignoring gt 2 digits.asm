; Welcome my Lord. Make me wet this time, you can do it! At least once

org 100h

.data
arr db 20 dup(?)
arr1 db 20 dup(?)

.code
mov ax, @data
mov ds, ax

mov cl, 0
mov si, 0
mov ah, 01h

input:
cmp cl, 20    ; if i == 20, go to nextstep
jz nextstep

int 21h
cmp al, 24h     ; if arr[i] == $, go to nextstep
jz nextstep

sub al, 30h
mov arr[si], al
inc si
inc cl             ; index ++, counter ++ 

jmp input


nextstep:
mov si, 0 ; index = 0, start from beginning
mov di, 0

iterate:
mov al, arr[si]      ; al = arr[0]

cmp al, 0h           ; ako e ascii kod < 0
jl nextstep1 

cmp al, 9h
jg nextstep1        ; ako e ascii kod > 9

check_digits:
cmp arr[si+1], 0h   
jle add_to_array     ; ako ima dve cifri edna po druga
cmp arr[si+1], 9h
jg add_to_array

mov bl, 10
mov al, arr[si]       ; ako se dve cifri, zemi ja prvata, mnozi ja so 10 i soberi ja vtorata
mul bl
add al, arr[si+1]

inc si            
sub cl, 1 

add_to_array:
mov arr1[di], al
inc di              ; arr1[j++]

nextstep1:
inc si               ; arr[i++]
loop iterate


mov cx, di           ; counter = j
mov di, 0            ; j = 0

print:
mov dl, arr1[di]    ; print arr1[j] za ednocifreni

cmp cx, 0
jz kraj

;;;;;;;;;;;;;;;;;;;

cmp dl, 9h
jg pecati_dvocifren    ; ako e dvocifren broj, odi vo pecati_dvocifren

;;;;;;;;;;;;;;;
add dl, 30h
mov ah, 02h                 ; pecati ednocifren
int 21h
mov dl, ' '
int 21h

inc di
loop print
jmp kraj                  ; ako posledniot broj e ednocifren, otkako kje go ispecates odi na kraj

pecati_dvocifren:
mov ax, dx
div bl ; ostatok vo AH
mov dh, ah

mov dl, al
add dl, 30h
mov ah, 02h
int 21h                        ; pecati dvocifren

mov dl, dh
add dl, 30h
int 21h

mov dl, ' '
int 21h

inc di
sub cx, 1
mov dh, 0
jmp print



;mov arr1[si], al     ; arr1[0] = al (arr[0])

;mov dl, arr1[di]
;mov ah, 02h
;int 21h

;iterate:
;mov dl, arr[si]    
;mov ah, 02h          ; iteriraj niz nizata i pecati gi site elementi
;int 21h

;inc si
;loop iterate

kraj:
ret




