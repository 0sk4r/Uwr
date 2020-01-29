#include <iostream>
#include <string>
#include <set>
#include <algorithm>
using namespace std;

set<string> ans;

void foo(string s)
{

    string tmp = s, x = s;
    for (int y = 0; y < 4; y++)
    {
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                swap(tmp[0], tmp[1]);
                swap(tmp[1], tmp[2]);
                swap(tmp[2], tmp[3]);
                x = min(x, tmp);
            }

            swap(tmp[4], tmp[0]);
            swap(tmp[0], tmp[5]);
            swap(tmp[5], tmp[2]);
        }
        swap(tmp[0], tmp[1]);
        swap(tmp[1], tmp[2]);
        swap(tmp[2], tmp[3]);
    }

    ans.insert(x);
}
int main()
{

    string s;

    cin >> s;
    sort(s.begin(), s.end());

    foo(s);
    while (next_permutation(s.begin(), s.end()))
    {
        foo(s);
    }
    cout << ans.size() << endl;
}