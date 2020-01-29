#include <iostream>
#include <bit>

using namespace std;

int main(){

    int player, others[1010];
    int n,m,k,ans=0;
    cin >> n >> m >> k;

    for(int i=0; i<m; i++){
        cin >> others[i];
    }

    cin >> player;

    for(int i=0; i<m;i++){
        int x = others[i] ^ player;

        int diff = __builtin_popcount(x);

        if(diff <= k) ans++;
    }

    cout << ans << endl;


}