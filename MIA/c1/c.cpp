#include <iostream>

using namespace std;

int t;
unsigned long long n, k, modulo, ans=1;

long long mult1(long long a, long long b, long long modulo1) {
    long long res = 0; 
    while(b>0){
        if(b%2 == 1){
            res = (res + a) % modulo1;
        }
        a = (a * 2) % modulo1;
        b = b/2;
    }

    return res % modulo1;
}
int main(){

    cin >> t;

    while(t--) {
        ans=1;
        cin >> k;
        cin >> n;
        cin >> modulo;
        n = n % modulo;
        while(k>0) {
            if (k%2 == 0) {
                // n = ((n % modulo) * (n % modulo)) % modulo;
                n = mult1(n, n, modulo);
                k = k/2;
            }
            else {
                // ans = ((ans % modulo) * (n % modulo)) % modulo;
                ans = mult1(ans, n, modulo);
                k = k/2;
                // n = ((n % modulo) * (n % modulo)) % modulo;
                n = mult1(n, n, modulo);
            }
        }

        cout << ans << "\n";

    }
}