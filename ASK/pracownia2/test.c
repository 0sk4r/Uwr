#include "stdio.h"
void heapify(int *dst, int *src, int n) {
  /* XXX: Fill in this procedure! */
  for(int i = 0; i<n; i++){
    dst[i] = src[i];
  }

  for(int i = 1; i < n; i++){
    if (dst[i] > dst[(i - 1)/2]){
      int j = i;

      while(dst[j] > dst[(j-1/2)]){
        int tmp = dst[j];
        dst[j] = dst[(j-1)/2];
        dst[(j-1)/2] = tmp;
        j = (j-1)/2; 
      }
    }
  }
}

int main(){

    int arr[] = {1,2,3,4,5};

    int heap[5];

    heapify(arr,heap,5);

    for(int j=0; j<5;j++){
        printf("%d ", heap[j]);
    }

}

