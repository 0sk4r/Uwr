#include <cstdio>
#include <cstring>

using namespace std;

const int MAXN = 33;
const int MAXV = MAXN * MAXN;
const int MAXE = MAXV * 8;

const int 
    xi[8] = {-2, -1, 1, 2,  2,  1, -1, -2},
    yi[8] = { 1,  2, 2, 1, -1, -2, -2, -1};

int n, kolumny, e, v;
char a[MAXN][MAXN];
int d[MAXN][MAXN];
int last[MAXV], prev[MAXV], curr[MAXV];
int next[MAXE], yy[MAXE];
int id, flag[MAXV];

bool run(int x)
{
    if (flag[x] == id) return false;
    flag[x] = id;
    
    int i = last[x];
    while (i)
    {
        if (!prev[yy[i]] || run(prev[yy[i]]))
        {
            prev[yy[i]] = x;
            curr[x] = yy[i];
            return true;
        }
        i = next[i];
    }
    return false;
}

int main()
{
/*
    freopen("in", "r", stdin);
    freopen("out", "w", stdout);
//*/
        scanf("%d %d\n", &n, &kolumny);
        for (int i = 0; i < n; i++)
            gets(a[i]);
            
        memset(last, 0, sizeof(last));
        memset(prev, 0, sizeof(prev));
        memset(curr, 0, sizeof(curr));
        memset(flag, 0, sizeof(flag));
        e = v = 0;
        
        for (int i = 0; i < n; i++)
            for (int j = 0; j < kolumny; j++)
            {
                v += a[i][j] != '#';
                d[i][j] = (i * kolumny + j) / 2 + 1;
            }
            
            
        for (int i = 0; i < n; i++)
            for (int j = 0; j < kolumny; j++)
                if (a[i][j] != '#' && ((i + j) & 1))
                {
                    for (int l = 0; l < 8; l++)
                    {
                        int
                            x = i + xi[l],
                            y = j + yi[l];
                            
                        if (x < 0 || y < 0 || n <= x || kolumny <= y || a[x][y] == '#') continue;
                        
                        
                        e++;
                        yy[e] = d[x][y];
                        next[e] = last[d[i][j]];
                        last[d[i][j]] = e;
                        
                        if (!curr[d[i][j]] && !prev[d[x][y]])
                        {
                            curr[d[i][j]] = d[x][y];
                            prev[d[x][y]] = d[i][j];
                        }
                    }
                }
                
        for (id = 1; id <= (n * kolumny - 1) / 2 + 1; id++)
            if (!curr[id]) run(kolumny);
            
        for (int i = 1; i <= (n * kolumny - 1) / 2 + 1; i++)
            if (curr[i]) v--;
            
        printf("%d\n", v);
    return 0;
}