    .file   "insert_sort.s"

    arg1 = %rdi
    arg2 = %rsi
    key1 = %r8
    key2 = %r9
    j = %r10
    i = %r11
    addres = %r12
    .text
    .global insert_sort
    .type insert_sort, @function

insert_sort:
    mov $1, i
for:
    lea 8(i, arg1), addres
    mov (addres), key1
    mov i, j
    sub $1, j
while:
    lea 8(j, arg1), addres
    mov (addres), key2
    cmp key1, key2 #key2 - key1
    jns switch
    jmp for

    .size insert_sort, .-insert_sort
