#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <math.h>
#include <time.h>
#include <sys/time.h>

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
    uint32_t toRev = 1234567890;

    printf("Liczba: %d\n", toRev);

    int iteracji = 100000000;
    double elapsed;
    clock_t start, end;


    //metoda 1

    start = clock();
    for (int i = 0; i < iteracji; i++)
    {
        metoda1(toRev);
    }
    end = clock();
    elapsed = ((double)(end - start) * 1000) / CLOCKS_PER_SEC;
    printf("1 metoda: %f ms\n", elapsed);

    //metoda 2

    start = clock();
    for (int i = 0; i < iteracji; i++)
    {
        metoda2(toRev);
    }
    end = clock();
    elapsed = ((double)(end - start) * 1000) / CLOCKS_PER_SEC;
    printf("2 metoda:  %f ms\n", elapsed);

    //metoda 3

    start = clock();
    for (int i = 0; i < iteracji; i++)
    {
        metoda3(toRev);
    }
    end = clock();
    elapsed = ((double)(end - start) * 1000) / CLOCKS_PER_SEC;
    printf("3. metoda: %f ms\n", elapsed);

    printf("%d\n", metoda1(toRev));
    printf("%d\n", metoda2(toRev));
    printf("%d\n", metoda3(toRev));

    return 0;
}
