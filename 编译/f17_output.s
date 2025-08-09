    .text
    .globl main
    
factorial:
    addi sp, sp, -4
    sw x1, 0(sp)
    addi sp, sp, -4
    sw x8, 0(sp)
    mv s0, sp
    addi sp, sp, -64
    sw a0, -4(s0)
    lw x5, -4(s0)
    li x6, 1
    slt x7, x6, x5
    xori x7, x7, 1
    beqz x7, if_false_0
    li x5, 1
    mv a0, x5
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
if_false_0:
    lw x5, -4(s0)
    addi sp, sp, -4
    sw x5, 0(sp)
    lw x6, -4(s0)
    li x7, 1
    sub x28, x6, x7
    mv a0, x28
    call factorial
    lw x5, 0(sp)
    addi sp, sp, 4
    mul x6, x5, x10
    mv a0, x6
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
    
fibonacci:
    addi sp, sp, -4
    sw x1, 0(sp)
    addi sp, sp, -4
    sw x8, 0(sp)
    mv s0, sp
    addi sp, sp, -64
    sw a0, -4(s0)
    lw x5, -4(s0)
    li x6, 0
    slt x7, x6, x5
    xori x7, x7, 1
    beqz x7, if_false_2
    li x5, 0
    mv a0, x5
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
if_false_2:
    lw x5, -4(s0)
    li x6, 1
    sub x7, x5, x6
    seqz x7, x7
    beqz x7, if_false_4
    li x5, 1
    mv a0, x5
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
if_false_4:
    lw x5, -4(s0)
    li x6, 1
    sub x7, x5, x6
    mv a0, x7
    call fibonacci
    addi sp, sp, -4
    sw x10, 0(sp)
    lw x5, -4(s0)
    li x6, 2
    sub x7, x5, x6
    mv a0, x7
    call fibonacci
    lw x5, 0(sp)
    addi sp, sp, 4
    add x6, x5, x10
    mv a0, x6
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
    
gcd:
    addi sp, sp, -4
    sw x1, 0(sp)
    addi sp, sp, -4
    sw x8, 0(sp)
    mv s0, sp
    addi sp, sp, -64
    sw a0, -4(s0)
    sw a1, -8(s0)
    lw x5, -8(s0)
    li x6, 0
    sub x7, x5, x6
    seqz x7, x7
    beqz x7, if_false_6
    lw x5, -4(s0)
    mv a0, x5
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
if_false_6:
    lw x5, -8(s0)
    lw x6, -4(s0)
    lw x7, -8(s0)
    rem x28, x6, x7
    mv a0, x5
    mv a1, x28
    call gcd
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
    
is_prime:
    addi sp, sp, -4
    sw x1, 0(sp)
    addi sp, sp, -4
    sw x8, 0(sp)
    mv s0, sp
    addi sp, sp, -64
    sw a0, -4(s0)
    lw x5, -4(s0)
    li x6, 1
    slt x7, x6, x5
    xori x7, x7, 1
    beqz x7, if_false_8
    li x5, 0
    mv a0, x5
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
if_false_8:
    lw x5, -4(s0)
    li x6, 3
    slt x7, x6, x5
    xori x7, x7, 1
    beqz x7, if_false_10
    li x5, 1
    mv a0, x5
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
if_false_10:
    lw x6, -4(s0)
    li x7, 2
    rem x28, x6, x7
    li x6, 0
    sub x7, x28, x6
    seqz x7, x7
    bnez x7, or_true_14
    lw x6, -4(s0)
    li x28, 3
    rem x29, x6, x28
    li x6, 0
    sub x28, x29, x6
    seqz x28, x28
    mv x5, x28
    j or_end_15
or_true_14:
    li x5, 1
or_end_15:
    beqz x5, if_false_12
    li x5, 0
    mv a0, x5
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
if_false_12:
    li x5, 5
    sw x5, -8(s0)
