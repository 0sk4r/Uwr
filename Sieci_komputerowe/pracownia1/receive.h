#ifndef recive_Included
#define receive_Included 1

#include "print.h"


struct packet {
        int identifier;
        int counter;
        int error;
        string IP;
};

struct packet getPacket(int sockfd, int PID);

int packetError (int val);

//int validType(int a);

int endTrace(string sender[3], string ip);

int reciveAnswer(int sockfd, int identifier,int ttl, string ip);
#endif
