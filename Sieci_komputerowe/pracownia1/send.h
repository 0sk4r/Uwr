/*
*   Oskar Sobczyk
*/

#ifndef send_Included
#define send_Included 1

#include "print.h"


u_int16_t checkSum (const void *buff, int length);

struct icmphdr createRequest(int PID, int nmbr);

void sendRequest(int sockfd, int identifier, int &counter, sockaddr_in targetIP);

#endif
