#include <iostream>

using namespace std;

int n,k;
string wall[2];
int visited[2][100060];
bool dfs(int x,int y,int waterlevel) {
    // printf("x=%d y=%d water=%d\n", x, y, waterlevel);
    if(y >= n) return true;
    // cout << y << endl;
    if(y < waterlevel || visited[x][y] == 1 || wall[x][y] == 'X'){
        // printf("false\n");
        return false;
    }

    visited[x][y] = 1;

    bool ans =  dfs((x+1) % 2,y+k, waterlevel+1) || dfs(x,y+1, waterlevel+1) || dfs(x,y-1, waterlevel+1);
    // if (!ans) visited[x][y] = 0;
    return ans;
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    cin  >> n >> k;
    cin >> wall[0];
    cin >> wall[1];

    if(dfs(0,0,0)){
        cout << "YES";
    } else {
        cout << "NO";
    }
    return 0;
}