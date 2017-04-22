#include "stdio.h"
#include <list>
#include <string>

using namespace std;
int main() {

    int instancje, terminale, nieterminale;
    char litery[26];
    char produkcje[8][8];

    char buffer[1002];
    char tablica[1002][1002];
    char a,b,c;

    for (int i = 0; i < 8;i++){
        for(int j = 0; j < 8; j++){
            produkcje[i][j]='X';
        }
    }

    scanf("%d\n",&instancje);

    scanf("%d %d\n",&nieterminale, &terminale);

    for(int i = 0; i < nieterminale; i++){
        
        scanf(" %c %c %c",&a,&b,&c);
        produkcje[b-65][c-65] = a;
    }

    for(int i = 0; i<terminale; i++){
        scanf(" %c %c",&a,&b);
        litery[b-97] = a;
    }
    scanf("%s", buffer);
    int len = strlen(buffer);

    strncpy(tablica[0], buffer, len);


    for(int l = 0; l < len; l++)
    {
        tablica[1][l] = litery[tablica[0][l]-97];
        printf("%c\n",tablica[1][l]);
    }

    for (unsigned row = 2; row < len; ++row){ // for each length

        for (unsigned column = 0; column < len - row; ++column) { // for each start
            // the string we're considering

            for (unsigned t = 0; t < row; ++t) { // for each split-point
                // what generates the two halves of this split?

                char lhs = tablica[column][column + t];
                char rhs = tablica[column + t + 1][column + row];
                printf("lhs = %c rhs = %c\n", lhs, rhs);
                char znak = produkcje[lhs - 65][rhs - 65];
                if(znak != 'X') {tablica[row][column] = znak;}
            }
        }
    }

    printf("%c", tablica[len][0]);
}