while_start_16:
    lw x5, -8(s0)
    lw x6, -8(s0)
    mul x7, x5, x6
    lw x5, -4(s0)
    slt x6, x5, x7
    xori x6, x6, 1
    beqz x6, while_end_17
    lw x6, -4(s0)
    lw x7, -8(s0)
    rem x28, x6, x7
    li x6, 0
    sub x7, x28, x6
    seqz x7, x7
    bnez x7, or_true_20
    lw x6, -4(s0)
    lw x28, -8(s0)
    li x29, 2
    add x30, x28, x29
    rem x28, x6, x30
    li x6, 0
    sub x29, x28, x6
    seqz x29, x29
    mv x5, x29
    j or_end_21
or_true_20:
    li x5, 1
or_end_21:
    beqz x5, if_false_18
    li x5, 0
    mv a0, x5
    mv sp, s0
    lw x8, 0(sp)
    addi sp, sp, 4
    lw x1, 0(sp)
    addi sp, sp, 4
    ret
if_false_18:
    lw x5, -8(s0)
    li x6, 6
    add x7, x5, x6
    sw x7, -8(s0)
    j while_start_16
while_end_17:
    li x5, 1
    mv a0, x5
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
    li x5, 332
    sw x5, -4(s0)
    li x5, -230
    sw x5, -8(s0)
    li x5, -156
    sw x5, -12(s0)
    li x5, 938
    sw x5, -16(s0)
    lw x5, -4(s0)
    lw x6, -8(s0)
    add x7, x5, x6
    lw x5, -12(s0)
    mul x6, x7, x5
    lw x5, -16(s0)
    lw x7, -4(s0)
    mul x28, x5, x7
    add x5, x6, x28
    lw x6, -8(s0)
    lw x7, -12(s0)
    sub x28, x6, x7
    lw x6, -4(s0)
    lw x7, -16(s0)
    neg x29, x7
    add x7, x6, x29
    li x6, 2048
    add x29, x7, x6
    rem x6, x28, x29
    li x7, 1
    add x28, x6, x7
    div x6, x5, x28
    lw x5, -4(s0)
    neg x7, x5
    lw x5, -8(s0)
    neg x28, x5
    mul x5, x7, x28
    lw x7, -12(s0)
    mv x28, x7
    mul x7, x5, x28
    lw x5, -16(s0)
    li x28, 2
    mv x29, x28
    sub x28, x5, x29
    lw x5, -12(s0)
    neg x29, x5
    sub x5, x28, x29
    mul x28, x7, x5
    add x5, x6, x28
    sw x5, -20(s0)
    li x5, -465
    sw x5, -24(s0)
    li x5, 431
    sw x5, -28(s0)
    li x5, 246
    sw x5, -32(s0)
    li x5, 0
    sw x5, -36(s0)
    lw x6, -24(s0)
    lw x7, -28(s0)
    slt x28, x7, x6
    beqz x28, and_false_24
    lw x6, -32(s0)
    li x7, 1
    add x29, x6, x7
    li x6, 1
    sub x7, x29, x6
    seqz x7, x7
    mv x5, x7
    j and_end_25
and_false_24:
    li x5, 0
and_end_25:
    beqz x5, if_false_22
    li x5, 1
    sw x5, -36(s0)
if_false_22:
    li x5, 0
    sw x5, -40(s0)
    lw x6, -24(s0)
    lw x7, -28(s0)
    slt x28, x6, x7
    bnez x28, or_true_28
    lw x6, -32(s0)
    li x7, 2
    add x29, x6, x7
    li x6, 2
    sub x7, x29, x6
    seqz x7, x7
    mv x5, x7
    j or_end_29
or_true_28:
    li x5, 1
or_end_29:
    beqz x5, if_false_26
    li x5, 1
    sw x5, -40(s0)
if_false_26:
    li x5, 0
    sw x5, -44(s0)
    lw x28, -24(s0)
    li x29, -671
    slt x30, x29, x28
    beqz x30, and_false_36
    lw x28, -28(s0)
    li x29, -390
    slt x31, x28, x29
    mv x7, x31
    j and_end_37
and_false_36:
    li x7, 0
and_end_37:
    bnez x7, or_true_34
    lw x29, -32(s0)
    li x30, -189
    slt x31, x30, x29
    beqz x31, and_false_38
    lw x29, -24(s0)
    li x30, 1006
    addi sp, sp, -4
    sw x5, 0(sp)
    slt x5, x29, x30
    mv x28, x5
    j and_end_39
