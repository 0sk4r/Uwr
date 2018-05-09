#Oskar Sobczyk
    
    .file   "fibonacci.s"
    .text
    .global fibonacci
    .type fibonacci, @function
    arg = %rdi
    resoult = %rax
    tmp = %r8

fibonacci:
    cmp $0, arg
    jnz t
    mov $0, resoult
    ret
t:
    cmp $1, arg
    ja fib
    mov $1, resoult
    ret

fib:
    dec arg
    push arg
    call fibonacci
    pop arg
    push resoult
    dec arg
    call fibonacci
    pop tmp
    add tmp, resoult
    ret
