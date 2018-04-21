    .text
    .global clz
    .type clz, @function

# rdi, rsi, rdx, rcx, r8, r9 - argumenty funkcji sa kolejno w tych rejestrach
clz:
    add $1, %rdi
    movq %rdi, %rax
    ret

.size clz, .-clz
