#include <exec/exec.h>
#include <clib/powerpc_protos.h>
#include <powerpc/memoryPPC.h>
#include "power.h"

void *PAllocMem(int size,unsigned int req)
{
        unsigned int flags=MEMF_CLEAR;
        if(req&PMEMF_NOCACHE)
                flags|=MEMF_CACHEOFF;
        return (AllocVecPPC(size,flags,8));
}

void PFreeMem(void *p)
{
        FreeVecPPC(p);
}
