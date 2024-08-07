.DSEG
.ORG SRAM_START
    contagem: .byte 1
    intervalo: .byte 1

.CSEG

    
 .ORG 0x0000 ; Vetor reset
 RJMP setup

 .ORG 0X0002
 RJMP isr_int0
 
 .ORG 0X0034
 
 .ORG 0x0020 ; Vetor (endere퇭o na Flash) do estouro do T/C0
 RJMP isr_tc0b

setup:
 sbi DDRB, PB5
 cbi PORTB, PB5 ; desliga led]
 
 cbi DDRD, PD2
 sbi PORTD, PD2

 ldi r16, 0b00000101 ;TC0 com prescaler de 1024, a 16 MHz gera
 out TCCR0B, R16 ; uma interrup퇭~ao a cada 16,384 ms
 LDI R16, 1
 sts TIMSK0, R16 ; habilita int. do TC0B (TIMSK0(0)=TOIE0 <- 1)
 
 sts EICRA, R16
 SBI EIMSK, INT0
 
 ldi r16, 0

 sei ; habilita as interrup퇭~oes globais

main:
 rjmp main

isr_tc0b:
    
    push r16
    push r17
    in r16 , SREG
    push r16
    
    lds r16,contagem
    lds r17,intervalo
    
    inc r16
    sts contagem,r16
    cp r16, r17
    brne fim
    sbi PINB, PB5 ; inverte o estado do LED depois de entrar 62 vezes
 ; na interrup퇭~ao: 62 * 16,384 ms = 1.015,81ms
 

fim:
    
    pop r16
    out SREG, r16
    pop r17
    pop r16
    reti
 
isr_int0:
    
    sbic PIND , PD2
    lds r16, intervalo
    subi r16, 12
    sts intervalo, r16
    
reset_intervalo:
    ldi r16,62
    sts intervalo , r16