#include "stdio.h"
#include "exec/types.h"
#include "functions.h"
#include "libraries/dosextens.h"
#include "intuition/intuition.h"
#include "graphics/gels.h"

double ran();
struct Window *OpenWindow();
struct ViewPort *ViewPortAddress();
struct VSprite *MakeBob();

struct VSprite *MyBob;
struct VSprite *Barracks;
struct VSprite *Bigtree;
struct VSprite *Blank;
struct VSprite *Crsturret;
struct VSprite *Door;
struct VSprite *Drroad;
struct VSprite *Drtur;
struct VSprite *Flag;
struct VSprite *Fuel;
struct VSprite *Helipad;
struct VSprite *Home;
struct VSprite *Horroad;
struct VSprite *Horwall;
struct VSprite *Lrdroad;
struct VSprite *Lruroad;
struct VSprite *Medtree;
struct VSprite *Medic;
struct VSprite *Officer;
struct VSprite *Prisoner;
struct VSprite *Rdroad;
struct VSprite *Rdtur;
struct VSprite *Ruroad;
struct VSprite *Rutur;
struct VSprite *Rudroad;
struct VSprite *Smtree;
struct VSprite *Turret;
struct VSprite *Udrroad;
struct VSprite *Urroad;
struct VSprite *Urtur;
struct VSprite *Utility;
struct VSprite *Verroad;
struct VSprite *Verwall;
struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct DiskfontBase *DiskfontBase;
struct Screen *CustScr;
struct Window *Wdw;
struct ViewPort *Vp;
struct RastPort *Rp;
struct TextFont *FontPtr1;
struct TextFont *FontPtr2;
struct IntuiMessage *message;

USHORT colors[] =
  {
    0x0666, 0x0000, 0x0340, 0x0530
  };

struct TextAttr StdFont =
  {
    "df0:fonts/sg_Topaz.font",9,0,0
  };

struct TextAttr SysFont =
  {
    "topaz.font",TOPAZ_EIGHTY,0,0
  };

struct NewScreen NewCustScr =
  {
    0,0,640,400,2,0,1,HIRES|LACE,CUSTOMSCREEN,NULL,NULL,NULL,NULL
  };

struct NewWindow NewWdw =
   {
    0,0,640,400,0,1,
    CLOSEWINDOW|
    MOUSEMOVE|
    RAWKEY|
    MOUSEBUTTONS|
    MENUPICK,

    WINDOWCLOSE|
    REPORTMOUSE|
    ACTIVATE,
    NULL,NULL,"FirePower Map Editor(c)V1.0    \\ /          by Greg MacKay   ",
    NULL,NULL,0,0,0,0,CUSTOMSCREEN
   };

#define FILE_MENU 0
 
int item_widths = 80;
 
#define BLACK_FILL  ITEMTEXT | ITEMENABLED | HIGHCOMP
 
#define NUM_FILE_ITEMS 8
#define NEW_ITEM       0
#define LOAD_ITEM      1
#define SAVE_ITEM      2
#define LOADLEFT_ITEM  3
#define LOADRIGHT_ITEM 4
#define SAVELEFT_ITEM  5
#define SAVERIGHT_ITEM 6
#define QUIT_ITEM      7

struct MenuItem  file_items[NUM_FILE_ITEMS];
struct IntuiText file_names[NUM_FILE_ITEMS];
 
char  *filemenu_names[] =
{
   "New",
   "Load",
   "Save",
   "Load Left",
   "Load Right",
   "Save Left",
   "Save Right",
   "Quit"
};
 
struct Menu fmenu =
{
  NULL,
  0, 0, 60, 10,
  MENUENABLED,
  "Options",
  file_items
};

