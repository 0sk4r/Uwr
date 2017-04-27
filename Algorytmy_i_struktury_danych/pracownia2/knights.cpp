#include <cstdio>

const int dr[8]={-2, -1,  1,  2, 2,1, -1, -2};
const int dc[8]={-1, -2, -2, -1, 1,2, 2, 1};

int M, N = 3;
int board[30][30];

inline bool inbounds(int r, int c){
	return 0<=r && r<M && 0<=c && c<N;
}

int dfs(int r, int c, char seen[30][30]){
	if(seen[r][c] || board[r][c]==-1)
    {return 0;}
	seen[r][c]=1;
	for(int d=0; d<8; d++){
		int nr=r+dr[d];
		int nc=c+dc[d];
		if(inbounds(nr, nc)){
			int &val=board[nr][nc];
			if(!val || (val>0 && dfs(val/32, val%32, seen))){
                
                val=r*32+c;
                return 1;
			}
		}
    }
	return 0;
}

void readinput(){
	scanf("%d", &M);
	char line[50];
	for(int i=0; i<M; i++){
        scanf("%s", line);
		for(int j=0; j<N; j++)
			board[i][j]= line[j]=='.' ? 0 : -1;
	}
}

int solve(){
	int res=0;
	for(int i=0; i<M; i++)
	for(int j=0; j<N; j++)
		if(board[i][j]!=-1){
			res++;
			if((i^j)&1){
                
				char seen[30][30]={{0}}; 
				res-=dfs(i, j, seen);
			}
		}
	return res;
}

int main(){

		readinput();
        
		printf("%d\n", solve());
        for(int i=0; i<M; i++){
            for(int j=0; j<N; j++){
                {if (board[i][j]== 0) printf("S");
                else if  (board[i][j]== -1) printf("x");
                else (printf("."));
                }
            
            }
            printf("\n");
        }
	return 0;
}
