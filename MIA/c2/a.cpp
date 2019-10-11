#include <iostream>
#include <math.h>
#include <stdlib.h>

using namespace std;

double N = 0, M = 0, ax, ay, bx, by;
double R = 0;
const double pi = 3.14159265358979323846;

int main()
{
    cin >> M >> N >> R;

    double radius = R / N;
    cin >> ax >> ay >> bx >> by;

    double cx = abs(bx - ax);
    double cy = abs(by - ay);
    double dy = min(by, ay);
    double radius2 = dy * radius;

    double dist = 2 * pi * radius2;
    dist = cx * dist / (M * 2);
    dist += radius * cy;

    dist = min(dist, ay * radius + by * radius);
    cout.precision(15);
    cout << dist;
}