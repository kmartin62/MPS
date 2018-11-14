; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    niza db ?
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    mov si, 0
    
    mov ah, 01h
    
    citaj:
    int 21h
    cmp al, 0Dh
    jz pecati:
    
    mov niza[si], al            ; vcituvaj stringovi i stavaj gi vo niza
    inc si
    jmp citaj
    
       
    pecati:
    mov cx, si
    mov si, 0
    
    mov dl, 0Ah
    mov ah, 02h       ; print new line
    int 21h
    
    print:
    mov dl, niza[si]
    mov ah, 02h
    int 21h                   ; pecati od nizata
    inc si
    loop print
   
    
    
    
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
