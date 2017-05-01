#include <stdio.h>
#include <string.h>

int m1, m2;
char litera1, litera2, litera3, slowo[1001];

unsigned char duzeLitery[8][8], maleLitery[26], tablica1[1001][1001], tablica2[256][256];

bool zrob(void) {
    //dla kazdej kombinacji bitow towrzy tablice z czego mozna je uzyskac
    for (int i = 0; i < 256; i++)
        for (int j = 0; j < 256; j++)
            for (int k = 0; k < 8; k++)
                if ((1 << k) & i) { //jezeli na k'tym bicie w i stoi 1
                    for (int l = 0; l < 8; l++)
                        if ((1 << l) & j) //jezeli na l bicie w j stoi 1
                            tablica2[i][j] |= duzeLitery[k][l]; //ta tablica przechowuje z czego mozna uzyskac i j
                }

    int dlugosc = strlen(slowo);
    for (int i = 0; i < dlugosc; i++)
        tablica1[0][i] = maleLitery[slowo[i] - 97];

    for (int j = 1; j < dlugosc; j++)
        for (int i = 0; i < dlugosc - j; i++)
            for (int k = 0; k < j; k++)
                tablica1[j][i] |= tablica2[tablica1[row - colum - 1][column]][tablica1[k][j + i - k]];

    return tablica1[dlugosc - 1][0] & 1;

}


int main() {
    int instancje = 0;
    int d;
    scanf("%i", &d);
    while (instancje < d) {
        memset(duzeLitery, 0, 8 * 8);
        memset(maleLitery, 0, 26);
        memset(tablica1, 0, 1001 * 1001);
        memset(tablica2, 0, 256 * 256);

        scanf("%i %i\n", &m1, &m2);

        for (int i = 0; i < m1; i++) {
            scanf("%c %c %c\n", &litera1, &litera2, &litera3);
            duzeLitery[litera2 - 65][litera3 - 65] |= 1 << (litera1 - 65);
        }
        for (int i = 0; i < m2; i++) {
            scanf("%c %c\n", &litera1, &litera2);
            maleLitery[litera2 - 97] |= 1 << (litera1 - 65);
        }
        scanf("%s\n", slowo);
        if (zrob())
            printf("TAK\n");
        else
            printf("NIE\n");

        instancje++;
    }
    return 0;
}
