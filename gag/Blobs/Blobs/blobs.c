/************************************************************************
 * Blobs.c
 *
 *            A simple graphics program on the Amiga by
 *            M. Peter Engelbrite
 *            Modified from "Sparks by Scott Ballantyne"
 ************************************************************************/

/* Because of a wierd bug in the current Manx C compiler I am using */
/* (versions 1.99G), the comments below have been moved to their current */
/* location, from the end of the include file lines.  Fred Fish, 3/8/86 *

/* Not all of these are used -- I include them */
/* 'cause I'm sick of compiler warnings.       */
#include <exec/types.h>
#include <exec/nodes.h>
#include <exec/lists.h>
#include <exec/exec.h>
#include <exec/execbase.h>
#include <exec/ports.h>
#include <exec/devices.h>
#include <exec/memory.h>
#include <hardware/blit.h>
#include <graphics/copper.h>
#include <graphics/regions.h>
#include <graphics/rastport.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <graphics/gels.h>
#include <intuition/intuition.h>

struct IntuitionBase *IntuitionBase = NULL;
struct GfxBase *GfxBase = NULL;


#define MAXX   640
#define MAXY   200

struct NewScreen MyScreen =
{ 0,0,MAXX,MAXY,4,0,1,HIRES, CUSTOMSCREEN, NULL, "Blobs", 0,0,};

   struct NewWindow DrawWindow = {
      0,0,MAXX,MAXY,
      0,1,
      MENUPICK,
      BORDERLESS | BACKDROP | ACTIVATE,
      NULL,
      NULL,
      NULL,
      NULL,
      NULL,
      0,0,0,0,
      CUSTOMSCREEN,
   };

struct Screen *Screen = NULL;
struct Window *Backdrop = NULL;
struct RastPort *DrawRP;
struct ViewPort *DrawVP;
struct IntuiMessage  *message;

struct MenuItem OnlyMenuItems[5];
struct IntuiText OnlyMenuText[5];
struct Menu OnlyMenu[1];
static int sparkleflag;

#define MAXDOTS  200
#define COLRS	 7
#define ERASE     0
static int xp[COLRS][MAXDOTS];
static UBYTE yp[COLRS][MAXDOTS];

static int curx[COLRS];
static UBYTE cury[COLRS];

main()
{

   register int  ndx;
   register int color;
   register int xx, yy;
   register int chase;
   ULONG class;
   USHORT code, ItemNum;

   if (!(IntuitionBase =
         (struct IntuitionBase *)OpenLibrary("intuition.library",0)))
         exit(1);

   if(!(GfxBase = (struct GfxBase *)OpenLibrary("graphics.library",0))) {
      cleanitup();
      exit(2);
   }

   if(!(Screen = (struct Screen *)OpenScreen(&MyScreen))) {
      cleanitup();
      exit(3);
   }

   DrawWindow.Screen = Screen;

   if(!(Backdrop = (struct Window *)OpenWindow(&DrawWindow))) {
      cleanitup();
      exit(4);
   }


   DrawRP = Backdrop->RPort;     /* Draw into backdrop window */
   DrawVP = &Screen->ViewPort;   /* Set colors in Screens VP  */
   setcolors();
   sparkleflag = 0;
   chase = 0;

   initmenuitems();
   initmenu();
   SetMenuStrip(Backdrop, &OnlyMenu[0]);

   for(color = 0; color < COLRS; color++)
     {
       curx[color] = 160;
       cury[color] = 100;
       for(ndx = 0; ndx < MAXDOTS; ndx++)
         {
           xp[color][ndx] = 1;
           yp[color][ndx] = 1;
         }
     }

   ndx = 0;

   FOREVER {
      while(message = (struct IntuiMessage *)GetMsg(Backdrop->UserPort)) {
         class = message->Class;
         code = message->Code;
         ReplyMsg(message);

         if (class == MENUPICK && code != MENUNULL) {
            ItemNum = ITEMNUM( code );
            switch (ItemNum) {
               case 0:
                  ShowTitle(Screen, FALSE);
                  break;
               case 1:
                  ShowTitle(Screen, TRUE);
                  break;
               case 2:
                  sparkleflag = !sparkleflag;
                  break;
               case 3:
                  chase = !chase;
                  break;
               case 4:
                  ClearMenuStrip(Backdrop);
                  cleanitup();
                  exit(0);
            }
         }
      }

      for(color = 0; color < COLRS; color++)
        {
          SetAPen(DrawRP, 0);
          WritePixel(DrawRP,xp[color][ndx],yp[color][ndx]);

          xx = curx[color] + RangeRand(3) - 1;
          yy = cury[color] + RangeRand(3) - 1;
          if(chase)
            {
              if(RangeRand(color + 2) == 0)
                {
                  xx = curx[color];
                  yy = cury[color];
                  if(Backdrop->MouseX > xx) xx++; else xx--;
                  if(Backdrop->MouseY > yy) yy++; else yy--;
                }
            }

          if(xx >= MAXX) xx = MAXX - 1;
          if(xx < 1) xx = 1;
          if(yy >= MAXY) yy = MAXY - 1;
          if(yy < 1) yy = 1;

          xp[color][ndx] = curx[color] = xx;
          yp[color][ndx] = cury[color] = yy;
          SetAPen(DrawRP, color + 3);
          WritePixel(DrawRP,xx,yy);

        }
      if (++ndx >= MAXDOTS)
        ndx = 0;
      if(sparkleflag) newcolors();
   }
}

