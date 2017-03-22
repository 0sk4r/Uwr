#include "print.h"

void printResult (int ttl, int time, string sender[3]) {
    if (ttl < 10) printf(" ");
    printf(" %d. ", ttl);
    if (time == -2) printf("*\n");
    else {

            printf("%s", sender[0].c_str());
            if (sender[0].compare(sender[1]) != 0)
                printf(" %s", sender[1].c_str());
            if (sender[0].compare(sender[2]) != 0 && sender[1].compare(sender[2]) != 0)
                printf(" %s", sender[2].c_str());
        }

        
        if (time==-1) printf("   ???\n");
        else if(time >= 0) printf("   %d ms\n", time);
    }
