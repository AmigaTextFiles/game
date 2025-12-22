/* BulletMe by Troels Walsted Hansen <troels@stud.cs.uit.no>.
**
** Source included for your enjoyment, feel free to modify at will.
** The neat 8-way symmetric circle drawing algorithm is from 
** http://graphics.lcs.mit.edu/~mcmillan/comp136/Lecture7/circle.html,
** and the commodity code is from a C= example. The rest is my own mess.
*/

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/layers.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/commodities.h>
#include <proto/icon.h>

#include <clib/cgxsystem_protos.h>
#include <pragmas/cgxsystem_pragmas.h>

#include <exec/memory.h>
#include <dos/dos.h>
#include <graphics/regions.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>

#include <stdlib.h>

#define REG(x)  register __## x
#define LVOCloseWindow -0x48
typedef void * __asm (*CloseWindow_t)(REG(a0) struct Window *, REG(a6) struct Library *);

struct HoleNode
{
	struct MinNode hn_Node;
	struct Window *hn_Window;
	struct Region *hn_Region;
};

extern void kprintf(const char *, ...);

STRPTR FindVictimWindow(void);
STRPTR Shoot(struct Window *win, ULONG x, ULONG y, ULONG radius);
struct HoleNode *FindHole(struct List *list, struct Window *win);
void CirclePoints(UBYTE *buf, int r, int cx, int cy, int x, int y);
void CircleMidpoint(UBYTE *buf, int diagonal, int radius);
__inline void setbit(UBYTE *array, int bit);
__inline int getbit(UBYTE *array, int bit);
void __asm __saveds of_CloseWindow(REG(a0) struct Window *window, REG(a6) struct Library *base);

#define VERSION    "1.0"
#define EVT_HOTKEY 1L
#define MAX_RADIUS 25
#define MIN_RADIUS 7

static const char *version = "$VER: BulletMe " VERSION " " __AMIGADATE__;

struct Library *CGXSystemBase = NULL;
struct Screen *scr = NULL;
struct List HoleList;
struct SignalSemaphore HLSemaphore;
CloseWindow_t int_CloseWindow = NULL;

struct NewBroker newbroker =
{
    NB_VERSION,
    "BulletMe",           
    "BulletMe " VERSION " " __AMIGADATE__,
    "Shoot the sheriff",
    NBU_UNIQUE | NBU_NOTIFY,    
    0, 0, 0, 0   
};

