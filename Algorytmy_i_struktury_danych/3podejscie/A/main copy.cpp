#include <iostream>
#include <vector>
#include <queue>
#include <stack>

using namespace std;

vector<pair<int, int>> edges[10001];
int next_ver[10001];
int visited[10001];
int waga[10001];

queue<int> droga;

int main()
{
    fill_n(visited, 10001, 0);

    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n, l, m, r;
    cin >> n;

    for (int i = 0; i < n; i++)
    {
        cin >> l >> m >> r;
        edges[r].push_back(make_pair(l, m));
    }

    stack<int> s;
    s.push(0);

    while (!s.empty())
    {
        int verticle = s.top();
        s.pop();

        for (long unsigned int i = 0; i < edges[verticle].size(); i++)
        {
            int next = edges[verticle][i].first;

            if (next == 0)
            {
                next_ver[next] = verticle;
                visited[next] = 1;
                waga[next] = edges[verticle][i].second;

                int dl = 0;
                int a = 0, b = waga[0], c = next_ver[0];
                while (c != 0)
                {
                    dl++;
                    a = c;
                    b = waga[c];
                    c = next_ver[c];
                }
                dl++;

                a = 0, b = waga[0], c = next_ver[0];
                cout << dl << endl;
                while (c != 0)
                {
                    cout << a << " " << b << " " << c << endl;
                    a = c;
                    b = waga[c];
                    c = next_ver[c];
                }
                cout << a << " " << b << " " << c << endl;
                return 0;
            }
            if (visited[next] == 0)
            {
                next_ver[next] = verticle;
                visited[next] = 1;
                waga[next] = edges[verticle][i].second;
                s.push(next);
            }
        }
    }

    cout << "BRAK" << endl;
    return 0;
}