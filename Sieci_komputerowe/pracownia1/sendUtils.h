
#ifndef sendUtils_Included
#define sendUtils_Included 1

#include "ioUtils.h"
#include <cassert>
#include "stdint.h"

u_int16_t checkSum (const void *buff, int length);

struct icmphdr createRequest(int PID, int nmbr);

void sendRequest(int sockfd, int identifier, int &counter, sockaddr_in targetIP);

#endif
