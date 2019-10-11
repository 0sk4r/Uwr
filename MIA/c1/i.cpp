#include <iostream>

using namespace std;

int n, a, b;
long long tab[1000000];
long long ans[1000000];
long long x = INT_MIN;
int main()
{
    cin >> n;
    cin >> a;
    cin >> b;
    cin >> tab[0];
    ans[0] = tab[0]*a;
    for(int i = 1; i<n; i++){
        // cin >> tab[i];
        scanf("%lld", &tab[i]);
        ans[i] = max(ans[i-1]+ a*tab[i], tab[i]*a);
        x = max(ans[i], x);
    }
    // ans[0] = tab[0]*a;

    // for(int i=1; i<n; i++){
    //     ans[i] = max(ans[i-1]+ a*tab[i], tab[i]*a);
    //     x = max(ans[i], x);
    // }
    x+=b;
    cout << x;

}