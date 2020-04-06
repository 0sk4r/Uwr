#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <iomanip>

using namespace std;

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

min_perimeter solve(vector<pair<int, int>> Px, vector<pair<int, int>> Py, int start, int end)
{
    float middle = float(start) + (float(end) - float(start)) / 2;
    // cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
    // cout << "start: " << start << " end: " << end << " middle: " << middle << endl;
    if (end - start < 3)
    {
        min_perimeter x;
        x.perimeter = 9999999999999;
        // cout << "koniec" << endl;
        return x;
    }

    // cout << "====DANE ROZWAZANE=================" << endl;
    // for (int i = start; i < end; i++)
    // {
    //     cout << Px[i].first << " " << Px[i].second << endl;
    // }
    // cout << "=====KONIEC=================" << endl;
    // cout << "====Sortowane po Y =================" << endl;
    // for (int i = 0; i < Py.size(); i++)
    // {
    //     cout << Py[i].first << " " << Py[i].second << endl;
    // }
    // cout << "=====KONIEC=================" << endl;
    vector<pair<int, int>> LeftPy, RightPy;

    for (int i = 0; i < Py.size(); i++)
    {
        if (Py[i].first < Px[middle].first)
        {
            LeftPy.push_back(Py[i]);
        }
        else
        {
            RightPy.push_back(Py[i]);
        }
    }
    min_perimeter left = solve(Px, LeftPy, start, floor(middle));
    min_perimeter right = solve(Px, RightPy, ceil(middle), end);

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

    for (int i = 0; i < Py.size(); i++)
    {
        if (abs(Py[i].first - Px[middle].first) < d)
        {
            closePoints.push_back(Py[i]);
        }
    }
    // cout << "bliskich punktow: " << closePoints.size() << endl;

    // cout << "######################################################" << endl;
    // for (int i = 0; i < closePoints.size(); i++)
    // {
    //     cout << closePoints[i].first << " " << closePoints[i].second << endl;
    // }
    // cout << "######################################################" << endl;

    for (int i = 0; i < closePoints.size() - 2; i++)
    {
        pair<int, int> a, b, c;
        a = closePoints[i];
        for (int j = i + 1; j < (closePoints.size() - 1); j++)
        {
            for (int k = j + 1; k < closePoints.size(); k++)
            {
                b = closePoints[j];
                c = closePoints[k];
                double per = dist(a, b) + dist(b, c) + dist(c, a);
                // cout << "new per: " << per << endl;

                if (per < best.perimeter)
                {

                    // cout << "jest lepszy!" << endl;
                    best.perimeter = per;
                    best.a = a;
                    best.b = b;
                    best.c = c;
                }
            }
        }
    }

    // cout << "Perimeter: " << best.perimeter << endl;

    return best;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    std::cout << std::fixed;
    std::cout << std::setprecision(10);
    int n, x, y;
    // vector<pair<int, int>> Ax, Ay;
    vector<pair<int, int>> Ax, Ay;
    // pair<int, int> Ax[500010], Ay[500010];

    cin >> n;

    for (int i = 0; i < n; i++)
    {
        cin >> x >> y;
        // cout << x << " " << y << endl;
        // Ax.push_back(make_pair(x, y));
        Ax.push_back(make_pair(x, y));
    }

    sort(Ax.begin(), Ax.end(), [](pair<int, int> a, pair<int, int> b) {
        return a.first < b.first;
    });

    // copy(Ax, Ax + n, Ay);
    Ay = Ax;

    sort(Ay.begin(), Ay.end(), [](pair<int, int> a, pair<int, int> b) {
        return a.second < b.second;
    });

    // cout << "========================================================" << endl;
    // for (int i = 0; i < n; i++)
    // {
    //     cout << Ax[i].first << " " << Ax[i].second << endl;
    // }

    min_perimeter ans = solve(Ax, Ay, 0, n);

    // cout << ans.perimeter << endl;
    cout << ans.a.first << " " << ans.a.second << endl;
    cout << ans.b.first << " " << ans.b.second << endl;
    cout << ans.c.first << " " << ans.c.second << endl;
}