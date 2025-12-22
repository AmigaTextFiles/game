/* Timer.c: Copyright © 2000 Nogfx - Timer Functions for FlashbackNG */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <exec/types.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <graphics/displayinfo.h>
#include <dos/dos.h>
#include <graphics/gfx.h>

#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/alib_protos.h>
#include <clib/dos_protos.h>
#include <clib/lowlevel_protos.h>
#include <clib/timer_protos.h>

#include "timer.h"

struct Library *TimerBase;
struct MsgPort *TimerPort;
struct timerequest *TimeReq;
struct timerequest *ReturnTime;

struct timerequest *CreateTimer(ULONG theUnit)
{
    ULONG Error;

    if (!(TimerPort=CreatePort(NULL,0)))
        ReturnTime=NULL;
    
    if (!(TimeReq=(struct timerequest*)(CreateExtIO(TimerPort,sizeof(struct timerequest)))))
    {
        DeletePort(TimerPort);
        ReturnTime = NULL;
    }

    Error=OpenDevice((STRPTR)"timer.device", theUnit, (struct IORequest*)(TimeReq), 0);
    if (Error!=0)
    {
        DeleteExtIO((struct IORequest*)(TimeReq));
        DeletePort(TimerPort);
        ReturnTime = NULL;
    }

    TimerBase=(struct Library*)(TimeReq->tr_node.io_Device);
    ReturnTime=(struct timerequest*)(TimeReq);
    return(ReturnTime);
}

void DeleteTimer(struct timerequest *WhichTimer)
{
    struct MsgPort *WhichPort;

    if (WhichPort=WhichTimer->tr_node.io_Message.mn_ReplyPort)
    {
        CloseDevice((struct IORequest *)(WhichTimer));
        DeleteExtIO((struct IORequest *)(WhichTimer));
        DeletePort(WhichPort);
    }
}


BOOL Temps(struct timeval debut,struct timeval fin,int speed)
{
    BOOL temp=FALSE;
    GetSysTime(&fin);
    //printf("Sec fin:%d\n",fin.tv_secs>>24);

    SubTime(&fin,&debut);
    //if (  ((double)((fin.tv_secs & 0xFFFF)*1000+(double)(fin.tv_micro/1000000.0)*1000))>=vitesse) temp=TRUE;
    //printf("Sec fin:%d\n",fin.tv_secs>>24);
    if (((int)(fin.tv_micro/100)+(int)(10000*fin.tv_secs))>=speed)
        temp=TRUE;

    return(temp);
}

