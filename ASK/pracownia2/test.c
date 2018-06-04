#include "stdio.h"

void heapify_help(int *src, int *dst, int start, int end, int i) {

    if(start>end) return;

    int middle = (end+start)/2;
    printf("middle[%d]=%d \n",middle,src[middle]);
    dst[i] = src[middle];

    heapify_help(src, dst, start, middle - 1, 2*i+1);
    heapify_help(src, dst, middle + 1, end, 2*i+2);


}

int main(){

    int src[7] = {0,0,2,5,6,7,7};
    int dst[7];
    int n = sizeof(src)/sizeof(src[0]);

    heapify_help(src,dst,0,n-1,0);

    for(int i = 0; i<n; i++){
        printf("%d ", dst[i]);
    }
    
    printf("\n");
}


