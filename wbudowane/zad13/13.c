#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <inttypes.h>
#include <math.h>
#include <time.h>
#include <sys/time.h>

#define size 75000000
long long int sum1=0,sum2=0,sum3=0;
uint32_t array[size];

uint32_t genInt32(){
    uint32_t int32;
    int32 = ((double)rand()/RAND_MAX)*0xFFFFFFFF;
    return int32;
}

uint32_t metoda1(uint32_t x)
{
    //zamienia parzyste i nieparzyste
    x = (((x & 0xaaaaaaaa) >> 1) | ((x & 0x55555555) << 1));
    //zamienia kolejne pary
    x = (((x & 0xcccccccc) >> 2) | ((x & 0x33333333) << 2));
    //zamienia polbajty
    x = (((x & 0xf0f0f0f0) >> 4) | ((x & 0x0f0f0f0f) << 4));
    //zamienia bajty
    x = (((x & 0xff00ff00) >> 8) | ((x & 0x00ff00ff) << 8));
    return ((x >> 16) | (x << 16));
}

//	odwracanie 8 bitów
uint8_t reverseBits(uint8_t x)
{
    return ((x * 0x80200802ULL) & 0x0884422110ULL) * 0x0101010101ULL >> 32;
}

uint32_t metoda2(uint32_t rev)
{
    uint32_t byte0 = (rev & 0xFF);
    uint32_t byte1 = (rev & 0xFF00) >> 8;
    uint32_t byte2 = (rev & 0xFF0000) >> 16;
    uint32_t byte3 = (rev & 0xFF000000) >> 24;
    return (reverseBits(byte0) << 24) | (reverseBits(byte1) << 16) | (reverseBits(byte2) << 8) | (reverseBits(byte3));
}

//bruteforce
uint32_t metoda3(uint32_t x)
{
    unsigned int rev = x;
    int s = sizeof(x) * 32 - 1;

    for (x >>= 1; x; x >>= 1)
    {
        rev <<= 1;
        rev |= x & 1;
        s--;
    }
    rev <<= s;
    return rev;
}

int main(void)
{
    int i; 
    for (i=0;i<size;i++){
        //wypelnianie tablicy
        array[i] = genInt32();
    }
    double delta;
    clock_t start, end;


    //metoda 1

    start = clock();
    for (int i = 0; i < size; i++)
    {   
        //printf("%lu\n",array[i]); 
        sum1+=metoda1(array[i]);
    }

    end = clock();
    delta = ((double)(end - start) * 1000) / CLOCKS_PER_SEC;
    printf("1 metoda: %f ms\n", delta);

    //metoda 2

    start = clock();
    for (int i = 0; i < size; i++)
    {
        sum2+=metoda2(array[i]);
    }
    end = clock();
    delta = ((double)(end - start) * 1000) / CLOCKS_PER_SEC;
    printf("2 metoda:  %f ms\n", delta);

    //metoda 3

    start = clock();
    for (int i = 0; i < size; i++)
    {
        sum3+=metoda3(array[i]);
    }
    end = clock();
    delta = ((double)(end - start) * 1000) / CLOCKS_PER_SEC;
    printf("3. metoda: %f ms\n", delta);
    printf("%lu %lu %lu",sum1,sum2,sum3);
    return 0;
}
