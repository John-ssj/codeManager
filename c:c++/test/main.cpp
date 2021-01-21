#include <iostream>
#include <vector>
#include <map>
using namespace std;

#define OK 1

typedef int status;
typedef char ElemType; //数据元素类型定义

typedef struct HNode {  //树的结构定义
    ElemType data;
    struct HNode *lchild;
    struct HNode *rchild;
//    struct HNode *parent;
} HNode, *HTree;


/*-----page 19 on textbook ---------*/
status InitBiTree(HTree &T);
status DestroyBiTree(HTree &T);
status CreateBiTree(HTree &T);
status ClearBiTree(HTree &T);
bool BiTreeEmpty(HTree T);
int BiTreeDepth(HTree T);
status Value(HTree T, HTree &e);
status Assign(HTree T,HTree &e,ElemType value);
status Parent(HTree T,HTree &e);
status LeftChild(HTree T,HTree &e);
status RightChild(HTree T,HTree &e);
status LeftSibling(HTree T,HTree &e);
status RightSibling(HTree T,HTree &e);
status InsertChild(HTree T,HTree &e,char LR,HTree &T2);
status DeleteChild(HTree T,HTree &e,char LR);
void visit(HTree e);
status PreOrderTraverse(HTree T,void(* visit)(HTree e));
status InOrderTraverse(HTree T,void(* visit)(HTree e));
status PostOrderTraverse(HTree T,void(* visit)(HTree e));
status LevelOrderTraverse(HTree T,void(* visit)(HTree e));

status CreateHTree(HTree &T, map<char,string> &Hmap);
status HTreeCode(HTree T, map<char,string> Hmap);
status HTreeDecode(HTree T);
/*--------------------------------------------*/


int main() {
    HTree trees[20],e[20];
    map<char,string> Hmap;
    string code;
    int T = 1,op=1, tmp=0;
    char LR;
    ElemType value;
    for (HTree &t : trees) {
        t = nullptr;
    }
    while (op) {
//        cout<<"请选择你的操作:";
        cin>>op;
        switch (op) {
            case 1:
                InitBiTree(trees[T]);
//                if (InitBiTree(trees[T]) == OK) cout<<"二叉树创建成功！\n";
                break;
            case 2:
                if (!trees[T]) break;
                DestroyBiTree(trees[T]);
//                if (DestroyBiTree(trees[T]) == OK) cout<<"二叉树销毁成功！\n";
                break;
            case 3:
                CreateBiTree(trees[T]);
//                if (CreateBiTree(trees[T]) == OK) cout<<"二叉树创建成功！\n";
                break;
            case 4:
                if (!trees[T]) break;
                ClearBiTree(trees[T]);
//                if (ClearBiTree(trees[T]) == OK) cout<<"二叉树清空成功！\n";
                break;
            case 5:
                BiTreeEmpty(trees[T]);
//                if (BiTreeEmpty(trees[T])) cout<<"二叉树为空！\n";
//                else cout<<"二叉树非空！\n";
                break;
            case 6:
                if(!trees[T]) break;
                cout << BiTreeDepth(trees[T]) << endl;
                break;
            case 7:
                if(!trees[T]) break;
                e[T]=trees[T];
                cout << trees[T]->data << endl;
                break;
            case 8:
                if(!trees[T]) break;
                Value(trees[T], e[T]);
                break;
            case 9:
                if(!trees[T]) break;
                cin>>value;
                Assign(trees[T], e[T], value);
                break;
            case 10:
                if(!trees[T]) break;
                Parent(trees[T], e[T]);
                break;
            case 11:
                if(!trees[T]) break;
                LeftChild(trees[T], e[T]);
                break;
            case 12:
                if(!trees[T]) break;
                RightChild(trees[T], e[T]);
                break;
            case 13:
                if(!trees[T]) break;
                LeftSibling(trees[T], e[T]);
                break;
            case 14:
                if(!trees[T]) break;
                RightSibling(trees[T], e[T]);
                break;
            case 15:
                if(!trees[T]) break;
                cin>>LR>>tmp;
                InsertChild(trees[T], e[T], LR, trees[tmp]);
                break;
            case 16:
                if(!trees[T]) break;
                cin>>LR;
                DeleteChild(trees[T], e[T], LR);
                break;
            case 17:
                if(!trees[T]) break;
                PreOrderTraverse(trees[T], visit);
                cout<<endl;
                break;
            case 18:
                if(!trees[T]) break;
                InOrderTraverse(trees[T], visit);
                cout<<endl;
                break;
            case 19:
                if(!trees[T]) break;
                PostOrderTraverse(trees[T], visit);
                cout<<endl;
                break;
            case 20:
                if(!trees[T]) break;
                LevelOrderTraverse(trees[T], visit);
                cout<<endl;
                break;
            case 29:
                cin>>T;
//                cout << "设置当前二叉树序号:" << endl;
//                cin >> tmp;
//                if (tmp >= 1 && tmp <= 10) T = tmp;
//                else cout << "输入错误!" << endl;
                break;
            case 31:
                CreateHTree(trees[T],Hmap);
                break;
            case 32:
                HTreeCode(trees[T],Hmap);
                break;
            case 33:
                HTreeDecode(trees[T]);
                break;
            case 34:
            case 35:
                getline(cin,code);
                getline(cin,code);
                cout<<1<<endl;
                break;
            default:
                break;
        }//end of switch
    }//end of while
//    cout<<"欢迎下次再使用本系统！\n";
    return 0;
}//end of main()


