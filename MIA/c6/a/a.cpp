#include<iostream>
using namespace std;

int main()
{
    int n, x=0, y=1;
    int mod_num = 1000000007;

    cin>>n;
    for(int i=1;i<n;i++)
    {
        int tmp = y;
        y = (x + y + 2) % mod_num;
        x = tmp;
    }
    cout<< y;
}