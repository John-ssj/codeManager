#include <stdio.h>
#include <stdlib.h>

int i = 0;

typedef int elemType;
typedef enum {
    ERROR = 0, OK = 1
} Status;
typedef enum {
    False = 0, True = 1
} Bool;
typedef enum {
    Lh = -1, Eh = 0, Rh = 1
} Balance;
typedef struct AVLTNode {
    elemType data;
    Balance bf;
    struct AVLTNode *lchild, *rchild;
} AVLTNode, *AVLTree;

void R_Rotate(AVLTree *T) {
    AVLTNode *lc = (*T)->lchild;
    (*T)->lchild = lc->rchild;
    lc->rchild = (*T);
    (*T) = lc;
}


void L_Rotate(AVLTree *T) {
    AVLTNode *rc = (*T)->rchild;
    (*T)->rchild = rc->lchild;
    rc->lchild = (*T);
    (*T) = rc;
}


void LeftBalance(AVLTree *T) {
    AVLTNode *lc = (*T)->lchild, *lrc;
    switch (lc->bf) {
        case Lh:
            (*T)->bf = Eh;
            lc->bf = Eh;
            R_Rotate(T);
            return;
        case Rh:
            lrc = lc->rchild;
            switch (lrc->bf) {
                case Lh:
                    (*T)->bf = Rh;
                    lc->bf = Eh;
                    break;
                case Eh:
                    (*T)->bf = Eh;
                    lc->bf = Eh;
                    break;
                case Rh:
                    (*T)->bf = Eh;
                    lc->bf = Lh;
                    break;
            }
            lrc->bf = Eh;
            L_Rotate(&((*T)->lchild));
            R_Rotate(T);
            return;
        default:
            return;
    }
}


void RightBalance(AVLTree *T) {
    AVLTNode *rc = (*T)->rchild, *rlc;
    switch (rc->bf) {
        case Rh:
            (*T)->bf = Eh;
            rc->bf = Eh;
            L_Rotate(T);
            return;
        case Lh:
            rlc = rc->lchild;
            switch (rlc->bf) {
                case Lh:
                    (*T)->bf = Eh;
                    rc->bf = Rh;
                    break;
                case Eh:
                    (*T)->bf = Eh;
                    rc->bf = Eh;
                    break;
                case Rh:
                    (*T)->bf = Lh;
                    rc->bf = Eh;
                    break;
            }
            rlc->bf = Eh;
            R_Rotate(&((*T)->rchild));
            L_Rotate(T);
            return;
        default:
            return;
    }
}


Status InsertAVL(AVLTree *T, elemType e, Bool *taller) {
    if (!(*T)) {
        *T = (AVLTNode *) malloc(sizeof(AVLTNode));
        if (!(*T)) {
            printf("Error!\n");
            return ERROR;
        }
        (*T)->lchild = (*T)->rchild = NULL;
        (*T)->data = e;
        (*T)->bf = Eh;
        *taller = True;
    } else {
        if ((*T)->data == e) {
            *taller = False;
            return ERROR;
        }
        if ((*T)->data > e) {
            if (InsertAVL(&((*T)->lchild), e, taller) == ERROR) return ERROR;
            if (*taller) {
                switch ((*T)->bf) {
                    case Lh:
                        LeftBalance(T);
                        *taller = False;
                        break;
                    case Eh:
                        (*T)->bf = Lh;
                        *taller = True;
                        break;
                    case Rh:
                        (*T)->bf = Eh;
                        *taller = False;
                        break;
                }
            }
        } else {
            if (InsertAVL(&((*T)->rchild), e, taller) == ERROR) return ERROR;
            if (*taller){
                switch ((*T)->bf) {
                    case Lh:
                        (*T)->bf = Eh;
                        *taller = False;
                        break;
                    case Eh:
                        (*T)->bf = Rh;
                        *taller = True;
                        break;
                    case Rh:
                        RightBalance(T);
                        *taller = False;
                        break;
                }
            }
        }
    }
    return OK;
}


int VistAVL(AVLTree T, elemType e) {
    i++;
    if (e == T->data) {
        return T->data;
    }
    if (e < T->data) {
        if (T->lchild == NULL) return ERROR;
        return VistAVL(T->lchild, e);
    } else {
        if (T->rchild == NULL) return ERROR;
        return VistAVL(T->rchild, e);
    }
}

int main() {
    AVLTree T = NULL,p;
    int e;
    int look=0;
    Bool taller;
    while (1) {
        scanf("%d", &e);
        if (e == 0) break;
        InsertAVL(&T, e, &taller);
//        printf("是否查看结构？");
//        scanf("%d",&look);
//        if(look){
//            p=T;
//            while (1) {
//                scanf("%d", &e);
//                if (e == 0) break;
//                if (e == 1) {
//                    p = p->lchild;
//                } else {
//                    p = p->rchild;
//                }
//            }
//            look=0;
//        }
    }
    printf("OK\n");
    while (1){
        i=0;
        scanf("%d",&e);
        if(e==0) break;
        printf("e=%d,i=%d\n",VistAVL(T, e),i);
    }
    return 0;
}
