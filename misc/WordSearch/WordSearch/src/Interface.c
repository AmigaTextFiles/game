#include <stdio.h>
#include <exec/types.h>
#include <exec/libraries.h>
#include "interface.h"
#include "wsearch.h"
#include <libraries/reqbase.h>

#define openxwl 200
#define openywl 150
#define openxdp 320
#define openydp 150

#define EXTRA  CHECKWIDTH
#define FLAGSA CHECKIT|ITEMTEXT|MENUTOGGLE|ITEMENABLED|HIGHCOMP
#define FLAGSB CHECKIT|ITEMTEXT|MENUTOGGLE|ITEMENABLED|COMMSEQ|HIGHCOMP
#define FLAGSC ITEMTEXT|MENUTOGGLE|ITEMENABLED|HIGHCOMP
#define FLAGSD ITEMTEXT|MENUTOGGLE|ITEMENABLED|COMMSEQ|HIGHCOMP

unsigned char fontheight;
unsigned char fontwidth;

char undo[MAXSIZE+1];

struct IntuitionBase *IntuitionBase = NULL;
struct GfxBase *GfxBase = NULL;
struct Window *WLWin = NULL,*DPWin = NULL;
struct RastPort *WLRP = NULL,*DPRP = NULL;
struct IntuiMessage *IMsg = NULL,Msg;
struct ReqLib *ReqBase=NULL;

struct TextAttr tp=
{
  "topaz.font",                 /* Topaz font. */
  TOPAZ_EIGHTY,                 /* 80/40 characters. */
  FS_NORMAL,			/* Underlined italic chars. */ 
  FPF_ROMFONT                   /* Exist in ROM. */
};

struct Gadget Words[MAXWORD];
struct StringInfo WordInfo[MAXWORD];
struct Gadget *LastWord=&Words[0];

struct PropInfo
  zp = {
        FREEVERT|AUTOKNOB,
        0,0,
        0,MAXBODY,
        0,0,0,0,0,0
       };
struct Image zimg;
struct Gadget
   z = {
        &Words[0],
        -15,9,16,-17,
        GADGHCOMP|GRELRIGHT|GRELHEIGHT,
        GADGIMMEDIATE|FOLLOWMOUSE|RELVERIFY,
        PROPGADGET|GZZGADGET,
        (APTR)&zimg,
        NULL,
        NULL,
        0,
        (APTR)&zp,
        0,NULL
       };
struct NewWindow NewWinWL =
       {
        0, 0, openxwl,openywl,
        0, 1,
        CLOSEWINDOW|GADGETUP|GADGETDOWN|NEWSIZE|
        MOUSEMOVE|REFRESHWINDOW|MENUPICK,
        WINDOWCLOSE|WINDOWDRAG|WINDOWDEPTH|WINDOWSIZING|
        GIMMEZEROZERO|SIMPLE_REFRESH,
        &z,
        NULL,
        "WORDLIST",
        NULL, NULL,
        75, 75, MAXSIZE*FONTWIDTH, MAXROWS*FONTHEIGHT,
        WBENCHSCREEN
       };

struct IntuiText IText[MAXROWS];
struct PropInfo
  xp = {
        FREEHORIZ|AUTOKNOB,
        0,0,
        MAXBODY,0,
        0,0,0,0,0,0
       },
  yp = {
        FREEVERT|AUTOKNOB,
        0,0,
        0,MAXBODY,
        0,0,0,0,0,0
       };
struct Image ximg,yimg;
struct Gadget
  x = {
        NULL,
        1,-8,-15,9,
        GADGHCOMP|GRELBOTTOM|GRELWIDTH,
        GADGIMMEDIATE|FOLLOWMOUSE|RELVERIFY|BOTTOMBORDER,
        PROPGADGET|GZZGADGET,
        (APTR)&ximg,
        NULL,
        NULL,
        0,
        (APTR)&xp,
        0,NULL
      },
  y = {
        &x,
        -15,9,16,-17,
        GADGHCOMP|GRELRIGHT|GRELHEIGHT,
        GADGIMMEDIATE|FOLLOWMOUSE|RELVERIFY,
        PROPGADGET|GZZGADGET,
        (APTR)&yimg,
        NULL,
        NULL,
        0,
        (APTR)&yp,
        0,NULL
      };
