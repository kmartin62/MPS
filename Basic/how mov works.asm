
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h      

; ZA KOMANDATA MOV, AKO PREMESTUVAME OD ADRESA 24000H VO 25000H
; TREBA DA JA PREKRSUVAME ADRESATA SEKOGAS NA DVA DELA
; FIZICKI DEL I OFFSET. FIZICKIOT DEL GO STAVAME VO SEGMENT
; A VO SEGMENTOT NE MOZEME DA PRISTAPIME DIREKTNO PA PRISTAPUVAME
; PREKU DRUG REGISTER, VO SLUCAJOT AX. POTOA VO SI (SOURCE INDEX 
; REGISTER) GO STAVAME OFFSETOT ZA IZVORNATA ADRESA DODEKA VO DI
; (DESTINATION INDEX REGISTER) GO STAVEM OFFSETOT NA DESTINACISKATA

MOV AX, 2000H 
MOV DS, AX

MOV SI, 4000H
MOV DI, 5000H

; NE MOZEME DIREKTNO DA TRANSFORMIRAME PODATOCI OD EDNA MEMORISKA
; ADRESA DO DRUGA

MOV BX, [SI]
MOV DX, [DI]

; PREMESTUVAME PODATOCI OD SI I DI, PREKU MEMORISKA ADRESA, VO
; REGISTRITE BX I DX, PRIVREMENO. PODATOCITE OD ADRESATA 4000H
; SE PREMESTUVAAT VO BX, DODEKA PODATOCITE OD 5000H SE PREMESTUVAAT
; VO DX

MOV [SI], DX
MOV [DI], BX

; PRAVIME SWAP T.E PODATOCITE OD DX, SO MEMORISKA ADRESA NA [DI],
; GI SMESTUVAME VO ADRESATA NA [SI] I PODATOCITE OD ADRESATA [SI]
; GI SMESTUVAME VO ADRESATA NA [DI]. 
ret

; DEMO ZA MOV, EXPLAINED           





