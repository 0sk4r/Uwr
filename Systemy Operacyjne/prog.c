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

	sem_t *sem_valet, *sem_tobacco, *sem_paper, *sem_matches;
	pid_t valet, smoker_tobacco, smoker_paper, smoker_matches;

	sem_unlink("/sem_valet");
	sem_unlink("/sem_tobacco");
	sem_unlink("/sem_paper");
	sem_unlink("/sem_matches");

	sem_valet=sem_open("/sem_valet", O_CREAT, (S_IRWXU | S_IRWXG | S_IRWXO), 1);
	sem_tobacco=sem_open("/sem_tobacco", O_CREAT, (S_IRWXU | S_IRWXG | S_IRWXO), 0);
	sem_paper=sem_open("/sem_paper", O_CREAT, (S_IRWXU | S_IRWXG | S_IRWXO), 0);
	sem_matches=sem_open("/sem_matches", O_CREAT, (S_IRWXU | S_IRWXG | S_IRWXO), 0);
	
	sem_close(sem_valet);
	sem_close(sem_tobacco);
	sem_close(sem_paper);
	sem_close(sem_matches);
	
	valet=fork();
	
	if(valet==0)
	{
	 char* argums[]={"valet", 0};
	 char* envir[]={ NULL };
	 execve("valet", argums, envir);
	}
	else
	{
	 smoker_tobacco=fork();
	 
		if(smoker_tobacco==0)
		{
	 	 char* argums[]={"smoker", "1", 0};
	 	 char* envir[]={ NULL };
		 execve("smoker", argums, envir);
		}
		else
		{
		 smoker_paper=fork();
		 
			if(smoker_paper==0)
			{
	 	 	 char* argums[]={"smoker", "2", 0};
	 	 	 char* envir[]={ NULL };
			 execve("smoker", argums, envir);
			}
			else
			{
			 smoker_matches=fork();
			 
				if(smoker_matches==0)
				{
	 	 		 char* argums[]={"smoker", "3", 0};
	 	 		 char* envir[]={ NULL };
				 execve("smoker", argums, envir);
				}
				else
				{
				 while(1);
				}
			}
		}
	}
	
	
	return 0;
}