WORD barracks[18] =
{
  0x0,0xFF80,0x9480,0x9480,0x9480,0x9480,0x9480,0xFF80,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD bigtree [18] =
{
  0x0,0x1C00,0x3E00,0x7F00,0x7F00,0x7F00,0x3E00,0x1C00,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD blank [18] =
{
  0xFF80,0x8080,0x8080,0x8080,0x8080,0x8080,0x8080,0x8080,0xFF80,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD crsturret [18] =
{
  0x1400,0x1400,0x3E00,0xE380,0x2A00,0xE380,0x3E00,0x1400,0x1400,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD door [18] =
{
  0x1400,0x1C00,0x800,0xEB80,0xEB80,0xEB80,0x800,0x1C00,0x1400,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD drroad [18] =
{
  0x1C00,0x1C00,0x1C00,0x1F80,0x1F80,0x1F80,0x0,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD drtur [18] =
{
  0x1400,0x1400,0x3E00,0x2380,0x2A00,0x2380,0x3E00,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD flg[18] =
{
  0xFF80,0x8080,0xBC80,0xA080,0xB880,0xA080,0xA080,0x8080,0xFF80,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD fuel [18] =
{
  0x3000,0x4800,0x8400,0x8400,0x4C00,0x3600,0x380,0x280,0x380,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD helipad [18] =
{
  0x1C00,0x2200,0x4100,0x8080,0x8080,0x8080,0x4100,0x2200,0x1C00,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD home [18] =
{
  0xFF80,0x8080,0xA280,0xA280,0xBE80,0xA280,0xA280,0x8080,0xFF80,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD horroad [18] =
{
  0x0,0x0,0x0,0xFF80,0xFF80,0xFF80,0x0,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD horwall [18] =
{
  0x0,0x0,0x0,0xFF80,0x0,0xFF80,0x0,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD lrdroad [18] =
{
  0x0,0x0,0x0,0xFF80,0xFF80,0xFF80,0x1C00,0x1C00,0x1C00,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD lruroad [18] =
{
  0x1C00,0x1C00,0x1C00,0xFF80,0xFF80,0xFF80,0x0,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD medtree [18] =
{
  0x0,0x0,0x1800,0x3C00,0x3C00,0x1800,0x0,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD medic [18] =
{
  0xFF80,0x8080,0xA280,0xB680,0xAA80,0xA280,0xA280,0x8080,0xFF80,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD officer [18] =
{
  0xFF80,0x8080,0x9C80,0xA280,0xA280,0xA280,0x9C80,0x8080,0xFF80,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD prisoner [18] =
{
  0xFF80,0x8080,0xBC80,0xA480,0xBC80,0xA080,0xA080,0x8080,0xFF80,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD rdroad [18] =
{
  0x0,0x0,0x0,0xFC00,0xFC00,0xFC00,0x1C00,0x1C00,0x1C00,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD rdtur [18] =
{
  0x0,0x0,0x3E00,0xE200,0x2A00,0xE200,0x3E00,0x1400,0x1400,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD ruroad [18] =
{
  0x1C00,0x1C00,0x1C00,0xFC00,0xFC00,0xFC00,0x0,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD rutur [18] =
{
  0x1400,0x1400,0x3E00,0xE200,0x2A00,0xE200,0x3E00,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD rudroad [18] =
{
  0x1C00,0x1C00,0x1C00,0xFC00,0xFC00,0xFC00,0x1C00,0x1C00,0x1C00,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD smtree [18] =
{
  0x0,0x0,0x0,0x800,0x1C00,0x800,0x0,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD turret [18] =
{
  0x0,0x0,0x3E00,0x2200,0x2A00,0x2200,0x3E00,0x0,0x0,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD udrroad [18] =
{
  0x1C00,0x1C00,0x1C00,0x1F80,0x1F80,0x1F80,0x1C00,0x1C00,0x1C00,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD urroad [18] =
{
  0x0,0x0,0x0,0x1F80,0x1F80,0x1F80,0x1C00,0x1C00,0x1C00,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD urtur [18] =
{
  0x0,0x0,0x3E00,0x2380,0x2A00,0x2380,0x3E00,0x1400,0x1400,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD utility [18] =
{
  0xFF80,0x8080,0xA280,0xA280,0xA280,0xA280,0x9C80,0x8080,0xFF80,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD verroad [18] =
{
  0x1C00,0x1C00,0x1C00,0x1C00,0x1C00,0x1C00,0x1C00,0x1C00,0x1C00,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

WORD verwall [18] =
{
  0x1400,0x1400,0x1400,0x1400,0x1400,0x1400,0x1400,0x1400,0x1400,
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
};

int map[65][65];
int topoffset, pen, roadpen;
int ObjValue;
char *ObjCode;
LONG strlen();
ULONG class;
USHORT code;
BYTE *OutText[6];
BOOL MouseMoved;
int x,y;
double ran();
int rndnum;

main()
{

  IntuitionBase = (struct IntuitionBase *)
       OpenLibrary("intuition.library",0);
  if (IntuitionBase == NULL)
    {
       printf("Could not open Intuition Library\n");
       exit(FALSE);
    }

  GfxBase = (struct GfxBase *)
       OpenLibrary("graphics.library",0);
  if (GfxBase==NULL)
    {
       CloseLibrary(IntuitionBase);
       printf("Could not open Graphics Library\n");
       exit(FALSE);
    }

  DiskfontBase = (struct DiskfontBase *)
       OpenLibrary("diskfont.library",0);
  if (DiskfontBase == NULL)
    {
       CloseLibrary(GfxBase);
       CloseLibrary(IntuitionBase);
       printf("Could not open Diskfont Library\n");
       exit(FALSE);
    }

  if ((NewWdw.Screen = CustScr = (struct Screen *)
       OpenScreen(&NewCustScr)) == NULL)
    {
       CloseLibrary(IntuitionBase);
       CloseLibrary(GfxBase);
       CloseLibrary(DiskfontBase);
       printf("Could not open Custom Screen\n");
       exit(FALSE);
    }

  if ((Wdw = (struct Window *) OpenWindow(&NewWdw)) == NULL)
    {
       CloseLibrary(IntuitionBase);
       CloseLibrary(GfxBase);
       CloseLibrary(DiskfontBase);
       CloseScreen(CustScr);
       printf("Could not open Custom Window\n");
       exit(FALSE);
    }

  if ((FontPtr1 = (struct TextFont *)OpenDiskFont(&StdFont)) == NULL)
    {
       CloseLibrary(IntuitionBase);
       CloseLibrary(GfxBase);
       CloseLibrary(DiskfontBase);
       CloseScreen(CustScr);
       CloseWindow(Wdw);
       printf("Could not open FirePower Editor Font\n");
       exit(FALSE);
    }

  if ((FontPtr2 = (struct TextFont *)OpenFont(&SysFont)) == NULL)
    {
       CloseLibrary(IntuitionBase);
       CloseLibrary(GfxBase);
       CloseLibrary(DiskfontBase);
       CloseScreen(CustScr);
       CloseWindow(Wdw);
       CloseFont(FontPtr1);
       printf("Could not open FirePower Text Font\n");
       exit(FALSE);
    }

   Rp = Wdw->RPort;
   Vp = ViewPortAddress(Wdw);
   
   MakeGelsInfo(Rp);

   MyBob = MakeBob(650,410,9,1,2,blank,0x03,0x00);
   AddBob(MyBob->VSBob,Rp);
   ObjCode = " ";
   ObjValue = 0;

   SortGList(Rp);
   DrawGList(Rp,Vp);
   RethinkDisplay();

   Initialize();

   /* This is the main loop */

   FOREVER
    {
      SetFont(Rp,FontPtr2);                            /*   Update    */
      sprintf(OutText,"%3d,%2d",x/9,y/9-1+topoffset);  /*    map      */
      PrintAt(582,394,OutText);                        /* coordinates */
      SetFont(Rp,FontPtr1);

      MouseMoved = FALSE;
      while(message = GetMsg(Wdw->UserPort))
        {

          switch (message->Class)
                {
                   case MOUSEMOVE   : MouseMoved = TRUE;
                                      x = message->MouseX; /* Update true */
                                      y = message->MouseY; /*   X and Y   */
                                      ReplyMsg(message);   /* coordinates */
                                      break;

                   case RAWKEY      : if ((message->Code) == 76)
                                           ScrollUp();
                                      if ((message->Code) == 77)
                                           ScrollDn();
                                      ReplyMsg(message);
                                      break;

                   case MOUSEBUTTONS: if ((message->Code) == SELECTDOWN)
                                        {
                                           if (x < 583)
                                              PlaceObj(); /*Clicked on map*/
                                           if (x > 583)
                                              ObjSelect(); /* or menu */
                                        } 
                                      ReplyMsg(message);
                                      break;

                   case MENUPICK    : if (MENUNUM(message->Code) != MENUNULL)
                                         domenu(ITEMNUM(message->Code));
                                      ReplyMsg(message);
                                      break;
 
                   case CLOSEWINDOW : ReplyMsg(message);
                                      End_program();
                                      exit(0);
                                      break;

                     } /* End switch */
        } /*End while*/
  if(MouseMoved = TRUE)
    {
      MyBob->X = x-9;
      MyBob->Y = y-10;
      SortGList(Rp);      /* Update Bob */
      DrawGList(Rp,Vp);
      RethinkDisplay();
    }

  }   /*End FOREVER*/
}   /* End of Main */
 
/*Functions start here */

UpdateBob()
{
   SortGList(Rp);
   DrawGList(Rp,Vp);
   RethinkDisplay();
}

PrintAt(a,b,s)
int a,b;
char *s;
{
   Move(Rp,a,b);
   Text(Rp,s,strlen(s));
}

ScrollUp()        /* This routine will scroll the screen down 9 pixels */
{                 /* and print a new line of data at top of map. */
   int top;
   char *TempCode;
   if (topoffset > 0)
     {
         TempCode = ObjCode;
         MyBob->X = 650;
         MyBob->Y = 410;
         UpdateBob();
         ScrollRaster(Rp,0,-9,3,11,579,397);
         topoffset -= 1;

         for (top=0;top<64;top++)
            {
                if (map[top+1][topoffset+1]<2)
                      continue;
                if (map[top+1][topoffset+1]==3)
                  {
                      ObjCode = "#";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==4)
                  {
                      ObjCode = "$";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==2)
                  {
                      ObjCode = "%";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==34)
                  {
                      ObjCode = "6";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==22)
                  {
                      ObjCode = "6";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==87)
                  {
                      ObjCode = "<";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==85)
                  {
                      ObjCode = "<";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==67)
                  {
                      ObjCode = "@";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==44)
                  {
                      ObjCode = "@";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==11)
                  {
                      ObjCode = "+";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==71)
                  {
                      ObjCode = "D";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==48)
                  {
                      ObjCode = "D";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==92)
                  {
                      ObjCode = "5";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==89)
                  {
                      ObjCode = "5";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==37)
                  {
                      ObjCode = "9";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==25)
                  {
                      ObjCode = "9";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==14)
                  {
                      ObjCode = ".";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==32)
                  {
                      ObjCode = "4";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==20)
                  {
                      ObjCode = "4";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==15)
                  {
                      ObjCode = "/";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==65)
                  {
                      ObjCode = ">";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==42)
                  {
                      ObjCode = ">";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==36)
                  {
                      ObjCode = "8";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==24)
                  {
                      ObjCode = "8";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==29)
                  {
                      ObjCode = "1";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==17)
                  {
                      ObjCode = "1";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==31)
                  {
                      ObjCode = "3";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==19)
                  {
                      ObjCode = "3";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==10)
                  {
                      ObjCode = "*";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==7)
                  {
                      ObjCode = "'";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==66)
                  {
                      ObjCode = "?";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==43)
                  {
                      ObjCode = "?";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==6)
                  {
                      ObjCode = "&";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==12)
                  {
                      ObjCode = ",";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==13)
                  {
                      ObjCode = "-";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==73)
                  {
                      ObjCode = "C";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==50)
                  {
                      ObjCode = "C";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==39)
                  {
                      ObjCode = ";";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==27)
                  {
                      ObjCode = ";";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==8)
                  {
                      ObjCode = "(";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==5)
                  {
                      ObjCode = ")";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==64)
                  {
                      ObjCode = "A";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==41)
                  {
                      ObjCode = "A";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==30)
                  {
                      ObjCode = "2";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==18)
                  {
                      ObjCode = "2";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==16)
                  {
                      ObjCode = "0";
                      SetAPen(Rp,1);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==70)
                  {
                      ObjCode = "B";
                      SetAPen(Rp,2);
                      goto next1;
                  }
                if (map[top+1][topoffset+1]==47)
                  {
                      ObjCode = "B";
                      SetAPen(Rp,3);
                      goto next1;
                  }
                      continue;

               next1: PrintAt(top*9+3,20,ObjCode);

            } /* End of FOR loop */

         ObjCode = TempCode;
         SetAPen(Rp,1);
     }
}

ScrollDn()        /* This routine will scroll the screen up 9 pixels and */
{                 /* print a new line of data at bottom of map */
   int top;
   char *TempCode;
   if (topoffset < 21)
     {
         TempCode = ObjCode;
         MyBob->X = 650;
         MyBob->Y = 410;
         UpdateBob();
         ScrollRaster(Rp,0,9,3,11,579,397);
         topoffset += 1;

         for (top=0;top<64;top++)
            {
                if (map[top+1][topoffset+43]<2)
                      continue;
                if (map[top+1][topoffset+43]==3)
                  {
                      ObjCode = "#";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==4)
                  {
                      ObjCode = "$";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==2)
                  {
                      ObjCode = "%";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==34)
                  {
                      ObjCode = "6";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==22)
                  {
                      ObjCode = "6";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==87)
                  {
                      ObjCode = "<";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==85)
                  {
                      ObjCode = "<";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==67)
                  {
                      ObjCode = "@";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==44)
                  {
                      ObjCode = "@";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==11)
                  {
                      ObjCode = "+";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==71)
                  {
                      ObjCode = "D";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==48)
                  {
                      ObjCode = "D";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==92)
                  {
                      ObjCode = "5";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==89)
                  {
                      ObjCode = "5";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==37)
                  {
                      ObjCode = "9";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==25)
                  {
                      ObjCode = "9";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==14)
                  {
                      ObjCode = ".";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==32)
                  {
                      ObjCode = "4";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==20)
                  {
                      ObjCode = "4";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==15)
                  {
                      ObjCode = "/";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==65)
                  {
                      ObjCode = ">";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==42)
                  {
                      ObjCode = ">";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==36)
                  {
                      ObjCode = "8";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==24)
                  {
                      ObjCode = "8";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==29)
                  {
                      ObjCode = "1";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==17)
                  {
                      ObjCode = "1";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==31)
                  {
                      ObjCode = "3";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==19)
                  {
                      ObjCode = "3";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==10)
                  {
                      ObjCode = "*";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==7)
                  {
                      ObjCode = "'";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==66)
                  {
                      ObjCode = "?";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==43)
                  {
                      ObjCode = "?";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==6)
                  {
                      ObjCode = "&";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==12)
                  {
                      ObjCode = ",";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==13)
                  {
                      ObjCode = "-";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==73)
                  {
                      ObjCode = "C";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==50)
                  {
                      ObjCode = "C";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==39)
                  {
                      ObjCode = ";";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==27)
                  {
                      ObjCode = ";";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==8)
                  {
                      ObjCode = "(";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==5)
                  {
                      ObjCode = ")";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==64)
                  {
                      ObjCode = "A";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==41)
                  {
                      ObjCode = "A";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==30)
                  {
                      ObjCode = "2";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==18)
                  {
                      ObjCode = "2";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==16)
                  {
                      ObjCode = "0";
                      SetAPen(Rp,1);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==70)
                  {
                      ObjCode = "B";
                      SetAPen(Rp,2);
                      goto next2;
                  }
                if (map[top+1][topoffset+43]==47)
                  {
                      ObjCode = "B";
                      SetAPen(Rp,3);
                      goto next2;
                  }
                      continue;

               next2: PrintAt(top*9+3,398,ObjCode);

           } /* End of FOR loop */

         ObjCode = TempCode;
         SetAPen(Rp,1);
     }
}

ClrScr()          /* This routine will clear the maps' screen */
{
   int ly;
   for (ly=20;ly < 399;ly += 9)
   PrintAt(3,ly,"                                                                ");
}

PlaceObj()       /* This routine will place an object on the map.If it is */
{                /* the same piece, it will erase it. */
   int gridx, gridy;
   gridx = x/9;
   gridy = y/9-1;
   if ((gridx<1) || (gridx>64) || (gridy<1) || (gridy>43))
      return();
   if (pen==3)
      SetAPen(Rp,3);
   if (pen==2)
      SetAPen(Rp,2);
   if (roadpen==1)
      SetAPen(Rp,1);
   if ((ObjValue==2) || (ObjValue==3) || (ObjValue==4))
      SetAPen(Rp,2);
   MyBob->X = 650;
   MyBob->Y = 410;
   UpdateBob();

   if ((map[gridx][gridy+topoffset] > 1) && (map[gridx][gridy+topoffset] == ObjValue))
      {
        rndnum = ran()*2;
        map[gridx][gridy+topoffset] = rndnum;
        PrintAt((x/9)*9-6,(y/9)*9+2," ");
      }
   else
      {
        map[gridx][gridy+topoffset] = ObjValue;
        PrintAt((x/9)*9-6,(y/9)*9+2,ObjCode);
      }
   SetAPen(Rp,1);
}

ObjSelect()   /* This routine will call upon other routines to assign */
{             /* the selected object. It also sets color to green or brown */
   MyBob->X = 650;
   MyBob->Y = 410;
   UpdateBob();

   if ((x>590) && (x<609) && (y>17) && (y<28))
     {
         MyBob->X = 650;
         MyBob->Y = 410;
         UpdateBob();
         SetAPen(Rp,0);
         RectFill(Rp,613,15,632,26);
         SetAPen(Rp,2);
         RectFill(Rp,614,16,631,25);
         SetAPen(Rp,1);
         RectFill(Rp,588,15,607,26);
         SetAPen(Rp,3);
         RectFill(Rp,590,17,605,24);
         pen = 3;
         DeleteVSprite(MyBob);
         MyBob = MakeBob(650,410,9,1,2,blank,0x03,0x00);
         AddBob(MyBob->VSBob,Rp);
         ObjCode = " ";
         SetAPen(Rp,1);
         return();
     }

   if ((x>615) && (x<634) && (y>17) && (y<28))
     {
         MyBob->X = 650;
         MyBob->Y = 410;
         UpdateBob();
         SetAPen(Rp,0);
         RectFill(Rp,588,15,607,26);
         SetAPen(Rp,3);
         RectFill(Rp,589,16,606,25);
         SetAPen(Rp,1);
         RectFill(Rp,613,15,632,26);
         SetAPen(Rp,2);
         RectFill(Rp,615,17,630,24);
         pen = 2;
         DeleteVSprite(MyBob);
         MyBob = MakeBob(650,410,9,1,2,blank,0x03,0x00);
         AddBob(MyBob->VSBob,Rp);
         ObjCode = " ";
         SetAPen(Rp,1);
         return();
     }

   if (pen == 2)
      SelectGreen();
   if (pen == 3)
      SelectBrown();
}

SelectGreen()     /* This routine will assign a green colored object */
{
   if ((x>592) && (x<606) && (y>49) && (y<61))
     {
         MyBob->X = 650;
         MyBob->Y = 410;
         UpdateBob();
         DeleteVSprite(MyBob);
         MyBob = MakeBob(650,410,9,1,2,horwall,0x03,0x00);
         AddBob(MyBob->VSBob,Rp);
         ObjCode = ">";
         ObjValue = 65;
         roadpen = 0;
         return();
     }
   else if ((x>617) && (x<631) && (y>49) && (y<61))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,verwall,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "B";
           ObjValue = 70;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>67) && (y<79))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,urtur,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "A";
           ObjValue = 64;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>67) && (y<79))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,rdtur,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "?";
           ObjValue = 66;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>85) && (y<97))
       { 
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,drtur,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "D";
           ObjValue = 71;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>85) && (y<97))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,rutur,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "C";
           ObjValue = 73;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>103) && (y<115))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,horroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "/";
           ObjValue = 15;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>103) && (y<115))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,verroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "0";
           ObjValue = 16;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>121) && (y<133))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,urroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = ")";
           ObjValue = 5;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>121) && (y<133))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,rdroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "'";
           ObjValue = 7;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>139) && (y<151))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,drroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "+";
           ObjValue = 11;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>139) && (y<151))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,ruroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "-";
           ObjValue = 13;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>157) && (y<169))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,udrroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "(";
           ObjValue = 8;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>157) && (y<169))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,rudroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "*";
           ObjValue = 10;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>175) && (y<187))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,lrdroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "&";
           ObjValue = 6;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>175) && (y<187))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,lruroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = ",";
           ObjValue = 12;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>193) && (y<205))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,crsturret,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "<";
           ObjValue = 87;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>193) && (y<205))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,turret,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = ";";
           ObjValue = 39;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>211) && (y<223))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,door,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "@";
           ObjValue = 67;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>211) && (y<223))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,fuel,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "9";
           ObjValue = 37;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>229) && (y<241))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,helipad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = ".";
           ObjValue = 14;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>229) && (y<241))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,barracks,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "6";
           ObjValue = 34;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>247) && (y<259))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,home,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "4";
           ObjValue = 32;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>247) && (y<259))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,medic,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "8";
           ObjValue = 36;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>265) && (y<277))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,flg,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "5";
           ObjValue = 92;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>265) && (y<277))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,utility,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "2";
           ObjValue = 30;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>283) && (y<295))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,officer,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "1";
           ObjValue = 29;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>283) && (y<295))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,prisoner,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "3";
           ObjValue = 31;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>301) && (y<313))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,smtree,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "#";
           ObjValue = 3;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>301) && (y<313))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,medtree,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "$";
           ObjValue = 4;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>319) && (y<331))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,bigtree,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "%";
           ObjValue = 2;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>319) && (y<331))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,blank,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = " ";
           rndnum = ran()*2;
           ObjValue = rndnum;
           return();
       }
   else if ((x>592) && (x<623) && (y>340) && (y<363))
            DrawLine();
}

