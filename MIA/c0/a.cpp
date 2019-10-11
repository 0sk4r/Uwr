#include <iostream>
#include <cmath>
using namespace std;
 
int tab[10010];
int queries[101];
int q, n, tmp1, tmp2 = 0, sum = 0;
 
int main(){
    cin >> q;
    for(int i = 0; i < q; i++){
        cin >> n;
        queries[i] = n;
        tmp1 = tmp2;
        for(int j = 0; j < n; j++){
            cin >> tab[j + tmp1];
            tmp2++;
        }
    }
    tmp1 = tmp2 = 0;
    for(int i = 0; i < q; i++){
        sum = 0;
        tmp1 = tmp2;
        for(int j = 0; j < queries[i]; j++){
            sum += tab[j + tmp1];
            tmp2++;
        }
        cout << ceil((long double)sum / queries[i]) << endl;
    }
}