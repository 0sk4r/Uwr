#include <iostream>
#include <algorithm>
using namespace std;

int n, tab[100];

int main() {
    cin >> n;
    for(int i=0; i<n; i++) {
        cin >> tab[i];
    }

     sort(tab, tab+n, greater<int>()); 

    int alice=0; int bob=0;

    for(int i=0; i<n; i+=2 ){
        alice+= tab[i];
    }
        for(int i=1; i<n; i+=2 ){
        bob+= tab[i];
    }

    cout << alice << " " << bob;
}