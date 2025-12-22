/* ===========================================================
   ===                Drunken  Mouse                       ===
   ===         By: Alex Livshits   July 1987               ===
   =========================================================== */

#include <exec/types.h>
#include <exec/memory.h>
#include <exec/interrupts.h>
#include <graphics/gels.h>
#include <graphics/sprite.h>
#include <graphics/text.h>
#include <intuition/intuition.h>
#include <devices/input.h>
#include <devices/inputevent.h>



#define IMAGE_HEIGHT (POINTERSIZE/2-2)


#define INPUT    0x00000001
#define VBLANK   0x00000002
/* =====  EXPORT ======= */
APTR MyTask;
ULONG INPUTEVENT;
SHORT PosX,PosY,DY;
/***/

/* =====  IMPORT ======= */
APTR IntuitionBase;
APTR GfxBase;
extern int in_start(),in_end(),in_moveptr();
extern int vblank_start(),vblank_end();
extern ULONG VBEVENT;
/***/

static ULONG INTUIEVENT;
static LONG signal;
static struct Window *win;
static struct RastPort *rport;
static struct ViewPort *vport;
static struct SimpleSprite Sprite1,Sprite2;
static int sprnum = -1;

static struct Preferences *Pref,*Pref1;
static SHORT STOPPGM;
static ULONG mask = 0;


static
struct NewWindow NewWindow = {
   120,0,   /* window XY origin relative to TopLeft of screen */
   250,10,   /* window width and height */
   0,1,   /* detail and block pens */
   CLOSEWINDOW,   /* IDCMP flags */
   ACTIVATE+WINDOWDEPTH+WINDOWDRAG+
   WINDOWCLOSE, /* other window flags */
   NULL,   /* first gadget in gadget list */
   NULL,   /* custom CHECKMARK imagery */
   " Drunken Mouse ",   /* window title */
   NULL,   /* custom screen */
   NULL,   /* custom bitmap */
   0,0,   /* minimum width and height */
   0,0,   /* maximum width and height */
   WBENCHSCREEN   /* destination screen type */
};

static SHORT delta1=0;
static SHORT inc = -2;
static SHORT delta2 = -10;
static SHORT inc2=2;

void
main()
{
   struct IntuiMessage *imsg;
   ULONG  class,event;
   USHORT code;
   struct Gadget *gad;

   GfxBase = OpenLibrary("graphics.library",0);
   IntuitionBase = OpenLibrary("intuition.library",0);

   win = OpenWindow(&NewWindow);
   if (!win) { DisplayBeep(0); cleanup(); }

   rport = win->RPort;
   INTUIEVENT = 1L<<win->UserPort->mp_SigBit;
   vport = ViewPortAddress(win);

   MyTask = FindTask(0);
   SetTaskPri(MyTask,-10);
   signal = AllocSignal(-1);
   if (signal==-1) { printf("\nAllocSignal failed."); cleanup(); }
   INPUTEVENT = 1L<<signal;


   if (in_start()) { printf("\nin_start() failed."); cleanup();}
   mask |= INPUT;

   if (vblank_start()) { printf("\nvblank_start() failed."); cleanup();}
   mask |= VBLANK;

   sprnum = GetSprite(&Sprite1,-1);
   if (sprnum==-1) { printf("\n No more sprites"); cleanup(); }

   sprnum = GetSprite(&Sprite2,-1);
   if (sprnum==-1) { printf("\n No more sprites"); cleanup(); }

   Sprite1.x = 0;
   Sprite1.y = 0;
   Sprite1.height = IMAGE_HEIGHT;

   Sprite2.x = 0;
   Sprite2.y = 0;
   Sprite2.height = IMAGE_HEIGHT;


   Pref = AllocMem(sizeof(struct Preferences),MEMF_CHIP);
   if (!Pref)
   {
      cleanup();
   }

   Pref1 = AllocMem(sizeof(struct Preferences),MEMF_CHIP);
   if (!Pref1)
   {
      cleanup();
   }

   GetPrefs(Pref,sizeof(struct Preferences));

   sprnum = (sprnum & 0x06)*2+16;
   SetRGB4(vport,sprnum+1,(Pref->color17)>>8,((Pref->color17)>>4)&0x0F,
                          (Pref->color17)&0x0F);
   SetRGB4(vport,sprnum+2,(Pref->color18)>>8,((Pref->color18)>>4)&0x0F,
                          (Pref->color18)&0x0F);
   SetRGB4(vport,sprnum+3,(Pref->color19)>>8,((Pref->color19)>>4)&0x0F,
                          (Pref->color19)&0x0F);

   ChangeSprite(vport,&Sprite1,Pref->PointerMatrix);
   GetPrefs(Pref1,sizeof(struct Preferences));
   ChangeSprite(vport,&Sprite2,Pref1->PointerMatrix);


   PosSprite(&Sprite1,0,0);
   PosSprite(&Sprite2,0,0);
   in_moveptr(0,0);

   SetWindowTitles(win,-1," Drunken Mouse (C)FLam ==A.Livshits & J-M.Forgeas==");
   PosX=PosY=0;
   STOPPGM = FALSE;


   while (!STOPPGM)
   {
      event = Wait(INTUIEVENT|INPUTEVENT|VBEVENT);
      if (event & INTUIEVENT)
      {
         while (imsg=(struct IntuiMessage *)GetMsg(win->UserPort))
         {
            class = imsg->Class;
            code = imsg->Code;
            gad = imsg->IAddress;
            ReplyMsg(imsg);
            switch(class)
            {
               case CLOSEWINDOW:
                  STOPPGM=TRUE;
                  break;

               default:
                  break;
            }
         }
      } /* end if INTUIEVENT */

      if (event & INPUTEVENT)
      {

         if ((delta1<-30)||(delta1>30)) inc=-inc;
         delta1 += inc;
         PosSprite(&Sprite1,PosX+delta1-4,PosY-delta1-4);
         PosSprite(&Sprite2,PosX-delta1,PosY+delta1);

      }

      else if (event & VBEVENT)
      {
         if ((delta1<-30)||(delta1>30)) inc=-inc;
         delta1 += inc;
         WaitBOVP(vport);
         PosSprite(&Sprite1,PosX+delta1-4,PosY-delta1-4);
         PosSprite(&Sprite2,PosX-delta1,PosY+delta1);

      }

   }

   cleanup();
}

static
PosSprite(sprite,x,y)
   ULONG *sprite;
   SHORT x,y;
{
   x = (x>>1)+Pref->XOffset;
   y = (y>>1)+Pref->YOffset;
   MoveSprite(0,sprite,x,y);
}


static
cleanup()
{
   if (mask & VBLANK) vblank_end();
   if (mask & INPUT) in_end();
   if (sprnum != -1) {
        FreeSprite(Sprite1.num);
        FreeSprite(Sprite2.num);
   }
   if (win) CloseWindow(win);
   if (Pref) FreeMem(Pref,sizeof(*Pref));
   if (Pref1) FreeMem(Pref1,sizeof(*Pref1));

   if (signal != -1) FreeSignal(signal);
   CloseLibrary(IntuitionBase);
   CloseLibrary(GfxBase);

   exit(0);
}

