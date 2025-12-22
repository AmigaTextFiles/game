#include <exec/exec.h>
#include <powerup/gcclib/powerup_protos.h>
#include <powerup/ppcproto/intuition.h>
#include <powerup/ppcproto/graphics.h>
#include <powerup/ppcproto/cybergraphics.h>
#include <cybergraphx/cybergraphics.h>
#include "power.h"
#include "c2p.h"
#include "display.h"

struct PDisplay *aktdisplay;
int PWindowMode=0L;

struct TagItem screentags[] = {
			{SA_Width,0},
			{SA_Height,0},
			{SA_Depth,0},
			{SA_DisplayID,0},
			{SA_Quiet,-1},
			{TAG_DONE,0}}; 

struct TagItem windowtags[] = {
			{WA_CustomScreen,0L},
			{WA_RMBTrap,-1},
			{WA_Backdrop,-1},
			{WA_Borderless,-1},
			{WA_Flags,WFLG_ACTIVATE},
			{WA_IDCMP,IDCMP_VANILLAKEY},
			{TAG_DONE,0}};

unsigned char blackpal[256*3];

struct PDisplay *POpenDisplay(int w,int h,int d)
{
	struct PDisplay *dp;
	dp=PPCAllocVec(sizeof(struct PDisplay),MEMF_CLEAR);
	dp->width=w;
	dp->height=h;
	dp->depth=d;
	
	if(CyberGfxBase)
	{
		ULONG scrid;
		if(PWindowMode)
		{
			if((dp->window=OpenWindowTags(0L,
				WA_InnerWidth,w,
				WA_InnerHeight,h,
				WA_GimmeZeroZero,1L,
				WA_Flags,WFLG_ACTIVATE|WFLG_DRAGBAR|WFLG_CLOSEGADGET,
				WA_IDCMP,IDCMP_VANILLAKEY|IDCMP_CLOSEWINDOW,
				0l,0l)))
			{
				struct RastPort *rp=*(struct RastPort **)((char*)dp->window+50);
				if((GetCyberMapAttr(rp->BitMap,CYBRMATTR_ISCYBERGFX))&&
				   (GetCyberMapAttr(rp->BitMap,CYBRMATTR_DEPTH)>8))
				{
					aktdisplay=dp;
					return dp;
				}
				CloseWindow(dp->window);
				dp->window=0L;
			}
		}
		scrid=BestCModeIDTags(CYBRBIDTG_Depth,d,
				   CYBRBIDTG_NominalWidth,w,
				   CYBRBIDTG_NominalHeight,h,
				   0L,0L);
		if(scrid==INVALID_ID)
		{
			PCloseDisplay(dp);
			return 0L;
		}
		if(!(dp->screen=OpenScreenTags(0L,SA_DisplayID,scrid,
						  SA_Quiet,-1L,
						  0L,0L)))
		{
			PCloseDisplay(dp);
			return 0L;
		}
	}else{
		if(d==24)
		{
			screentags[0].ti_Data=w*4;
			screentags[3].ti_Data=SUPERHAM_KEY;
			screentags[2].ti_Data=8;
		}
		else
		{
			screentags[3].ti_Data=LORES_KEY;
			screentags[2].ti_Data=d;
			screentags[0].ti_Data=w;
		}
		screentags[1].ti_Data=h;
		if(!(dp->screen=OpenScreenTagList(0L,screentags)))
		{
			PCloseDisplay(dp);
			return 0L;
		}
	}

	windowtags[0].ti_Data=(ULONG)dp->screen;
	if(!(dp->window=OpenWindowTagList(0L,windowtags)))
	{
		PCloseDisplay(dp);
		return 0L;
	}
	if(!CyberGfxBase)
	{		
		if(!(dp->screenbuf1=AllocScreenBuffer(dp->screen,0L,SB_SCREEN_BITMAP)))
		{
			PCloseDisplay(dp);
			return 0L;
		}		
		if(!(dp->screenbuf2=AllocScreenBuffer(dp->screen,0L,SB_COPY_BITMAP)))
		{
			PCloseDisplay(dp);
			return 0L;
		}
		if(!(dp->screenbuf3=AllocScreenBuffer(dp->screen,0L,SB_COPY_BITMAP)))
		{
			PCloseDisplay(dp);
			return 0L;
		}
	}

