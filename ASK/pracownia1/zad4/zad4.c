#include <stdio.h>
#include <stdlib.h>

extern long fibonacci(unsigned long n);

int main(int argc, char* argv[]){
    
    if (argc == 2){
        long arg = atol(argv[1]);
        long n = fibonacci(arg);
        printf("fib(%ld) = %ld \n",arg,n);
    }

    return 0;
}