struct NewWindow NewWinDP =
        {
        200, 0, openxdp,openydp,
        0, 1,
        CLOSEWINDOW|GADGETUP|GADGETDOWN|NEWSIZE|
        MOUSEMOVE|REFRESHWINDOW|MENUPICK,
        WINDOWCLOSE|WINDOWDRAG|WINDOWDEPTH|WINDOWSIZING|
        GIMMEZEROZERO|SIMPLE_REFRESH,
        &y,
        NULL,
        "PUZZLE",
        NULL, NULL,
        75, 75, MAXCOLS*FONTWIDTH, MAXROWS*FONTHEIGHT,
        WBENCHSCREEN
        };

struct IntuiText IT[] =
  {
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Open"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Save"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Save As"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Print"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Wordlist"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Display"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Print Redirect"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Dimensions"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Generate"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "New Key"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "New Puzzle"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Word Direction"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Key"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Puzzle"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Direction"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "+X+Y"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "+X-Y"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "-X+Y"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "-X-Y"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "+Y+X"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "+Y-X"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "-Y+X"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "-Y-X"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Insert"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Delete"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Sort"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Left"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Left-Down"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Down"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Right-Down"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Right"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Right-Up"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Up"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Left-Up"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "New"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "To File"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "To Clipboard"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Uppercase All"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Clean Up"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "To Buffer"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "From Buffer"},
    { 0, 1, JAM2, CHECKWIDTH, 0, &tp, "Try to Overlap"}
  };
struct MenuItem M0I4[] =
  {
    {&M0I4[ 1], 80,  2,160, 10,FLAGSD,0,(APTR)&IT[ 4],NULL, 'w',NULL},
    {NULL     , 80, 12,160, 10,FLAGSD,0,(APTR)&IT[ 5],NULL, 'd',NULL}
  };
struct MenuItem M0I5[] =
  {
    {&M0I5[ 1], 80,  2,160, 10,FLAGSA,2,(APTR)&IT[35],NULL,NULL,NULL},
    {NULL     , 80, 12,160, 10,FLAGSA,1,(APTR)&IT[36],NULL,NULL,NULL}
  };
struct MenuItem M1I1[] =
  {
    {&M1I1[ 1], 80,  2,160, 10,FLAGSD,0,(APTR)&IT[ 9],NULL, 'n',NULL},
    {&M1I1[2] , 80, 12,160, 10,FLAGSD,0,(APTR)&IT[10],NULL, 'z',NULL},
    {NULL     , 80, 22,160, 10,FLAGSA,0,(APTR)&IT[41],NULL, NULL, NULL}
  };
struct MenuItem M1I2[] =
  {
    {&M1I2[ 1], 80,  2, 100, 10,FLAGSA|CHECKED,0,(APTR)&IT[26],NULL,NULL,NULL},
    {&M1I2[ 2], 80, 12, 100, 10,FLAGSA|CHECKED,0,(APTR)&IT[27],NULL,NULL,NULL},
    {&M1I2[ 3], 80, 22, 100, 10,FLAGSA|CHECKED,0,(APTR)&IT[28],NULL,NULL,NULL},
    {&M1I2[ 4], 80, 32, 100, 10,FLAGSA|CHECKED,0,(APTR)&IT[29],NULL,NULL,NULL},
    {&M1I2[ 5], 80, 42, 100, 10,FLAGSA|CHECKED,0,(APTR)&IT[30],NULL,NULL,NULL},
    {&M1I2[ 6], 80, 52, 100, 10,FLAGSA|CHECKED,0,(APTR)&IT[31],NULL,NULL,NULL},
    {&M1I2[ 7], 80, 62, 100, 10,FLAGSA|CHECKED,0,(APTR)&IT[32],NULL,NULL,NULL},
    {NULL     , 80, 72, 100, 10,FLAGSA|CHECKED,0,(APTR)&IT[33],NULL,NULL,NULL}
  };
