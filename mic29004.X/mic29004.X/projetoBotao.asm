;setup


ldi r16, 0xFF
out DDRD, r16
 
;   código equivalente
;   sbi DDRD , PD0 ;configura PD0 a PD7 como saída
;   sbi DDRD , PD1
;   sbi DDRD , PD2
;   sbi DDRD , PD3
;   sbi DDRD , PD4
;   sbi DDRD , PD5
;   sbi DDRD , PD6
;   sbi DDRD , PD7
    
    cbi DDRB , PB0 ;configura PB0 e PB1 como entrada
    cbi DDRB , PB1
    
    sbi PORTB ,PB0
    sbi PORTB ,PB1
loop:
    rcall Selecao
    rcall Ajuste
    
    
    rjmp loop

    
Selecao:
    sbic PINB , PB0
    rjmp SelecaoNotPress
    rjmp SelecaoPress
    
SelecaoPress:
    sbi PORTD , PD0
    sbi PORTD , PD1
    sbi PORTD , PD2
    sbi PORTD , PD3
    ret
    
SelecaoNotPress:
    cbi PORTD , PD0
    cbi PORTD , PD1
    cbi PORTD , PD2
    cbi PORTD , PD3
    ret
    
Ajuste: 
    sbic PINB , PB1
    rjmp AjusteNotPress
    rjmp AjustePress
    
AjustePress:
    sbi PORTD , PD4
    sbi PORTD , PD5
    sbi PORTD , PD6
    sbi PORTD , PD7
    ret
    
AjusteNotPress:
    cbi PORTD , PD4
    cbi PORTD , PD5
    cbi PORTD , PD6
    cbi PORTD , PD7
    ret