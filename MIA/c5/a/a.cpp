#include <iostream>
#include <map>

using namespace std;

map<long long, long long> tree;
long long q, v, u, w, type;

void update(long long u, long long v, long long w)
{

    while (u != v)
    {
        if (v < u)
        {
            swap(u, v);
        }
        tree[v] += w;
        v = v / 2;
    }
}

long long cost(long long u, long long v)
{
    long long resoult = 0;

    while (u != v)
    {
        if (v < u)
        {
            swap(u, v);
        }
        resoult += tree[v];
        v = v / 2;
    }

    return resoult;
}

int main()
{
    ios::sync_with_stdio(false);
    cin.tie(0);

    cin >> q;

    while (q--)
    {
        cin >> type >> u >> v;

        if (type == 1)
        {
            cin >> w;
            update(u, v, w);
        }
        else
        {
            long long price;
            price = cost(u, v);
            cout << price << "\n";
        }
    }
}