#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <iomanip>

using namespace std;
vector<pair<int, int>> Ax;
vector<int> Ay;

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

min_perimeter solve(const vector<pair<int, int>> &Px, const vector<int> Py, int start, int end)
{
    float middle = float(start) + (float(end) - float(start)) / 2;
    // cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
    // cout << "start: " << start << " end: " << end << " middle: " << middle << endl;
    if (end - start < 3)
    {
        min_perimeter x;
        x.perimeter = 9999999999999;
        x.a = make_pair(0, 0);
        x.b = make_pair(0, 0);
        x.c = make_pair(0, 0);
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
    //     cout << Px[Py[i]].first << " " << Px[Py[i]].second << endl;
    // }
    // cout << "=====KONIEC=================" << endl;
    vector<int> LeftPy, RightPy;
    LeftPy.reserve((end - start)/2);
    RightPy.reserve((end - start)/2);
    // cout << "MiddleX: " <<  Px[floor(middle)].first << endl;
    // cout << "Py size: " << Py.size() << endl;
    for (unsigned int i = 0; i < Py.size(); i++)
    {
        // cout << "X: " << Px[Py[i]].first << " Y: " << Px[Py[i]].second << endl;
        if (Px[Py[i]].first < Px[floor(middle)].first)
        {
            // cout << "lewy" << endl;
            LeftPy.push_back(i);
        }
        else
        {

            // cout << "prawy" << endl;
            RightPy.push_back(i);
        }
    }
    // cout << "Left Py: " << LeftPy.size() << endl;
    // for(auto i : LeftPy){
    //     cout << "i: " << LeftPy[i] << endl;
    //     cout << Px[LeftPy[i]].first << " " << Px[LeftPy[i]].second << endl;
    // }
    // for (int i = 0; i < LeftPy.size(); i++)
    // {
    //     cout << Px[LeftPy[i]].first << " " << Px[LeftPy[i]].second << endl;
    // }
    // cout << "=====KONIEC=================" << endl;
    // cout << "Right Py: " << RightPy.size() << endl;
    //     for (int i = 0; i < RightPy.size(); i++)
    // {
    //     cout << Px[RightPy[i]].first << " " << Px[RightPy[i]].second << endl;
    // }
    // cout << "=====KONIEC=================" << endl;
    min_perimeter left = solve(Px, LeftPy, start, floor(middle));
    min_perimeter right = solve(Px, RightPy, floor(middle), end);

    min_perimeter best;
    best.perimeter = 9999999999999;
    best.a = make_pair(0, 0);
    best.b = make_pair(0, 0);
    best.c = make_pair(0, 0);
    if (left.perimeter < right.perimeter)
    {
        best = left;
    }
    else
    {
        best = right;
    }

    double d = best.perimeter / 2;
    // cout << "d " << d << endl;
    vector<int> closePoints;

    for (unsigned int i = 0; i < Py.size(); i++)
    {
        if (abs(Px[Py[i]].first - Px[floor(middle)].first) <= d)
        {
            closePoints.push_back(i);
        }
    }
    // cout << "bliskich punktow: " << closePoints.size() << endl;

    // cout << "######################################################" << endl;
    // for (int i = 0; i < closePoints.size(); i++)
    // {
    //     cout << Px[Py[closePoints[i]]].first << " " << Px[Py[closePoints[i]]].second << endl;
    // }
    // cout << "######################################################" << endl;

    pair<int, int> a, b, c;
    for (long i = 0; i < closePoints.size() - 2; i++)
    {
        a = Px[Py[closePoints[i]]];
        for (long j = i + 1; j < (closePoints.size() - 1); j++)
        {
            for (long k = j + 1; k < closePoints.size(); k++)
            {

                // cout << i << " " << j << " " << k << endl;
                b = Px[Py[closePoints[j]]];
                c = Px[Py[closePoints[k]]];
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
    // cout << "!!!!!!!!!!!!!!!!!!!!!!!!WYCHODZE!!!!!!!!!!!!!!!!!" << endl;

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
    // pair<int, int> Ax[500010], Ay[500010];

    cin >> n;

    for (int i = 0; i < n; i++)
    {
        cin >> x >> y;
        // cout << x << " " << y << endl;
        // Ax.push_back(make_pair(x, y));
        Ax.push_back(make_pair(x, y));
        Ay.push_back(i);
    }

    sort(Ax.begin(), Ax.end(), [](pair<int, int> a, pair<int, int> b) {
        return a.first < b.first;
    });

    // copy(Ax, Ax + n, Ay);
    // Ay = Ax;

    sort(Ay.begin(), Ay.end(), [](int a, int b) {
        return Ax[a].second < Ax[b].second;
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