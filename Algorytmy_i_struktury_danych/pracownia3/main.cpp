#include <stdio.h>
#include "string.h"


void cyk() {

    int terminale, nieterminale;
    int litery[26][8];
    int produkcje[8][8];

    char buffer[1005];
    int kombinacje[256][256]; //tablica wszystkich mozliwych kombinacji 8 bitow
    int tablica[1005][1005];
    char a, b, c;


    //zerowanie tablic
    memset(produkcje, 0, sizeof(produkcje));
    memset(litery, 0, sizeof(litery));
    memset(tablica, 0, sizeof(tablica));
    memset(kombinacje,0,sizeof(kombinacje));

    scanf("%d %d\n", &nieterminale, &terminale);

    //wczytanie gramatyki
    for (int i = 0; i < nieterminale; i++) {

        scanf(" %c %c %c", &a, &b, &c);
        produkcje[b - 65][c - 65] = produkcje[b - 65][c - 65] | 1 << (a - 65);
    }

    //tworzenie kombinacji wszystkich bitow
    for(int x = 0; x<256; x++){
        for(int y = 0; y < 256; y++){
            for(int lewa = 0; lewa < 8; lewa++){
                for(int prawa = 0; prawa < 8; prawa++){
                    if(((1 << lewa) & x) && ((1 << prawa) & y)){
                        kombinacje[x][y] = kombinacje[x][y] | produkcje[lewa][prawa];
                    }
                }

            }
        }
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
        for(int x = 0; x<8; x++) {
            if (litery[litera - 97][x] == 1) {
                tablica[1][l] |= 1 << x;
            }
        }
    }

    for (int row = 2; row <= len; ++row) {

        for (int column = 0; column < len - row + 1; ++column) {


            for (int t = 0; t < row - 1; ++t) {
                int lewaLitera = tablica[t + 1][column];
                int prawaLitera = tablica[row - 1 - t][column + 1 + t];

                tablica[row][column] = tablica[row][column] | kombinacje[lewaLitera][prawaLitera];


            }
        }

    }

    if(tablica[len][0] & 1) printf("TAK\n");
    else printf("NIE\n");

}


int main() {

    int instancje;

    scanf("%d\n", &instancje);

    for (int i = 0; i < instancje; i++) {
        cyk();
    }
}