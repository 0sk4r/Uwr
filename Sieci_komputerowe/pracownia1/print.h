#ifndef print_Included
#define print_Included 1

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

void printResult (int ttl, int time, string sender[3]);

#endif
