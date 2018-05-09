all: zad4.o fibonacci.o
	gcc -o zad4 zad4.o fibonacci.o -Wall -Wextra

zad4.o: zad4.c
	gcc -Og -g -c zad4.c -Wall -Wextra

asm.o: fibonacci.s
	gcc -c -g fibonacci.s -Wall -Wextra

clean:
	rm -f fibonacci.o zad4.o zad4

debug: zad4
	gdb -x .gdbinit -ex 'break main' -ex 'run' zad4
	
