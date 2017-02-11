/* 
Oskar Sobczyk - Problem palaczy tytoniu
nr indeksu 281822
18.01.2017
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

int main(int argc, char* argv[])
{
	int items;
	sem_t *sem_valet, *sem_tobacco, *sem_paper, *sem_matches;
	
	sem_valet=sem_open("/sem_valet",0);
	sem_tobacco=sem_open("/sem_tobacco",0); 
	sem_paper=sem_open("/sem_paper",0);		
	sem_matches=sem_open("/sem_matches",0);	
	

 	srand(time(0));
	
	while(1)
	{
	 sem_wait(sem_valet);
	 

	 items=(rand()%3);
		
	
	 	if(items==0)
	 	{
		 printf("Lokaj: Wykładam papier i zapałki.\n");
		 sem_post(sem_tobacco);
		}
		else if(items==1)
		{
		 printf("Lokaj: Wykładam tytoń i zapałki.\n");
		 sem_post(sem_paper);
		}
		else
		{
		 printf("Lokaj: Wykładam tytoń i papier.\n");
		 sem_post(sem_matches);
		}
	}

	return 0;
}