SelectBrown()     /* This routine will assign a brown colored object */
{   
   if ((x>592) && (x<606) && (y>49) && (y<61))
     {
         MyBob->X = 650;
         MyBob->Y = 410;
         UpdateBob();
         DeleteVSprite(MyBob);
         MyBob = MakeBob(650,410,9,1,2,horwall,0x03,0x00);
         AddBob(MyBob->VSBob,Rp);
         ObjCode = ">";
         ObjValue = 42;
         roadpen = 0;
         return();
     }
   else if ((x>617) && (x<631) && (y>49) && (y<61))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,verwall,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "B";
           ObjValue = 47;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>67) && (y<79))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,urtur,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "A";
           ObjValue = 41;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>67) && (y<79))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,rdtur,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "?";
           ObjValue = 43;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>85) && (y<97))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,drtur,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "D";
           ObjValue = 48;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>85) && (y<97))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,rutur,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "C";
           ObjValue = 50;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>103) && (y<115))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,horroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "/";
           ObjValue = 15;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>103) && (y<115))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,verroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "0";
           ObjValue = 16;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>121) && (y<133))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,urroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = ")";
           ObjValue = 5;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>121) && (y<133))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,rdroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "'";
           ObjValue = 7;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>139) && (y<151))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,drroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "+";
           ObjValue = 11;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>139) && (y<151))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,ruroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "-";
           ObjValue = 13;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>157) && (y<169))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,udrroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "(";
           ObjValue = 8;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>157) && (y<169))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,rudroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "*";
           ObjValue = 10;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>175) && (y<187))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,lrdroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "&";
           ObjValue = 6;
           roadpen = 1;
           return();
       }   
   else if ((x>617) && (x<631) && (y>175) && (y<187))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,lruroad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = ",";
           ObjValue = 12;
           roadpen = 1;
           return();
       }
   else if ((x>592) && (x<606) && (y>193) && (y<205))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,crsturret,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "<";
           ObjValue = 85;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>193) && (y<205))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,turret,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = ";";
           ObjValue = 27;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>211) && (y<223))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,door,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "@";
           ObjValue = 44;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>211) && (y<223))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,fuel,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "9";
           ObjValue = 25;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>229) && (y<241))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,helipad,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = ".";
           ObjValue = 14;
           roadpen = 1;
           return();
       }
   else if ((x>617) && (x<631) && (y>229) && (y<241))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,barracks,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "6";
           ObjValue = 22;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>247) && (y<259))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,home,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "4";
           ObjValue = 20;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>247) && (y<259))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,medic,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "8";
           ObjValue = 24;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>265) && (y<277))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,flg,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "5";
           ObjValue = 89;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>265) && (y<277))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,utility,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "2";
           ObjValue = 18;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>283) && (y<295))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,officer,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "1";
           ObjValue = 17;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>283) && (y<295))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,prisoner,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "3";
           ObjValue = 19;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>301) && (y<313))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,smtree,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "#";
           ObjValue = 3;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>301) && (y<313))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,medtree,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "$";
           ObjValue = 4;
           roadpen = 0;
           return();
       }
   else if ((x>592) && (x<606) && (y>319) && (y<331))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,bigtree,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = "%";
           ObjValue = 2;
           roadpen = 0;
           return();
       }
   else if ((x>617) && (x<631) && (y>319) && (y<331))
       {
           MyBob->X = 650;
           MyBob->Y = 410;
           UpdateBob();
           DeleteVSprite(MyBob);
           MyBob = MakeBob(650,410,9,1,2,blank,0x03,0x00);
           AddBob(MyBob->VSBob,Rp);
           ObjCode = " ";
           rndnum = ran()*2;
           ObjValue = rndnum;
           return();
       }
   else if ((x>592) && (x<623) && (y>340) && (y<363))
            DrawLine();
}

