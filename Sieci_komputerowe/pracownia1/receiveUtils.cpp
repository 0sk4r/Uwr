#include "receiveUtils.h"
#include <sys/time.h>

//odbiera pakiet i zwraca go w postaci struktury
struct packet getPacket(int sockfd, int identifier)
{
    struct sockaddr_in sender;
    socklen_t sender_len = sizeof(sender);
    u_int8_t buffer[IP_MAXPACKET + 1];
    u_int8_t *bufferPointer = buffer;

    //Odebranie pakiety z gniazda
    ssize_t packet_len = recvfrom(sockfd, buffer, IP_MAXPACKET, MSG_DONTWAIT, (struct sockaddr *)&sender, &sender_len);

    //Obsluga bledow odbioru pakietu
    if (packet_len < 0)
    {
        //zwracamy pakiet z kodem z bledu -1
        struct packet recivedPacket = {-1, -1, -1, ""};
        return recivedPacket;
    }

    //wydobycie adresu ip
    char senderIP[20];
    inet_ntop(AF_INET, &(sender.sin_addr), senderIP, sizeof(senderIP));

    //naglowek
    struct iphdr *ipHeader = (struct iphdr *)buffer;

    //naglowek pakietu icmp
    u_int8_t *icmp_packet = buffer + 4 * ipHeader->ihl;
    struct icmphdr *receivedICMPHDR = (struct icmphdr *)icmp_packet;

    //jesli naglowek to ICMP_ECHOREPLY i identyfikator pakietu zgadza sie z indentyfikatorem procesu
    if (receivedICMPHDR->type == ICMP_ECHOREPLY && receivedICMPHDR->un.echo.id == identifier)
    {
        struct packet recivedPacket = {identifier, receivedICMPHDR->un.echo.sequence, ICMP_ECHOREPLY, senderIP};
        return recivedPacket;
    }

    //jesli naglowek to ICMP_TIME_EXCEEDED
    else if (receivedICMPHDR->type == ICMP_TIME_EXCEEDED)
    {
        //wyciagamy z niego oryginalny naglowek
        bufferPointer += 4 * ipHeader->ihl + 8;
        struct ip *originalPacket = (struct ip *)bufferPointer;
        bufferPointer += (originalPacket->ip_hl * 4);
        struct icmp *originalICMP = (struct icmp *)bufferPointer;
        int counter = originalICMP->icmp_seq;

        if (originalICMP->icmp_id == identifier)
        {
            struct packet recivedPacket = {identifier, counter, ICMP_TIME_EXCEEDED, senderIP};
            return recivedPacket;
        }
    }

    //jesli pakiet nie pasuje zwracamy pakiet z kodem bledu -2

    struct packet recivedPacket = {-1, -1, -2, ""};
    return recivedPacket;
}

// Sprawdzanie poprawnosci odbioru pakietu
int packetError(int val)
{
    string empty = "Resource temporarily unavailable";
    if (val < 0 && empty.compare(strerror(errno)) != 0)
    {
        fprintf(stderr, "recvfrom error: %s\n", strerror(errno));
        return 1;
    }
    else
        return 0;
}

// Funkcja sprawdzajaca, czy otrzymany naglowek ICMP jest typu echo reply lub time exceeded
int validType(int a) { return (a == ICMP_ECHOREPLY || a == ICMP_TIME_EXCEEDED); }

// Funkcja okreslajaca czy otrzymalismy odpowiedz od trace'owanego adresu
int endTrace(string sender[3], string ip)
{
    return (!sender[0].compare(ip) || !sender[1].compare(ip) || !sender[2].compare(ip));
}

int reciveAnswer(int sockfd, int identifier, int ttl, string ip)
{

    clock_t start = clock();

    timeval time;
    gettimeofday(&time, NULL);
    long long startTime = ((long long)time.tv_sec * 1000) + (time.tv_usec / 1000);

    int answer = 0, total_time = 0, avg_time;
    string incoming_ip[3] = {"", "", ""};

    fd_set descriptors;
    FD_ZERO(&descriptors);
    FD_SET(sockfd, &descriptors);
    struct timeval timeout;
    timeout.tv_sec = 1000 / 1000;
    timeout.tv_usec = (1000 % 1000) * 1000;

    // Petla oczekujaca na przyjscie pakietow zwrotnych
    //while (answer < 3 && (clock() - start) / CLOCKS_PER_SEC < 1)
    while (answer < 3)
    {

        int ready = select(sockfd + 1, &descriptors, NULL, NULL, &timeout);

        if (ready)
        {
            //odebranie pakietu
            struct packet pakiet = getPacket(sockfd, identifier);

            // obsluga bledu
            if (pakiet.error < 0)
            {
                fprintf(stderr, "recvfrom error: %s\n", strerror(errno));
            }

            //sprawdzenie czy pakie nalezy do tego procesu i czy jest odpowiedzia na obecny ttl 
            if (pakiet.identifier == identifier && (pakiet.error == ICMP_ECHOREPLY || pakiet.error == ICMP_TIME_EXCEEDED) && (pakiet.counter / 3 + 1) == ttl)
            {
                //obliczenie czasu
                gettimeofday(&time, NULL);
                long long curTime = ((long long)time.tv_sec * 1000) + (time.tv_usec / 1000);
                total_time += curTime - startTime;
                //total_time += clock() - start;

                //zapisanie przychodzacego numeru ip
                incoming_ip[pakiet.counter % 3] = pakiet.IP;
                answer++;   //zwiekszenie licznika odpowiedzi
            }
        }
        else
            break;
    }
    //jesli nie otrzymano 3 odpowiedzi
    if (answer != 3)
    {
        if (answer == 0)
        {
            avg_time = -2;  //jesli nie otrzymano zadnej odpowiedzi 
        }
        else
        {
            avg_time = -1; //jesli otrzymano mniej niz 3 odpowiedzi
        }
    }
    else
    {
        //avg_time = total_time * 1000 / CLOCKS_PER_SEC / 3;
        avg_time = total_time / 3; //jesli otrzymano wszystkie odpowiedzi
    }

    printResult(ttl, avg_time, incoming_ip); //wypisanie wyniku

    //Sprawdzenie czy dotarlismy do celu
    if (endTrace(incoming_ip, ip))
        return 1;
    else
        return -1;
}
