#include <iostream>
#include <set>

using namespace std;
int n, ans = 0;

void foo(int x)
{   
    if (x > 0 && x <= n)
        ans++;

    if (x > n)
        return;

    for (int i = 0; i <= 9; i++)
    {
        int tmp = x * 10 + i;
        int tmp_cp = tmp;

        set<int> digits;
        while (tmp)
        {
            digits.insert(tmp % 10);
            tmp /= 10;
        }

        if (digits.size() <= 2 && tmp_cp > 0)
        {
            foo(tmp_cp);
        }
    }
}
int main()
{
    cin >> n;

    if (n < 100)
    {
        cout << n;
        return 0;
    }
    foo(0);
    cout << ans << endl;
}