DrawLine()  /* This routine draws a line from point A to point B */
            /* If points are not lined up, a filled rectangle will result */
{
           int i, hor, ver, bx = 0, by = 0, ex = 0, ey = 0;
           SetFont(Rp,FontPtr2);
           for (i=1;i<9;i++)
              {
                 PrintAt(590,380,"PT A?");
                 Delay(3);
                 PrintAt(590,380,"     ");
                 Delay(3);
              }
     FOREVER
        {
             sprintf(OutText,"%3d,%2d",x/9,y/9-1+topoffset);
             PrintAt(582,394,OutText);
             MouseMoved = FALSE;
         while(message = GetMsg(Wdw->UserPort))
             {
             switch (message->Class)
                {
                   case MOUSEMOVE   : MouseMoved = TRUE;
                                      x = message->MouseX;
                                      y = message->MouseY;
                                      ReplyMsg(message);
                                      break;

                   case MOUSEBUTTONS: if ((message->Code) == SELECTDOWN)
                                        {
                                           bx = x/9;
                                           by = y/9-1;
                                           goto part2;
                                        } 
                                      ReplyMsg(message);
                                      break;
                }
             } /*End While */
             if(MouseMoved == TRUE)
                {
                   MyBob->X = x-9;
                   MyBob->Y = y-10;
                   SortGList(Rp);
                   DrawGList(Rp,Vp);
                   RethinkDisplay();
                }
         } /* End FOREVER */

part2:     for (i=1;i<9;i++)
              {
                 PrintAt(590,380,"PT B?");
                 Delay(3);
                 PrintAt(590,380,"     ");
                 Delay(3);
              }
     FOREVER
        {
             sprintf(OutText,"%3d,%2d",x/9,y/9-1+topoffset);
             PrintAt(582,394,OutText);
             MouseMoved = FALSE;
         while(message = GetMsg(Wdw->UserPort))
             {
             switch (message->Class)
                {
                   case MOUSEMOVE   : MouseMoved = TRUE;
                                      x = message->MouseX;
                                      y = message->MouseY;
                                      ReplyMsg(message);
                                      break;

                   case MOUSEBUTTONS: if ((message->Code) == SELECTDOWN)
                                        {
                                           ex = x/9;
                                           ey = y/9-1;
                                           goto draw;
                                        } 
                                      ReplyMsg(message);
                                      break;
                }
             } /*End While */
             if(MouseMoved == TRUE)
                {
                   MyBob->X = x-9;
                   MyBob->Y = y-10;
                   SortGList(Rp);
                   DrawGList(Rp,Vp);
                   RethinkDisplay();
                }
         } /* End FOREVER */

draw:    SetFont(Rp,FontPtr1);
         if (pen==3)
             SetAPen(Rp,3);
         if (pen==2)
             SetAPen(Rp,2);
         if (roadpen==1)
             SetAPen(Rp,1);
         if ((ObjValue==2) || (ObjValue==3) || (ObjValue==4))
             SetAPen(Rp,2);
         MyBob->X = 650;
         MyBob->Y = 410;
         UpdateBob();
         if (bx<1) bx=1;
         if (bx>64) bx=64;
         if (by<1) by=1;
         if (by>64) by=64;
         if (ex<1) ex=1;
         if (ex>64) ex=64;
         if (ey<1) ey=1;
         if (ey>64) ey=64;

         if ((ex>=bx)&&(ey>=by))
           {
              for (hor=bx;hor<=ex;hor++)
                 {
                    for (ver=by;ver<=ey;ver++)
                       {
                          map[hor][ver+topoffset] = ObjValue;
                          PrintAt(hor*9-6,(ver+1)*9+2,ObjCode);
                       }
                 }
           }
         else if ((ex<=bx)&&(ey<=by))
           {
              for (hor=ex;hor<=bx;hor++)
                 {
                    for (ver=ey;ver<=by;ver++)
                       {
                          map[hor][ver+topoffset] = ObjValue;
                          PrintAt(hor*9-6,(ver+1)*9+2,ObjCode);
                       }
                 }
           }
         else if ((ex<=bx)&&(ey>=by))
           {
              for (hor=ex;hor<=bx;hor++)
                 {
                    for (ver=by;ver<=ey;ver++)
                       {
                          map[hor][ver+topoffset] = ObjValue;
                          PrintAt(hor*9-6,(ver+1)*9+2,ObjCode);
                       }
                 }
           }
         else if ((ex>=bx)&&(ey<=by))
           {
              for (hor=bx;hor<=ex;hor++)
                 {
                    for (ver=ey;ver<=by;ver++)
                       {
                          map[hor][ver+topoffset] = ObjValue;
                          PrintAt(hor*9-6,(ver+1)*9+2,ObjCode);
                       }
                 }
           }
    SetAPen(Rp,1);
    return();        
}

