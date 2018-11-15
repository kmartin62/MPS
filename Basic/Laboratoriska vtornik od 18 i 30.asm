; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    bukva db ?
    array db 100 dup(?)
    counter db ?
ends

stack segment
    dw   128  dup(0)
ends

code segment
    read proc
        
        read endp
    
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    mov si, 0
    mov ah, 01h
    int 21h
    mov bukva, al ; bukvata stavi ja vo bukva
    
    int 21h
    cmp al, 2Eh
    jz kraj
    
    mov array[si], al
    inc si
    citaj:
    int 21h
    cmp al, 2Eh
    jz proverka
    
    mov array[si], al
    inc si
    jmp citaj
    
    
    proverka:
    cmp array[si-1], 2Eh    ; ako ima dve tocki edna po druga
    jz procedura
    mov array[si], al
    inc si                  ; ako nema, stavi ja tockata vo niza
    jmp citaj
    
    
    procedura:
    mov cx, si
    inc si
    mov array[si], 24h    ; stavi $ na krajot za da znaes kaj e krajot
    ;mov si, 0
    
    ;print:
    ;cmp array[si], 24h
    ;jz kraj
    
    ;mov dl, array[si]
    ;mov ah, 02h
    ;int 21h
    
    ;inc si
    ;jmp print 
    
    mov si, 0
    mov bl, bukva
    
    procedura1:
    cmp array[si], bl      ; ako array[i] == bukva, go to inc
    jz increment
    
    cmp array[si], 2Eh
    jz reset              ; ako sme dosle do tocka, resetiraj
    
    cmp array[si], 24h
    jz kraj               ; ako sme dosle do "$", izlezi
    
    inc si                ; ako nisto od ova, i++
    jmp procedura1
    
    
    reset:
    mov dl, counter
    add dl, 30h            ; dl = counter
    mov ah, 02h            ; pecati counter
    int 21h
    
    mov counter, 0
    inc si               ; counter = 0
    jmp procedura1       ; i ++
    
    increment:
    inc counter
    inc si                 ; counter ++
    jmp procedura1         ; i ++
    
    
    kraj:        
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
