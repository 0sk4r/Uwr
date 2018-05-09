#Oskar Sobczyk
    
    .file   "insert_sort.s"
    .text
    .global insert_sort
    .type insert_sort, @function

    ptr_s = %rdi #wskaznik na pierwszy element
    ptr_e = %rsi #wskaznik na ostatni element
    addres1 = %r8
    addres2 = %r9
    val1 = %r10
    val2 = %r11
    i = %r12
    j = %r13
    x = %r14

insert_sort:
    mov $1, i

for:
    lea (ptr_s,i,8), addres1
    cmp addres1, ptr_e
    js end
    mov (addres1), val1
    mov i, j
    dec j
while:
    cmp $0, j #j>=0
    js for2 

    lea (ptr_s, j, 8), addres2 # *tab[j]
    mov (addres2), val2 #tab[j]
    cmp val1, val2 #tab[j] > temp = tab[i]
    js for2
    
    lea 8(ptr_s,j,8), addres2
    mov val2, (addres2) #tab[j+1] = tab[j]
    dec j
    jmp while
for2:
    lea 8(ptr_s,j,8), addres2
    mov val1, (addres2) #tab[j+1] = temp
    inc i #i++
    jmp for
end:
    ret
    .size insert_sort, .-insert_sort
