#ifndef ENTROPY_H
#define ENTROPY_H 1

#ifndef __amigaos4__
#include "os4_types.h"
#endif

#include <devices/timer.h>

typedef struct IOStdReq entropy;


/* entropy.c */
entropy *OpenEntropy (void);
void CloseEntropy (entropy *io);
void GenEntropy (entropy *io, void *ptr, int32 ln);

#endif
