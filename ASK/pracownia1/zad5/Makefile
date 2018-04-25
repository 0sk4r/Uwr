all: zad5.o mulf.o
	gcc -o zad5 zad5.o mulf.o -Wall -Wextra

zad5.o: zad5.c
	gcc -Og -g -c zad5.c -Wall -Wextra

mulf.o: mulf.s
	gcc -c -g mulf.s -Wall -Wextra

clean:
	rm -f mulf.o zad5.o zad5

dis:
	objdump -d zad5

debug: zad5
	gdb -x .gdbinit -ex 'break main' -ex 'run' zad5
	