int main(int argc, char **argv)
{
	int retval = RETURN_FAIL;
	BOOL running = TRUE;
	STRPTR error = NULL;
	UBYTE *hotkey, **ttypes = NULL;
	struct MsgPort *broker_mp = NULL;
	ULONG cxsigflag;
	CxObj *broker = NULL, *filter, *sender, *translate;
	CxMsg *msg;
	struct HoleNode *hn;
	struct EasyStruct es;

	NewList(&HoleList);
	InitSemaphore(&HLSemaphore);
	ttypes = ArgArrayInit(argc, argv);

	/* init things */

	if(!(CGXSystemBase = OpenLibrary("cgxsystem.library", 41)) ||
	    (CGXSystemBase->lib_Version == 41 && CGXSystemBase->lib_Revision < 7))
	{
		error = "Requires CyberGraphX V3 r64 or higher (cgxsystem.library V41.7+)";
		goto done;
	}

	if(!(scr = LockPubScreen(NULL)))
	{
		error = "Couldn't lock default public screen";
		goto done;
	}

	/* init cx stuff */

	if(!(broker_mp = CreateMsgPort()))
	{
		error = "Couldn't create msgport";
		goto done;
	}

	newbroker.nb_Port = broker_mp;
	cxsigflag = 1L << broker_mp->mp_SigBit;
	
	newbroker.nb_Pri = (BYTE)ArgInt(ttypes, "CX_PRIORITY", 0);
	hotkey = ArgString(ttypes, "HOTKEY", "rawmouse leftbutton mouse_leftpress");

	if(!(broker = CxBroker(&newbroker, NULL)))
	{
		error = "Couldn't create new CX broker";
		goto done;
	}

	if(!(filter = CxFilter(hotkey)))
	{
		error = "Couldn't create cxfilter";
		goto done;
	}

	AttachCxObj(broker, filter);
	
	if(!(sender = CxSender(broker_mp, EVT_HOTKEY)))
	{
		error = "Couldn't create cxsender";
		goto done;
	}

	AttachCxObj(filter, sender);
	
	if(!(translate = (CxTranslate(NULL))))
	{
		error = "Couldn't create cxtranslate";
		goto done;
	}

	AttachCxObj(filter, translate);
	
	if(CxObjError(filter))
	{
		error = "Internal cx error";
		goto done;
	}
		
	ActivateCxObj(broker, 1L);

	/* patch intuition */

	Disable();
	int_CloseWindow  = (CloseWindow_t)SetFunction((struct Library *)IntuitionBase, LVOCloseWindow, (APTR)of_CloseWindow);
	Enable();

	/* Fill in EasyStruct */
	es.es_StructSize   = sizeof(struct EasyStruct);
	es.es_Flags        = 0;
	es.es_Title        = "BulletMe";
	es.es_TextFormat   = "Warning: Removing the patch is dangerous!\nRemove anyway?";
	es.es_GadgetFormat = "Yes|No";

	/* input loop */

	while(running)
	{
	   ULONG sigrcvd, msgid, msgtype;
	
	    sigrcvd = Wait(SIGBREAKF_CTRL_C | cxsigflag);
	
	    while(msg = (CxMsg *)GetMsg(broker_mp))
	    {
	        msgid = CxMsgID(msg);
	        msgtype = CxMsgType(msg);
	        ReplyMsg((struct Message *)msg);
	
	        switch(msgtype)
	        {
	            case CXM_IEVENT:
	                switch(msgid)
	                {
	                    case EVT_HOTKEY:
								{
									error = FindVictimWindow();
									if(error) running = FALSE;
	                        break;
								}
	                    default:
	                        break;
	                }
	                break;
	            case CXM_COMMAND:
	                switch(msgid)
	                {
	                    case CXCMD_DISABLE:
	                        ActivateCxObj(broker, 0L);
	                        break;
	                    case CXCMD_ENABLE:
	                        ActivateCxObj(broker, 1L);
	                        break;
	                    case CXCMD_KILL:
	                        running = FALSE;
	                        break;
	                    case CXCMD_UNIQUE:
	                        running = FALSE;
	                        break;
	                    default:
	                        break;
	                }
	                break;
	            default:
                break;
	        }
	    }
	    if (sigrcvd & SIGBREAKF_CTRL_C)
	        running = FALSE;

		if(!running &&	!FindPort("SetMan") && 
		   !EasyRequestArgs(NULL, &es, NULL, NULL))
			running = TRUE;
	}

	retval = RETURN_OK;
done:
	if(error) Printf("%s\n", error);

	ObtainSemaphore(&HLSemaphore);

	while((hn = (struct HoleNode *)RemHead(&HoleList)))
	{
		InstallTransparentRegion(hn->hn_Window->WLayer, NULL);
		DisposeRegion(hn->hn_Region);
		FreeMem(hn, sizeof(struct HoleNode));
	}

	if(int_CloseWindow)
	{
		Disable();
		SetFunction((struct Library *)IntuitionBase, LVOCloseWindow, (APTR)int_CloseWindow);
		Enable();
	}

	if(broker) DeleteCxObjAll(broker);

	if(broker_mp)
	{
		while(msg = (CxMsg *)GetMsg(broker_mp))
			ReplyMsg((struct Message *)msg);

		DeletePort(broker_mp);
	}

	ArgArrayDone();
	if(scr)           UnlockPubScreen(NULL, scr);
	if(CGXSystemBase) CloseLibrary(CGXSystemBase);

	return(retval);
}

STRPTR FindVictimWindow(void)
{
	STRPTR error = NULL;
	ULONG lock, x, y, rad;
	struct Screen *firstscr;
	struct Layer *lay;
	struct Window *win;

	lock = LockIBase(0);
	firstscr = IntuitionBase->FirstScreen;
	x = IntuitionBase->MouseX;
	y = IntuitionBase->MouseY;
	UnlockIBase(lock);

	ObtainSemaphore(&HLSemaphore);
	Forbid();

	if(firstscr != scr)
	{
		error = "Wrong screen";
		goto done;
	}

	if(!(lay = WhichLayer(&scr->LayerInfo, x, y)))
	{
		error = "Couldn't find layer under mouse";
		goto done;
	}

	if(lay->Flags & LAYERBACKDROP)
		goto done;

	for(win = scr->FirstWindow;
	    win && win->WLayer != lay;
	    win = win->NextWindow);

	if(!win)
	{
		error = "Couldn't find the window that the layer belongs to";
		goto done;
	}

	/* shoot a hole in the window */

	rad = rand() % MAX_RADIUS;
	if(rad < MIN_RADIUS) rad = MIN_RADIUS;

	if((error = Shoot(win, x - win->LeftEdge - rad, y - win->TopEdge - rad, rad)))
		goto done;

done:
	ReleaseSemaphore(&HLSemaphore);
	Permit();
	return(error);
}

