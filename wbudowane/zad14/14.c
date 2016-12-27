#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <inttypes.h>
#include <stdbool.h>
#define size 75000000


uint32_t array[size];
uint32_t init32(){
    uint32_t init32;
    init32 = ((double)rand()/RAND_MAX)*0xFFFFFFFF;
    return init32;
}

bool sposobjeden(uint32_t x){
    int32_t negacja = ~(x);
    bool power = x && !(negacja & (negacja - 1));
    return power;
}

bool sposobdwa(uint32_t x){
    int count = 0;
    uint32_t negacja = ~(x);

    for (count=0; negacja; count++)
        negacja &= negacja - 1;

    if(count<2) return true;
    else return false;
}

int main(void){

    int i,y = 0,x = 0;
    double elapsed; // in milliseconds
	clock_t start, end;
    srand(time(0));

    for (i=0;i<size;i++){
        //wypelnianie tablicy
        array[i] = init32();
    }

    start = clock();
    for (i=0;i<size;i++){

        if(!sposobjeden(array[i])) x++;
    }
    end = clock();
	elapsed = ((double) (end - start) * 1000) / CLOCKS_PER_SEC;
	printf("ilosc liczb: %i\n",x);
	printf("1. sposob potrzebowal %f ms\n", elapsed);

	//----------------------------------------------------------

    start = clock();
    for (i=0;i<size;i++){

        if(!sposobdwa(array[i])) y++;
    }
    end = clock();
	elapsed = ((double) (end - start) * 1000) / CLOCKS_PER_SEC;
	printf("ilosc liczb: %i\n",y);
	printf("1. sposob potrzebowal %f ms\n", elapsed);


    //printf("%i\n",x);
    return 0;
}
