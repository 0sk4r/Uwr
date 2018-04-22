    .file   "lcm_gcd.s"

    arg1 = %rdi
    arg2 = %rsi
    resoult = %rax
    lcm = %r8
    gcd = %rdx
    temp = %r9
    .text
    .global lcm_gcd
    .type lcm_gcd, @function

# rdi, rsi, wynik w %rax
lcm_gcd:
    xorq %rdx, %rdx #zerowanie do div
    mov arg1, %rax
    mul arg2
loop:
    cmp arg2, arg1 #chcemy arg1 > arg2
    js switch #if r0 > r1, r0 = r0 - r1
    sub arg2, arg1

    cmp arg1, arg2
    jnz loop
    #gcd = arg1
    #mov arg1, resoult

    div arg1
    mov arg1, gcd
    ret

#mozna zoptymalizowac zeby nie uzywac dodatkowego rejestru
switch:
    mov arg1, temp
    mov arg2, arg1
    mov temp, arg2
    jmp loop
    .size lcm_gcd, .-lcm_gcd
