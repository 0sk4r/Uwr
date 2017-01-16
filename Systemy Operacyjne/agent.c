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
#include <time.h>

//Tobacco : 001
//Paper : 010
//Matches : 100

int main(int argc, char* argv[])
{
	int first_item, second_item;
	sem_t *sem_valet, *sem_tobacco, *sem_paper, *sem_matches;
	
	sem_valet=sem_open("/sem_valet",0);
	sem_tobacco=sem_open("/sem_tobacco",0); 
	sem_paper=sem_open("/sem_paper",0);		
	sem_matches=sem_open("/sem_matches",0);	
	

 	srand(time(0));
	
	while(1)
	{
	 sem_wait(sem_valet);
	 

	 first_item=(1<<(rand()%3));
	 
	 	do
	 	{
		second_item=(1<<(rand()%3));
		}
		while(first_item==second_item);
		
	 	int mask=(first_item|second_item);
	
	 	if(mask==6)
	 	{
		 printf("Agent: Kładę na stole papier i zapałki.\n");
		 sem_post(sem_tobacco);
		}
		else if(mask==5)
		{
		 printf("Agent: Kładę na stole tytoń i zapałki.\n");
		 sem_post(sem_paper);
		}
		else
		{
		 printf("Agent: Kładę na stole tytoń i papier.\n");
		 sem_post(sem_matches);
		}
	}

	return 0;
}