struct MenuItem M2I2[] =
  {
    {&M2I2[ 1], 80,  2, 80, 10,FLAGSA|CHECKED,254,(APTR)&IT[15],NULL,NULL,NULL},
    {&M2I2[ 2], 80, 12, 80, 10,FLAGSA,253,(APTR)&IT[16],NULL,NULL,NULL},
    {&M2I2[ 3], 80, 22, 80, 10,FLAGSA,251,(APTR)&IT[17],NULL,NULL,NULL},
    {&M2I2[ 4], 80, 32, 80, 10,FLAGSA,247,(APTR)&IT[18],NULL,NULL,NULL},
    {&M2I2[ 5], 80, 42, 80, 10,FLAGSA,239,(APTR)&IT[19],NULL,NULL,NULL},
    {&M2I2[ 6], 80, 52, 80, 10,FLAGSA,223,(APTR)&IT[20],NULL,NULL,NULL},
    {&M2I2[ 7], 80, 62, 80, 10,FLAGSA,191,(APTR)&IT[21],NULL,NULL,NULL},
    {NULL     , 80, 72, 80, 10,FLAGSA,127,(APTR)&IT[22],NULL,NULL,NULL}
  };
struct MenuItem M0[] =
  {
    {&M0[ 1],  0,  0,160, 10,FLAGSC,0,(APTR)&IT[34],NULL,NULL,NULL},
    {&M0[ 2],  0, 12,160, 10,FLAGSD,0,(APTR)&IT[ 0],NULL, 'o',NULL},
    {&M0[ 3],  0, 24,160, 10,FLAGSD,0,(APTR)&IT[ 1],NULL, 's',NULL},
    {&M0[ 4],  0, 36,160, 10,FLAGSC,0,(APTR)&IT[ 2],NULL,NULL,NULL},
    {&M0[ 5],  0, 48,160, 10,FLAGSC,0,(APTR)&IT[ 3],NULL,NULL,&M0I4[0]},
    {NULL   ,  0, 60,160, 10,FLAGSC,0,(APTR)&IT[ 6],NULL,NULL,&M0I5[0]}
  };
struct MenuItem M1[] =
  {
    {&M1[ 1],  0,  0,160, 10,FLAGSC,0,(APTR)&IT[ 7],NULL,NULL,NULL},
    {&M1[ 2],  0, 12,160, 10,FLAGSC,0,(APTR)&IT[ 8],NULL,NULL,&M1I1[0]},
    {NULL   ,  0, 24,160, 10,FLAGSC,0,(APTR)&IT[11],NULL,NULL,&M1I2[0]}
  };
struct MenuItem M2[] =
  {
    {&M2[ 1],  0,  0, 160, 10,FLAGSD,0,(APTR)&IT[12],NULL, 'k',NULL},
    {&M2[ 2],  0, 12, 160, 10,FLAGSD,0,(APTR)&IT[13],NULL, 'p',NULL},
    {NULL   ,  0, 24, 160, 10,FLAGSC,0,(APTR)&IT[14],NULL,NULL,&M2I2[0]}
  };
struct MenuItem M3[] =
  {
    {&M3[ 1],  0,  0, 160, 10,FLAGSC,0,(APTR)&IT[39],NULL,NULL,NULL},
    {&M3[ 2],  0, 12, 160, 10,FLAGSC,0,(APTR)&IT[40],NULL,NULL,NULL},
    {&M3[ 3],  0, 24, 160, 10,FLAGSD,0,(APTR)&IT[23],NULL, 'i',NULL},
    {&M3[ 4],  0, 36, 160, 10,FLAGSD,0,(APTR)&IT[24],NULL, 'd',NULL},
    {&M3[ 5],  0, 48, 160, 10,FLAGSC,0,(APTR)&IT[38],NULL,NULL,NULL},
    {&M3[ 6],  0, 60, 160, 10,FLAGSC,0,(APTR)&IT[37],NULL,NULL,NULL},
    {NULL   ,  0, 72, 160, 10,FLAGSC,0,(APTR)&IT[25],NULL,NULL,NULL}
  };
struct Menu TheMenu[] =
  {
    {&TheMenu[ 1],  0,  0,100, 10,MENUENABLED,"Project ",&M0[0]},
    {&TheMenu[ 2],100,  0,100, 10,MENUENABLED,"Puzzle  ",&M1[0]},
    {&TheMenu[ 3],200,  0,100, 10,MENUENABLED,"Display ",&M2[0]},
    { NULL       ,300,  0,100, 10,MENUENABLED,"Wordlist",&M3[0]}
  };

