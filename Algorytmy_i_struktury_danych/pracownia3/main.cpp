#include "stdio.h"
#include "cstring"

using namespace std;

int  terminale, nieterminale;
int litery[26][8];
char produkcje[8][8];

char buffer[1002];
char tablica[1002][1002][8];
char a,b,c;

void check() {



    for (int i = 0; i < 8;i++){
        for(int j = 0; j < 8; j++){
            produkcje[i][j]='X';
        }
    }

    for (int i = 0; i < 26;i++){
        for(int j = 0; j < 8; j++){
            litery[i][j]=0;
        }
    }
    scanf("%d %d\n",&nieterminale, &terminale);

    for(int i = 0; i < nieterminale; i++){

        scanf(" %c %c %c",&a,&b,&c);
        produkcje[b-65][c-65] = a;
    }

    for(int i = 0; i<terminale; i++){
        scanf(" %c %c",&a,&b);
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


    for (unsigned row = 2; row <= len; ++row){

        for (unsigned column = 0; column < len - row + 1; ++column) {
            printf("row = %d column = %d\n",row,column);

            for (unsigned t = 0; t < row - 1; ++t) {

                for(int x = 0; x < 8; x++) {
                    for(int y = 0; y<8; y++) {
                        char lhs = tablica[t + 1][column][x];
                        char rhs = tablica[row - 1 - t][column + 1 + t][y];
                        if (lhs == 1 && rhs == 1) {
                            //printf("lhs = %c rhs = %c\n", lhs+65, rhs+65);
                            char znak = produkcje[x][y];
                            //printf("%c\n", znak);
                            if (znak != 'X') tablica[row][column][znak-65] = 1;
                        }
                    }
                }
                }

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
