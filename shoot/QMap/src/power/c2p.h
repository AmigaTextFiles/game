#ifndef PC2P_H
#define PC2P_H

#include <graphics/gfx.h>
#include "display.h"

void PChk2Pl(struct BitMap *,char *,unsigned int,unsigned int,unsigned int,unsigned int);
void PChk2Pl24(struct BitMap *,unsigned long *,unsigned int,unsigned int,unsigned int,unsigned int);
void PInit24BitMode(struct PDisplay *);

#endif
