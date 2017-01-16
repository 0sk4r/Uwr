/*
Kamil Matuszewski - problem palaczy tytoniu.
Problem palaczy tytoniu rozwiązany przy pomocy semaforów.
Program działa na procesach, i do użycia wymaga systemu linux.
Wersja: 22.01.2016
*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <semaphore.h>
#include <unistd.h>

int main(int argc, char* argv[])
{	
	sem_t *sem_valet, *sem_tabacco, *sem_paper, *sem_matches;
	
	sem_valet=sem_open("/sem_valet",0);
	sem_tabacco=sem_open("/sem_tobacco",0);
	sem_paper=sem_open("/sem_paper",0);
	sem_matches=sem_open("/sem_matches",0);

	int id = atoi(argv[1]);
	
	while(1)
	{


		if(id==1) //smoker_tobacco
		{
		 sem_wait(sem_tabacco);
		 sleep(1);
		 printf("Palacz z tytoniem. Zabrałem papier i zapałki. Zaczynam palic\n");
		}
		else if(id==2) //smoker_paper
		{
		 sem_wait(sem_paper);
		 sleep(1);
		 printf("Palacz z papierem. Zabrałem tytoń i zapałki. Zaczynam palic\n");
		}
		else
		{
		 sem_wait(sem_matches); //smoker_matches
		 sleep(1);
		 printf("Palacz z zapałkami. Zabrałem tytoń i papier. Zaczynam palic\n");
		}		
		
		sleep(1);
		printf("Pale....\n");
		sleep(1);
		printf("Pale....\n");
		sleep(1);
		printf("Pale....\n");
		sleep(1);
		printf("Skonczylem palic\n");
		sleep(1);
		
		sem_post(sem_valet);
	}
	
	return 0;
}

