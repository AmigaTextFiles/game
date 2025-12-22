#ifndef _GOUTILS_H
#define _GOUTILS_H

#include "case.h"

#define PLAYER_NAME(color) ((color==-1)?"empty":((color==0)?"black":"white"))

char *getStrPos (int x, int y);
Case strToCase (char *s);

#endif