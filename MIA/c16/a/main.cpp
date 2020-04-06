#include <iostream>
#include <string>

using namespace std;


int main(){

    int prime[20] = {2,3,4,5,7,9,11,13,17,19,23,25,29,31,37,41,43,47,49};
    int ans = 0;
    string tmp;

    for(int i=0; i<19; i++){
        cout << prime[i] << endl;
        fflush(stdout);
        cin >> tmp;
        if(tmp == "yes") ans++;
    } 

    if(ans>=2) cout << "composite" << endl;
    else cout << "prime" << endl;
}