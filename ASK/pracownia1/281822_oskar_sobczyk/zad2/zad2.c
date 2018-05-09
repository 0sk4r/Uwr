//Oskar Sobczyk

#include <stdio.h>
#include <stdlib.h>

typedef struct {
    unsigned long lcm, gcd;
} result_t;

result_t lcm_gcd(unsigned long arg1, unsigned long arg2);

int main(int argc, char* argv[]) {

    
	if (argc == 3) { 
		
		long arg1 = atol(argv[1]); 
        long arg2 = atol(argv[2]);
		result_t res = lcm_gcd(arg1, arg2);

        printf("gcd = %ld lcm = %ld \n", res.gcd, res.lcm);

	}
	else{
		printf("Niepoprawna ilość argumentow.\n");
	}

	return 0;
}