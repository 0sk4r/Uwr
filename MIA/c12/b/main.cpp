#include <iostream>
#include <vector>
#include <climits>
#include <queue>
#include <iomanip>

using namespace std;

vector<int> roads[105];
int dist[105], visited[105];
long long sp_count[105];
int min_dist;
float road_num;
void shortpath(int node)
{
    // cout << node << endl;
    queue<int> q;
    for (int i = 0; i < 105; i++)
    {
        dist[i] = 10000;
        visited[i] = 0;
        sp_count[i] = 0;
    }
    // memset(dist, 200, 102);
    // memset(visited, 0, 102);
    // memset(sp_count, 0, 102);

    visited[node] = 1;
    dist[node] = 0;
    sp_count[node] = 1;

    q.push(node);

    while (!q.empty())
    {
        int v = q.front();
        visited[v] = 1;
        for (int i = 0; i < roads[v].size(); i++)
        {
            if (!visited[roads[v][i]])
            {

                if (dist[roads[v][i]] > dist[v] + 1)
                {
                    dist[roads[v][i]] = dist[v] + 1;
                    q.push(roads[v][i]);
                    sp_count[roads[v][i]] = sp_count[v];
                }
                else if (dist[roads[v][i]] == dist[v] + 1)
                {
                    sp_count[roads[v][i]] += sp_count[v];
                }
            }
        }
        q.pop();
    }
}
int main()
{

    // memset(dist, INT_MAX, 102);

    int n, m;

    cin >> n >> m;

    int v, u;
    for (int i = 0; i < m; i++)
    {
        cin >> v >> u;

        roads[v].push_back(u);
        roads[u].push_back(v);
    }

    shortpath(1);
    min_dist = dist[n];
    road_num = sp_count[n];
    double ans = 1.0;
    for (int i = 2; i < n; i++)
    {
        shortpath(i);
        if (dist[1] + dist[n] == min_dist)
        {
            ans = max(ans, 2.0 * sp_count[1] * sp_count[n] / road_num);
        }
    }
    cout.setf(ios::fixed);

    cout << fixed << setprecision(16) << ans << endl;
}