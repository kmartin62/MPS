; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    a db 20 dup(?)
    b db 20 dup(?)
    startElement dw ?
    noElementi dw ?
    tmp dw ?
    total dw 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
    space proc
        mov ah,02h
        mov dl,13d
        int 21h
        
        mov dl,10d
        int 21h
        ret
    space endp
    
    read proc
        pop bx 
        
        pop noElementi  ; broj na elementi
        pop startElement  ; startna pozicija
        pop di ; b
        pop si ; a
        add di, total ; di = di + total
        
        add si, startElement
        mov cx, noElementi
        
        stavaj:
        mov al, [si]
        mov [di], al
        inc si
        inc di
        inc total
        loop stavaj
                
        push bx
        ret
     read endp
        
        
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    pocetok:
    lea si, a   ; adresa na a -> si
    lea di, b   ; adresa na b -> di
        
    push si    ; adresa na a
    push di    ; adresa na b
    
    citaj:
    mov ah, 01h
    int 21h
    cmp al, 2Eh
    jz printaj
    cmp al, 20h
    jz naredno
    mov [si], al
    inc si
    jmp citaj
    
    
    naredno:
    mov ah, 01h
    int 21h
    mov ah, 0
    sub al, 30h
    push ax    ; stavi go startElement
    
    mov ah, 01h
    int 21h
    mov ah, 0
    sub al, 30h
    push ax     ; stavi go noElementi
    
    call read 
    
    jmp pocetok
    
    
    printaj:
    mov cx, total
    lea di, b
    call space
    
    iterate:
    mov dl, [di]
    mov ah, 02h
    int 21h
    inc di
    loop iterate
    
    
    
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
