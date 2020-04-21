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

    long long tab[1000010];
    int solutions[1000010];
    int ans_max[1000010], ans_min[1000010];

    // memset(tab, 0, sizeof(tab));
    // memset(ans_max, 0, sizeof(ans_max));
    // memset(ans_min, 0, sizeof(ans_min));


    vector<pair<int, int>> monets;
    long long total_mass, num_monets;

    cin >> total_mass;

    cin >> num_monets;

    for (long i = 0; i <= total_mass; i++)
    {
        tab[i] = 0;
        ans_max[i] = 0;
        ans_min[i] = 0;
    }
    int value, mass;

    for (long i = 0; i < num_monets; i++)
    {
        cin >> value >> mass;
        monets.push_back(make_pair(value, mass));
    }

    sort(monets.begin(), monets.end(), [](pair<int, int> a, pair<int, int> b) {
        if(a.first < b.first) {
            return true;
        } else if( a.first > b.first) {
            return false;
        }
        return a.second < b.second;
    });

    for(int i = 1; i < (monets.size() - 1); i++){
        if(monets[i-1].first == monets[i].first && monets[i+1].first == monets[i].first){
            monets.erase(monets.begin() + i);
        }
    }

    tab[0] = 0;

    for (long weight = 1; weight <= total_mass; weight++)
    {

        for (long unsigned int j = 0; j < monets.size(); j++)
        {

            pair<int, int> monet = monets[j];

            if (monet.second <= weight)
            {
                long long new_val = tab[weight - monet.second] + monet.first;

                if (tab[weight] < new_val)
                {
                    tab[weight] = new_val;
                    solutions[weight] = j;
                }
            }
        }
    }

    // for(int i=0; i<=total_mass; i++){on sa

    //     cout << tab[i] << endl;

    // }
    long long max_val = tab[total_mass];
    long k = total_mass;

    if (max_val != 0)
    {

        while (k > 0) 
        {

            pair<int, int> monet = monets[solutions[k]];
            ans_max[solutions[k]] += 1;
            k -= monet.second;
        }
    }

    // ===============================================================

    for (long i = 0; i <= total_mass; i++)
    {
        tab[i] = LLONG_MAX;
    }

    // memset(tab, LONG_MAX, sizeof(tab));

    tab[0] = 0;

    for (long weight = 1; weight <= total_mass; weight++)
    {

        for (long unsigned int j = 0; j < monets.size(); j++)
        {

            pair<int, int> monet = monets[j];

            if (monet.second <= weight)
            {
                if (tab[weight - monet.second] != LLONG_MAX)
                {

                    long long new_val = tab[weight - monet.second] + monet.first;

                    if (tab[weight] > new_val)
                    {
                        tab[weight] = new_val;
                        solutions[weight] = j;
                    }
                }
            }
        }
    }

    // for(int i=0; i<=total_mass; i++){on sa

    //     cout << tab[i] << endl;

    // }
    long long min_val = tab[total_mass]; 
    k = total_mass;

    if (min_val != LLONG_MAX)
    {

        while (k > 0)
        {

            pair<int, int> monet = monets[solutions[k]];
            ans_min[solutions[k]] += 1;
            k -= monet.second;
        }
    }

    //========================================================
    if (max_val != 0 && min_val != LLONG_MAX)
    {
        cout << "TAK" << endl;
        cout << min_val << endl;
        for (int i = 0; i < num_monets; i++)
        {
            cout << ans_min[i] << " ";
        }
        cout << endl;
        cout << max_val << endl;
        for (int i = 0; i < num_monets; i++)
        {
            cout << ans_max[i] << " ";
        }
        return 0;
    }
    else
    {
        cout << "NIE" << endl;
        return 0;
    }

    return 0;
}