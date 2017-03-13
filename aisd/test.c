#include <stdio.h>

int main(){
    int a;
    int b;
    scanf("%i %i",&a,&b);
    if(b<a){
        int t = a;
        a=b;
        b=t;
    }

    for(int i=a;i<=b;i++)
    {
        printf("%d\n",i);
    }

}