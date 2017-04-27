#include "stdio.h"

int wiersz, kolumna = 3;
char plansza[1000000][5];
char buffer[50];

char powrot[500000][64];

int maska[8][3] = {{0,0,0},{1,0,0},{0,1,0},{0,0,1},{1,1,0},{0,1,1},{1,0,1},{1,1,1}};

int pionki[8] = {0,1,1,1,2,2,2,3};

int optymalne[2][64];

bool check(char wiersz[5], char maska[3])
{
    for(int pole; pole<3; pole++)
    {
        if(wiersz[pole] == 'x' && maska[pole]== 1) return false;
        
        
    }
    return true;
}

bool bicia(int maska1[3], int maska2[3], int maska3[3], int maska4[3]){
    
    
    
}


int main(){
    fgets(buffer,15, stdin);
    sscanf(buffer, "%d", &wiersz);
    
    for (int i = 0; i < wiersz; i++)
    {
        fgets(plansza[i], kolumna + 2, stdin);
    }

    //if(wiersz%2 != 0){ plansza[wiersz+1] = ['x','x','x'];}
    
    for (int i = 0; i < wiersz; i=i+2){
       
        for(int x = 0; x < 8; x++)
        {
            if(check(plansza[i],maska[x]))
            {
                
                for(int y = 0; y < 8; y++)
                {
                    if(check(plansza[i+1],maska[y])){
                    
                        
                    
                    }
                }
                
            }
        }
    }
}
