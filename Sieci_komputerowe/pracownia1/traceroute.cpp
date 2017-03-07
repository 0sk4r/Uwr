#include "ioUtils.h"
#include "sendUtils.h"
#include "receiveUtils.h"

//maksymalna wartosc ttl
#define MAX_TTL 30

int main(int argc, char *argv[])
{
    // Weryfikacja poprawnej ilosci argumentow na wejsciu
    if (argc != 2) printf("nieprawidlowa ilosc argumentow!\n");

    //Tworzy gniazdo surowe
    int sockfd = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
    
    //Obsluga bledow gniazda
    if (sockfd < 0)
    {
        fprintf(stderr, "Wystapil blad podczas tworzenia gniazda: %s\n", strerror(errno));
    }

    //konwersja ip na strukture
    struct sockaddr_in targetIP;
    bzero(&targetIP, sizeof(targetIP));
    targetIP.sin_family = AF_INET;
    int ip = inet_pton(AF_INET, argv[1], &(targetIP.sin_addr));

    //weryfikacja poprawnosci ip
    if(!ip) printf("Niepoprawny adres IP!");


    int counter = 0; //numery kolejnych pakietow
    int identifier = getpid(); //identyfikator pakietow jakie wysyla proces

    
    for (int ttl = 1; ttl <= MAX_TTL; ttl++)
    {
        
        //Zmiana wartosci ttl
        int setSocket = setsockopt(sockfd, IPPROTO_IP, IP_TTL, &ttl, sizeof(int));
        
        //sprawdzenie poprawnosci operacji
        if (setSocket < 0)
        {
            fprintf(stderr, "Wystapil blad podczas zmient TTL: %s\n", strerror(errno));
        }

        //Wyslanie 3 pakietow icmp_echo
        sendRequest(sockfd, identifier, counter, targetIP);

        //odebranie pakietow i sprawdzenie czy osiagneliśmy cel
        if(reciveAnswer(sockfd,identifier,ttl,argv[1])==1) return EXIT_SUCCESS;
    }

    // Konczymy program niepowodzeniem w przypadku kiedy ttl > 30
    return EXIT_FAILURE;
}