BOOL init()
{
   int i;
   
   key = (char *)calloc((px+1)*(py+1),sizeof(char));
   if(key<=0)
   {
	fprintf(stderr,"Unable to Allocate Memory for new Key\n");
	return(FALSE);
   }
   puzzle = (char *)calloc((px+1)*(py+1),sizeof(char));
   if(puzzle<=0)
   {
	fprintf(stderr,"Unable to Allocate Memory for new Puzzle\n");
	return(FALSE);
   }
   display = (char *)calloc((max(px,py)+1)*(max(px,py)+2),sizeof(char));
   if(display<=0)
   {
	fprintf(stderr,"Unable to Allocate Memory for new Display\n");
	return(FALSE);
   }


    IntuitionBase = (struct IntuitionBase *)
      OpenLibrary("intuition.library",0);
    if(IntuitionBase == NULL) 
    {
	fprintf(stderr,"Couldn't Open Intuition.library\n");
	return(FALSE);
    }
    
    GfxBase = (struct GfxBase *)
      OpenLibrary("graphics.library",0);
    if(GfxBase == NULL)
    {
	fprintf(stderr,"Couldn't Open Graphics.library\n");
	return(FALSE);
    }

    ReqBase = (struct ReqLib *)
      OpenLibrary("req.library",REQVERSION);
    if(ReqBase == NULL)
    {
	fprintf(stderr,"Couldn't Open Req.library V2\n");
	return(FALSE);
    }

    i = GetFontHandW();
    fontheight = (i>>8)&0xFF;
    fontwidth = i&0xFF;

    for(i=0;i<MAXROWS;i++)
     {
        IText[i].FrontPen = 1;
        IText[i].BackPen = 0;
        IText[i].DrawMode = JAM2;
        IText[i].LeftEdge = 0;
        IText[i].TopEdge = i * fontheight;
        IText[i].ITextFont = NULL;
        IText[i].NextText = &IText[i+1];
	IText[i].IText = " ";
     }
    IText[MAXROWS-1].NextText = NULL;

    for(i=0;i<MAXWORD;i++)
     {
        word[i][0] = 0;
        Words[i].NextGadget = &Words[i+1];
        Words[i].LeftEdge = 0;
        Words[i].TopEdge = i * (FONTHEIGHT+2);
        Words[i].Width = 0;
        Words[i].Height = FONTHEIGHT+2;
        Words[i].Flags = GADGHCOMP|GRELWIDTH;
        Words[i].Activation = GADGIMMEDIATE|RELVERIFY;
        Words[i].GadgetType = STRGADGET;
        Words[i].GadgetRender = NULL;
        Words[i].SelectRender = NULL;
        Words[i].GadgetText = NULL;
        Words[i].MutualExclude = 0;
        Words[i].SpecialInfo = (APTR)&WordInfo[i];
        Words[i].GadgetID = 1;
        WordInfo[i].Buffer = word[i];
        WordInfo[i].UndoBuffer = undo;
        WordInfo[i].BufferPos = 0;
        WordInfo[i].MaxChars = MAXSIZE;
        WordInfo[i].DispPos = 0;
     }
    Words[MAXWORD-1].NextGadget = NULL;

    WLWin = (struct Window *) OpenWindow(&NewWinWL);
    if(WLWin == NULL)
    {
	fprintf(stderr,"Couldn't Open Wordlist Window\n");
    	return(FALSE);
    }
    WLRP = WLWin->RPort;
    SetMenuStrip(WLWin,TheMenu);
    OffMenu(WLWin,(ULONG)SHIFTMENU(0)+SHIFTITEM(5)+SHIFTSUB(1));


    DPWin = (struct Window *) OpenWindow(&NewWinDP);
    if(DPWin == NULL)
    {
	fprintf(stderr,"Couldn't Open Display Window\n");
	return(FALSE);
    }
    DPRP = DPWin->RPort;
    SetMenuStrip(DPWin,TheMenu);
    OffMenu(DPWin,(ULONG)SHIFTMENU(0)+SHIFTITEM(5)+SHIFTSUB(1));

    Msg.Class = NEWSIZE;
    wordlist();

    return(TRUE);
}
