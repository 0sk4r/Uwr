#include "stdio.h"

int main(){
	int a,b,t,i;

	scanf("%d %d", &a, &b);

	if(b<a){
		t=a;
		a=b;
		b=t;
	}

	for(i=a; i<=b; i++){
		printf("%d\n", i);
	}
	
}
