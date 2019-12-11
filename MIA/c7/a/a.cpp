#include <iostream>

using namespace std;

int main()
{
    long long zero = 0, one = 0, n = 0;

    cin >> n;
    for (int i = 0; i < n; i++)
    {
        char tmp;
        cin >> tmp;
        if (tmp == '0')
        {
            zero++;
        }
        else
            one++;
    }

    cout << abs(one - zero) << endl;
}