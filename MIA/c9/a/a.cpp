#include <iostream>
#include <string>

using namespace std;

int letters[30];

int main(){
    string s;

    cin >> s;

    for(int i=0; i<s.size(); i++){
        letters[s[i] - 'a']++;
    }

    int x = 0;

    for(int i = 0; i < 30; i++){
        if(letters[i] % 2 != 0) x++;
    }

    // cout << x << endl;
    if(x == 0 || x == 1 || x % 2 == 1) {
        cout << "First" << endl;
        return 0;
    }

    if( x % 2 == 0) cout << "Second" << endl;

}