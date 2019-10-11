#include <iostream>

using namespace std;

int n, tab[1000], ans = 0;

int main()
{
    cin >> n;

    for (int i = 0; i < n; i++)
    {
        cin >> tab[i];
    }

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < i; j++)
        {
            if (tab[j] > tab[i])
                ans++;
        }
    }

    cout << ans;
}