#include <stdio.h>
#include <stdlib.h>

extern int clz(long num);

int main(int argc, char* argv[]) {

	// long res = clz(4);
	if (argc == 2) { 
		
		long num = atol(argv[1]); 
		long res = clz(num);

		printf("clz(%ld) = %ld \n",num,res);
	}

	return 0;
}