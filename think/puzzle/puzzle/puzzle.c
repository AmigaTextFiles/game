/*
 *  PUZZLEWINDOW.C
 *
 *  (c)Copyright 1993 by Tobias Ferber,  All Rights Reserved.
 */

#include <time.h>

#include <exec/types.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/rastport.h>

#include "newlook.h"

static char rcs_id[]= "$VER: $Id$";

extern struct Window *OpenWindow( struct NewWindow * );
extern UWORD AddGadget( struct Window *, struct Gadget *, UWORD );
extern VOID RefreshGList( struct Gadget *, struct Window *, struct Requester *, UWORD );

/* NewWindow Flags and IDCMPFlags */

#define NW_FLAGS  (WINDOWCLOSE|WINDOWDEPTH|WINDOWDRAG|ACTIVATE| \
                   SMART_REFRESH|RMBTRAP|GIMMEZEROZERO )

#define NW_IDCMP  (CLOSEWINDOW|GADGETUP|VANILLAKEY)

static const ULONG PuzzleWindowHandle= 1UL; /* NewLook handle */
static struct Window *PuzzleWindow= (struct Window *)NULL;
static struct Border *PuzzleFrame= (struct Border *)NULL;
static struct Gadget *PuzzleGadgets[16];
static UBYTE PuzzleText[16][3];
static ULONG FreeBrick;


static void InitPuzzleBricks(void)
{
   static int p[16]= { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 };
   int i,j,k,n;
   time_t t;

   for(n=0; n<93; n++)
   {
     time(&t);
     srand(t*270970*rand(42));
     i= (t*rand(t)) & 0x0F;
     j= (i*rand(t)) & 0x0F;
     k= p[i]; p[i]= p[j]; p[j]= k;
   }

   for(n=0;n<16;n++)
   {
     if(p[n])
       sprintf(PuzzleText[n],"%d",p[n]);
     else
       sprintf(PuzzleText[FreeBrick=n],"  ");
   }
}


static void ExchangePuzzleBricks(g0,g1)
struct Gadget *g0, *g1;
{
  USHORT pos0= RemoveGadget(PuzzleWindow,g0);
  USHORT pos1= RemoveGadget(PuzzleWindow,g1);

  struct IntuiText *it= g0->GadgetText;

  g0->GadgetText= g1->GadgetText;
  g1->GadgetText= it;

  if(pos0 != 0xFFFF)
    AddGadget(PuzzleWindow,g0,pos0);

  if(pos1 != 0xFFFF)
    AddGadget(PuzzleWindow,g1,pos1);

  RefreshGList(g0,PuzzleWindow,NULL,1L);
  RefreshGList(g1,PuzzleWindow,NULL,1L);
}


static void ClosePuzzleWindow(void)
{
  if(PuzzleWindow)
  {
    CloseWindow(PuzzleWindow);
    PuzzleWindow= (struct Window *)NULL;
  }
}


static int OpenPuzzleWindow(void)
{
  struct NewWindow *nw;
  short n=0, dx,dy;

  for(dy=0; dy<4; dy++)
  {
    for(dx=0; dx<4; dx++)
    {
      PuzzleGadgets[n]= CreateButton(16+26*dx,8+13*dy,26,13,PuzzleText[n],n);

      if(!PuzzleGadgets[n])
        return 3;

      PuzzleGadgets[n]->GadgetText->DrawMode= JAM2;

      if(n>0)
        (PuzzleGadgets[n-1])->NextGadget= PuzzleGadgets[n];

      ++n;
    }
  }

  /* just to be sure... */
  (PuzzleGadgets[15])->NextGadget= (struct Gadget *)NULL;

  if(nw= InitNewWindow(0L,"Puzzle",136,68,NW_IDCMP,NW_FLAGS,PuzzleGadgets[0]))
    PuzzleWindow= OpenWindow(nw);

  if(!PuzzleWindow)
    return 2;

  dx= PuzzleWindow->BorderLeft + PuzzleWindow->BorderRight + 4;
  dy= PuzzleWindow->BorderTop  + PuzzleWindow->BorderBottom + 2;

  PuzzleFrame= CreateFrame(0,0, PuzzleWindow->Width  - dx,
                                PuzzleWindow->Height - dy, 10,5);
  if(!PuzzleFrame)
    return 1;

  DrawBorder(PuzzleWindow->RPort, PuzzleFrame, 2,1);
  RefreshWindowFrame(PuzzleWindow);
  return 0;
}


static BOOL HandlePuzzleWindowIDCMP(void)
{
  BOOL running= TRUE;
  struct IntuiMessage *imsg;
  ULONG class;
  USHORT code;
  struct Gadget *g;

  Wait(1L << PuzzleWindow->UserPort->mp_SigBit);
  while(imsg=(struct IntuiMessage *)GetMsg(PuzzleWindow->UserPort))
  {
    class = imsg->Class;
    code  = imsg->Code;
    g     = (struct Gadget *)imsg->IAddress;
    ReplyMsg(imsg);

    switch(class)
    {
      case CLOSEWINDOW:
        running= FALSE;
        break;

      case GADGETUP:
        {
          long id= g->GadgetID;

          if(id == FreeBrick-4 || id == FreeBrick+4 ||
            (id == FreeBrick-1 && id != 3 && id != 7 && id != 11) ||
            (id == FreeBrick+1 && id != 4 && id != 8 && id != 12) )
          {
             ExchangePuzzleBricks(g,PuzzleGadgets[FreeBrick]);
             FreeBrick= id;
          }
        }
        break;

      case VANILLAKEY:
        switch( (UBYTE)code )
        {
          case '\33': /* ESC */
            running= FALSE;
            break;
        }
        break;
    }
  }
  return running;
}

/* public */

void DoPuzzle(void)
{
  ULONG LastHandle= SetNewLookHandle(PuzzleWindowHandle);

  InitPuzzleBricks();

  if( OpenPuzzleWindow() == 0)
  {
    while( HandlePuzzleWindowIDCMP() );

    ClosePuzzleWindow();
  }
  SmartFreeAll(PuzzleWindowHandle);
  (void)SetNewLookHandle(LastHandle);
}


#ifdef TEST

/* system stuff */
struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

void main(void)
{
  GfxBase= (struct GfxBase *)OpenLibrary("graphics.library",0L);
  IntuitionBase= (struct IntuitionBase *)OpenLibrary("intuition.library",0L);

  if(GfxBase && IntuitionBase)
    DoPuzzle();

  if(IntuitionBase) CloseLibrary(IntuitionBase);
  if(GfxBase) CloseLibrary(GfxBase);
}

#ifdef _DCC /* Dice */
void wbmain(void) { main(); }
#endif /* _DCC */

#endif /* TEST */
