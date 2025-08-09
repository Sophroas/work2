    .text
    .globl main
    
sum8:
    addi sp, sp, -4
    sw x1, 0(sp)
    addi sp, sp, -4
    sw x8, 0(sp)
    mv s0, sp
    addi sp, sp, -64
    sw a0, -4(s0)
    sw a1, -8(s0)
    sw a2, -12(s0)
    sw a3, -16(s0)
    sw a4, -20(s0)
    sw a5, -24(s0)
    sw a6, -28(s0)
    sw a7, -32(s0)
    lw x5, -4(s0)
    lw x6, -8(s0)
    sub x7, x5, x6
    lw x5, -12(s0)
    sub x6, x7, x5
    lw x5, -16(s0)
    add x7, x6, x5
    lw x5, -20(s0)
    sub x6, x7, x5
    lw x5, -24(s0)
    add x7, x6, x5
    lw x5, -28(s0)
    sub x6, x7, x5
    lw x5, -32(s0)
    sub x7, x6, x5
    mv a0, x7
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    li a0, 0
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    
sum16:
    addi sp, sp, -4
    sw x1, 0(sp)
    addi sp, sp, -4
    sw x8, 0(sp)
    mv s0, sp
    addi sp, sp, -64
    sw a0, -4(s0)
    sw a1, -8(s0)
    sw a2, -12(s0)
    sw a3, -16(s0)
    sw a4, -20(s0)
    sw a5, -24(s0)
    sw a6, -28(s0)
    sw a7, -32(s0)
    lw t0, 8(s0)
    sw t0, -36(s0)
    lw t0, 12(s0)
    sw t0, -40(s0)
    lw t0, 16(s0)
    sw t0, -44(s0)
    lw t0, 20(s0)
    sw t0, -48(s0)
    lw t0, 24(s0)
    sw t0, -52(s0)
    lw t0, 28(s0)
    sw t0, -56(s0)
    lw t0, 32(s0)
    sw t0, -60(s0)
    lw t0, 36(s0)
    sw t0, -64(s0)
    lw x5, -4(s0)
    lw x6, -8(s0)
    sub x7, x5, x6
    lw x5, -12(s0)
    add x6, x7, x5
    lw x5, -16(s0)
    add x7, x6, x5
    lw x5, -20(s0)
    sub x6, x7, x5
    lw x5, -24(s0)
    sub x7, x6, x5
    lw x5, -28(s0)
    add x6, x7, x5
    lw x5, -32(s0)
    sub x7, x6, x5
    lw x5, -36(s0)
    add x6, x7, x5
    lw x5, -40(s0)
    sub x7, x6, x5
    lw x5, -44(s0)
    add x6, x7, x5
    lw x5, -48(s0)
    add x7, x6, x5
    lw x5, -52(s0)
    add x6, x7, x5
    lw x5, -56(s0)
    sub x7, x6, x5
    lw x5, -60(s0)
    sub x6, x7, x5
    lw x5, -64(s0)
    sub x7, x6, x5
    mv a0, x7
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    li a0, 0
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    
sum32:
    addi sp, sp, -4
    sw x1, 0(sp)
    addi sp, sp, -4
    sw x8, 0(sp)
    mv s0, sp
    addi sp, sp, -64
    sw a0, -4(s0)
    sw a1, -8(s0)
    sw a2, -12(s0)
    sw a3, -16(s0)
    sw a4, -20(s0)
    sw a5, -24(s0)
    sw a6, -28(s0)
    sw a7, -32(s0)
    lw t0, 8(s0)
    sw t0, -36(s0)
    lw t0, 12(s0)
    sw t0, -40(s0)
    lw t0, 16(s0)
    sw t0, -44(s0)
    lw t0, 20(s0)
    sw t0, -48(s0)
    lw t0, 24(s0)
    sw t0, -52(s0)
    lw t0, 28(s0)
    sw t0, -56(s0)
    lw t0, 32(s0)
    sw t0, -60(s0)
    lw t0, 36(s0)
    sw t0, -64(s0)
    lw t0, 40(s0)
    sw t0, -68(s0)
    lw t0, 44(s0)
    sw t0, -72(s0)
    lw t0, 48(s0)
    sw t0, -76(s0)
    lw t0, 52(s0)
    sw t0, -80(s0)
    lw t0, 56(s0)
    sw t0, -84(s0)
    lw t0, 60(s0)
    sw t0, -88(s0)
    lw t0, 64(s0)
    sw t0, -92(s0)
    lw t0, 68(s0)
    sw t0, -96(s0)
    lw t0, 72(s0)
    sw t0, -100(s0)
    lw t0, 76(s0)
    sw t0, -104(s0)
    lw t0, 80(s0)
    sw t0, -108(s0)
    lw t0, 84(s0)
    sw t0, -112(s0)
    lw t0, 88(s0)
    sw t0, -116(s0)
    lw t0, 92(s0)
    sw t0, -120(s0)
    lw t0, 96(s0)
    sw t0, -124(s0)
    lw t0, 100(s0)
    sw t0, -128(s0)
    lw x5, -4(s0)
    lw x6, -8(s0)
    sub x7, x5, x6
    lw x5, -12(s0)
    sub x6, x7, x5
    lw x5, -16(s0)
    add x7, x6, x5
    lw x5, -20(s0)
    add x6, x7, x5
    lw x5, -24(s0)
    sub x7, x6, x5
    lw x5, -28(s0)
    sub x6, x7, x5
    lw x5, -32(s0)
    sub x7, x6, x5
    sw x7, -132(s0)
    lw x5, -36(s0)
    lw x6, -40(s0)
    add x7, x5, x6
    lw x5, -44(s0)
    add x6, x7, x5
    lw x5, -48(s0)
    add x7, x6, x5
    lw x5, -52(s0)
    add x6, x7, x5
    lw x5, -56(s0)
    add x7, x6, x5
    lw x5, -60(s0)
    add x6, x7, x5
    lw x5, -64(s0)
    sub x7, x6, x5
    sw x7, -136(s0)
    lw x5, -68(s0)
    lw x6, -72(s0)
    add x7, x5, x6
    lw x5, -76(s0)
    sub x6, x7, x5
    lw x5, -80(s0)
    sub x7, x6, x5
    lw x5, -84(s0)
    add x6, x7, x5
    lw x5, -88(s0)
    add x7, x6, x5
    lw x5, -92(s0)
    add x6, x7, x5
    lw x5, -96(s0)
    add x7, x6, x5
    sw x7, -140(s0)
    lw x5, -100(s0)
    lw x6, -104(s0)
    sub x7, x5, x6
    lw x5, -108(s0)
    add x6, x7, x5
    lw x5, -112(s0)
    sub x7, x6, x5
    lw x5, -116(s0)
    sub x6, x7, x5
    lw x5, -120(s0)
    add x7, x6, x5
    lw x5, -124(s0)
    add x6, x7, x5
    lw x5, -128(s0)
    add x7, x6, x5
    sw x7, -144(s0)
    lw x5, -132(s0)
    lw x6, -136(s0)
    sub x7, x5, x6
    lw x5, -140(s0)
    add x6, x7, x5
    lw x5, -144(s0)
    add x7, x6, x5
    mv a0, x7
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    li a0, 0
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    
sum64:
    addi sp, sp, -4
    sw x1, 0(sp)
    addi sp, sp, -4
    sw x8, 0(sp)
    mv s0, sp
    addi sp, sp, -64
    sw a0, -4(s0)
    sw a1, -8(s0)
    sw a2, -12(s0)
    sw a3, -16(s0)
    sw a4, -20(s0)
    sw a5, -24(s0)
    sw a6, -28(s0)
    sw a7, -32(s0)
    lw t0, 8(s0)
    sw t0, -36(s0)
    lw t0, 12(s0)
    sw t0, -40(s0)
    lw t0, 16(s0)
    sw t0, -44(s0)
    lw t0, 20(s0)
    sw t0, -48(s0)
    lw t0, 24(s0)
    sw t0, -52(s0)
    lw t0, 28(s0)
    sw t0, -56(s0)
    lw t0, 32(s0)
    sw t0, -60(s0)
    lw t0, 36(s0)
    sw t0, -64(s0)
    lw t0, 40(s0)
    sw t0, -68(s0)
    lw t0, 44(s0)
    sw t0, -72(s0)
    lw t0, 48(s0)
    sw t0, -76(s0)
    lw t0, 52(s0)
    sw t0, -80(s0)
    lw t0, 56(s0)
    sw t0, -84(s0)
    lw t0, 60(s0)
    sw t0, -88(s0)
    lw t0, 64(s0)
    sw t0, -92(s0)
    lw t0, 68(s0)
    sw t0, -96(s0)
    lw t0, 72(s0)
    sw t0, -100(s0)
    lw t0, 76(s0)
    sw t0, -104(s0)
    lw t0, 80(s0)
    sw t0, -108(s0)
    lw t0, 84(s0)
    sw t0, -112(s0)
    lw t0, 88(s0)
    sw t0, -116(s0)
    lw t0, 92(s0)
    sw t0, -120(s0)
    lw t0, 96(s0)
    sw t0, -124(s0)
    lw t0, 100(s0)
    sw t0, -128(s0)
    lw t0, 104(s0)
    sw t0, -132(s0)
    lw t0, 108(s0)
    sw t0, -136(s0)
    lw t0, 112(s0)
    sw t0, -140(s0)
    lw t0, 116(s0)
    sw t0, -144(s0)
    lw t0, 120(s0)
    sw t0, -148(s0)
    lw t0, 124(s0)
    sw t0, -152(s0)
    lw t0, 128(s0)
    sw t0, -156(s0)
    lw t0, 132(s0)
    sw t0, -160(s0)
    lw t0, 136(s0)
    sw t0, -164(s0)
    lw t0, 140(s0)
    sw t0, -168(s0)
    lw t0, 144(s0)
    sw t0, -172(s0)
    lw t0, 148(s0)
    sw t0, -176(s0)
    lw t0, 152(s0)
    sw t0, -180(s0)
    lw t0, 156(s0)
    sw t0, -184(s0)
    lw t0, 160(s0)
    sw t0, -188(s0)
    lw t0, 164(s0)
    sw t0, -192(s0)
    lw t0, 168(s0)
    sw t0, -196(s0)
    lw t0, 172(s0)
    sw t0, -200(s0)
    lw t0, 176(s0)
    sw t0, -204(s0)
    lw t0, 180(s0)
    sw t0, -208(s0)
    lw t0, 184(s0)
    sw t0, -212(s0)
    lw t0, 188(s0)
    sw t0, -216(s0)
    lw t0, 192(s0)
    sw t0, -220(s0)
    lw t0, 196(s0)
    sw t0, -224(s0)
    lw t0, 200(s0)
    sw t0, -228(s0)
    lw t0, 204(s0)
    sw t0, -232(s0)
    lw t0, 208(s0)
    sw t0, -236(s0)
    lw t0, 212(s0)
    sw t0, -240(s0)
    lw t0, 216(s0)
    sw t0, -244(s0)
    lw t0, 220(s0)
    sw t0, -248(s0)
    lw t0, 224(s0)
    sw t0, -252(s0)
    lw t0, 228(s0)
    sw t0, -256(s0)
    lw x5, -4(s0)
    lw x6, -8(s0)
    sub x7, x5, x6
    lw x5, -12(s0)
    add x6, x7, x5
    lw x5, -16(s0)
    sub x7, x6, x5
    lw x5, -20(s0)
    add x6, x7, x5
    lw x5, -24(s0)
    sub x7, x6, x5
    lw x5, -28(s0)
    add x6, x7, x5
    lw x5, -32(s0)
    sub x7, x6, x5
    sw x7, -260(s0)
    lw x5, -36(s0)
    lw x6, -40(s0)
    sub x7, x5, x6
    lw x5, -44(s0)
    add x6, x7, x5
    lw x5, -48(s0)
    sub x7, x6, x5
    lw x5, -52(s0)
    add x6, x7, x5
    lw x5, -56(s0)
    add x7, x6, x5
    lw x5, -60(s0)
    sub x6, x7, x5
    lw x5, -64(s0)
    add x7, x6, x5
    sw x7, -264(s0)
    lw x5, -68(s0)
    lw x6, -72(s0)
    add x7, x5, x6
    lw x5, -76(s0)
    add x6, x7, x5
    lw x5, -80(s0)
    sub x7, x6, x5
    lw x5, -84(s0)
    add x6, x7, x5
    lw x5, -88(s0)
    sub x7, x6, x5
    lw x5, -92(s0)
    sub x6, x7, x5
    lw x5, -96(s0)
    add x7, x6, x5
    sw x7, -268(s0)
    lw x5, -100(s0)
    lw x6, -104(s0)
    add x7, x5, x6
    lw x5, -108(s0)
    sub x6, x7, x5
    lw x5, -112(s0)
    sub x7, x6, x5
    lw x5, -116(s0)
    add x6, x7, x5
    lw x5, -120(s0)
    add x7, x6, x5
    lw x5, -124(s0)
    add x6, x7, x5
    lw x5, -128(s0)
    add x7, x6, x5
    sw x7, -272(s0)
    lw x5, -132(s0)
    lw x6, -136(s0)
    sub x7, x5, x6
    lw x5, -140(s0)
    add x6, x7, x5
    lw x5, -144(s0)
    add x7, x6, x5
    lw x5, -148(s0)
    add x6, x7, x5
    lw x5, -152(s0)
    add x7, x6, x5
    lw x5, -156(s0)
    add x6, x7, x5
    lw x5, -160(s0)
    sub x7, x6, x5
    sw x7, -276(s0)
    lw x5, -164(s0)
    lw x6, -168(s0)
    add x7, x5, x6
    lw x5, -172(s0)
    add x6, x7, x5
    lw x5, -176(s0)
    sub x7, x6, x5
    lw x5, -180(s0)
    add x6, x7, x5
    lw x5, -184(s0)
    sub x7, x6, x5
    lw x5, -188(s0)
    sub x6, x7, x5
    lw x5, -192(s0)
    sub x7, x6, x5
    sw x7, -280(s0)
    lw x5, -196(s0)
    lw x6, -200(s0)
    sub x7, x5, x6
    lw x5, -204(s0)
    sub x6, x7, x5
    lw x5, -208(s0)
    add x7, x6, x5
    lw x5, -212(s0)
    add x6, x7, x5
    lw x5, -216(s0)
    add x7, x6, x5
    lw x5, -220(s0)
    sub x6, x7, x5
    lw x5, -224(s0)
    add x7, x6, x5
    sw x7, -284(s0)
    lw x5, -228(s0)
    lw x6, -232(s0)
    add x7, x5, x6
    lw x5, -236(s0)
    add x6, x7, x5
    lw x5, -240(s0)
    sub x7, x6, x5
    lw x5, -244(s0)
    sub x6, x7, x5
    lw x5, -248(s0)
    add x7, x6, x5
    lw x5, -252(s0)
    add x6, x7, x5
    lw x5, -256(s0)
    add x7, x6, x5
    sw x7, -288(s0)
    lw x5, -260(s0)
    lw x6, -264(s0)
    add x7, x5, x6
    lw x5, -268(s0)
    add x6, x7, x5
    lw x5, -272(s0)
    add x7, x6, x5
    lw x5, -276(s0)
    add x6, x7, x5
    lw x5, -280(s0)
    sub x7, x6, x5
    lw x5, -284(s0)
    add x6, x7, x5
    lw x5, -288(s0)
    sub x7, x6, x5
    mv a0, x7
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    li a0, 0
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    
main:
    addi sp, sp, -4
    sw x1, 0(sp)
    addi sp, sp, -4
    sw x8, 0(sp)
    mv s0, sp
    addi sp, sp, -64
    li x5, 1
    sw x5, -4(s0)
    li x5, 2
    sw x5, -8(s0)
    li x5, 3
    sw x5, -12(s0)
    li x5, 4
    sw x5, -16(s0)
    li x5, 5
    sw x5, -20(s0)
    li x5, 6
    sw x5, -24(s0)
    li x5, 7
    sw x5, -28(s0)
    li x5, 8
    sw x5, -32(s0)
    li x5, 9
    sw x5, -36(s0)
    li x5, 601
    sw x5, -40(s0)
    li x5, 106
    sw x5, -44(s0)
    li x5, 210
    sw x5, -48(s0)
    li x5, 906
    sw x5, -52(s0)
    li x5, 361
    sw x5, -56(s0)
    li x5, 856
    sw x5, -60(s0)
    li x5, 794
    sw x5, -64(s0)
    lw x5, -4(s0)
    li x6, 736
    lw x7, -12(s0)
    li x28, 331
    lw x29, -20(s0)
    li x30, 221
    lw x31, -28(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 969
    mv a0, x5
    mv a1, x6
    mv a2, x7
    mv a3, x28
    mv a4, x29
    mv a5, x30
    mv a6, x31
    mv a7, x5
    call sum8
    sw x10, -68(s0)
    lw x5, -4(s0)
    lw x6, -8(s0)
    lw x7, -12(s0)
    lw x28, -16(s0)
    lw x29, -20(s0)
    lw x30, -24(s0)
    lw x31, -28(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -32(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 80
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 755
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 755
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 886
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -68(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -52(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -68(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -56(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -68(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -60(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -68(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -64(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    mv a0, x5
    mv a1, x6
    mv a2, x7
    mv a3, x28
    mv a4, x29
    mv a5, x30
    mv a6, x31
    mv a7, x5
    call sum16
    addi sp, sp, 32
    sw x10, -72(s0)
    li x5, 921
    sw x5, -76(s0)
    li x5, 434
    sw x5, -80(s0)
    li x5, 135
    sw x5, -84(s0)
    li x5, 235
    sw x5, -88(s0)
    li x5, 512
    sw x5, -92(s0)
    li x5, 820
    sw x5, -96(s0)
    li x5, 369
    sw x5, -100(s0)
    li x5, 1010
    sw x5, -104(s0)
    li x5, 114
    sw x5, -108(s0)
    li x5, 417
    sw x5, -112(s0)
    li x5, 267
    sw x5, -116(s0)
    li x5, 496
    sw x5, -120(s0)
    li x5, 565
    sw x5, -124(s0)
    li x5, 595
    sw x5, -128(s0)
    li x5, 989
    sw x5, -132(s0)
    li x5, 521
    sw x5, -136(s0)
    lw x5, -4(s0)
    lw x6, -8(s0)
    lw x7, -12(s0)
    lw x28, -16(s0)
    lw x29, -20(s0)
    lw x30, -24(s0)
    lw x31, -28(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -32(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -36(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -40(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -44(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -48(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -52(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -56(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -60(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -64(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -76(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -80(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -84(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -88(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -92(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -96(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -100(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -104(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -108(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -112(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -116(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -120(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -124(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -128(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -132(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -136(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    mv a0, x5
    mv a1, x6
    mv a2, x7
    mv a3, x28
    mv a4, x29
    mv a5, x30
    mv a6, x31
    mv a7, x5
    call sum32
    addi sp, sp, 96
    sw x10, -140(s0)
    lw x5, -4(s0)
    lw x6, -8(s0)
    lw x7, -12(s0)
    lw x28, -16(s0)
    lw x29, -20(s0)
    lw x30, -24(s0)
    lw x31, -28(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -32(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 556
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 622
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 635
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 573
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 937
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 16
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 220
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 869
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -76(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -80(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -84(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -88(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -92(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -96(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -100(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -104(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 387
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 796
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 169
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 983
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 148
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 489
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 249
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 259
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -4(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 362
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -8(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 677
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -12(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 572
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -16(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 453
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -20(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 489
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -24(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 486
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -28(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 647
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -32(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 642
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -36(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 395
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -40(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 489
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -44(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 767
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -48(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 986
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -52(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 928
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -56(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 402
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -60(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 886
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -64(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    li x5, 495
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -4(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -76(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -8(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -80(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -12(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -84(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -16(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -88(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -20(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -92(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -24(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -96(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -28(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -100(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -32(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -104(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -4(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -36(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -140(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -8(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -40(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -140(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -12(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -44(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -140(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -16(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -48(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -140(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -20(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -52(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -140(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -24(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -56(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -140(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -28(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -60(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -140(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    lw x5, -32(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -64(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    mul x5, x5, x5
    lw x5, -68(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x5, -72(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    sub x5, x5, x5
    lw x5, -140(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    add x5, x5, x5
    add x5, x5, x5
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    addi sp, sp, -4
    sw x5, 0(sp)
    mv a0, x5
    mv a1, x6
    mv a2, x7
    mv a3, x28
    mv a4, x29
    mv a5, x30
    mv a6, x31
    mv a7, x5
    call sum64
    addi sp, sp, 224
    sw x10, -144(s0)
    lw x5, -68(s0)
    lw x6, -72(s0)
    add x7, x5, x6
    lw x5, -140(s0)
    sub x6, x7, x5
    lw x5, -144(s0)
    sub x7, x6, x5
    sw x7, -148(s0)
    lw x5, -148(s0)
    li x6, 1404
    rem x7, x5, x6
    mv a0, x7
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    li a0, 0
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
    
