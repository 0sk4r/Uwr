#include <vector>
#include <set>
#include <iostream>

using namespace std;
string s;
long long q, l, r, type, pos, ans;
char c;

vector<set<int>> characters(26);

int main()
{
    iostream::sync_with_stdio(false);
    cin.tie(0);
    cin >> s;

    for (int i = 0; i < s.size(); i++)
    {
        characters[s[i] - 'a'].insert(i);
    }

    cin >> q;
    while (q--)
    {
        cin >> type;

        if (type == 1)
        {
            cin >> pos >> c;
            pos -= 1;
            characters[s[pos] - 'a'].erase(pos);
            s[pos] = c;
            characters[s[pos] - 'a'].insert(pos);
        }
        else
        {
            cin >> l >> r;
            l -= 1;
            r -= 1;

            ans = 0;

            for (int i = 0; i < 26; i++)
            {
                if (characters[i].lower_bound(l) != characters[i].upper_bound(r))
                    ans++;
            }

            cout << ans << "\n";
        }
    }
}