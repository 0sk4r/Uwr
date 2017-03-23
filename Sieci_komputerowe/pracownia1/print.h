/*
*   Oskar Sobczyk
*/

#ifndef print_Included
#define print_Included 1

#include <iostream>
#include <time.h>
#include <unistd.h>
#include <cstdint>
#include <cstring>
#include <cassert>
#include <strings.h>

#include <arpa/inet.h>
#include <errno.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#include <sys/time.h>

using namespace std;

void print (int ttl, int time, string sender[3]);

#endif
