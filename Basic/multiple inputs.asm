
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

                  ; VCITAJ PRV BROJ
MOV AH, 1
INT 21H

MOV BL, AL        ; VCITAJ GO VTORIOT BROJ
INT 21H

MOV BH, AL        ; VCITAJ GO TRETIOT BROJ
INT 21H

MOV CL, AL        ; VCITAJ GO CETVRTIOT BROJ
INT 21H
MOV CH, AL

MOV AH, 2
MOV DL, 10        ; NEW LINE
INT 21H
MOV DL, 13
INT 21H


MOV AH, 2         ; KOMANDA ZA PRINTANJE
                  
MOV DL, BL        ; PRINTAJ PRV
INT 21H

MOV DL, BH        ; PRINTAJ VTOR
INT 21H

MOV DL, CL        ; PRINTAJ TRET
INT 21H

MOV DL, CH        ; PRINTAJ CETVRT
INT 21H
ret




