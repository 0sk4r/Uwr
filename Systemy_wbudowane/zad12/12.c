#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

#define iteration 10000000

void metoda1(char a[], int size){
    int n = size - 1;
    int count = n;

        for (int i = n; i >= 0; i--)
        {
            if (a[i] != ' ')
                a[count--] = a[i];
        }

        while (count >= 0)
        {
            a[count--] = ' ';
        }

        printf("%s\n",a);
}

void metoda2(char b[], int size){
    int space = 0;
    int n = size - 1;
      for (int i = 0; i <= n; i++)
        {
            if (b[i] == ' ')
            {
                for (int j = i - 1; j >= 0; j--)
                {
                    b[j + 1] = b[j];
                }
                i++;
                space++;
            }
        }
        for (int i = 0; i < space; i++)
        {
            b[i] = ' ';
        }
        printf("%s\n",b);
}

int main()
{
    double delta;
    clock_t start, end;
    long int sum = 0;

    // metoda 1 O(N) ================================================================
    printf("=====================Metoda 1 ==========================\n");
    start = clock();
    for (int x = 0; x < iteration; x++)
    {

        char a[] = "Ala ma kota";
        int n = sizeof(a) - 1;
        int count = n;

        for (int i = n; i >= 0; i--)
        {
            if (a[i] != ' ')
                a[count--] = a[i];
        }

        while (count >= 0)
        {
            a[count--] = ' ';
        }

        sum += sizeof(a[2]);
    }
    end = clock();
    delta = ((double)(end - start) * 1000) / CLOCKS_PER_SEC;
    printf("Metoda: %f ms\n", delta);

    // metoda 2 O(N*N)=================================================================
    printf("===================== Metoda 2 ==========================\n");
    start = clock();

    for (int x = 0; x < iteration; x++)
    {

        char b[] = "Ala ma kota";
        int n = sizeof(b) - 1;
        int space = 0;

        for (int i = 0; i <= n; i++)
        {
            if (b[i] == ' ')
            {
                for (int j = i - 1; j >= 0; j--)
                {
                    b[j + 1] = b[j];
                }
                i++;
                space++;
            }
        }
        for (int i = 0; i < space; i++)
        {
            b[i] = ' ';
        }
        sum += sizeof(b);
    }
    end = clock();
    delta = ((double)(end - start) * 1000) / CLOCKS_PER_SEC;
    printf("Metoda: %f ms\n", delta);
    printf("%lu\n", sum);
    char napis[] = "ala ma kota";
    metoda1(napis,sizeof(napis));
    metoda2(napis,sizeof(napis));
}
