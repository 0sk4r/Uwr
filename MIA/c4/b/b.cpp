#include <iostream>
#include <vector>

using namespace std;

int n, init[100010], goal[100010], visited[100010], changed_nodes_num = 0;
vector<int> graph[100010];
vector<int> changed_nodes;

void dfs(int verticle, int odd, int even, int level)
{
    visited[verticle] = 1;

    if (level % 2 == 0)
    {

        init[verticle] ^= (even % 2);
    }
    else
    {
        init[verticle] ^= (odd % 2);
    }
    // cout << "verticle: " << verticle << " init= " << init[verticle] << "goal: " << goal[verticle]; 

    if (init[verticle] != goal[verticle])
    {
        if (level % 2 == 0)
        {
            even += 1;
        }
        else
        {
            odd += 1;
        }

        // cout << "test" << endl;
        changed_nodes_num++;

        changed_nodes.push_back(verticle + 1);
    }

    level += 1;

    vector<int> next = graph[verticle];
    for (int i = 0; i < graph[verticle].size(); i++)
    {
        int ver = graph[verticle][i];
        // cout << ver;
        if (!visited[ver])
        {
            dfs(ver, odd, even, level);
        }
    }
}

int main()
{

    cin >> n;

    for (int i = 0; i < n - 1; i++)
    {
        int x, y;
        cin >> x >> y;

        graph[x - 1].push_back(y - 1);
        graph[y - 1].push_back(x - 1);
    }

    for (int i = 0; i < n; i++)
    {
        cin >> init[i];
    }

    for (int i = 0; i < n; i++)
    {
        cin >> goal[i];
    }

    dfs(0, 0, 0, 0);

    cout << changed_nodes_num << endl;
    for (int i = 0; i < changed_nodes.size(); i++)
    {
        cout << changed_nodes[i] << endl;
    }
}
