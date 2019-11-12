#include <iostream>
#include <vector>

using namespace std;

int n;
vector<int> sons[1000];
int deg[1000];

int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    cin >> n;

    for(int i=1; i<n; i++){
        int tmp;
        cin >> tmp;
        tmp--;
        sons[tmp].push_back(i);
        deg[tmp]++;
    }

    for(int i=0; i<n; i++){
        int ans = 0;
        for(int j=0; j<sons[i].size(); j++){
            if(deg[sons[i][j]] == 0){
                ans++;
            }
        }
        if(ans < 3 && deg[i] != 0) {
            cout << "NO";
            return 0;
        }
    }

    cout << "YES";
    return 0;
}