status InitBiTree(HTree &T) {
    if (T) return OK;
    T = new HNode();
    T->lchild = nullptr;
    T->rchild = nullptr;
//    T->parent = nullptr;
    T->data = '\0';
    return OK;
}


status DestroyBiTree(HTree &T) {
    if (T->lchild) {
        DestroyBiTree(T->lchild);
        T->lchild = nullptr;
    }
    if (T->rchild) {
        DestroyBiTree(T->rchild);
        T->rchild = nullptr;
    }
    delete T;
    T = nullptr;
    return OK;
}


status CreateBiTree(HTree &T) {
    char ch;
    cin >> ch;
    if (ch == '^') T = nullptr;
    else {
        if (!T) T = new HNode();
        T->data = ch;
        CreateBiTree(T->lchild);
        CreateBiTree(T->rchild);
    }
    return OK;
}


status ClearBiTree(HTree &T) {
    DestroyBiTree(T);
    InitBiTree(T);
    return OK;
}

bool BiTreeEmpty(HTree T) {
    if (!T || T->data == '\0') {
        cout << 1 << endl;
        return true;
    } else {
        cout << 0 << endl;
        return false;
    }
}


int BiTreeDepth(HTree T) {
    if (T) {
        int left = BiTreeDepth(T->lchild);
        int right = BiTreeDepth(T->rchild);
        return (left > right) ? left + 1 : right + 1;
    }
    return 0;
}


status Value(HTree T, HTree &e){
    cout<<e->data<<endl;
    return OK;
}


status Assign(HTree T,HTree &e,ElemType value){
    e->data=value;
    return OK;
}


status InOrderFind(HTree T,HTree &e,int &f,void(* visit)(HTree T, HTree& e,int &f)){
    if(f) return OK;
    visit(T,e,f);
    if(T->lchild) InOrderFind(T->lchild,e,f,visit);
    if(T->rchild) InOrderFind(T->rchild,e,f,visit);
    return OK;
}


status Parent(HTree T,HTree &e){
    int flag=0;
    InOrderFind(T,e,flag,[](HTree T,HTree &e,int &f){
        if((T->lchild && T->lchild==e) || (T->rchild && T->rchild==e)) {
            cout<<T->data<<endl;
            e=T;
            f=1;
        }
    });
    if(!flag) cout<<'^'<<endl;
    return OK;
}


status LeftChild(HTree T,HTree &e){
    if(e->lchild){
        cout<<e->lchild->data<<endl;
        e=e->lchild;
    } else {
        cout<<'^'<<endl;
    }
    return OK;
}


status RightChild(HTree T,HTree &e){
    if(e->rchild){
        cout<<e->rchild->data<<endl;
        e=e->rchild;
    } else {
        cout<<'^'<<endl;
    }
    return OK;
}


status LeftSibling(HTree T,HTree &e){
    int flag=0;
    InOrderFind(T,e,flag,[](HTree T,HTree &e,int &f){
        if((T->lchild && T->lchild==e) || (T->rchild && T->rchild==e)) {
            f=1;
            if(T->rchild==e && T->lchild){
                f=2;
                cout<<T->lchild->data<<endl;
                e=T->lchild;
            }
        }
    });
    if(flag<2) cout<<'^'<<endl;
    return OK;
}


status RightSibling(HTree T,HTree &e){
    int flag=0;
    InOrderFind(T,e,flag,[](HTree T,HTree &e,int &f){
        if((T->lchild && T->lchild==e) || (T->rchild && T->rchild==e)) {
            f=1;
            if(T->lchild==e && T->rchild){
                f=2;
                cout<<T->rchild->data<<endl;
                e=T->rchild;
            }
        }
    });
    if(flag<2) cout<<'^'<<endl;
    return OK;
}


