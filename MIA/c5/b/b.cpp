#include <iostream>

using namespace std;

int tab[(1 << 17) * 2 + 100];

int main()
{

    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    int n, m, tmp;

    cin >> n >> m;

    n = 1 << n;

    for (int i = 0; i < n; i++)
    {
        cin >> tmp;

        int num = i + n;
        tab[num] = tmp;
        bool operation = true;
        while (num)
        {
            num = num / 2;
            if (operation)
            {
                tab[num] = tab[num * 2] | tab[num * 2 + 1];
                operation = false;
            }
            else
            {
                tab[num] = tab[num * 2] ^ tab[num * 2 + 1];
                operation = true;
            }
        }
    }

    while (m)
    {
        int p, b;
        cin >> p >> b;

        int num = p + n - 1;
        tab[num] = b;
        bool operation = true;

        while (num)
        {
            num = num / 2;
            if (operation)
            {
                tab[num] = tab[num * 2] | tab[num * 2 + 1];
                operation = false;
            }
            else
            {
                tab[num] = tab[num * 2] ^ tab[num * 2 + 1];
                operation = true;
            }
        }

        m--;
        cout << tab[1] << endl;
    }
}