#include <iostream>
#include <string>

using namespace std;

int main()
{
    string s;
    string ans = "";
    cin >> s;
    int length = s.length();

    int iterator = 0;

    while (iterator < length)
    {
        int max_char = s[iterator];

        for (int i = iterator + 1; i < length; i++)
        {
            if (max_char < s[i])
                max_char = s[i];
        }

        int last_position = iterator;

        for (int i = last_position; i < length; i++)
        {
            if (max_char == s[i])
            {
                ans += s[i];
                last_position = i;
            }
        }

        iterator = last_position + 1;
    }

    cout << ans << endl;
}