and_false_38:
    li x28, 0
and_end_39:
    mv x6, x28
    j or_end_35
or_true_34:
    li x6, 1
or_end_35:
    seqz x5, x6
    beqz x5, and_false_32
    lw x7, -28(s0)
    li x28, -257
    slt x29, x28, x7
    bnez x29, or_true_40
    lw x7, -24(s0)
    li x28, -169
    slt x30, x7, x28
    mv x6, x30
    j or_end_41
or_true_40:
    li x6, 1
or_end_41:
    mv x5, x6
    j and_end_33
and_false_32:
    li x5, 0
and_end_33:
    beqz x5, if_false_30
    li x5, 1
    sw x5, -44(s0)
if_false_30:
    li x5, 10617
    sw x5, -48(s0)
    li x5, 16000
    sw x5, -52(s0)
    li x5, 23223
    sw x5, -56(s0)
    lw x5, -52(s0)
    li x6, 12
    rem x7, x5, x6
    lw x5, -56(s0)
    li x6, 12
    rem x28, x5, x6
    mv a0, x7
    mv a1, x28
    call gcd
    mv a0, x10
    call factorial
    addi sp, sp, -4
    sw x10, 0(sp)
    lw x5, -48(s0)
    li x6, 10
    rem x7, x5, x6
    li x5, 2
    sub x6, x7, x5
    mv a0, x6
    call fibonacci
    lw x5, 0(sp)
    addi sp, sp, 4
    add x6, x5, x10
    sw x6, -60(s0)
    li x5, 0
    sw x5, -64(s0)
    lw x6, -48(s0)
    lw x7, -52(s0)
    slt x28, x7, x6
    beqz x28, and_false_44
    lw x6, -48(s0)
    lw x7, -56(s0)
    slt x29, x7, x6
    mv x5, x29
    j and_end_45
and_false_44:
    li x5, 0
and_end_45:
    beqz x5, if_false_42
    lw x5, -48(s0)
    sw x5, -64(s0)
    j if_end_43
if_false_42:
    lw x6, -52(s0)
    lw x7, -48(s0)
    slt x28, x7, x6
    beqz x28, and_false_48
    lw x6, -52(s0)
    lw x7, -56(s0)
    slt x29, x7, x6
    mv x5, x29
    j and_end_49
and_false_48:
    li x5, 0
and_end_49:
    beqz x5, if_false_46
    lw x5, -52(s0)
    sw x5, -64(s0)
    j if_end_47
if_false_46:
    lw x5, -56(s0)
    sw x5, -64(s0)
if_end_47:
if_end_43:
    li x5, 0
    sw x5, -68(s0)
    li x5, 1
    sw x5, -72(s0)
while_start_50:
    lw x5, -72(s0)
    li x6, 19
    slt x7, x6, x5
    xori x7, x7, 1
    beqz x7, while_end_51
    lw x5, -72(s0)
    li x6, 2
    rem x7, x5, x6
    li x5, 0
    sub x6, x7, x5
    seqz x6, x6
    beqz x6, if_false_52
    lw x5, -68(s0)
    lw x6, -72(s0)
    lw x7, -72(s0)
    mul x28, x6, x7
    add x6, x5, x28
    sw x6, -68(s0)
    j if_end_53
if_false_52:
    lw x5, -72(s0)
    li x6, 4
    rem x7, x5, x6
    li x5, 0
    sub x6, x7, x5
    seqz x6, x6
    beqz x6, if_false_54
    lw x5, -68(s0)
    lw x6, -72(s0)
    lw x7, -72(s0)
    mul x28, x6, x7
    lw x6, -72(s0)
    mul x7, x28, x6
    add x6, x5, x7
    sw x6, -68(s0)
    j if_end_55
if_false_54:
    lw x5, -68(s0)
    lw x6, -72(s0)
    add x7, x5, x6
    sw x7, -68(s0)
if_end_55:
if_end_53:
    lw x5, -72(s0)
    li x6, 1
    add x7, x5, x6
    sw x7, -72(s0)
    j while_start_50
while_end_51:
    li x5, 0
    sw x5, -76(s0)
    li x5, 1
    sw x5, -72(s0)
