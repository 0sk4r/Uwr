#include <stdio.h>
#include <stdlib.h>
unsigned long Row[30];
unsigned long init32(){

    unsigned long init32;
    srand(time(NULL));
    init32 = ((double)rand()/RAND_MAX)*0xFFFFFFFF;
    return init32;
}

void displayBinary(unsigned long array[], int x){

    unsigned long MASK = 0x80000000;
    do {
        printf("%c", (array[x] & MASK) ?'X':0x20);
    }while ((MASK >>=1) != 0);
}

int main(void){

    int i, j;

    for (i=0;i<30;i++){
        Row[i] = init32();
    }//populate array

    for (j=0;j<30;j++){
        displayBinary(Row, j);
        printf("\n");
    }//display array contents
}
