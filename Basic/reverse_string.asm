; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    ten dw ?
    remainder db ?
ends

stack segment
    dw   128  dup(0)
ends

code segment
    read proc
        mov cx, 3
        mov ah, 01h
        int 21h
        push ax
        inc cx
        
        jmp l1
        
        read endp
    
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    mov cx, 0
    
    ;call read
    
    input:
    mov ah, 01h
    int 21h          ; citaj znaci od tastatura se dodeka ne stisnes ENTER
    cmp al, 0Dh
    jz l2
    
    mov ten, ax
    push ten         ; Ten = AL(AX), stavi go na stek
    inc cx
    jmp l1
    

    
    l2:
    pop dx
    mov ah, 02h      ; Vo DX smesti go vrvot na stekot
    int 21h          ; Ispecati go
    loop l2
    
    
    
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