Initialize()
{
   LONG boxcnt;
   SetFont(Rp,FontPtr1);   /* FirePower Font */
   NewMenu( &fmenu, filemenu_names, file_items, file_names,
            NUM_FILE_ITEMS, item_widths, BLACK_FILL);
 
   SetMenuStrip(Wdw, &fmenu);
   LoadRGB4(Vp,&colors,4);
   SetAPen(Rp,1);   /* Drawing Color (BLACK) */
   SetBPen(Rp,0);   /* Background Color (GREY) */
   ClrScr();
   RectFill(Rp,580,10,581,399); /* Draw line dividing map and menu */

   RectFill(Rp,588,15,607,26);  /* Draw border around brown pick box */
   SetAPen(Rp,3);                  /* Set color to brown */
   RectFill(Rp,590,17,605,24);  /* Fill in brown box */
   SetAPen(Rp,2);                  /* Set color to green */
   RectFill(Rp,614,16,631,25);  /* Fill in green box */
   pen = 3;  /* set drawing pen to brown */

   for (boxcnt = 47;boxcnt < 330;boxcnt += 18)
      {
       SetAPen(Rp,1);                               /* Set color to black */
       RectFill(Rp,590,boxcnt,604,boxcnt+12);     /* Draw black boxes for menu picks */
       RectFill(Rp,615,boxcnt,629,boxcnt+12);
       SetAPen(Rp,0);                               /* Set color to background */
       RectFill(Rp,591,boxcnt+1,603,boxcnt+11);  /* Hollow out black boxes */
       RectFill(Rp,616,boxcnt+1,628,boxcnt+11);
      }
   SetAPen(Rp,1);
   PrintAt(593,58,">");
   PrintAt(618,58,"B");
   PrintAt(593,76,"A");
   PrintAt(618,76,"?");
   PrintAt(593,94,"D");
   PrintAt(618,94,"C");
   PrintAt(593,112,"/");
   PrintAt(618,112,"0");
   PrintAt(593,130,")");
   PrintAt(618,130,"'");
   PrintAt(593,148,"+");
   PrintAt(618,148,"-");
   PrintAt(593,166,"(");
   PrintAt(618,166,"*");
   PrintAt(593,184,"&");
   PrintAt(618,184,",");
   PrintAt(593,202,"<");
   PrintAt(618,202,";");
   PrintAt(593,220,"@");
   PrintAt(618,220,"9");
   PrintAt(593,238,".");
   PrintAt(618,238,"6");
   PrintAt(593,256,"4");
   PrintAt(618,256,"8");
   PrintAt(593,274,"5");
   PrintAt(618,274,"2");
   PrintAt(593,292,"1");
   PrintAt(618,292,"3");
   PrintAt(593,310,"#");
   PrintAt(618,310,"$");
   PrintAt(593,328,"%");

   RectFill(Rp,594,342,625,365); /* Draw box for 'line draw' */
   SetAPen(Rp,0);
   RectFill(Rp,595,343,624,364); /* Hollow out box */
   SetAPen(Rp,1);
   RectFill(Rp,600,347,600,360);
   RectFill(Rp,605,354,620,354);
}

