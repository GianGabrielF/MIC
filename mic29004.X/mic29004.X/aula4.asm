.DSEG
.ORG SRAM_START
    A: .BYTE 1
    B: .BYTE 2
.CSEG

start:
    ldi XH, 0x01 ; Byte mais significativo de X (XH = R27)
    ldi XL, 0x00 ; Byte menos significativo de X (XL = R26)
Loop:
    inc r0
    st X+, r0
    rjmp loop
