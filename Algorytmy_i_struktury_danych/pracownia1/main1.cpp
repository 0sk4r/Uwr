#include "stdio.h"
#include <string>
#include "vector"
#include <iostream>
#include "stack"

using namespace std;

int main()
{
    int n, m;
    if (scanf("%d %d\n", &n, &m) < 0)
    {
    }
    int V = n * m;
    string wiersz;
    //vector<int> *sasiedztwa = new vector<int>[ (n * m) + 1 ];
    int sasiedztwa[V][4];
    for(int i = 0;i<V;i++){
        for(int j=0;j<4;j++) sasiedztwa[i][j]=0;
    }
    int spojne[V];
    int licznik = 0;

    for (int i = 0; i < n; i++)
    {
        char buffer[m];
        if (scanf("%s", buffer) < 0)
        {
        }
        wiersz += buffer;
    }

    for (int i = 0; i < n * m; i++)
    {
        if (wiersz[i] == 'B')
        {
            if ((wiersz[i + m] == 'C' || wiersz[i + m] == 'D' || wiersz[i + m] == 'F') && i / m != n + 1)
            {
                sasiedztwa[i].push_back(i + m);
                sasiedztwa[i + m].push_back(i);
            }
            if (sasiedztwa[i].empty())
                sasiedztwa[i].push_back(-1);
        }
        else if (wiersz[i] == 'D')
        {
            if ((wiersz[i + 1] == 'C' || wiersz[i + 1] == 'B' || wiersz[i + 1] == 'F') && i % m + 1 != m)
            {
                sasiedztwa[i].push_back(i + 1);
                sasiedztwa[i + 1].push_back(i);
            }
            if (sasiedztwa[i].empty())
                sasiedztwa[i].push_back(-1);
        }
        else if (wiersz[i] == 'E')
        {
            if ((wiersz[i + 1] == 'B' || wiersz[i + 1] == 'C' || wiersz[i + 1] == 'F') && i % m + 1 != m)
            {
                sasiedztwa[i].push_back(i + 1);
                sasiedztwa[i + 1].push_back(i);
            }
            if ((wiersz[i + m] == 'C' || wiersz[i + m] == 'D' || wiersz[i + m] == 'F') && i / 4 != n + 1)
            {
                sasiedztwa[i].push_back(i + m);
                sasiedztwa[i + m].push_back(i);
            }
            if (sasiedztwa[i].empty())
                sasiedztwa[i].push_back(-1);
        }
        else if (wiersz[i] == 'F')
        {
            if ((wiersz[i + 1] == 'B' || wiersz[i + 1] == 'C' || wiersz[i + 1] == 'F') && i % m + 1 != m)
            {
                //printf("test1");
                sasiedztwa[i].push_back(i + 1);
                sasiedztwa[i + 1].push_back(i);
            }
            if ((wiersz[i + m] == 'C' || wiersz[i + m] == 'D' || wiersz[i + m] == 'F') && i / 4 != n + 1)
            {
                //printf("test1");

                sasiedztwa[i].push_back(i + m);
                sasiedztwa[i + m].push_back(i);
            }
            if (sasiedztwa[i].empty())
                sasiedztwa[i].push_back(-1);
        }
        else if (wiersz[i] == 'C')
        {
            if (sasiedztwa[i].empty())
                sasiedztwa[i].push_back(-1);
        }
    }

    for (int i = 0; i <= V; i++)
    {
        spojne[i] = 0;
    }
    
    stack<int> stos;

    for (int i = 0; i < V; i++)
    {
        if (spojne[i] == 0 && sasiedztwa[i].empty() == false)
        {
            //printf("%d\n",i);
            licznik += 1;
            stos.push(i);
            spojne[i] = licznik;
            while (stos.empty() == false)
            {
                int v = stos.top();
                stos.pop();
                for (unsigned int j = 0; j < sasiedztwa[v].size(); j++)
                {
                    if (spojne[sasiedztwa[v][j]] == 0)
                    {
                        //printf("%d\n",sasiedztwa[v][j]);
                        stos.push(sasiedztwa[v][j]);
                        spojne[sasiedztwa[v][j]] = licznik;
                    }
                }
            }
        }
    }
    printf("%d \n", licznik);

    return 0;
}