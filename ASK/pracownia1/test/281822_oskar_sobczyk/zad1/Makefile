all: zad1.o asm.o
	gcc -o zad1 zad1.o clz.o -Wall -Wextra

zad1.o: zad1.c
	gcc -Og -g -c zad1.c -Wall -Wextra

asm.o: clz.s
	gcc -c -g clz.s -Wall -Wextra

clean:
	rm -f clz.o zad1.o zad1

debug: zad1
	gdb -x .gdbinit -ex 'break main' -ex 'run' zad1
	
