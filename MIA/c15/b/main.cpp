#include <iostream>
#include <math.h>
using namespace std;
 
int main()
{
 
    long long a, b, ans = 0;
 
    cin >> a >> b;
 
    for (long long i = 0; pow(2, i - 1) <= b; i++)
    {
        for (long long j = 0; j < i-1; j++)
        {
            long long ones = pow(2, i) - 1;
            long long one_zero = ones - pow(2, j);
            if (one_zero >= a && one_zero <= b)
                ans++;
        }
    }
 
    cout << ans << endl;
}