//Oskar Sobczyk

#include <stdio.h>
#include <stdlib.h>

extern void insert_sort(long *first, long *last);

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, "Za mało argumentów\n");
        return -1;
    }
    long *arr;
    //long arr[100];
    int n = argc - 1;
    arr = malloc(n*sizeof(long));
    
    //wczytywanie do tablicy
    for (int i = 0; i < n; i++)
    {
        arr[i] = atol(argv[1 + i]);
    }

    insert_sort(arr, &arr[n - 1]);

    for (int i = 0; i < n; i++)
        printf("%ld\n", arr[i]);

    return 0;
}