#include <iostream>
#include <vector>

using namespace std;
vector<long long> edges[100010];
int cats[100010];
long long n, m;
long long ans = 0;
void dfs(int ver, int maxcat, int last)
{
    if (maxcat > m)
        return;
    bool leaf = true;
    for (int i = 0; i < edges[ver].size(); i++)
    {   
        if(last != edges[ver][i]){
        // cout << "ver: " << ver << "\n";
        // cout << edges[ver][i] << "\n";
        // cout << edges[ver].size() << "\n";
        leaf = false;
        dfs(edges[ver][i], maxcat * cats[edges[ver][i]] + cats[edges[ver][i]], ver);
        }
    }
    if (leaf)
    {
        ans++;
    }
}
int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    cin >> n >> m;

    for (int i = 0; i < n; i++)
    {
        cin >> cats[i];
    }

    for (int i = 1; i < n; i++)
    {
        int x, y;
        cin >> x >> y;
        edges[x - 1].push_back(y - 1);
    }

    dfs(0, cats[0], -1);

    cout << ans;
}