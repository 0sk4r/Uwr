#ifndef ioUtils_Included
#define ioUtils_Included 1

#include <iostream>
#include <time.h>
#include <unistd.h>
#include <cstdint>
#include <cstring>
#include <strings.h>

#include <arpa/inet.h>
#include <errno.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>

using namespace std;

// Funkcja sprawdzajaca poprawnosc wejscia
int inputError (int argc, char *argv[]);

// Brzydka funkcja wypisujaca na wyjscie adresy IP nadawcow pakietow zwrotnych wraz z czasem oczekiwania na ich otrzymanie
void printResult (int ttl, int time, string sender[3]);

#endif
