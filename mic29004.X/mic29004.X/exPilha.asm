.DSEG
 .ORG SRAM_START
 var1: .BYTE 32
 var2: .BYTE 32
 var3: .BYTE 32

 .CSEG

start:
    ldi XL,LOW(var1)
    ldi XH,HIGH(var1)
    ldi YL,LOW(var2)
    ldi YH,HIGH(var2)
    ldi ZL,LOW(var3)
    ldi ZH,HIGH(var3)
    
    rcall soma
    
soma:
    
