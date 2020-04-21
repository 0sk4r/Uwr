#include <iostream>
#include <vector>
#include <climits>
#include <cstring>
#include <algorithm>

using namespace std;

int main()
{

    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    // long long tab[1000010];
    // int solutions[1000010];
    int ans_max[110] = {0}, ans_min[110] = {0};

    // memset(tab, 0, sizeof(tab));
    // memset(ans_max, 0, sizeof(ans_max));
    // memset(ans_min, 0, sizeof(ans_min));

    vector<pair<int, int>> monets;
    long long total_mass, num_monets;

    cin >> total_mass;

    cin >> num_monets;

    // for (long i = 0; i <= total_mass; i++)
    // {
    //     tab[i] = 0;
    //     ans_max[i] = 0;
    //     ans_min[i] = 0;
    // }
    int value, mass;

    for (long i = 0; i < num_monets; i++)
    {
        cin >> value >> mass;
        monets.push_back(make_pair(value, mass));
    }

    sort(monets.begin(), monets.end(), [](pair<int, int> a, pair<int, int> b) {
        if (a.first < b.first)
        {
            return true;
        }
        else if (a.first > b.first)
        {
            return false;
        }
        return a.second < b.second;
    });

    // for (int i = 1; i < (monets.size() - 1); i++)
    // {
    //     if (monets[i - 1].first == monets[i].first && monets[i + 1].first == monets[i].first)
    //     {
    //         monets.erase(monets.begin() + i);
    //     }
    // }

    // cout << endl;
    // for(int i=0; i < monets.size(); i++){

    //     cout << monets[i].first << " " << monets[i].second << endl;
    // }

    int weight_max = total_mass;
    int val_max = 0;
    int val_min = 0;
    int i = 0;
    while (weight_max > 0 && i < monets.size())
    {
        pair<int, int> monet = monets[i];

        if (weight_max >= monet.second)
        {
            ans_max[i] += 1;
            weight_max -= monet.second;
            val_max += monet.first;
        }
        else
        {
            i++;
        }
    }

    int weight_min = total_mass;
    i = monets.size() - 1;
    while (weight_min > 0 && i >= 0)
    {
        pair<int, int> monet = monets[i];
        // cout << i << endl;
        if (weight_min >= monet.second)
        {
            ans_min[i] += 1;
            weight_min -= monet.second;
            val_min += monet.first;
        }
        else
        {
            i--;
        }
    }

    if(weight_max == 0 && weight_min ==0){

        cout << "TAK" << endl;
        cout << val_min << endl;
        for (int j = 0; j < num_monets; j++)
        {
            cout << ans_min[j] << " ";
        }
        cout << endl;
        cout << val_max << endl;
        for (int j = 0; j < num_monets; j++)
        {
            cout << ans_max[j] << " ";
        }
    }
    else {
        cout << "NIE" << endl;
    }

    return 0;
}