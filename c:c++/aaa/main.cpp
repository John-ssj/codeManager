#include <iostream>
#include <vector>
using namespace std;

int main(){
    int n,m,u,v,sum=0;
    cin>>n>>m;
    int time[n],list[n];
    vector<int> relate[n],stack;
    for(int i=0;i<n;i++){
        cin>>time[i];
        list[i]=0;
    }
    for(int i=0;i<m;i++){
        cin>>u>>v;
        relate[v-1].push_back(u-1);
    }
    sum += time[n-1];
    list[n-1]=1;

    for(int each=0;each<relate[n-1].size();each++){
        stack.push_back(relate[n-1][each]);
    }
    for(int a : stack){
        if (list[a]==1) continue;
        sum+=time[a];
        list[a]=1;
        for(int each=0;each<relate[a].size();each++){
            stack.push_back(relate[a][each]);
        }
    }
    cout<<sum;
    return 0;
}