	if(!CyberGfxBase)
		if(d==24)
		{
			int i;
			PInit24BitMode(dp);
			for(i=0;i<768;i++)
				blackpal[i]=0;
			PSetPalette(dp,blackpal);
		}

	aktdisplay=dp;
	return dp;
}

void PCloseDisplay(struct PDisplay *dp)
{
	if(dp->screenbuf3)
		FreeScreenBuffer(dp->screen,dp->screenbuf3);
	if(dp->screenbuf2)
		FreeScreenBuffer(dp->screen,dp->screenbuf2);
	if(dp->screenbuf1)
		FreeScreenBuffer(dp->screen,dp->screenbuf1);
	if(dp->window)
		CloseWindow(dp->window);
	if(dp->screen)
		CloseScreen(dp->screen);
	PPCFreeVec(dp);
}

void PBltChkHidden(struct PDisplay *dp,char *buf,int x,int y,int w,int h)
{
	if(CyberGfxBase)
	{
		if(!(dp->screen))
		{
			struct RastPort *rp=*(struct RastPort **)((char *)dp->window+50);
			WriteLUTPixelArray(buf,0,0,w,rp,dp->windowpal,x,y,w,h,CTABFMT_XRGB8);
		}else{
			struct RastPort *rp=(struct RastPort *)((char *)dp->screen+84);
			WritePixelArray(buf,0,0,w,rp,x,y,w,h,RECTFMT_LUT8);
		}
	}else
		PChk2Pl(dp->screenbuf3->sb_BitMap,buf,x,y,w,h);
}

void PBlt24Hidden(struct PDisplay *dp,unsigned long *buf,int x,int y,int w,int h)
{
	if(CyberGfxBase)
	{
		if(!(dp->screen))
		{
			struct RastPort *rp=*(struct RastPort **)((char *)dp->window+50);
			WritePixelArray(buf,0,0,w*4,rp,x,y,w,h,RECTFMT_ARGB);
		}else{
			struct RastPort *rp=(struct RastPort *)((char *)dp->screen+84);
			WritePixelArray(buf,0,0,w*4,rp,x,y,w,h,RECTFMT_ARGB);
		}
	}else
		PChk2Pl24(dp->screenbuf3->sb_BitMap,buf,x,y,w,h);
}

void PSwapDisplay(struct PDisplay *dp)
{
	void *t1;
	if(!CyberGfxBase)
	{
		t1=dp->screenbuf1;
		dp->screenbuf1=dp->screenbuf2;
		dp->screenbuf2=dp->screenbuf3;
		dp->screenbuf3=t1;
		while(!ChangeScreenBuffer(dp->screen,dp->screenbuf1))
			WaitTOF();
	}
}

void PWaitRaster(int rl)
{
	if(CyberGfxBase)
		WaitTOF();
	else
		while(((*(volatile unsigned long *)0xDFF004)&0x1ff00)!=(rl<<8));
	//WaitTOF();
}

void PWaitRaster2(int rl)
{
	if(CyberGfxBase)
		WaitTOF();
	else
		while(((*(volatile unsigned long *)0xDFF004)&0x1ff00)<=(rl<<8));
	//WaitTOF();
}

void PTimeShare(unsigned short color)
{
	volatile unsigned short *col0=(volatile unsigned short *)0xDFF180;
	*col0=color;
}

void PSetPalette(struct PDisplay *pd,unsigned char *pal)
{
	int i;
	static ULONG loadrgb32[256*3+2];
	
	if(!(pd->screen))	//WindowMode
	{
		int i;
		for(i=0;i<256;i++)
		{
			pd->windowpal[i]=(pal[0]<<16)+(pal[1]<<8)+pal[2];
			pal+=3;
		}
	}else{
		char *sp=(char *)pd->screen;			// Dirty
		struct ViewPort *vp=(struct ViewPort *)(sp+44); // Hack!!!
		
		ULONG *loadrgbptr=&loadrgb32[1];
		loadrgb32[0]=256<<16;
		loadrgb32[256*3+1]=0L;
		for(i=0;i<3*256;i++)
		{
			*loadrgbptr++=(*pal++)<<24;
		}
		LoadRGB32(vp,loadrgb32);
	}
}
