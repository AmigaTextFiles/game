/*
*/
#include <exec/types.h>
#include <intuition/intuition.h>
#ifdef __GNUC__
 struct Library *SysBase,*DOSBase,*GfxBase,*IntuitionBase;
# include <inline/exec.h>
# include <inline/dos.h>
# include <inline/graphics.h>
# include <inline/intuition.h>
#else
# include <clib/exec_protos.h>
# include <clib/dos_protos.h>
# include <clib/graphics_protos.h>
# include <clib/intuition_protos.h>
#endif

#include <stdlib.h>
#include <time.h>

struct Window	*w;
struct RastPort *r;
struct BitMap	*bm;
void exitgfx(void)
{
 if(bm) FreeBitMap(bm);
 if(w) CloseWindow(w);
}
void InitGfx(void)
{
 w=OpenWindowTags(NULL,WA_InnerWidth,320,
		       WA_InnerHeight,256,
		       WA_Title,(ULONG)"Testing 1 3 4",
		       WA_Flags,WFLG_DEPTHGADGET |
				WFLG_DRAGBAR	 |
				WFLG_CLOSEGADGET |
			       /* WFLG_ACTIVATE    |*/
				WFLG_RMBTRAP,
		 /*	 WA_IDCMP,IDCMP_CLOSEWINDOW|
				IDCMP_RAWKEY	 |
				IDCMP_VANILLAKEY, */
		       TAG_DONE);
 if(!(w)) PutStr("**Fatal: No window\n"),exit(2);

 r=w->RPort;
 SetAPen(r,1);
 atexit(exitgfx);
}
void ClearWin(void)
{
 EraseRect(r,w->BorderLeft,w->BorderTop,w->Width-w->BorderRight-1,w->Height-w->BorderBottom-1);
}
void Line(int a,int b,int c,int d)
{
 Move(r,w->BorderLeft+a,w->BorderTop+b);
 Draw(r,w->BorderLeft+c,w->BorderTop+d);
}

int main(int ac,char **av)
{
 int i,j;
 InitGfx();
 srand(time(NULL));
 for(i=100;i;i--) Line(rand()%320,rand()&255,rand()%320,rand()&255);
 /* init bitmap */
 bm=AllocBitMap(32,32,8,BMF_CLEAR,r->BitMap);
/* too much inlined asm for gcc */
 srand(time(NULL));
 /* get rectangle */
 (void)BltBitMap(r->BitMap,150,120,bm,0,0,32,32,0xc0,~0,NULL);
 /* and blit it back */
 for(j=0;j<256;j+=32)
 for(i=0;i<320;i+=32)
 BltBitMapRastPort(bm,0,0,r,w->BorderLeft+i,w->BorderTop+j,32,32,0xc0);
 Delay(59);
}

