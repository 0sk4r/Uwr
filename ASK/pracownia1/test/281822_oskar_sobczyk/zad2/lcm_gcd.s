#Oskar Sobczyk

    .file   "lcm_gcd.s"
    .text
    .global lcm_gcd
    .type lcm_gcd, @function

    arg1 = %rdi
    arg2 = %rsi
    lcm = %r8
    gcd = %rdx
    temp = %r9


lcm_gcd:
    xorq %rdx, %rdx #zerowanie do div
    mov arg1, %rax
    mul arg2
loop:
    cmp arg2, arg1 #chcemy arg1 > arg2
    js switch 
    sub arg2, arg1 #arg1 = arg1 - arg2

    cmp arg1, arg2
    jnz loop
    #gcd = arg1
    div arg1 #(arg1 * arg2)/gcd(arg1,arg2) = lcm(arg1, arg2)
    #lcm juz jest w %rax
    mov arg1, gcd
    ret

switch:
    mov arg1, temp
    mov arg2, arg1
    mov temp, arg2
    jmp loop
    .size lcm_gcd, .-lcm_gcd
