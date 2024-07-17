


setup:
 sbi DDRD, PD2 ;configura o pino PD2 como sa´?da

 cbi DDRD, PD7 ;configura o pino PD7 como entrada
 sbi PORTD, PD7 ;habilita o pull-up para o bot~ao

 ;----------------------
 ;LAÇO PRINCIPAL
 ;----------------------
naoPress: ;loop bot~ao n~ao pressionado (pull-up)
 sbi PORTD,PD2 ;desliga LED
 sbic PIND,PD7 ;verifica se o bot~ao foi pressionado,
 rjmp naoPress ;sen~ao volta e fica preso no la¸co naoPress

press: ;loop bot~ao pressionado
 cbi PORTD,PD2 ;desliga LED
 sbis PIND,PD7 ;verifica se o bot~ao foi solto, sen~ao
 rjmp press ;sen~ao, aguarda.

 rjmp naoPress ;vai para o loop do "bot~ao pressionado"