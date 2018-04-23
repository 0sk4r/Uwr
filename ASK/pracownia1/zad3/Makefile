all: zad3.o insert_sort.o
	gcc -o zad3 zad3.o insert_sort.o -Wall -Wextra

zad2.o: zad3.c
	gcc -Og -g -c zad3.c -Wall -Wextra

asm.o: insert_sort.s
	gcc -c -g insert_sort.s -Wall -Wextra

clean:
	rm -f insert_sort.o zad3.o zad3

dis:
	objdump -d zad3

debug: zad3
	gdb -x .gdbinit -ex 'break main' -ex 'run' zad3
	