status InsertChild(HTree T,HTree &e,char LR,HTree &T2){
    HTree p;
    if(LR=='L') {
        p=e->lchild;
        e->lchild=T2;
        T2->rchild=p;
    }else{
        p=e->rchild;
        e->rchild=T2;
        T2->rchild=p;
    }
    return OK;
}


status DeleteChild(HTree T,HTree &e,char LR){
    if(LR=='L'){
        DestroyBiTree(e->lchild);
        e->lchild=nullptr;
    }else{
        DestroyBiTree(e->rchild);
        e->rchild=nullptr;
    }
    return OK;
}


void visit(HTree e){
    cout<<e->data;
}


status PreOrderTraverse(HTree T,void(* visit)(HTree e)){
    visit(T);
    if(T->lchild) PreOrderTraverse(T->lchild,visit);
    if(T->rchild) PreOrderTraverse(T->rchild,visit);
    return OK;
}



status InOrderTraverse(HTree T,void(* visit)(HTree e)){
    vector<HNode*> S;
    HNode *p=T;
    while (p || !S.empty()){
        if(p){
            S.push_back(p);
            p=p->lchild;
        }else{
            p=S.back();
            S.pop_back();
            visit(p);
            p=p->rchild;
        }
    }
    return OK;
}


status PostOrderTraverse(HTree T,void(* visit)(HTree e)){
    if(T->lchild) PostOrderTraverse(T->lchild,visit);
    if(T->rchild) PostOrderTraverse(T->rchild,visit);
    visit(T);
    return OK;
}


status LevelOrderTraverse(HTree T,void(* visit)(HTree e)){
    vector<HNode*> rel;
    rel.insert(rel.begin(),T);
    while (!rel.empty())
    {
        HNode* front = rel.back();
        visit(front);
        rel.pop_back();
        if(front->lchild) rel.insert(rel.begin(),front->lchild);
        if(front->rchild) rel.insert(rel.begin(),front->rchild);
    }
    return OK;
}


status CreateHTreeNodes(HTree &T,const string& definition,int &num){
    char ch = definition[num++];
    if (ch == '^') T = nullptr;
    else {
        if (!T) T = new HNode();
        T->data = ch;
        CreateHTreeNodes(T->lchild,definition,num);
        CreateHTreeNodes(T->rchild,definition,num);
    }
    return OK;
}

//status FindAllParents(HTree &T){
//    if(T->lchild) {
//        T->lchild->parent=T;
//        FindAllParents(T->lchild);
//    }
//    if(T->rchild){
//        T->rchild->parent=T;
//        FindAllParents(T->rchild);
//    }
//    return OK;
//}

bool is_LeafNode(HTree T){
    if(T->lchild || T->rchild) return false;
    return true;
}


status CreateHMap(HTree &T, map<char,string> &Hmap, vector<char> &Hcode){
    if(is_LeafNode(T)) {
        string S;
        for(char & i : Hcode) {
            S += i;
        }
//        cout<<T->data<<"=="<<S<<endl;
        Hmap[T->data] = S;
    } else {
        if(T->lchild){
            Hcode.push_back('0');
            CreateHMap(T->lchild,Hmap,Hcode);
            Hcode.pop_back();
        }
        if(T->rchild){
            Hcode.push_back('1');
            CreateHMap(T->rchild,Hmap,Hcode);
            Hcode.pop_back();
        }
    }
    return OK;
}


status CreateHTree(HTree &T, map<char,string> &Hmap){
    int num=0;
    vector<char> Hcode;
    string definition;
    getline(cin,definition);
    getline(cin,definition);
    CreateHTreeNodes(T,definition,num);
//    FindAllParents(T);
    CreateHMap(T,Hmap,Hcode);
    return OK;
}


status HTreeCode(HTree T, map<char,string> Hmap){
    int num=0;
    vector<char> code;
    string definition;
    getline(cin,definition);
    getline(cin,definition);
    for(char ch : definition){
        cout<<Hmap[ch];
    }
    cout<<endl;
    return OK;
}


status HTreeDecode(HTree T){
    int num=0;
    HNode *p=T;
    string code;
    getline(cin,code);
    getline(cin,code);
    code+='\n';
    while(code[num]!='\n'){
        if(code[num]=='0'){
            p=p->lchild;
        }else{
            p=p->rchild;
        }
        num++;
        if(p->lchild || p->rchild) continue;
        cout<<p->data;
        p=T;
    }
    cout<<endl;
    return OK;
}