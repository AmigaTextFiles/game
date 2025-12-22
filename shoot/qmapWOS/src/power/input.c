#include <exec/exec.h>
#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include "power.h"
#include "display.h"

int PLMBStatus()
{
        return (((*(volatile unsigned char *)0xbfe001)&0x40)==0L);
}

int PGetKey()
{
        int c;
        struct IntuiMessage *m;
        struct MsgPort *mp=*(struct MsgPort **)((char *)(aktdisplay->window)+86);
        m=(struct IntuiMessage *)GetMsg(mp);
        if(!m) return 0;
        if(*((int *)m+5)==IDCMP_VANILLAKEY) c=*((unsigned short *)m+12);
                else c=0;
        ReplyMsg((void *)m);
        return c;
}
