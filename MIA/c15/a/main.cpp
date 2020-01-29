#include <iostream>

using namespace std;

int main(){

    int queue[1000005]={};
    int n;
    int queue_size=0;
    int max_queue = 0, last_msg=0;
    cin >> n;
    for(int i=0; i < n; i++){
        int t, c;
        cin >> t >> c;
        queue[t] = c;
    }

    for(int i=0; i<=1000000; i++){
        if(queue_size > 0) {
            queue_size--;
            last_msg = i;
        }
        queue_size += queue[i];
        if(queue[i]) last_msg = i;
        max_queue = max(max_queue, queue_size);
    }

    last_msg += queue_size;

    cout << last_msg << " " << max_queue << endl;

}