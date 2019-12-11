#include <iostream>

using namespace std;


int main(){

    long long n,m;

    cin >> n >> m;

    long long div = n/m;
    long long x = n - m*div;

    for(int i=0; i<m; i++){
        if(x-- > 0){
            cout << div+1 << " ";
        }
        else {
            cout << div << " ";
        }
    }

}