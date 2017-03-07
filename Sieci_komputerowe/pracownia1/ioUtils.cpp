#include "ioUtils.h"

// Brzydka funkcja wypisujaca na wyjscie adresy IP nadawcow pakietow zwrotnych wraz z czasem oczekiwania na ich otrzymanie
void printResult (int ttl, int time, string sender[3]) {
    //if (ttl < 10) printf(" ");
    printf(" %d. ", ttl);
//printf("%d",time);
    if (time == -2) printf("*\n");
    else {
        if (sender[0].compare("") != 0) {
            printf("%s", sender[0].c_str());
            if (sender[0].compare(sender[1]) != 0 && sender[1].compare("") != 0)
                printf(" %s", sender[1].c_str());
            if (sender[0].compare(sender[2]) != 0 && sender[1].compare(sender[2]) != 0 && sender[2].compare("") != 0)
                printf(" %s", sender[2].c_str());
        }
        else if (sender[1].compare("") != 0) {
            printf("%s", sender[1].c_str());
            if (sender[1].compare(sender[2]) != 0 && sender[2].compare("") != 0)
                printf("%s", sender[2].c_str());
        }
        else printf("%s", sender[2].c_str());
        if (time==-1) printf("   ???\n");
        else printf("   %d ms\n", time);
    }
}
