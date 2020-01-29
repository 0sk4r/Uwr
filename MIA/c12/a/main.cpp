#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int n, m, q;
int v1, v2, c;

int edge[110][110];
// int color[110][110];
vector<int> color[110][110];

int visited[110];

bool dfs(int start, int end, int col)
{

    if (start == end)
        return true;

    if (visited[start] == 1)
        return false;
    visited[start] = 1;

    // cout << "start: " << start << " end: " << end << " color: " << col << endl;
    for (int i = 0; i < n; i++)
    {
        // cout << "edge" << i << ": " << edge[start][i] << endl;

        if (edge[start][i] == 1 && count(color[start][i].begin(), color[start][i].end(), col))
        {
            // cout << "ok" << endl;
            if (dfs(i, end, col))
                return true;
        }
    }

    return false;
}
int main()
{
    cin >> n >> m;

    for (int i = 0; i < m; i++)
    {
        cin >> v1 >> v2 >> c;
        v1 -= 1;
        v2 -= 1;
        c -= 1;
        edge[v1][v2] = 1;
        edge[v2][v1] = 1;

        color[v1][v2].push_back(c);
        color[v2][v1].push_back(c);
        // color[v1][v2] = 1;
        // color[v2][v1] = 1;
    }

    cin >> q;

    for (int i = 0; i < q; i++)
    {
        int u, v;
        cin >> u >> v;
        u -= 1;
        v -= 1;
        // cout << u << v << endl;
        int ans = 0;

        for (int col = 0; col < 100; col++)
        {
            for (int j = 0; j < n; j++)
                visited[j] = 0;

            if (dfs(u, v, col))
                ans++;
        }
        cout << ans << endl;
        // cout << "======================\n";
    }
}