    .file   "clz.s"

    #MASK = 0xFFFF0000
    MASK = 0xFFFFFFFF00000000
    mask = %rsi
    tmp = %rdx
    arg = %rdi
    resoult = %al
    count = %cl

    .text
    .global clz
    .type clz, @function

# rdi, rsi, rdx, rcx, r8, r9 - argumenty funkcji sa kolejno w tych rejestrach
clz:
#init
    xorq %rax, %rax #zerowanie rejestru wyniku
    cmp $0, arg #sprawdzenie czy arg to 0
    jz zero #jesli tak zwracamy 64
    mov $MASK, mask
    mov $32, count

loop:
    mov arg, tmp
    cmp $0, count
    jz end
    and mask, tmp
    cmp $0, tmp
    jz rs

#kiedy lewa polowoa != 0
ls:
    shr count, arg #przesuwamy lewa polowe w prawo
    shr $1, count #dzielimy count na 2 => 32,16,8,4...
    shr count, mask #przesuwamy maske w prawo zeby badac lewa polowe bitow
    jp loop

#kiedy lewa polowa to 0
rs:
    add count, resoult #dodajemy do wyniku
    shr $1, count #dzielimy count na 2 => 32,16,8,4...
    #TODO: Problem z maska. Maska przesuwa sie o 32 a nie o 16
    shr count, mask 
    jp loop

end:
    ret
zero:
    mov $64, resoult
    ret
.size clz, .-clz
 