NewMenu ( menu, item_names,  menu_items, menu_text, num_items, Mwidth, flag)
 
struct Menu      *menu;
char             *item_names[];
struct MenuItem  menu_items[];
struct IntuiText menu_text[];
int               num_items;
int               Mwidth;
long                flag;
{
    int i;
    int height = 0;
 
    for (i=0; i< num_items; i++) {
 
          menu_text[i].IText = item_names[i];
          menu_items[i].NextItem = &menu_items[i+1];
          menu_items[i].TopEdge = 10 * i;
          menu_items[i].LeftEdge = 0;
          menu_items[i].Height = 8;
          menu_items[i].ItemFill = (APTR)&menu_text[i];
          menu_items[i].Flags = flag;
          menu_items[i].Width = Mwidth;
          menu_items[i].MutualExclude = 0x0000;
          menu_items[i].Command = 0;
          menu_items[i].SubItem = NULL;
          menu_items[i].NextSelect = NULL;
          height += 10;
    }
    menu_items[num_items-1].NextItem = NULL;
    menu->Height = height;
}

domenu(item)
int item;
{
      switch (item) {

            case   NEW_ITEM: NewScr();
                             break;

            case  LOAD_ITEM: LoadMap();
                             break;

            case  SAVE_ITEM: SaveMap();
                             break;

            case  LOADLEFT_ITEM:  LoadLeft();
                                  break;

            case  LOADRIGHT_ITEM: LoadRight();
                                  break;

            case  SAVELEFT_ITEM : SaveLeft();
                                  break;

            case  SAVERIGHT_ITEM: SaveRight();
                                  break;

            case  QUIT_ITEM: End_program();
                             exit(0);
                             break;
                   }
}

NewScr()
{
   int treesx;
   int treesy;
   char ch;
   topoffset = 0;
   ClrScr();
   SetAPen(Rp,1);
   SetFont(Rp,FontPtr2);
   PrintAt(40,200,"Would you like random trees? (y/n) ");
   SetFont(Rp,FontPtr1);
   for (;;)
      {
        message = GetMsg(Wdw->UserPort);
        if ((message->Code) < 200)
           break;
      }

   if ((message->Code) == 21)
     {
        for (treesx=1;treesx<65;treesx++)
           {
              for (treesy=1;treesy<65;treesy++)
                 {
                    rndnum = ran()*5;
                    map[treesx][treesy] = rndnum;
                 }
           }
     }
   else
     {
        for (treesx=1;treesx<65;treesx++)
           {
              for (treesy=1;treesy<65;treesy++)
                 {
                    rndnum = ran()*2;
                    map[treesx][treesy] = rndnum;
                 }
           }
     }
   PrintScr();
}
   
