
#include <iostream>
 
using namespace std;
 
long long foo(long long x)
{
    if (x % 4 == 0)
    {
        return 0;
    }
    else if (x % 4 == 1)
    {
        return x - 1;
    }
    else if (x % 4 == 2)
    {
        return 1;
    }
 
    return x;
}
int main()
{
 
    long long n, x, m, sum=0;
 
    cin >> n;
    for (int i = 0; i < n; i++)
    {
        cin >> x >> m;
 
        sum ^= foo(x) ^ foo(x+m);
    }
 
    if(sum){
        cout << "tolik" << endl;
    } else {
        cout << "bolik" << endl;
    }
}