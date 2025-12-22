#include <exec/exec.h>
#include <clib/exec_protos.h>
#include "power.h"

//struct ExecBase *SysBase=0L;
struct IntuitionBase *IntuitionBase=0L;
struct GfxBase *GfxBase=0L;

int PInit(int argc,char *argv[])
{
        //SysBase=*(struct ExecBase **)4L;
        if(!(IntuitionBase=(struct IntuitionBase *)OpenLibrary("intuition.library",39L)))
                return -1;
        if(!(GfxBase=(struct GfxBase *)OpenLibrary("graphics.library",39L)))
                return -1;
        return 0;
}

void PDeinit()
{
        if(IntuitionBase)
                CloseLibrary((struct Library *)IntuitionBase);
        if(GfxBase)
                CloseLibrary((struct Library *)GfxBase);
}