while_start_56:
    lw x5, -72(s0)
    li x6, 10
    slt x7, x6, x5
    xori x7, x7, 1
    beqz x7, while_end_57
    li x5, 1
    sw x5, -80(s0)
    li x5, 1
    sw x5, -84(s0)
while_start_58:
    lw x5, -80(s0)
    lw x6, -72(s0)
    slt x7, x6, x5
    xori x7, x7, 1
    beqz x7, while_end_59
    lw x5, -84(s0)
    lw x6, -80(s0)
    mul x7, x5, x6
    sw x7, -84(s0)
    lw x5, -80(s0)
    li x6, 1
    add x7, x5, x6
    sw x7, -80(s0)
    j while_start_58
while_end_59:
    lw x5, -76(s0)
    lw x6, -84(s0)
    add x7, x5, x6
    sw x7, -76(s0)
    lw x5, -72(s0)
    li x6, 1
    add x7, x5, x6
    sw x7, -72(s0)
    j while_start_56
while_end_57:
    li x5, 0
    sw x5, -88(s0)
    lw x5, -48(s0)
    mv a0, x5
    call is_prime
    beqz x10, if_false_60
    lw x5, -52(s0)
    mv a0, x5
    call is_prime
    beqz x10, if_false_62
    lw x5, -48(s0)
    lw x6, -52(s0)
    mul x7, x5, x6
    sw x7, -88(s0)
    j if_end_63
if_false_62:
    lw x5, -56(s0)
    mv a0, x5
    call is_prime
    beqz x10, if_false_64
    lw x5, -48(s0)
    lw x6, -56(s0)
    mul x7, x5, x6
    sw x7, -88(s0)
    j if_end_65
if_false_64:
    lw x5, -48(s0)
    sw x5, -88(s0)
if_end_65:
if_end_63:
    j if_end_61
if_false_60:
    lw x5, -52(s0)
    mv a0, x5
    call is_prime
    beqz x10, if_false_66
    lw x5, -56(s0)
    mv a0, x5
    call is_prime
    beqz x10, if_false_68
    lw x5, -52(s0)
    lw x6, -56(s0)
    mul x7, x5, x6
    sw x7, -88(s0)
    j if_end_69
if_false_68:
    lw x5, -52(s0)
    sw x5, -88(s0)
if_end_69:
    j if_end_67
if_false_66:
    lw x5, -56(s0)
    mv a0, x5
    call is_prime
    beqz x10, if_false_70
    lw x5, -56(s0)
    sw x5, -88(s0)
    j if_end_71
if_false_70:
    lw x5, -48(s0)
    lw x6, -52(s0)
    add x7, x5, x6
    lw x5, -56(s0)
    add x6, x7, x5
    sw x6, -88(s0)
if_end_71:
if_end_67:
if_end_61:
    li x5, 0
    sw x5, -92(s0)
    li x5, 6617876
    sw x5, -96(s0)
    li x5, 0
    sw x5, -100(s0)
while_start_72:
    lw x5, -96(s0)
    li x6, 0
    slt x7, x6, x5
    beqz x7, while_end_73
    lw x5, -96(s0)
    li x6, 2
    rem x7, x5, x6
    li x5, 1
    sub x6, x7, x5
    seqz x6, x6
    beqz x6, if_false_74
    lw x5, -100(s0)
    li x6, 1
    add x7, x5, x6
    sw x7, -100(s0)
if_false_74:
    lw x5, -96(s0)
    li x6, 2
    div x7, x5, x6
    sw x7, -96(s0)
    j while_start_72
while_end_73:
    lw x5, -20(s0)
    lw x6, -36(s0)
    sub x7, x5, x6
    lw x5, -40(s0)
    add x6, x7, x5
    lw x5, -44(s0)
    sub x7, x6, x5
    lw x5, -60(s0)
    sub x6, x7, x5
    lw x5, -64(s0)
    add x7, x6, x5
    lw x5, -68(s0)
    add x6, x7, x5
    lw x5, -76(s0)
    sub x7, x6, x5
    lw x5, -88(s0)
    sub x6, x7, x5
    lw x5, -100(s0)
    add x7, x6, x5
    sw x7, -104(s0)
    lw x5, -104(s0)
    mv a0, x5
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
    
