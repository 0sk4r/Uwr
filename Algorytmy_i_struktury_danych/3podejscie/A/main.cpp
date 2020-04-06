#include <iostream>
#include <vector>
#include <queue>
#include <stack>

using namespace std;

vector<pair<int, int>> edges[10001];
pair<int, int> visited[10001];
queue<int> droga;

int main()
{
    fill_n(visited, 10001, make_pair(-1, -1));

    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n, l, m, r;
    cin >> n;

    for (int i = 0; i < n; i++)
    {
        cin >> l >> m >> r;
        edges[r].push_back(make_pair(m, l));
    }

    stack<int> s;
    s.push(0);

    while (!s.empty())
    {
        int verticle = s.top();
        s.pop();

        for (int i = 0; i < edges[verticle].size(); i++)
        {
            int next = edges[verticle][i].second;

            if (next == 0)
            {
                visited[next] = make_pair(edges[verticle][i].first, verticle);

                int dl = 0;
                int a = 0, b = visited[0].first, c = visited[0].second;
                while (c != 0)
                {
                    dl++;
                    a = c;
                    b = visited[c].first;
                    c = visited[c].second;
                }
                dl++;

                a = 0, b = visited[0].first, c = visited[0].second;
                cout << dl << endl;
                while (c != 0)
                {
                    cout << a << " " << b << " " << c << endl;
                    a = c;
                    b = visited[c].first;
                    c = visited[c].second;
                }
                cout << a << " " << b << " " << c << endl;
                return 0;
            }
            if (visited[next].first == -1)
            {
                visited[next] = make_pair(edges[verticle][i].first, verticle);
                s.push(next);
            }
        }
    }

    cout << "BRAK" << endl;
    return 0;
}