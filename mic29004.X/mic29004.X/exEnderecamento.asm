.DSEG
    .ORG SRAM_START
    A1: .BYTE 12
    A2: .BYTE 12
    A3: .BYTE 12
    A4: .BYTE 3
    
.CSEG

start:
    LDI XH, HIGH(A2)
    LDI XL, LOW(A2)
    LDI YH, HIGH(A3)
    LDI YL, LOW(A3)
    
    ldi r16, 0
LOOP:		; colocando os valores de A2 e A3
    inc r16
    st X+,r16
    st Y+,r16
    cpi r16,12
    brne LOOP
    
    
    LDI ZH, HIGH(A1)
    LDI ZL, LOW(A1)
    
    ld r0,X
    ldd r1,Y+11
    add r0,r1
    st Z,r0
    ldi r16,0
SOMA:		; fazendo soma dos valores
    ld r0,X+
    ld r1,-Y
    add r0,r1
    st Z+,r0
    inc r16  
    cpi r16,12    
    brlt SOMA
  
	
    LDI XH,HIGH(A4)
    LDI XL,LOW(A4)
    LDI ZH,HIGH(A2)
    LDI ZH,LOW(A2)
		; fazendo a outra soma
    ldd r0,Z+2
    ldd r1,Y+5
    add r0,r1
    st X+,r0
    
    ldd r0,Z+3
    ldd r1,Y+4
    add r0,r1
    st X+,r0
    
    ldd r0,Z+8
    ldd r1,Y+9
    add r0,r1
    st X+,r0
    
    
    
    rjmp start
