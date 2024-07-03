.DSEG
.ORG	SRAM_START
    A: .BYTE 1
    B: .BYTE 1
    C: .BYTE 1
    
.CSEG    
start:
    ldi r16,0x12 ; inicializando A
    sts A, r16
    
    ldi r16, 0x05 ; inicializando B
    sts B, r16
    
    lds r17, A
    lds r18, B
    
    add r17, r18 ;adiciona B ao A e coloca o valor em C
    sts C, r17
    
    
    
    ldi r16,0x0B ; reinicializando A
    sts A, r16
    
    ldi r16, 0x32 ; reinicializando B
    sts B, r16
    
    ldi XL,LOW(A) ; inicia o ponteiro X
    ldi XH,HIGH(A)
    
    ldi YL,LOW(B) ; inicia o ponteiro Y
    ldi YH,HIGH(B)
    
    ldi ZL,LOW(C)
    ldi ZH,HIGH(C)
    
    ld r17,X
    ld r18,Y
    
    add r17, r18
    st Z,r17
    
    rjmp start
    
