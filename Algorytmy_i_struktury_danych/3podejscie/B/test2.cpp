#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <iomanip>

using namespace std;

vector<pair<int, int>> Px;
struct min_perimeter
{
    double perimeter;
    pair<int, int> a;
    pair<int, int> b;
    pair<int, int> c;
};

double dist(pair<int, int> x, pair<int, int> y)
{

    return sqrt(pow(x.first - y.first, 2.0) + pow(x.second - y.second, 2.0));
}

min_perimeter solve(const vector<pair<int, int>> &Py, int start, int end)
{
    float middle = float(start) + (float(end) - float(start)) / 2;

    if (end - start < 3)
    {
        min_perimeter x;
        x.perimeter = 9999999999999;
        return x;
    }

    vector<pair<int, int>> LeftPy, RightPy;

    for (unsigned int i = 0; i < Py.size(); i++)
    {
        if (Py[i].first < Px[floor(middle)].first)
        {
            LeftPy.push_back(Py[i]);
        }
        else
        {
            RightPy.push_back(Py[i]);
        }
    }

    min_perimeter left = solve(LeftPy, start, floor(middle));
    min_perimeter right = solve(RightPy, floor(middle), end);

    min_perimeter best;

    if (left.perimeter < right.perimeter)
    {
        best = left;
    }
    else
    {
        best = right;
    }

    double d = best.perimeter / 2;

    vector<pair<int, int>> closePoints;

    for (unsigned int i = 0; i < Py.size(); i++)
    {
        if (abs(Py[i].first - Px[floor(middle)].first) <= d)
        {
            closePoints.push_back(Py[i]);
        }
    }

    pair<int, int> a, b, c;
    bool al, bl, cl;
    int okno = 0;
    int jx=0, kx=0;
    for (unsigned int i = 2; i < closePoints.size(); i++)
    {
        a = closePoints[i];
        al = a.first < Px[floor(middle)].first;
        while (abs(a.second - closePoints[okno].second > d))
        {
            okno++;
        }

        jx=0;
        for (unsigned int j = okno; j + 1 < i && jx <= 16 ; j++)
        {
            jx++;
            b = closePoints[j];
            bl = b.first < Px[floor(middle)].first;
            kx=0;
            for (unsigned int k = j + 1; k < i && kx <= 16; k++)
            {
                kx++;
                c = closePoints[k];
                cl = c.first < Px[floor(middle)].first;

                if ((al && bl && cl) || (!al && !bl && !cl))
                {
                    break;
                }

                double per = dist(a, b) + dist(b, c) + dist(c, a);

                if (per < best.perimeter)
                {
                    best.perimeter = per;
                    best.a = a;
                    best.b = b;
                    best.c = c;
                }
            }
        }
    }
    return best;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    std::cout << std::fixed;
    std::cout << std::setprecision(10);
    int n, x, y;
    vector<pair<int, int>> Ay;

    cin >> n;

    for (int i = 0; i < n; i++)
    {
        cin >> x >> y;
        Px.push_back(make_pair(x, y));
    }

    sort(Px.begin(), Px.end(), [](pair<int, int> a, pair<int, int> b) {
        return a.first < b.first;
    });

    Ay = Px;

    sort(Ay.begin(), Ay.end(), [](pair<int, int> a, pair<int, int> b) {
        return a.second < b.second;
    });

    min_perimeter ans = solve(Ay, 0, n);

    cout << ans.a.first << " " << ans.a.second << endl;
    cout << ans.b.first << " " << ans.b.second << endl;
    cout << ans.c.first << " " << ans.c.second << endl;
}