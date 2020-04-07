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
    // cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
    // cout << "start: " << start << " end: " << end << " middle: " << middle << endl;
    if (end - start < 3)
    {
        min_perimeter x;
        x.perimeter = 9999999999999;
        // cout << "koniec" << endl;
        return x;
    }

    // // cout << "====DANE ROZWAZANE=================" << endl;
    // for (int i = start; i < end; i++)
    // {
    //     cout << Px[i].first << " " << Px[i].second << endl;
    // }
    // // cout << "=====KONIEC=================" << endl;
    // // cout << "====Sortowane po Y =================" << endl;
    // for (int i = 0; i < Py.size(); i++)
    // {
    //     cout << Py[i].first << " " << Py[i].second << endl;
    // }
    // // cout << "=====KONIEC=================" << endl;
    vector<pair<int, int>> LeftPy, RightPy;

    // cout << "MiddleX: " <<  Px[floor(middle)].first << endl;
    for (unsigned int i = 0; i < Py.size(); i++)
    {
        // cout << "X: " << Py[i].first << " Y: " << Py[i].second << endl;
        if (Py[i].first < Px[floor(middle)].first)
        {
            // cout << "lewy" << endl;
            LeftPy.push_back(Py[i]);
        }
        else
        {
            // cout << "prawy" << endl;
            RightPy.push_back(Py[i]);
        }
    }

    // cout << "Left Py: " << LeftPy.size() << endl;
    // for(unsigned int i=0; i<LeftPy.size(); i++){
    //     // cout << "i: " << LeftPy[i] << endl;
    //     cout << LeftPy[i].first << " " << LeftPy[i].second << endl;
    // }
    // cout << "=====KONIEC=================" << endl;
    // cout << "Right Py: " << RightPy.size() << endl;
    //     for (unsigned int i = 0; i < RightPy.size(); i++)
    // {
    //     cout << RightPy[i].first << " " << RightPy[i].second << endl;
    // }
    // cout << "=====KONIEC=================" << endl;
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

    vector<pair<int, int>> closePointsL;
    vector<pair<int, int>> closePointsR;

    for (unsigned int i = 0; i < Py.size(); i++)
    {
        if (abs(Py[i].first - Px[middle].first) <= d)
        {
            if (Py[i].first < Px[middle].first)
            {

                closePointsL.push_back(Py[i]);
            }
            else
            {
                closePointsR.push_back(Py[i]);
            }
        }
    }
    // cout << "D: " << d << endl;
    // cout << "bliskich punktow: " << closePoints.size() << endl;

    // cout << "######################################################" << endl;
    // for (int i = 0; i < closePoints.size(); i++)
    // {
    //     cout << closePoints[i].first << " " << closePoints[i].second << endl;
    // }
    // cout << "######################################################" << endl;

    pair<int, int> a, b, c;

    for (unsigned int i = 0; i < closePointsL.size(); i++)
    {
        a = closePointsL[i];
        for (unsigned int j = 0; j + 1 < closePointsR.size(); j++)
        {
            b = closePointsR[j];
            if (abs(b.second - a.second) > d)
                break;
            for (unsigned int k = j + 1; k < closePointsR.size(); k++)
            {
                c = closePointsR[k];
                if (abs(c.second - a.second) > d)
                    break;
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
                // if (abs(c.second - a.second) > d)
                //     break;
            }
        }
    }

    for (unsigned int i = 0; i < closePointsR.size(); i++)
    {
        a = closePointsR[i];
        for (unsigned int j = 0; j + 1 < closePointsL.size(); j++)
        {
            b = closePointsL[j];
            if (abs(b.second - a.second) > d)
                break;
            for (unsigned int k = j + 1; k < closePointsL.size(); k++)
            {
                c = closePointsL[k];
                if (abs(c.second - a.second) > d)
                    break;
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
                // if (abs(c.second - a.second) > d)
                //     break;
            }
        }
    }
    // for (unsigned int i = 0; i + 2 < closePoints.size(); i++)
    // {
    //     // cout << "iiiii " << i << " < " << (int)closePoints.size()-2 << endl;
    //     a = closePoints[i];
    //     for (unsigned int j = i + 1; j + 1 < closePoints.size(); j++)
    //     {
    //         b = closePoints[j];
    //         if (abs(b.second - a.second) > d)
    //             break;
    //         for (unsigned int k = j + 1; k < closePoints.size(); k++)
    //         {
    //             c = closePoints[k];
    //             if (abs(c.second - a.second) > d)
    //                 break;
    //             double per = dist(a, b) + dist(b, c) + dist(c, a);
    //             // cout << "new per: " << per << endl;

    //             if (per < best.perimeter)
    //             {

    //                 // cout << "jest lepszy!" << endl;
    //                 best.perimeter = per;
    //                 best.a = a;
    //                 best.b = b;
    //                 best.c = c;
    //             }
    //         }
    //         if (abs(c.second - a.second) > d)
    //             break;
    //     }
    // }

    // cout << "start: " << start << " end: " << end << " middle: " << middle << endl;
    // cout << "Perimeter: " << best.perimeter << endl;
    // cout << "Ax: " << best.a.first << " Ay: " << best.a.second << endl;
    // cout << "Bx: " << best.b.first << " By: " << best.b.second << endl;
    // cout << "Cx: " << best.c.first << " Cy: " << best.c.second << endl;
    // cout << "*****************wychodze****************" << endl;
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
    vector<pair<int, int>> Ay;
    // pair<int, int> Ax[500010], Ay[500010];

    cin >> n;

    for (int i = 0; i < n; i++)
    {
        cin >> x >> y;
        // cout << x << " " << y << endl;
        // Ax.push_back(make_pair(x, y));
        Px.push_back(make_pair(x, y));
    }

    sort(Px.begin(), Px.end(), [](pair<int, int> a, pair<int, int> b) {
        return a.first < b.first;
    });

    // copy(Ax, Ax + n, Ay);
    Ay = Px;

    sort(Ay.begin(), Ay.end(), [](pair<int, int> a, pair<int, int> b) {
        return a.second < b.second;
    });

    // cout << "========================================================" << endl;
    // for (int i = 0; i < n; i++)
    // {
    //     cout << Ax[i].first << " " << Ax[i].second << endl;
    // }

    min_perimeter ans = solve(Ay, 0, n);

    // cout << ans.perimeter << endl;
    cout << ans.a.first << " " << ans.a.second << endl;
    cout << ans.b.first << " " << ans.b.second << endl;
    cout << ans.c.first << " " << ans.c.second << endl;
}