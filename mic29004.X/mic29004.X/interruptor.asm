//DEFINIÇÕES
    .equ ON = PD2
    .equ OFF = PD3
    .equ L0 = PB0
    .equ L1 = PB1
    
.DSEG
.ORG SRAM_START

    
.CSEG
    
    
.ORG 0X0000
    rjmp setup
.ORG 0X0002
    rjmp isr_int0
.ORG 0X0004
    rjmp isr_int1
    
    
setup:
    ;configurar saidas
    sbi DDRB, PB0 ;se for mudar os pinos,tem que mudar os registradores
    SBI DDRB, PB1 
    ;configurar entradas
    cbi DDRD, PD2
    cbi DDRD, PD3
    
    ;config interrupcoes externas
    ldi r16, 0b0000_1010
    sts EICRA, r16
    sbi EIMSK , int0
    sbi EIMSK , int1
    
    ;habilitar interrupção global
    sei
    
    main:
  sbi  PORTB,L0    ; desliga L0
  ldi r19, 80 
  rcall delay      ; delay 1s
  cbi  PORTB,L0    ; liga L0
  ldi r19, 80 
  rcall delay      ; delay 1s
  rjmp main

;------------------------------
  ;subrotina de int0: liga o L1
;------------------------------
  
isr_int0:
  
  cbi PORTB, L1 ; liga o L1
    
  reti
  
  
;------------------------------
  ;subrotina de int1: desliga o L1
;------------------------------
  
isr_int1:
    
  sbi PORTB, L1 ; desliga o L1
  
  reti
  
  
;------------------------------------------------------------
;SUB-ROTINA DE ATRASO Programável
;Depende do valor de R19 carregado antes da chamada.
;Exemplos: 
; - R19 = 16 --> 200ms 
; - R19 = 80 --> 1s 
;------------------------------------------------------------
delay:           
  push r17	     ; Salva os valores de r17,
  push r18	     ; ... r18,
  in r17,SREG    ; ...
  push r17       ; ... e SREG na pilha.

  ; Executa sub-rotina :
  clr r17
  clr r18
loop:            
  dec  R17       ;decrementa R17, começa com 0x00
  brne loop      ;enquanto R17 > 0 fica decrementando R17
  dec  R18       ;decrementa R18, começa com 0x00
  brne loop      ;enquanto R18 > 0 volta decrementar R18
  dec  R19       ;decrementa R19
  brne loop      ;enquanto R19 > 0 vai para volta

  pop r17         
  out SREG, r17  ; Restaura os valores de SREG,
  pop r18        ; ... r18
  pop r17        ; ... r17 da pilha

  ret
  
  ;int0 tá amarrado pelo hardware no PD2 e o int1 tá amarrado no hardware ao PD3