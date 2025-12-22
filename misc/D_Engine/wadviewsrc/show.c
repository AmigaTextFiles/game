#include <exec/types.h>
#include <intuition/screens.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>

extern UWORD pal[];

void ShowFloor(UBYTE *b)
{
	struct Screen *s;
	struct Window *w;
	struct Message *msg;
	ULONG x,y;
	
	if((s=OpenScreenTags(NULL,
			SA_Depth,	8,
			SA_Height,	256,
			SA_Width,	320,
			SA_Quiet,	TRUE,
			SA_ShowTitle,	FALSE,
			SA_Colors32,	(ULONG)pal,
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
			for(y=0;y<64;y++)
				for(x=0;x<64;x++)
				{
					SetAPen(w->RPort,*b++);
					WritePixel(w->RPort,x,y);
				}
			for(x=0;x<5;x++)
				for(y=0;y<4;y++)
					ClipBlit(w->RPort,0,0,w->RPort,
						x*64,y*64,64,64,0xc0);
			WaitPort(w->UserPort);
			msg=GetMsg(w->UserPort);
			ReplyMsg(msg);
			CloseWindow(w);
		}	
		CloseScreen(s);	
	}
}

void ShowWall(UBYTE *b)
{
	struct Screen *s;
	struct Window *w;
	struct Message *msg;
	UBYTE *a;
	ULONG x;
	ULONG i;
	UBYTE c,c2;
	ULONG wi,he;
	
	if((s=OpenScreenTags(NULL,
			SA_Depth,	8,
			SA_Height,	256,
			SA_Width,	320,
			SA_Quiet,	TRUE,
			SA_ShowTitle,	FALSE,
			SA_Colors32,	(ULONG)pal,
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
			wi=b[1]<<8|b[0];
			he=b[3]<<8|b[2];
			if((wi<=320)&&(he<=200))
			{
				for(x=0;x<wi;x++)
				{
					a=b+8+x*4;
					i=a[3]<<24|a[2]<<16|a[1]<<8|a[0];
					a=b+i;
					c2=*a++;
					while(c2!=255)
					{
						c=*a++;
						a++;
						while(c--)
						{
							SetAPen(w->RPort,*a++);
							WritePixel(w->RPort,x,c2);
							c2++;
						}
						a++;
						c2=*a++;
					}
				}	
				WaitPort(w->UserPort);
				msg=GetMsg(w->UserPort);
				ReplyMsg(msg);
			}
			CloseWindow(w);
		}	
		CloseScreen(s);	
	}
}

void InitPal(UBYTE *playpal,UWORD *pal)
{
	ULONG i;
	*pal++=256;
	*pal++=0;
	for (i=0;i<256;i++)
	{
		*((ULONG*)pal)++=(*playpal++)<<24;
		*((ULONG*)pal)++=(*playpal++)<<24;
		*((ULONG*)pal)++=(*playpal++)<<24;
	}
	*pal++=0;
}
