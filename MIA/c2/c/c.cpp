#include <iostream>
#include <vector>
#include <numeric>

int main() {

    int n;
    long tmp;

    std::cin >> n;
    std::vector<long> tab(n);

    for(int i=0; i<n; i++){
        std::cin >> tmp;
        tab.push_back(tmp);
    }



    std::vector<long> row1;
    std::vector<long> row2;

    row1.push_back(tab[0]);

    // for(int i=1; i<n; i++){
    //     std::vector<long> last = ans[i-1];
    //     for(int j=0; j<last.size(); j++){
    //         ans[i].push_back(std::gcd(tab[i], last[j]));
    //     }
    // }

}