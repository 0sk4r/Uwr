#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;
int selection(vector<int> &tab, int k);

int median(vector<int> &tab)
{
    vector<int> medians;

    for (int i = 0; i < tab.size(); i+= 5)
    {   
        if(i + 5 > tab.size()){
            sort(tab.begin() + i, tab.end());
            int middle = (tab.size() - i) /2;
            medians.push_back(tab[i+middle]);
        }
        else{

        sort(tab.begin() + i, tab.begin() + i + 5);
        medians.push_back(tab[i + 2]);
        }
    }

    return selection(medians, medians.size() / 2);
}

int selection(vector<int> &tab, int k)
{

    if (tab.size() < 5)
    {
        sort(tab.begin(), tab.end());
        return tab[k];
    }
    int p = median(tab);
    int mediana = p;

    vector<int> smaller, larger, eq;

    // smaller.reserve(tab.size());
    // larger.reserve(tab.size());
    // eq.reserve(tab.size());
    for (int i = 0; i < tab.size(); i++)
    {
        if (tab[i] == mediana)
            eq.push_back(tab[i]);
        else if (tab[i] < mediana)
            smaller.push_back(tab[i]);
        else
            larger.push_back(tab[i]);
    }
    // while(l < h){

    //     swap(tab[h], tab[l]);

    //     while(tab[h] >= mediana) h--;
    //     while(tab[l] <= mediana) l++;

    //     if(l<h) swap[tab[h],tab[l]];
    // }

    if (k < smaller.size())
        return selection(smaller, k);
    else if (k <  smaller.size() + eq.size())
        return eq[0];
        // return selection(eq, k - smaller.size());
    else
        return selection(larger, k - smaller.size() - eq.size());
}


int main()
{

    vector<int> tab;
    int n, k;

    cin >> n >> k;
    k--;
    int tmp;
    for (int i = 0; i < n; i++)
    {

        cin >> tmp;
        tab.push_back(tmp);
    }

    cout << selection(tab, k) << endl;

    return 0;
}