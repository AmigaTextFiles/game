#include <exec/exec.h>
#include <powerup/ppcproto/exec.h>
#include <powerup/ppcproto/intuition.h>
#include "power.h"
#include "display.h"

int PLMBStatus()
{
	if(aktdisplay->screen)
		return (((*(volatile unsigned char *)0xbfe001)&0x40)==0L);
	else
	{
		struct IntuiMessage *m;
		m=(struct IntuiMessage *)GetMsg(aktdisplay->window->UserPort);
		if(m)
		{
			ULONG c;
			c=m->Class;
			ReplyMsg(m);
			if(c==IDCMP_CLOSEWINDOW)
				return 1L;
		}
		return 0L;
	}
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
	ReplyMsg(m);
	return c;
}
