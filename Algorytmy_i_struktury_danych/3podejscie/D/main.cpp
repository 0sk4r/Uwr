#include <iostream>
#include <vector>

using namespace std;
int selection(vector<int> tab, int start, int end, int k);

int median(vector<int> tab, int start, int end)
{
    cout << "end= " << end << endl;
    vector<int> medians;

    for (int i = start; i < end; i+= 5)
    {   
        cout << " i " << i << endl;
        if(i + 5 >= end){
            sort(tab.begin() + i, tab.end());
            int middle = (end - i) /2;
            cout << "mediana = " << tab[i + middle] << endl;
            medians.push_back(tab[i+middle]);
        }
        else{

        sort(tab.begin() + i, tab.begin() + 5);
        cout << "mediana = " << tab[i + 2] << endl;
        medians.push_back(tab[i + 2]);
        }
    }
    cout << "lol" << endl;

    return selection(medians, 0, medians.size(), medians.size() / 2);
}

int selection(vector<int> tab, int start, int end, int k)
{
    cout << "k= " << k << endl;

    if (tab.size() <= 5)
    {
        sort(tab.begin(), tab.end());
        return tab[start + k];
    }
    int p = median(tab, start, end);
    cout << "p=" << p << endl;
    int mediana = tab[p];
    int l = start, h = end;

    vector<int> smaller, larger;

    for (int i = 0; i < tab.size(); i++)
    {

        if (tab[i] < mediana)
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

    if (k <= smaller.size())
        return selection(smaller, 0, smaller.size(), k);
    else
        return selection(larger, 0, larger.size(), k - smaller.size());
}


int main()
{

    vector<int> tab;
    int n, k;

    cin >> n >> k;
    int tmp;
    for (int i = 0; i < n; i++)
    {

        cin >> tmp;
        tab.push_back(tmp);
    }

    cout << selection(tab, 0, tab.size(), k);

    return 0;
}