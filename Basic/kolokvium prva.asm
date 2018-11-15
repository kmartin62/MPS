; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    ostatok db ?
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

    mov ah, 01h
    citaj:
    int 21h
    sub al, 30h
    mov dl, al    ; prviot broj vo dl
    int 21h
    sub al, 30h
    mov dh, al    ; vtoriot vo dh
    
    mul dl         ; al = al * dl
    mov bl, al
    
    cmp dl, dh
    jb procedura1 ; ako prviot e pomal od vtoriot,
                 ; go to proc1. Ako DL = 2 i DH = 4
    
    mov bh, dh
    mov dh, 0
    mov ax, dx
    div bh
    
    cmp ah, 0
    jz kraj
    cmp bl, 09h
    jg procedura2
    mov dl, bl
    add dl, 30h
    mov ah, 02h
    int 21h
    jmp kraj
    
    
    procedura1:
    mov ostatok, dl
    mov dl, bl
    add dl, 30h
    mov ah, 02h
    int 21h
    
    
    procedura2:
    mov bh, 0
    mov ax, bx
    mov bl, 10
    div bl
    
    mov dh, ah
    mov dl, al
    add dl, 30h
    mov ah, 02h 
    int 21h
    mov dl, dh
    add dl, 30h
    int 21h
    
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
