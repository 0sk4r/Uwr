//Oskar Sobczyk

#include <stdio.h>
#include <stdlib.h>

extern int clz(long num);

int main(int argc, char* argv[]) {

	if (argc == 2) { 
    
		long num = atol(argv[1]); 
		long res = clz(num);
       
		printf("%ld \n",res);
	}

	return 0;
}
