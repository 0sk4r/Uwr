#include <iostream>
#include <algorithm>

using namespace std;

long long n, m, k, p[5005], tab[5005][5005];
int main()
{

    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    cin >> n >> m >> k;

    for (int i = 1; i <= n; i++)
    {
        cin >> p[i];
        p[i] += p[i - 1];
    }

    for (int i = 1; i <= k; i++)
    {
        for (int j = m; j <= n; j++)
        {
            tab[i][j] = max(tab[i][j - 1], tab[i - 1][j - m] + p[j] - p[j - m]);
        }
    }

    cout << tab[k][n];
}