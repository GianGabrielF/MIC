.INCLUDE <m328Pdef.inc>

 start:
; Exemplo sbis/sbic
 waitUM:
     sbis PIND,7
     rjmp waitUM
 waitZERO:
     sbic PIND,7
     rjmp waitZERO
     nop
 rjmp start