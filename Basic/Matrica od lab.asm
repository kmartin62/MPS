; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    matrica db 5,5,5,4,4,4,3,3,3,2,2,2
    red db 4
    kolona db 3
    x db ?
    y db ?
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
    
    ye:
    mov ah, 01h
    int 21h
    mov x, al
    int 21h
    mov y, al
    

    add x, -30h     ;vcitaj koj red
    add y, -30h     ; so koj da go zamenes u matricata
    
    
    mov ah, red
    cmp x, ah
    jg kraj         ; proveri ako za red e vnesen broj pogolem od goleminata na samiot red
    cmp y, ah
    jg kraj
    
    
    mov si, 0
    mov al, kolona
    mul x     ; x e 1, mat[3][4][5], x=2, mat[6][7][8], x=3, mat[9][10][11] 
    ; AL = kolona (3) * X. Za x=0, al=0
    mov bl, kolona
    xor bh, bh
    
    mov cx, bx     ; iteriraj 
    xor ah, ah    ; si = ax
    mov si, ax
    
    mov al, kolona    
    mov di, 0          ; odredi ja lokacijata na vtoro vneseniot red
    mul y
    
    xor ah, ah
    mov di, ax

    swap:     ; ako x e 0, treba da se ispecatat matrica[0], matrica[1], matrica[2]. Ako e 3, matrica[9] matrica[10] matrica[11]
    ;mov al, x  
    ;mov dl, matrica[si]
    ;add dl, 30h               ; dl = matrica[odbranred*opsta_golemina_na_red]
    ;mov ah, 02h
    ;int 21h
    ;mov dl, matrica[di]
    ;add dl, 30h
    ;int 21h
    
    mov dl, matrica[si]
    mov dh, matrica[di]
    
    mov matrica[si], dh
    mov matrica[di], dl
    
    
    inc si
    inc di                   ; i ++
                             ; j ++

    loop swap
    
    mov si, 0
    mov cx, 12
    
    pecati:
    mov dl, matrica[si]
    add dl, 30h
    mov ah, 02h              ; pecati gi so smeneti redici
    int 21h
    
    inc si
    loop pecati    
    


    
    
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
