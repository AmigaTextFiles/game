#include <exec/types.h>
#include <intuition/screens.h>
#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
/*#include <clib/dos_protos.h>*/

extern struct direntry
{
	ULONG offset;
	ULONG length;
	UBYTE name[8];
}*dirraw;
extern UWORD pal[];
UBYTE *LoadLump(ULONG lumpn);
void ShowRect(struct Window *w,UBYTE *r);
void ShowLine(struct Window *w,UBYTE *r);
void ShowSSector(struct Window *w,ULONG ssn);
void ShowNoder(struct Window *w,UBYTE *np,ULONG nn);

#define THINGS 0
#define LINEDEFS 1
#define SIDEDEFS 2
#define VERTEXES 3
#define SEGS 4
#define SSECTORS 5
#define NODES 6
#define SECTORS 7
#define REJECT 8
#define BLOCKMAP 9

WORD xorg,yorg,xdim,ydim;
LONG scale;

#define TRANSX(x) (((scale*(x))>>16)-((scale*xorg)>>16))
#define TRANSY(y) (((-scale*(y))>>16)+512+((scale*yorg)>>16))

UBYTE *levlumps[10];

void ShowMap(ULONG selected)
{
	struct Screen *s;
	struct Window *w;
	struct IntuiMessage *msg;
	BOOL running;
	ULONG i;
	for(i=0;i<10;i++)
		levlumps[i]=LoadLump(selected+i+1);

	if((s=OpenScreenTags(NULL,
			SA_Depth,	4,
			SA_Height,	512,
			SA_Width,	640,
			SA_Quiet,	TRUE,
			SA_ShowTitle,	FALSE,
			SA_DisplayID,	HIRESLACE_KEY,
			TAG_DONE))!=0)
	{
		if((w=OpenWindowTags(NULL,
			WA_Backdrop,	TRUE,
			WA_Borderless,	TRUE,
			WA_CustomScreen,(ULONG)s,
			WA_IDCMP,	IDCMP_VANILLAKEY,
			WA_Activate,	TRUE,
			TAG_DONE))!=0)
		{
			xorg=(*(levlumps[BLOCKMAP]+1)<<8)|(*(levlumps[BLOCKMAP]));
			yorg=(*(levlumps[BLOCKMAP]+3)<<8)|(*(levlumps[BLOCKMAP]+2));
			xdim=(*(levlumps[BLOCKMAP]+5)<<8)|(*(levlumps[BLOCKMAP]+4));
			ydim=(*(levlumps[BLOCKMAP]+7)<<8)|(*(levlumps[BLOCKMAP]+6));
			if(xdim>ydim)
				scale=(4<<16)/xdim;
			else
				scale=(4<<16)/ydim;
			ShowNoder(w,levlumps[NODES],dirraw[selected+1+NODES].length/28-1);
			running=TRUE;
			do
			{
				WaitPort(w->UserPort);
				msg=(struct IntuiMessage *)GetMsg(w->UserPort);
				if(msg->Class==IDCMP_VANILLAKEY)
					running=FALSE;
				ReplyMsg((struct Message *)msg);
			}while(running);
			CloseWindow(w);
		}	
		CloseScreen(s);	
	}
	for(i=0;i<10;i++)
		FreeVec(levlumps[i]);
}

void ShowNoder(struct Window *w,UBYTE *np,ULONG nn)
{
	struct Message *msg;
	UBYTE *np2;
	ULONG a;
	np2=np+nn*28;
	ShowLine(w,np2);
	ShowRect(w,np2+8);
	/*WaitPort(w->UserPort);
	msg=GetMsg(w->UserPort);
	ReplyMsg(msg);*/
	ShowRect(w,np2+8);
	a=np2[25]<<8|np2[24];
	if((a&0x8000)==0)
		ShowNoder(w,np,a);
	else
		ShowSSector(w,(a&0x7fff));
	ShowRect(w,np2+16);
	/*WaitPort(w->UserPort);
	msg=GetMsg(w->UserPort);
	ReplyMsg(msg);*/
	ShowRect(w,np2+16);
	a=np2[27]<<8|np2[26];
	if((a&0x8000)==0)
		ShowNoder(w,np,a);
	else
		ShowSSector(w,(a&0x7fff));
}

void ShowRect(struct Window *w,UBYTE *r)
{
	int x,y,x1,y1;
	SetDrMd(w->RPort,COMPLEMENT);
	SetAPen(w->RPort,3);	
	y=(WORD)(r[1]<<8|r[0]);
	y1=(WORD)(r[3]<<8|r[2]);
	x=(WORD)(r[5]<<8|r[4]);
	x1=(WORD)(r[7]<<8|r[6]);
	Move(w->RPort,TRANSX(x),TRANSY(y1));
	Draw(w->RPort,TRANSX(x1),TRANSY(y1));
	Draw(w->RPort,TRANSX(x1),TRANSY(y));
	Draw(w->RPort,TRANSX(x),TRANSY(y));
	Draw(w->RPort,TRANSX(x),TRANSY(y1));
}

void ShowLine(struct Window *w,UBYTE *r)
{
	int x,y;
	SetDrMd(w->RPort,JAM1);
	SetAPen(w->RPort,2);	
	x=(WORD)(r[1]<<8|r[0]);
	y=(WORD)(r[3]<<8|r[2]);
	Move(w->RPort,TRANSX(x),TRANSY(y));
	x+=(WORD)(r[5]<<8|r[4]);
	y+=(WORD)(r[7]<<8|r[6]);
	Draw(w->RPort,TRANSX(x),TRANSY(y));
}

void ShowSSector(struct Window *w,ULONG ssn)
{
	struct Message *msg;
	UBYTE *ssecp;
	UBYTE *segsp;
	UBYTE *verp;
	int segs,segn,i;
	ULONG vers,vere;
	int x,y;
	SetDrMd(w->RPort,JAM1);
	SetAPen(w->RPort,1);
	ssecp=levlumps[SSECTORS]+ssn*4;
	segs=ssecp[3]<<8|ssecp[2];
	segn=ssecp[1]<<8|ssecp[0];
	verp=levlumps[VERTEXES];
	for(i=0;i<segn;i++)
	{
		segsp=levlumps[SEGS]+segs*12;
		vers=segsp[1]<<8|segsp[0];
		vere=segsp[3]<<8|segsp[2];
		x=(WORD)(verp[vers*4+1]<<8|verp[vers*4]);
		y=(WORD)(verp[vers*4+3]<<8|verp[vers*4+2]);
		Move(w->RPort,TRANSX(x),TRANSY(y));
		x=(WORD)(verp[vere*4+1]<<8|verp[vere*4]);
		y=(WORD)(verp[vere*4+3]<<8|verp[vere*4+2]);
		Draw(w->RPort,TRANSX(x),TRANSY(y));
		segs++;
	}
	/*WaitPort(w->UserPort);
	msg=GetMsg(w->UserPort);
	ReplyMsg(msg);*/
}
