#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

vector<long long> a, b;
int main()
{
    long long n, m, suma = 0, sumb = 0;

    cin >> m >> n;
    long long tmp;
    for (long long i = 0; i < m; i++)
    {
        cin >> tmp;
        a.push_back(tmp);
    }

    for (long long i = 0; i < n; i++)
    {
        cin >> tmp;
        b.push_back(tmp);
    }

    for (long long i = 0; i < m; i++)
    {
        suma += a[i];
    }

    for (long long i = 0; i < n; i++)
    {
        sumb += b[i];
    }

    sort(a.begin(), a.end());
    sort(b.begin(), b.end());
    long long ans1 = sumb, ans2 = suma;

    for (long long i = 0; i < m - 1; i++)
    {
        ans1 += min(a[i], sumb);
    }

    for (long long i = 0; i < n - 1; i++)
    {
        ans2 += min(b[i], suma);
    }

    cout << min(ans1, ans2) << endl;
}