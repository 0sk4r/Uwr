#include <iostream>

using namespace std;

int main(){

    int tab[5000];
    int n, a12,a23,a13;
    cin >> n;
    cout << "? 1 2" << endl;
    fflush(stdout);
    cin >> a12;
    cout << "? 2 3" << endl;
    fflush(stdout);
    cin >> a23;
    cout << "? 1 3" << endl;
    fflush(stdout);
    cin >> a13;

    tab[1] = (a12 + a13 - a23)/2;
    tab[2] = (a12 - tab[1]);
    tab[3] = (a23 - tab[2]);

    for(int i = 4; i<=n; i++){
        int tmp;
        cout << "? " << i-1 << " " <<  i << endl;
        fflush(stdout);
        cin >> tmp;
        tab[i] = tmp - tab[i-1];
    }
    cout << "! ";

    for(int i = 1; i<= n; i++){
        cout << tab[i] << " ";
    }
}