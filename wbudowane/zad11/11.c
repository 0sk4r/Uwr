#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <inttypes.h>
#include <math.h>
#include <time.h>
#include <sys/time.h>
#include <stdio.h>
#include <string.h>

long long int MAX_FILE_SIZE = 300000000;

static const unsigned char BitsSetTable65536[65536] =
{
#   define B2(n)  n,      n+1,      n+1,      n+2
#   define B4(n)  B2(n),  B2(n+1),  B2(n+1),  B2(n+2)
#   define B6(n)  B4(n),  B4(n+1),  B4(n+1),  B4(n+2)
#   define B8(n)  B6(n),  B6(n+1),  B6(n+1),  B6(n+2)
#   define B10(n) B8(n),  B8(n+1),  B8(n+1),  B8(n+2)
#   define B12(n) B10(n), B10(n+1), B10(n+1), B10(n+2)
#   define B14(n) B12(n), B12(n+1), B12(n+1), B12(n+2)
           B14(0),B14(1), B14(1),   B14(2)
};

static const unsigned char BitsSetTable256[256] =
{
#   define B2(n) n,     n+1,     n+1,     n+2
#   define B4(n) B2(n), B2(n+1), B2(n+1), B2(n+2)
#   define B6(n) B4(n), B4(n+1), B4(n+1), B4(n+2)
            B6(0), B6(1), B6(1), B6(2)
};

const char *byte_to_binary(int x)
{
    static char b[9];
    b[0] = '\0';

    int z;
    for (z = 128; z > 0; z >>= 1)
    {
        strcat(b, ((x & z) == z) ? "1" : "0");
    }

    return b;
}


int main(void){
FILE *f;
char *buffer;
buffer = (char*) malloc (MAX_FILE_SIZE);
int n = 0;
long int sum1 = 0,sum2=0,sum3=0;
double elapsed;
clock_t start, end;

f = fopen("sample.bin", "rb");
//wczytywanie do tablicy
if (f)
{
    n = fread(buffer, sizeof(uint8_t), MAX_FILE_SIZE, f);
}
else
{
    printf("cos poszlo nie tak");
}

// METODA 1 ======================================================================================
printf("==================Metoda precalc 256======================\n");
start = clock();
for(int i=0;i<MAX_FILE_SIZE;i++){
    unsigned char y = buffer[i];
    unsigned int x = BitsSetTable256[y];
    sum1 += x;

}

    end = clock();
	elapsed = ((double) (end - start) * 1000) / CLOCKS_PER_SEC;
    printf("zapalonych bitow: %lu\n",sum1);
	printf("Sposob potrzebowal %f ms\n\n", elapsed);

// METODA 2 ======================================================================================
printf("==================Metoda precalc 65536======================\n");
start = clock();
for(int i=0;i<MAX_FILE_SIZE-1;i+=2){
    unsigned char x = 0;
    unsigned char y = 0;
    y = buffer[i+1];
    x = buffer[i];
    uint16_t w =    (x) << 8 | (y);

    sum2 += BitsSetTable65536[w];

}

end = clock();
elapsed = ((double) (end - start) * 1000) / CLOCKS_PER_SEC;
printf("zapalonych bitow %lu\n",sum2);
printf("Sposob potrzebowal %f ms\n\n", elapsed);

// METODA 3 ===========================================================================================
printf("==================Metoda masek======================\n");
start = clock();
for(int i=0;i<MAX_FILE_SIZE;i++){

    unsigned char int v = buffer[i]; // count the number of bits set in v
    unsigned int c; // c accumulates the total bits set in v
    //tobin(v);

    c = (v & 0b01010101) + ((v>>1) & 0b01010101);
    c = (c & 0b00110011) + ((c>>2) & 0b00110011);
    c = (c & 0b00001111) + ((c>>4) & 0b00001111);

    sum3 +=c;

}
    end = clock();
	elapsed = ((double) (end - start) * 1000) / CLOCKS_PER_SEC;
    printf("zapalonych bitow: %lu\n",sum3);
	printf("Sposob potrzebowal %f ms\n", elapsed);

    
	sum1 = sum1 + sum2 + sum3;
	printf("%lu",sum1);
return 0;
}
