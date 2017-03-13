#include "stdio.h"
#include <string>
#include "vector"
#include "stack"
#include "iostream"
using namespace std;

int main()
{
    int n, m;
    if (scanf("%d %d\n", &n, &m) < 0)
    {
    }
    int V = n * m;
    char buffer1[m + 2], buffer2[m + 2];
    vector<int> sasiedztwa[V + 2];
    int spojne[V];
    int licznik = 0;
    int kol = 0;
    /*
    for (int i = 0; i < n; i++)
    {
        char buffer[m];
        if (scanf("%s", buffer) < 0)
        {
        }
        wiersz += buffer;
    }
*/
        
    scanf("%s", buffer1);
    scanf("%s", buffer2);
    for (int j = 0; j <n; j++)
    {
        for (int i = 0; i < m; i++)
        {
            kol = licznik + i;
            //printf("%d \n",kol);  
            if (buffer1[i] == 'A')
            {
            }
            else if (buffer1[i] == 'B')
            {
                if ((buffer2[i] == 'C' || buffer2[i] == 'D' || buffer2[i] == 'F') && (kol / m != n-1))
                {
                    sasiedztwa[kol].push_back(kol + m);
                    sasiedztwa[kol + m].push_back(kol);
                }
                if (sasiedztwa[kol].empty())
                    sasiedztwa[kol].push_back(-1);
            }
            else if (buffer1[i] == 'D')
            {
                if ((buffer1[i + 1] == 'C' || buffer1[i + 1] == 'B' || buffer1[i + 1] == 'F') && (i !=m-1))
                {
                    sasiedztwa[kol].push_back(kol + 1);
                    sasiedztwa[kol + 1].push_back(kol);
                }
                if (sasiedztwa[kol].empty())
                    sasiedztwa[kol].push_back(-1);
            }
            else if (buffer1[i] == 'E')
            {
                if ((buffer1[i + 1] == 'B' || buffer1[i + 1] == 'C' || buffer1[i + 1] == 'F') && (i !=m-1))
                {
                    sasiedztwa[kol].push_back(kol + 1);
                    sasiedztwa[kol + 1].push_back(kol);
                }
                if ((buffer2[i] == 'C' || buffer2[i] == 'D' || buffer2[i] == 'F') && (kol / m != n-1))
                {
                    sasiedztwa[kol].push_back(kol + m);
                    sasiedztwa[kol + m].push_back(kol);
                }
                if (sasiedztwa[kol].empty())
                    sasiedztwa[kol].push_back(-1);
            }
            else if (buffer1[i] == 'F')
            {
                if ((buffer1[i + 1] == 'B' || buffer1[i + 1] == 'C' || buffer1[i + 1] == 'F') && (i !=m-1))
                {
                    //printf("test1");
                    sasiedztwa[kol].push_back(kol + 1);
                    sasiedztwa[kol + 1].push_back(kol);
                }
                if ((buffer2[i] == 'C' || buffer2[i] == 'D' || buffer2[i] == 'F') && (kol / m != n-1))
                {

                    sasiedztwa[kol].push_back(kol + m);
                    sasiedztwa[kol + m].push_back(kol);
                }
                if (sasiedztwa[kol].empty())
                {
                    //printf("test1");
                    sasiedztwa[kol].push_back(-1);
                }
            }
            else if (buffer1[i] == 'C')
            {
                if (sasiedztwa[kol].empty())
                    sasiedztwa[kol].push_back(-1);
            }
        }

        for (int x = 0; x < m; x++)
        {
            buffer1[x] = buffer2[x];
        }
        //*buffer1 = *buffer2;
        scanf("%s", buffer2);
        licznik += m;
    }
    
    /*

    for (int i = 0; i <= V; i++) // wypisujemy graf
    {
        cout << endl
             << "Sasiedzi wierzcholka " << i << ": ";
        for (vector<int>::iterator it = sasiedztwa[i].begin(); it != sasiedztwa[i].end(); ++it)
            cout << *it << ", ";
    }
    */
    
    for (int i = 0; i <= V; i++)
    {
        spojne[i] = 0;
    }

    stack<int> stos;
licznik = 0;
    for (int i = 0; i < V; i++)
    {
        if (spojne[i] == 0 && sasiedztwa[i].empty() == false)
        {
            licznik += 1;
            if (sasiedztwa[i][0] != -1)
            {
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
                            stos.push(sasiedztwa[v][j]);
                            spojne[sasiedztwa[v][j]] = licznik;
                        }
                    }
                }
            }
        }
    }
    printf("%d \n", licznik);
    return 0;

}