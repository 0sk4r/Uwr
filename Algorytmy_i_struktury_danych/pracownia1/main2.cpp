#include "stdio.h"
#include "queue"
using namespace std;

int main()
{
    int n, m;
    char map[2000][2002];
    char buffer[2002];
    int odwiedzony[2000][2000];
    int licznik = 0;

    fgets(buffer,15, stdin);
    sscanf(buffer, "%d %d", &n, &m);

    for (int i = 0; i < n; i++)
    {
        fgets(map[i], m + 2, stdin);
    }

    queue<int> kolejka;
    
     for (int x = 0; x < n; x++)
    {
        for (int y = 0; y < m; y++)
        {
            odwiedzony[x][y]=0;
        }
        }
    for (int x = 0; x < n; x++)
    {
        for (int y = 0; y < m; y++)
        {
            if (odwiedzony[x][y] == 0 && map[x][y] != 'A')
            {
                licznik += 1;
                kolejka.push(x * m + y);
                odwiedzony[x][y] = 1;
                while (!kolejka.empty())
                {
                    int v = kolejka.front();
                    kolejka.pop();
                    int i = v / m;
                    int j = v % m;

                    if (map[i][j] == 'B')
                    {
                        if ((map[i][j - 1] == 'D' || map[i][j - 1] == 'E' || map[i][j - 1] == 'F') && j!=0)
                        {
                            if (odwiedzony[i][j - 1] == 0)
                            {
                                kolejka.push(i * m + j - 1);
                                odwiedzony[i][j - 1] = 1;
                            }
                        }

                        if ((map[i + 1][j] == 'C' || map[i+1][j] == 'D' || map[i+1][j] == 'F') && i!=n-1)
                        {
                            if (odwiedzony[i + 1][j] == 0)
                            {
                                kolejka.push((i + 1) * m + j);
                                odwiedzony[i + 1][j] = 1;
                            }
                        }
                    }

                    if (map[i][j] == 'C')
                    {
                        if ((map[i - 1][j] == 'B' || map[i - 1][j] == 'E' || map[i - 1][j] == 'F') && i != 0)
                        {
                            if (odwiedzony[i - 1][j] == 0)
                            {
                                kolejka.push((i - 1) * m + j);
                                odwiedzony[i - 1][j] = 1;
                            }
                        }
                        if ((map[i][j - 1] == 'D' || map[i][j - 1] == 'E' || map[i][j - 1] == 'F')  && j!=0)
                        {
                            if (odwiedzony[i][j - 1] == 0)
                            {
                                kolejka.push(i * m + j - 1);
                                odwiedzony[i][j - 1] = 1;
                            }
                        }
                    }

                    if (map[i][j] == 'D')
                    {
                        if ((map[i - 1][j] == 'B' || map[i - 1][j] == 'E' || map[i - 1][j] == 'F') && i != 0)
                        {
                            if (odwiedzony[i - 1][j] == 0)
                            {
                                kolejka.push((i - 1) * m + j);
                                odwiedzony[i - 1][j] = 1;
                            }
                        }
                        if ((map[i][j + 1] == 'B' || map[i][j + 1] == 'C' || map[i][j+1] == 'F') && j!= m-1)
                        {
                            if (odwiedzony[i][j + 1] == 0)
                            {
                                kolejka.push(i * m + j + 1);
                                odwiedzony[i][j + 1] = 1;
                            }
                        }
                    }

                    if(map[i][j]=='E'){
                         if ((map[i][j + 1] == 'B' || map[i][j + 1] == 'C' || map[i][j+1] == 'F') && j!=m-1)
                        {
                            if (odwiedzony[i][j + 1] == 0)
                            {
                                kolejka.push(i * m + j + 1);
                                odwiedzony[i][j + 1] = 1;
                            }
                        }
                        if ((map[i + 1][j] == 'C' || map[i+1][j] == 'D' || map[i+1][j] == 'F') && i != n-1)
                        {
                            if (odwiedzony[i + 1][j] == 0)
                            {
                                kolejka.push((i + 1) * m + j);
                                odwiedzony[i + 1][j] = 1;
                            }
                        }
                    }

                    if (map[i][j] == 'F')
                    {

                        if ((map[i][j - 1] == 'D' || map[i][j - 1] == 'E' || map[i][j - 1] == 'F')  && j!=0)
                        {
                            if (odwiedzony[i][j - 1] == 0)
                            {
                                kolejka.push(i * m + j - 1);
                                odwiedzony[i][j - 1] = 1;
                            }
                        }

                        if ((map[i][j + 1] == 'B' || map[i][j + 1] == 'C' || map[i][j +1] == 'F') && j!=m-1)
                        {
                            if (odwiedzony[i][j + 1] == 0)
                            {
                                kolejka.push(i * m + j + 1);
                                odwiedzony[i][j + 1] = 1;
                            }
                        }

                        if ((map[i - 1][j] == 'B' || map[i - 1][j] == 'E' || map[i - 1][j] == 'F') && i != 0)
                        {
                            if (odwiedzony[i - 1][j] == 0)
                            {
                                kolejka.push((i - 1) * m + j);
                                odwiedzony[i - 1][j] = 1;
                            }
                        }

                        if ((map[i + 1][j] == 'C' || map[i+1][j] == 'D' || map[i+1][j] == 'F') && i!=n-1)
                        {
                            if (odwiedzony[i + 1][j] == 0)
                            {
                                kolejka.push((i + 1) * m + j);
                                odwiedzony[i + 1][j] = 1;
                            }
                        }
                    }
                }
            }
        }
    }


    printf("%d \n",licznik);
}