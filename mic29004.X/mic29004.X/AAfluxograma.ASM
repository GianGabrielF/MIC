.INCLUDE <m328Pdef.inc>
label:
    .DEF count=R17
    
    
start:
    sbis GPIOR0, 3 ; salta se o bit 3 do GPIOR0 for UM,ou seja,o botao esta sendo apertado
    rjmp start	   ; faz o loop esperando o botão ser apertado
    
    ldi count, 0   ; inicia o contador
contador:
    cpi count, 10  ; compara o contador com 10
    breq Wait10	   ; salta se o contador for 10
    inc count
    rjmp contador
    
    
Wait10:
    ;"muda_estado_led"
    sbis GPIOR0 7
    rjmp led_on
    
    cbi GPIOR0 7
    rjmp start

led_on:
    sbi GPIOR0 7
    
    
    rjmp start
