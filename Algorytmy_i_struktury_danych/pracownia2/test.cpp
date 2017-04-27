#include<bits/stdc++.h>
#define fr(x) scanf("%d",&x)
using namespace std;

char s[35][35];
int IDX=0;
vector<int> g[1000];
int match[1000],vis[1000],tym=0;
int index1[35][35];

int aug(int l){
    if(vis[l]==tym)return 0;
    vis[l]=tym;
    for(auto&r:g[l]){
        if(match[r]==-1||aug(match[r])){
            match[r]=l;
            return 1;
        }
    }
    return 0;
}

int main(){
    int t,m,n,mcbm,sub;
    fr(t);
    while(t--){
        fr(m);fr(n);
        mcbm=0;
        sub=0;
        for(int i=0;i<1000;++i)g[i].clear();
        IDX=0;
        for(int i=0;i<m;++i)scanf("%s",&s[i]);
        //traverse all blak cells 0,0 is black all cells(i,j) such that i+j=even are black
        for(int i=0;i<m;++i){
            for(int j=0;j<n;++j){
                if(s[i][j]=='.')index1[i][j]=++IDX;
                else index1[i][j]=-1,++sub;
            }
        }
        for(int i=0;i<m;++i){
            for(int j=(i&1);j<n;j+=2){
                if(index1[i][j]==-1)continue;
                
                if(i>1&&j>0&&index1[i-2][j-1]!=-1)g[index1[i][j]].emplace_back(index1[i-2][j-1]);
                if(i>1&&j<n-1&&index1[i-2][j+1]!=-1)g[index1[i][j]].emplace_back(index1[i-2][j+1]);
                if(i<m-2&&j>0&&index1[i+2][j-1]!=-1)g[index1[i][j]].emplace_back(index1[i+2][j-1]);
                if(i<m-2&&j<n-1&&index1[i+2][j+1]!=-1)g[index1[i][j]].emplace_back(index1[i+2][j+1]);
                
                if(i>0&&j>1&&index1[i-1][j-2]!=-1)g[index1[i][j]].emplace_back(index1[i-1][j-2]);
                if(j>1&&i<m-1&&index1[i+1][j-2]!=-1)g[index1[i][j]].emplace_back(index1[i+1][j-2]);
                if(j<n-2&&i>0&&index1[i-1][j+2]!=-1)g[index1[i][j]].emplace_back(index1[i-1][j+2]);
                if(j<n-2&&i<m-1&&index1[i+1][j+2]!=-1)g[index1[i][j]].emplace_back(index1[i+1][j+2]);
            }
        }
        memset(match,-1,sizeof(match));
        for(int i=0;i<m;++i){
            for(int j=(i&1);j<n;j+=2){
                if(index1[i][j]==-1)continue;
                ++tym;
                mcbm+=aug(index1[i][j]);
            }
        }
        printf("%d\n",m*n-mcbm-sub);
    }
    return 0;
}