PrintScr()     /* This routine prints the map on the screen */
{
   int row,col;
   char *TempCode;
   TempCode = ObjCode;
   MyBob->X = 650;
   MyBob->Y = 410;
   UpdateBob();
   ClrScr();
   topoffset = 0;
   for (row=0;row<64;row++)
      {
         for (col=1;col<44;col++)
            {
                if (map[row+1][col]<2)
                      continue;
                if (map[row+1][col]==3)
                  {
                      ObjCode = "#";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==4)
                  {
                      ObjCode = "$";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==2)
                  {
                      ObjCode = "%";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==34)
                  {
                      ObjCode = "6";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==22)
                  {
                      ObjCode = "6";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==87)
                  {
                      ObjCode = "<";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==85)
                  {
                      ObjCode = "<";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==67)
                  {
                      ObjCode = "@";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==44)
                  {
                      ObjCode = "@";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==11)
                  {
                      ObjCode = "+";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==71)
                  {
                      ObjCode = "D";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==48)
                  {
                      ObjCode = "D";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==92)
                  {
                      ObjCode = "5";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==89)
                  {
                      ObjCode = "5";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==37)
                  {
                      ObjCode = "9";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==25)
                  {
                      ObjCode = "9";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==14)
                  {
                      ObjCode = ".";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==32)
                  {
                      ObjCode = "4";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==20)
                  {
                      ObjCode = "4";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==15)
                  {
                      ObjCode = "/";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==65)
                  {
                      ObjCode = ">";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==42)
                  {
                      ObjCode = ">";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==36)
                  {
                      ObjCode = "8";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==24)
                  {
                      ObjCode = "8";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==29)
                  {
                      ObjCode = "1";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==17)
                  {
                      ObjCode = "1";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==31)
                  {
                      ObjCode = "3";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==19)
                  {
                      ObjCode = "3";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==10)
                  {
                      ObjCode = "*";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==7)
                  {
                      ObjCode = "'";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==66)
                  {
                      ObjCode = "?";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==43)
                  {
                      ObjCode = "?";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==6)
                  {
                      ObjCode = "&";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==12)
                  {
                      ObjCode = ",";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==13)
                  {
                      ObjCode = "-";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==73)
                  {
                      ObjCode = "C";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==50)
                  {
                      ObjCode = "C";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==39)
                  {
                      ObjCode = ";";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==27)
                  {
                      ObjCode = ";";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==8)
                  {
                      ObjCode = "(";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==5)
                  {
                      ObjCode = ")";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==64)
                  {
                      ObjCode = "A";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==41)
                  {
                      ObjCode = "A";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==30)
                  {
                      ObjCode = "2";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==18)
                  {
                      ObjCode = "2";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                if (map[row+1][col]==16)
                  {
                      ObjCode = "0";
                      SetAPen(Rp,1);
                      goto next3;
                  }
                if (map[row+1][col]==70)
                  {
                      ObjCode = "B";
                      SetAPen(Rp,2);
                      goto next3;
                  }
                if (map[row+1][col]==47)
                  {
                      ObjCode = "B";
                      SetAPen(Rp,3);
                      goto next3;
                  }
                      continue;

               next3: PrintAt(row*9+3,col*9+11,ObjCode);
            }
      }
     ObjCode = TempCode;
     SetAPen(Rp,1);
}

LoadMap()       /* This routine will load a full (4096 bytes) map. */
{
   FILE *in;
   char buf[27];
   int i = 0;
   int j, row, col;
   ClrScr();
   SetAPen(Rp,1);
   SetFont(Rp,FontPtr2);
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|VANILLAKEY|MOUSEBUTTONS|MENUPICK);
   PrintAt(50,100,"Enter name of map to load: ");
   for (;;)
      {
        message = GetMsg(Wdw->UserPort);
        if ((message->Code) == 13)
             break;
        if (((message->Code) > 7) && ((message->Code) < 123))
          {
             buf[i] = message->Code;
                  if ((buf[i] == 8) && (i>0))
                    {
                       i-=1;
                       PrintAt(i*8+266,100," ");
                    }
                  else
                    {
                       if (((buf[i] == 8) && (i==0)) || (i>25))
                            goto skip;
                       sprintf(OutText,"%c",buf[i]);
                       PrintAt(i*8+266,100,OutText);
                       i++;
                       skip: ;
                    }
          }
      }
   buf[i] = 0;
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|RAWKEY|MOUSEBUTTONS|MENUPICK);
   if ((in = fopen(&buf[0],"r")) != NULL)
     {
        SetFont(Rp,FontPtr1);
        for (row=1;row<65;row++)
           {
              for (col=1;col<65;col++)
                   map[row][col] = getc(in);
           }
        fclose(in);
        PrintScr();
     }
   else
        PrintAt(200,200,"Error, can't load file.");
   SetFont(Rp,FontPtr1);
}

SaveMap()     /* This routine saved a full (4096 bytes) map. */
{
   FILE *out;
   char buf[27];
   int i = 0;
   int j, row, col;
   ClrScr();
   SetAPen(Rp,1);
   SetFont(Rp,FontPtr2);
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|VANILLAKEY|MOUSEBUTTONS|MENUPICK);
   PrintAt(50,100,"Enter name of map to save: ");
   for (;;)
      {
        message = GetMsg(Wdw->UserPort);
        if ((message->Code) == 13)
             break;
        if (((message->Code) > 7) && ((message->Code) < 123))
          {
             buf[i] = message->Code;
                  if ((buf[i] == 8) && (i>0))
                    {
                       i-=1;
                       PrintAt(i*8+266,100," ");
                    }
                  else
                    {
                       if (((buf[i] == 8) && (i==0)) || (i>25))
                            goto skip;
                       sprintf(OutText,"%c",buf[i]);
                       PrintAt(i*8+266,100,OutText);
                       i++;
                       skip: ;
                    }
          }
      }
   buf[i] = 0;
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|RAWKEY|MOUSEBUTTONS|MENUPICK);
   if ((out = fopen(&buf[0],"w")) != NULL)
     {
        SetFont(Rp,FontPtr1);
        for (row=1;row<65;row++)
           {
              for (col=1;col<65;col++)
                   putc(map[row][col],out);
           }
        fclose(out);
        PrintScr();
     }
   else
        PrintAt(200,200,"Error, can't save file.");
   SetFont(Rp,FontPtr1);
}

