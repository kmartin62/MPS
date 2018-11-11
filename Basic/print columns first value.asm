; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    array db 5,5,5,5,4,4,4,4,3,3,3,3,2,2,2,2,1,1,1,1    ; 0, 4, 8, 12
    red dw ?
    kolona dw ?
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
    
    mov red, 0
    mov kolona, 0
    mov si, 0
    mov red, 0
    
    printEachColumn:
    mov dl, array[si]      ; dl = array[0]
    add dl, 30h
    mov ah, 02h
    int 21h
    
    inc kolona                  ; i++; kolona = 1 ; kolona = 2
                            ; ax = 4
    mov ax, 4               ; bx = 1       ; bx = 2
    mov bx, kolona              ; ax = 4
    mul bx
                            ; si = 4
    mov si, ax
    
    cmp kolona, 5
    jz kraj
    
    
    jmp printEachColumn        
    
    
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
