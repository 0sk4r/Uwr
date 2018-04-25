    .file   "mulf.s"
    arg1 = %rdi
    arg2 = %rsi
    resoult = %rax
    sign1 = %r8
    sing2 = %r9
    exp1 = %r10
    exp2 = %r11
    frac1 = %r12
    frac2 = %r13
    zfrac1 = %r14
    zfrac2 = %r15
    tmp = %rbp
    frac_mask = 0x007FFFFF
    exp_mask = 0xFF
    lol = 0x00800000

    .text
    .global mulf
    .type mulf, @function

mulf:
    cmp $0, arg1
    je zero
    cmp $0, arg2
    je zero

    #fraction calculation
    mov arg1, frac1
    and $frac_mask, frac1
    mov arg2, frac2
    and $frac_mask, frac2

    #exponent calculation
    mov arg1, exp1
    shr $23, exp1
    and $exp_mask, exp1
    mov arg2, exp2
    shr $23, exp2
    and $exp_mask, exp2

    #sign calculation
    mov arg1, sign1
    shr $31, sign1
    mov arg2, sing2
    shr $31, sing2

    #compute sign sign1= sign1 ^ sign2
    xor sing2, sign1

    #compute exp exp1 = exp1 + exp2 - 127
    add exp2, exp1
    sub $0x7f, exp1


    #or $0x00800000, frac1
    #shl $7, frac1
    #or $0x00800000, frac2
    #shl $8, frac2

    #mantisa frac1 = frac1 * frac2
    mov frac1, %rax
    mul frac2
    mov %rax, frac1

    mov frac1, zfrac1
    shr $32, zfrac1

    mov frac1, zfrac2
    #and $4294967295, zfrac2

    cmp $0, zfrac2
    je lol
    or $1, zfrac2
lol:    
    or zfrac2, zfrac1

    mov zfrac1, tmp
    shl $1, tmp
    cmp $0, tmp
    jns xd

    shl $1, zfrac1
    dec exp1
xd:
    shl $31, sign1
    mov sign1, resoult
    shl $23, exp1
    or exp1, resoult
    shr $7, frac1
    or frac1, resoult

    ret
zero:
    mov $0, resoult
    ret

    .size mulf, .-mulf
