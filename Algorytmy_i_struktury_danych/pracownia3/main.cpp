#include "stdio.h"
#include "cstring"

using namespace std;


void check() {

    int  terminale, nieterminale;
    int litery[26][8];
    char produkcje[8][8][8];

    char buffer[1002];
    char tablica[1002][1002][8];
    char a,b,c;


    for (int i = 0; i < 1002;i++){
        for(int j = 0; j < 1002; j++){
            for(int x = 0; x<8 ;x++){
                tablica[i][j][x] = 0;
            }
        }
    }
    //A TU SIE TABLICA ZERUJE
    for (int i = 0; i < 8;i++){
        for(int j = 0; j < 8; j++) {
            for (int x = 8; x < 8; x++) {
                produkcje[i][j][x] = 0;
            }
        }
    }

    for (int i = 0; i < 26;i++){
        for(int j = 0; j < 8; j++){
            litery[i][j]=0;
        }
    }
    scanf("%d %d\n",&nieterminale, &terminale);


    //TU SIE WCZYTUJA!!!!!!!!!!!
    for(int i = 0; i < nieterminale; i++){

        scanf(" %c %c %c",&a,&b,&c);
        //printf("%c %c %c",a,b,c);
        produkcje[b-65][c-65][a-65] = 1;
    }

    for(int i = 0; i<terminale; i++){
        scanf(" %c %c",&a,&b);
        //printf(" %c %c",a,b);
        litery[b-97][a - 65] = 1;
    }
    scanf("%s", buffer);
    int len = (int) strlen(buffer);

    for(int l = 0; l < len; l++)
    {
        char litera = buffer[l];
        //printf("%c: ",litera);
        for(int x = 0; x<8; x++) {
            if (litery[litera - 97][x] == 1) {
                // printf("%c", x + 65);
                tablica[1][l][x] = 1;
            }
        }
        // printf("\n");
    }

    //A TU WYPISUJA
    for(int x = 0; x <8; x++){
        for(int y = 0; y<8; y++){
            for(int z = 0; z<8;z++){
            if(produkcje[y][z][x] == 1) printf("%c --> %c %c\n",x+65,y+65,z+65);
            }
        }
    }
//GDZIES WCZESNIEJ SIE PSUJE ============================================================================================
    for (unsigned row = 2; row <= 2; ++row) {

        for (unsigned column = 0; column < len - row + 1; ++column) {
            printf("row = %d column = %d ",row,column);

            for (unsigned t = 0; t < row - 1; ++t) {

                for(int x = 0; x < 8; x++) {
                        for(int y = 0; y<8; y++) {
                        char lhs = tablica[t + 1][column][x];
                        char rhs = tablica[row - 1 - t][column + 1 + t][y];
                        if (lhs == 1 && rhs == 1) {
                            for(int z=0; z<8; z++) {
                                printf("lhs = %c rhs = %c\n", x+65, y+65);
                                //produkcje X Y <-- Z
                                int znak = produkcje[x][y][z];
                                //printf("%c\n", znak);
                                if (znak == 1){
                                    tablica[row][column][z] = 1;
                                    printf("%c",z+65);
                                }

                            }
                        }
                    }
                }

            }

            for(int z = 0; z<8; z++){
                if(tablica[row][column][z] ==1){
                    printf("%c",z+65);
                }
            }

            printf("\n");
                //printf("%d %d , %d %d \n", t + 1, column, row - 1 - t, column + 1 + t);

        }

    }
    //printf("test %d", tablica[len][0][0]);
    if(tablica[len][0][0] == 1)
    {
        printf("TAK\n");
    }
    else
        printf("NIE\n");
    // printf("==============================================");
}

int main() {

    int instancje;

    scanf("%d\n", &instancje);

    for(int i=0;i< instancje; i++){
        check();
    }
}
