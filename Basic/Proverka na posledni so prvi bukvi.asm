; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "Greshka$"
    pkey1 db "Nema greshka$"
    n db ?
    index dw ?
    string db 20 dup(?)
    first db 9 dup(?)
    last db 9 dup(?)
ends

stack segment
    dw   128  dup(0)
ends

code segment
    read proc
          mov di, 0          ; DI a.k.a j = 0
    
    citaj:
    mov si, 0          ; SI a.k.a i = 0
    
    mov ah, 01h
    citaj_string:
    int 21h                 ; citaj i sporedi dali e vnesen karakterot '-'
    cmp al, 2Dh             ; ako e, jmp test1
    jz test1
    mov string[si], al      ; niza od stringovi[i] = karakterot sho e vnesen. Primer string[0]='a'
    inc si                  ; i ++;
    
    jmp citaj_string    
    
    test1:
    mov al, string[si-1]     ; al = posledniot clen od string nizata
    mov last[di], al          ; last[j] = al
    mov si, 0                ; i = 0 - za prviot karakter od nizata
    mov al, string[si]        ; al = prviot karakter
    mov first[di], al         ; first[j] = al
    inc di                    ; j ++
    
    loop citaj
    
    mov si, 0              ; i = 0
    mov cx, di               ; cx = di t.e kolku da e loop
    
    print_:
    mov dl, first[si]               ; pecati go prviot element od first nizata
    mov ah, 02h
    int 21h
    
    mov dl, last[si]
    int 21h                        ; pecati go posledniot
    inc si
    
    mov dl, 02Dh                  ; pecati crticka t.e razdvoj gi so - za naredniot print
    int 21h
    
    loop print_
    
    ; za n = 5, di = 5 posle print_
    ; first={/i/,t,a,r,d}  last={t,a,r,d,/a/}
    ; za slucajot se ignoriraat prviot karakter od first i posledniot od last
    ; obrabotuvame nizi so di - 1 elementi
    sub si, 1
    mov cx, si
    mov si, 1    ; za first
    mov di, 0    ; za last
    
    proverka_prv_so_posleden:
    mov al, last[di]
    cmp first[si], al
    jne message1
    
    inc si
    inc di
    
    loop proverka_prv_so_posleden
    
    jmp message2      ; ako nema greska kje go pomine loop-ot i kje dojde tuka. Go to message2
        
    read endp
    
    
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    mov ah, 01h
    int 21h
    sub al, 30h         ; vcitaj n
    mov n, al
    
    mov cl, n
    xor ch, ch         ; stavi go N vo CX
    
    call read           ; call proc
    
    message2:
    lea dx, pkey1
    mov ah, 9           ; print message2
    int 21h
    
    jmp kraj
    
    
    message1:
    mov index, si        
    lea dx, pkey
    mov ah, 9
    int 21h        ; print message1
    
    ; wait for any key....
    kraj:    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