LoadLeft()  /* This routine loads the left half of a map (2048 bytes) */
{
   FILE *in;
   char buf[27];
   int i = 0;
   int j, row, col;
   ClrScr();
   SetAPen(Rp,1);
   SetFont(Rp,FontPtr2);
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|VANILLAKEY|MOUSEBUTTONS|MENUPICK);
   PrintAt(50,100,"Enter name of left map to load: ");
   for (;;)
      {
        message = GetMsg(Wdw->UserPort);
        if ((message->Code) == 13)
             break;
        if (((message->Code) > 7) && ((message->Code) < 123))
          {
             buf[i] = message->Code;
                  if ((buf[i] == 8) && (i>0))
                    {
                       i-=1;
                       PrintAt(i*8+306,100," ");
                    }
                  else
                    {
                       if (((buf[i] == 8) && (i==0)) || (i>25))
                            goto skip;
                       sprintf(OutText,"%c",buf[i]);
                       PrintAt(i*8+306,100,OutText);
                       i++;
                       skip: ;
                    }
          }
      }
   buf[i] = 0;
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|RAWKEY|MOUSEBUTTONS|MENUPICK);
   if ((in = fopen(&buf[0],"r")) != NULL)
     {
        SetFont(Rp,FontPtr1);
        for (row=1;row<33;row++)
           {
              for (col=1;col<65;col++)
                   map[row][col] = getc(in);
           }
        fclose(in);
        PrintScr();
     }
   else
        PrintAt(200,200,"Error, can't load file.");
   SetFont(Rp,FontPtr1);
}

LoadRight()  /* This routine loads the right half of a map (2048 bytes)  */
{
   FILE *in;
   char buf[27];
   int i = 0;
   int j, row, col;
   ClrScr();
   SetAPen(Rp,1);
   SetFont(Rp,FontPtr2);
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|VANILLAKEY|MOUSEBUTTONS|MENUPICK);
   PrintAt(50,100,"Enter name of right map to load: ");
   for (;;)
      {
        message = GetMsg(Wdw->UserPort);
        if ((message->Code) == 13)
             break;
        if (((message->Code) > 7) && ((message->Code) < 123))
          {
             buf[i] = message->Code;
                  if ((buf[i] == 8) && (i>0))
                    {
                       i-=1;
                       PrintAt(i*8+314,100," ");
                    }
                  else
                    {
                       if (((buf[i] == 8) && (i==0)) || (i>25))
                            goto skip;
                       sprintf(OutText,"%c",buf[i]);
                       PrintAt(i*8+314,100,OutText);
                       i++;
                       skip: ;
                    }
          }
      }
   buf[i] = 0;
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|RAWKEY|MOUSEBUTTONS|MENUPICK);
   if ((in = fopen(&buf[0],"r")) != NULL)
     {
        SetFont(Rp,FontPtr1);
        for (row=33;row<65;row++)
           {
              for (col=1;col<65;col++)
                   map[row][col] = getc(in);
           }
        fclose(in);
        PrintScr();
     }
   else
        PrintAt(200,200,"Error, can't load file.");
   SetFont(Rp,FontPtr1);
}

SaveLeft()   /* This routine saves the left half of a map (2048 bytes) */
{
   FILE *out;
   char buf[27];
   int i = 0;
   int j, row, col;
   ClrScr();
   SetAPen(Rp,1);
   SetFont(Rp,FontPtr2);
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|VANILLAKEY|MOUSEBUTTONS|MENUPICK);
   PrintAt(50,100,"Enter name of left map to save: ");
   for (;;)
      {
        message = GetMsg(Wdw->UserPort);
        if ((message->Code) == 13)
             break;
        if (((message->Code) > 7) && ((message->Code) < 123))
          {
             buf[i] = message->Code;
                  if ((buf[i] == 8) && (i>0))
                    {
                       i-=1;
                       PrintAt(i*8+306,100," ");
                    }
                  else
                    {
                       if (((buf[i] == 8) && (i==0)) || (i>25))
                            goto skip;
                       sprintf(OutText,"%c",buf[i]);
                       PrintAt(i*8+306,100,OutText);
                       i++;
                       skip: ;
                    }
          }
      }
   buf[i] = 0;
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|RAWKEY|MOUSEBUTTONS|MENUPICK);
   if ((out = fopen(&buf[0],"w")) != NULL)
     {
        SetFont(Rp,FontPtr1);
        for (row=1;row<33;row++)
           {
              for (col=1;col<65;col++)
                   putc(map[row][col],out);
           }
        fclose(out);
        PrintScr();
     }
   else
        PrintAt(200,200,"Error, can't save file.");
   SetFont(Rp,FontPtr1);
}

SaveRight()   /* This routine saves the right half of a map (2048 bytes) */
{
   FILE *out;
   char buf[27];
   int i = 0;
   int j, row, col;
   ClrScr();
   SetAPen(Rp,1);
   SetFont(Rp,FontPtr2);
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|VANILLAKEY|MOUSEBUTTONS|MENUPICK);
   PrintAt(50,100,"Enter name of right map to save: ");
   for (;;)
      {
        message = GetMsg(Wdw->UserPort);
        if ((message->Code) == 13)
             break;
        if (((message->Code) > 7) && ((message->Code) < 123))
          {
             buf[i] = message->Code;
                  if ((buf[i] == 8) && (i>0))
                    {
                       i-=1;
                       PrintAt(i*8+314,100," ");
                    }
                  else
                    {
                       if (((buf[i] == 8) && (i==0)) || (i>25))
                            goto skip;
                       sprintf(OutText,"%c",buf[i]);
                       PrintAt(i*8+314,100,OutText);
                       i++;
                       skip: ;
                    }
          }
      }
   buf[i] = 0;
   ModifyIDCMP(Wdw,CLOSEWINDOW|MOUSEMOVE|RAWKEY|MOUSEBUTTONS|MENUPICK);
   if ((out = fopen(&buf[0],"w")) != NULL)
     {
        SetFont(Rp,FontPtr1);
        for (row=33;row<65;row++)
           {
              for (col=1;col<65;col++)
                   putc(map[row][col],out);
           }
        fclose(out);
        PrintScr();
     }
   else
        PrintAt(200,200,"Error, can't save file.");
   SetFont(Rp,FontPtr1);
}

End_program()
{
   DeleteVSprite(MyBob);

       SortGList(Rp);
       DrawGList(Rp,Vp);
       RethinkDisplay();

   DeleteGelsInfo(Rp->GelsInfo);
   ClearMenuStrip(Wdw);
   CloseFont(FontPtr1);
   CloseFont(FontPtr2);
   CloseWindow(Wdw);
   CloseScreen(CustScr);
   CloseLibrary(DiskfontBase);
   CloseLibrary(GfxBase);
   CloseLibrary(IntuitionBase);
}

