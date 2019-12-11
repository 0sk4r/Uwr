#include <iostream>

using namespace std;

int main()
{

    long long n, m, ans = -1, ans_num = 0;
    long long flats[110], floors[110];

    cin >> n >> m;

    int x, y;

    for (int i = 0; i < m; i++)
    {

        cin >> flats[i] >> floors[i];
    }

    for (int i = 1; i <= 100; i++)
    {

        bool error = false;
        for (int j = 0; j < m; j++)
        {

            if (1 + (flats[j] - 1) / i != floors[j])
            {
                error = true;
                break;
            }
        }

        if (!error)
        {
            int x = ((n-1) / i) + 1;


            if (ans != -1 && ans != x)
            {
                cout << "-1";
                return 0;
            }
            else
            {
                ans = x;
            }
        }
    }

    cout << ans << endl;
}