cleanitup()    /* release allocated resources */
{
   if (Backdrop)
      CloseWindow(Backdrop);
   if (Screen)
      CloseScreen(Screen);
   if (GfxBase)
      CloseLibrary(GfxBase);
   if (IntuitionBase)
      CloseLibrary(IntuitionBase);
}

newcolors()
{

  SetRGB4(DrawVP, RangeRand(12) + 3,
          RangeRand(16), RangeRand(16), RangeRand(16)
         );
}

setcolors()
{
   SetRGB4(DrawVP, 0, 0, 0, 0);
   SetRGB4(DrawVP, 1, 3, 5, 10);
   SetRGB4(DrawVP, 2, 15, 15, 15);
   SetRGB4(DrawVP, 3, 15, 6, 0);
   SetRGB4(DrawVP, 4, 14, 3, 0);
   SetRGB4(DrawVP, 5, 15, 11, 0);
   SetRGB4(DrawVP, 6, 15, 15, 2);
   SetRGB4(DrawVP, 7, 11, 15, 0);
   SetRGB4(DrawVP, 8, 5, 13, 0);
   SetRGB4(DrawVP, 9, 0, 0, 15);
   SetRGB4(DrawVP, 10, 3, 6, 15);
   SetRGB4(DrawVP, 11, 7, 7, 15);
   SetRGB4(DrawVP, 12, 12, 0, 14);
   SetRGB4(DrawVP, 13, 15, 2, 14);
   SetRGB4(DrawVP, 15, 13, 11, 8);
}

initmenuitems()
{
   short n;

   for(n = 0; n < 5; n++) {  /* One struct for each item */
      OnlyMenuItems[n].LeftEdge = 0;
      OnlyMenuItems[n].TopEdge = 10 * n;
      OnlyMenuItems[n].Width = 112;
      OnlyMenuItems[n].Height = 10;
      OnlyMenuItems[n].Flags = ITEMTEXT | ITEMENABLED | HIGHCOMP;
      OnlyMenuItems[n].MutualExclude = 0;
      OnlyMenuItems[n].SelectFill = NULL;
      OnlyMenuItems[n].Command = 0;
      OnlyMenuItems[n].SubItem = NULL;
      OnlyMenuItems[n].NextSelect = 0;

      OnlyMenuText[n].FrontPen = 0;
      OnlyMenuText[n].BackPen = 1;
      OnlyMenuText[n].DrawMode = JAM2;
      OnlyMenuText[n].LeftEdge = 0;
      OnlyMenuText[n].TopEdge = 1;
      OnlyMenuText[n].ITextFont = NULL;
      OnlyMenuText[n].NextText = NULL;
   }
   OnlyMenuItems[0].NextItem = &OnlyMenuItems[1]; /* next item */
   OnlyMenuItems[1].NextItem = &OnlyMenuItems[2]; /* next item */
   OnlyMenuItems[2].NextItem = &OnlyMenuItems[3]; /* next item */
   OnlyMenuItems[3].NextItem = &OnlyMenuItems[4]; /* next item */
   OnlyMenuItems[4].NextItem = NULL; /* Last item */

   OnlyMenuItems[0].ItemFill = (APTR)&OnlyMenuText[0];
   OnlyMenuItems[1].ItemFill = (APTR)&OnlyMenuText[1];
   OnlyMenuItems[2].ItemFill = (APTR)&OnlyMenuText[2];
   OnlyMenuItems[3].ItemFill = (APTR)&OnlyMenuText[3];
   OnlyMenuItems[4].ItemFill = (APTR)&OnlyMenuText[4];

   OnlyMenuText[0].IText = (UBYTE *)"Hide Title Bar";
   OnlyMenuText[1].IText = (UBYTE *)"Show Title Bar";
   OnlyMenuText[2].IText = (UBYTE *)"Flash";
   OnlyMenuText[3].IText = (UBYTE *)"Chase";
   OnlyMenuText[4].IText = (UBYTE *)"QUIT!";
}

initmenu()
{
   OnlyMenu[0].NextMenu = NULL;                 /* No more menus */
   OnlyMenu[0].LeftEdge = 0;
   OnlyMenu[0].TopEdge = 0;
   OnlyMenu[0].Width = 85;
   OnlyMenu[0].Height = 10;
   OnlyMenu[0].Flags = MENUENABLED;             /* All items selectable */
   OnlyMenu[0].MenuName = "Actions";
   OnlyMenu[0].FirstItem = OnlyMenuItems;   /* Pointer to first item */
}
