.DSEG
    .ORG SRAM_START
    A: .BYTE 1
    B: .BYTE 1
    C: .BYTE 1
 
.CSEG

start:
    lds r0, 0x0100
    lds r1, 0x0101
    sts A,r0
    sts B,r1
    lds r16,A
    lds r17,B
    add r16,r17
    sts C,r16
    rjmp start
