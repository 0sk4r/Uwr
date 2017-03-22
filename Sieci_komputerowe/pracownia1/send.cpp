#include "send.h"

//Obliczanie sumy kontrolnej pakietu
u_int16_t checkSum(const void *buff, int length)
{
    assert(length % 2 == 0);
    u_int32_t sum;
    const u_int16_t *ptr = (const u_int16_t *)buff;
    for (sum = 0; length > 0; length -= 2)
        sum += *ptr++;
    sum = (sum >> 16) + (sum & 0xffff);
    return (u_int16_t)(~(sum + (sum >> 16)));
}

//Funkcja zwraca naglowek icmp_echo
struct icmphdr createRequest(int PID, int nmbr)
{
    struct icmphdr icmp_header;
    icmp_header.type = ICMP_ECHO;
    icmp_header.code = 0;
    icmp_header.un.echo.id = PID; //identyfikatorem pakietu to numer procesu
    icmp_header.un.echo.sequence = nmbr;
    icmp_header.checksum = 0;
    icmp_header.checksum = checkSum((u_int16_t *)&icmp_header, sizeof(icmp_header)); //obliczenie sumy kontrolnej
    return icmp_header;
}

//funkcja wysyla 3 pakiety icmp_echo
void sendRequest(int sockfd, int identifier, int &counter, sockaddr_in targetIP)
{
    for (int i = 0; i < 3; i++)
    {
        struct icmphdr icmp_request = createRequest(identifier, counter++);
        int send_request = sendto(sockfd, &icmp_request, sizeof(icmp_request), 0, (struct sockaddr *)&targetIP, sizeof targetIP);
        
        //obsluga bledow
        if (send_request < 0)
        {
            fprintf(stderr, "Wystapil blad podczas wysylania pakietu: %s\n", strerror(errno));
        }
    }
}
