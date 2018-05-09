all: zad2.o lcm_gcd.o
	gcc -o zad2 zad2.o lcm_gcd.o -Wall -Wextra

zad2.o: zad2.c
	gcc -Og -g -c zad2.c -Wall -Wextra

asm.o: lcm_gcd.s
	gcc -c -g lcm_gcd.s -Wall -Wextra

clean:
	rm -f lcm_gcd.o zad2.o zad2

debug: zad2
	gdb -x .gdbinit -ex 'break main' -ex 'run' zad2
	