STRPTR Shoot(struct Window *win, ULONG xo, ULONG yo, ULONG radius)
{
	STRPTR error = NULL;
	ULONG diagonal = (radius * 2) + 1, y;
	UBYTE *bitbuf = NULL;
	struct HoleNode *hn = NULL;
	struct Rectangle rect;
	struct Region *reg;
	struct Hook *bfhook;

	if((hn = FindHole(&HoleList, win)))
	{
		Remove((struct Node *)hn);
		InstallTransparentRegion(hn->hn_Window->WLayer, NULL);
	}
	else
	{
		/* allocations... */

		if(!(hn = AllocMem(sizeof(struct HoleNode), MEMF_CLEAR)))
		{
			error = "No mem for node";
			goto done;
		}

		hn->hn_Window = win;

		if(!(hn->hn_Region = NewRegion()))
		{
			error = "No memory for region";
			goto done;
		}
	}

	if(!(bitbuf = AllocVec((diagonal * diagonal / 8) + 
	    (diagonal * diagonal % 8 ? 1 : 0), MEMF_CLEAR)))
	{
		error = "No memory for bitbuf";
		goto done;
	}

	/* draw a circle into the buffer */

	CircleMidpoint(bitbuf, diagonal, radius);

	/* OR in all rectangles that should be made transparent into region */

	for(y = 0; y < diagonal; y++)
	{
		int x0, x1;

		for(x0 = 0;          x0 < diagonal && !getbit(bitbuf, x0 + y*diagonal); x0++);
		for(x1 = diagonal-1; x1 > 0        && !getbit(bitbuf, x1 + y*diagonal); x1--);

		if(x0 != diagonal && x1 != 0)
		{
			rect.MinX = xo + x0;
			rect.MinY = rect.MaxY = yo + y;
			rect.MaxX = xo + x1;

			if(!OrRectRegion(hn->hn_Region, &rect))
			{
				error = "ORing region failed";
				goto done;
			}
		}
	}

	bfhook = InstallLayerHook(win->WLayer, LAYERS_NOBACKFILL);

	if((reg = InstallTransparentRegion(win->WLayer, hn->hn_Region)))
	{
		InstallTransparentRegion(win->WLayer, reg);
		InstallLayerHook(win->WLayer, bfhook);
		error = "Window has transparent layer already";
		goto done;
	}

	InstallLayerHook(win->WLayer, bfhook);
	AddTail(&HoleList, (struct Node *)hn);

done:
	if(bitbuf) FreeVec(bitbuf);

	if(error)
	{
		if(hn)
		{
			if(hn->hn_Region) DisposeRegion(hn->hn_Region);
			FreeMem(hn, sizeof(struct HoleNode));
		}
	}

	return(error);
}

struct HoleNode *FindHole(struct List *list, struct Window *win)
{
	struct HoleNode *hn;

	for(hn = (struct HoleNode *)list->lh_Head;
	    hn->hn_Node.mln_Succ;
	    hn = (struct HoleNode *)hn->hn_Node.mln_Succ)
	{
		if(hn->hn_Window == win)
			return(hn);
	}

	return(NULL);
}

void CirclePoints(UBYTE *buf, int w, int cx, int cy, int x, int y)
{
	if(x == 0)
	{
		setbit(buf, cx     + (cy + y) * w);
		setbit(buf, cx     + (cy - y) * w);
		setbit(buf, cx + y +  cy      * w);
		setbit(buf, cx - y +  cy      * w);
	}
	else if(x == y)
	{
		setbit(buf, cx + x + (cy + y) * w);
		setbit(buf, cx - x + (cy + y) * w);
		setbit(buf, cx + x + (cy - y) * w);
		setbit(buf, cx - x + (cy - y) * w);
	}
	else if(x < y)
	{
		setbit(buf, cx + x + (cy + y) * w);
		setbit(buf, cx - x + (cy + y) * w);
		setbit(buf, cx + x + (cy - y) * w);
		setbit(buf, cx - x + (cy - y) * w);
		setbit(buf, cx + y + (cy + x) * w);
		setbit(buf, cx - y + (cy + x) * w);
		setbit(buf, cx + y + (cy - x) * w);
		setbit(buf, cx - y + (cy - x) * w);
	}
}

void CircleMidpoint(UBYTE *buf, int diagonal, int radius)
{
	int x = 0;
	int y = radius;
	int p = (5 - radius*4)/4;

	CirclePoints(buf, diagonal, radius, radius, x, y);
	while(x < y)
	{
		x++;

		if(p < 0) p += 2*x+1;
		else
		{
			y--;
			p += 2*(x-y)+1;
		}
		CirclePoints(buf, diagonal, radius, radius, x, y);
	}
}

__inline void setbit(UBYTE *array, int bit)
{
	*(array+bit/8) |= (0x80 >> bit%8);
}

__inline int getbit(UBYTE *array, int bit)
{
	return( *(array+bit/8) & (0x80 >> bit%8) );
}

void __asm __saveds
of_CloseWindow(REG(a0) struct Window *window,
               REG(a6) struct Library *base)
{
	struct HoleNode *hn;

	ObtainSemaphore(&HLSemaphore);

	if((hn = FindHole(&HoleList, window)))
	{
		Remove((struct Node *)hn);
		InstallTransparentRegion(hn->hn_Window->WLayer, NULL);
		DisposeRegion(hn->hn_Region);
		FreeMem(hn, sizeof(struct HoleNode));
	}

	ReleaseSemaphore(&HLSemaphore);

	(*int_CloseWindow)(window, base);
}
