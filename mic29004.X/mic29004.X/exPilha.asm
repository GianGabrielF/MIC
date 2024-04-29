.DSEG
 .ORG SRAM_START
 A: .BYTE 4 ; numero de bits dividido por 8. 32 bits é .BYTE 4
 B: .BYTE 4
 C: .BYTE 4

 .CSEG

start:
    ;inicializando A
    ldi r16, 0x04
    sts A+0,r16
    ldi r16, 0x03
    sts A+1,r16
    ldi r16, 0x02
    sts A+2,r16
    ldi r16, 0x01
    sts A+3,r16
    
    ;inicializando B
    ldi r16, 0x0FF ;utiliza o R16 mas qualquer um do 16 até o 31 vale
    sts B+0,r16
    ldi r16, 0xFF
    sts B+1,r16
    ldi r16, 0xFF
    sts B+2,r16
    ldi r16, 0x00
    sts B+3,r16
    
    
    ;chama subrotina
    ;subrotina está esperando passar valores de X,Y e Z
    
    ;inicializando X,apontando pra A
    LDI XH, HIGH(A)
    LDI XL, LOW(A)
    
    ;inicializando Y,apontando pra B
    LDI YH, HIGH(B)
    LDI YL, LOW(B)
    
    ;inicializa Z,apontando pra C,mesmo com C não tendo um valor já ditado
    LDI ZH, HIGH(C)
    LDI ZL, LOW(C)
    
    
    rcall soma32
    
    
    
    rjmp start
    
    
    
    

    
    
    
    ;*o byte menos significativo é o de menor endereço
    
soma32:

    ;salva o contexto atravez da pilha
    PUSH R16
    PUSH R17
    PUSH R18
    IN R18, SREG
    PUSH R18
    
    ldi r16,0
    clc
LOOP_SOMA:
    ld r17,X+
    ld r18,Y+
    adc r17,r18
    st Z+,r17
    
    inc r16
    cpi r16,4
    brne LOOP_SOMA
    
    
    ;recupera contexto
    POP R18
    OUT SREG, R18
    POP R18
    POP R17
    POP R16
    ret
    
    
    
    
    
    
    
    
    
    
    
    
    ;Implemente uma sub-rotina que some duas variáveis de 32 bits na SRAM com as seguintes características:
	;O ponteiros X e Y devem ser usados para passar como parâmetro a posição das variáveis.
	;O resultado será armazenado na variável apontada pelo ponteiro Z.
	;Considere o byte menos significativo armazenado no menor endereço.
	;Salve o contexto adequadamente.
	;Faça um programa principal para testar a sub-rotina.   
