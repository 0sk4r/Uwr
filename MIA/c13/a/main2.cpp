#include <iostream>
#include <complex>
#include <vector>
#include <math.h>

#ifndef M_PI
#define M_PI (3.14159265358979323846)
#endif

using namespace std;


void fft(vector<complex<double>> &a)
{
    int n = a.size();

    if (n == 1)
        return;

    vector<complex<double>> a_even(n / 2), a_odd(n / 2);

    int j = 0;
    for (int i = 0; i < n; i += 2)
    {
        a_even[j] = a[i];
        j++;
    }

    j = 0;
    for (int i = 1; i < n; i += 2)
    {
        a_odd[j] = a[i];
        j++;
    }

    fft(a_even);
    fft(a_odd);

    for (int i = 0; i < n / 2; ++i)
    {
        complex<double> e = exp(complex<double>(0, 2 * M_PI * i / n));

        a[i] = a_even[i] + e * a_odd[i];
        a[i + n / 2] = a_even[i] - e * a_odd[i];
    }
}

void ufft(vector<complex<double>> &a)
{
    int n = a.size();

    if (n == 1)
        return;

    vector<complex<double>> a_even(n / 2), a_odd(n / 2);

    int j = 0;
    for (int i = 0; i < n; i += 2)
    {
        a_even[j] = a[i];
        j++;
    }

    j = 0;
    for (int i = 1; i < n; i += 2)
    {
        a_odd[j] = a[i];
        j++;
    }

    ufft(a_even);
    ufft(a_odd);

    for (int i = 0; i < n / 2; ++i)
    {
        complex<double> e = exp(complex<double>(0, -2 * M_PI * i / n));

        a[i] = a_even[i] + e * a_odd[i];
        a[i + n / 2] = a_even[i] - e * a_odd[i];
    }
}



int main()
{
    int t, pol_size;

    cin >> t;

    for (int i = 0; i < t; i++)
    {
        vector<complex<double>> a, b;
        cin >> pol_size;
        int tmp;

        for (int j = 0; j <= pol_size; j++)
        {
            cin >> tmp;
            a.push_back(tmp);
        }

        for (int j = 0; j <= pol_size; j++)
        {
            cin >> tmp;
            b.push_back(tmp);
        }

        int n = 1;

        while (n < max(a.size(), b.size()))
            n *= 2;
        n *= 2;

        a.resize(n);
        b.resize(n);

        fft(a);
        fft(b);

        for (size_t i = 0; i < n; ++i)
            a[i] *= b[i];

        ufft(a);

        for (int i = 0; i < 2 * pol_size + 1; i++)
        {
            cout << llround(a[i].real() / n) << " ";
        }

        cout << endl;

        // multiply(a, b, n);
    }
}