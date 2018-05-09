//Oskar Sobczyk

#include <stdio.h>
#include <stdlib.h>

unsigned long fibonacci(unsigned long n);

int main(int argc, char* argv[]){
    
    if (argc == 2){
        long arg = atol(argv[1]);
        long n = fibonacci(arg);
        printf("%ld \n",n);
    }

    return 0;
}
