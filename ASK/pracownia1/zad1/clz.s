    .file   "clz.s"

    #maska wykorzystywana do pobierania lewej polowy bitow
    MASK = 0xFFFFFFFF00000000 
    mask = %rsi
    tmp = %rdx
    arg = %rdi
    resoult = %al
    count = %cl

    .text
    .global clz
    .type clz, @function

# rdi - argument funkcji, rax - zwracana wartosc
clz:
#init
    mov $MASK, mask
    mov $32, count
    xorq %rax, %rax #zerowanie rejestru wyniku
    cmp $0, arg #sprawdzenie czy arg to 0
    jz zero #jesli tak zwracamy 64

loop:
    cmp $0, count
    jz end
    mov arg, tmp
    and mask, tmp
    cmp $0, tmp
    jz rs

#kiedy lewa polowoa != 0
ls:
    shr count, arg #przesuwamy lewa polowe w prawo
    shr $1, count #dzielimy count na 2 => 32,16,8,4...
    shr count, mask #przesuwamy maske w prawo zeby badac lewa polowe bitow
    jmp loop

#kiedy lewa polowa to 0
rs:
    add count, resoult #dodajemy do wyniku
    shr $1, count #dzielimy count na 2 => 32,16,8,4...
    shr count, mask 
    jmp loop

zero:
    mov $64, resoult
    ret

end:
    ret

.size clz, .-clz

