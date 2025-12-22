/*
**
**  Bruce.h
**
**  generic header file
**
*/

#define Prototype   extern
#define Local	    static

#define INIT_MINLIST(l) { \
    (l)->mlh_Head = (struct Node *) (&(l)->mlh_Tail); \
    (l)->mlh_Tail = NULL; \
    (l)->mlh_TailPred = (struct Node *) (&(l)->mlh_Head); \
}

#define INIT_LIST(l,t) { \
    INIT_MINLIST(((struct MinList *)(l))); \
    (l)->lh_Type = t; \
}

#include "prog_protos.h"

