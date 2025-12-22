#ifdef DO_AMIGAOS

#include <rtgmaster/rtgmaster.h>
#include <rtgmaster/rtgsublibs.h>
#include <clib/rtgmaster_protos.h>
#include <powerpc/memoryPPC.h>
#include <clib/powerpc_protos.h>

#include <graphics/gfx.h>
#include <graphics/rastport.h>
#include <intuition/intuition.h>
#include <exec/types.h>

// Next three structures are internal rtgmaster structures used
// by a hack, that is needed as rtgmaster currently only supports
// LoadRGB32-style color loading, not SetRGB32-style color loading
// Will add this to the next rtgmaster-version. Currently this
// program does not run on EGS.

#define byte UBYTE

struct MyPort
{
    struct MsgPort *port;
    ULONG signal;
    WORD *MouseX;
    WORD *MouseY;
};

int Workbench=0;

struct RtgScreenAMI
{
    struct RtgScreen Header;
    UWORD  Locks;
    struct Screen *ScreenHandle;
    ULONG  PlaneSize;
    ULONG  DispBuf;
    ULONG  ChipMem1;
    ULONG  ChipMem2;
    ULONG  ChipMem3;
    struct BitMap Bitmap1;
    struct BitMap Bitmap2;
    struct BitMap Bitmap3;
    ULONG  Flags;
    struct Rectangle MyRect;
    BYTE   Place[52];
    struct RastPort RastPort1;
    struct RastPort RastPort2;
    struct RastPort RastPort3;
    struct Window *MyWindow;
    APTR   Pointer;
    struct MyPort  PortData;
    struct DBufInfo *dbufinfo;
    ULONG DispBuf1;
    ULONG DispBuf2;
    ULONG DispBuf3;
    ULONG SafeToWrite;
    ULONG SafeToDisp;
    ULONG SrcMode;
    APTR   tempras;
    APTR   tempbm;
    APTR   wbcolors;
    ULONG  Width;
    ULONG  Height;
    ULONG  colchanged;
};

struct RtgScreenCGX
{
    struct RtgScreen Header;
    struct Screen *MyScreen;
    ULONG  ActiveMap;
    APTR   MapA;
    APTR   MapB;
    APTR   MapC;
    APTR   FrontMap;
    ULONG  Bytes;
    ULONG  Width;
    UWORD  Height;
    ULONG  NumBuf;
    UWORD  Locks;
    ULONG  ModeID;
    struct BitMap *RealMapA;
    ULONG Tags[5];
    ULONG  OffA;
    ULONG  OffB;
    ULONG  OffC;
    struct Window *MyWindow;
    struct MyPort PortData;
    ULONG  BPR;
    struct DBufInfo *dbi;
    ULONG  SafeToWrite;
    ULONG  SafeToDisp;
    ULONG  Special;
    ULONG  SrcMode;
    APTR   tempras;
    APTR   tempbm;
    APTR   wbcolors;
    ULONG  colchanged;
    ULONG  ccol;
};

#include "system.h"

extern "C" {
#include <exec/types.h>
#include <exec/memory.h>
#include <exec/execbase.h>

#include <intuition/intuition.h>
#include <devices/inputevent.h>

#include <clib/exec_protos.h>

#include "cryst_rev.h"
extern void ConvertFrame(byte *,byte *,unsigned long);


}

#include <clib/rtgmaster_protos.h>
#include <clib/graphics_protos.h>

extern struct ExecBase *SysBase;
struct RTGMasterBase *RTGMasterBase;

static char *version = VERSTAG;
static struct Screen *scr;
static struct Window *wnd;
static unsigned short *empty_pointer;
static struct RastPort temprp;

struct GfxBase *GfxBase;
struct Library *PowerPCBase;
struct Library *WarpBase;

static BOOL aga;

struct ScreenReq *sr;
struct RtgScreen *MyScreen;

struct ViewPort *vp;
extern int mmu;


// Keyboard fonctions
Graphics::Graphics(int argc, char *argv[])
{
        signal(SIGINT, SIG_IGN);                  // FIXME: make a proper handler

        if (mmu) Memory=(char *)AllocVecPPC(FRAME_WIDTH*FRAME_HEIGHT,MEMF_CLEAR|MEMF_FAST|MEMF_CACHEOFF,8);

        else Memory = (char *)AllocVecPPC(FRAME_WIDTH*FRAME_HEIGHT, MEMF_CLEAR|MEMF_FAST,8);

        // don't touch, please !
        graphicsData = Memory;
}

Graphics::~Graphics(void)
{
        if(Memory) { FreeVecPPC(Memory); Memory = NULL; }
}


static unsigned long WBColorTable[3*256+2],ColorTable[3*256+2];
static int pen_obtained=FALSE;
static struct ColorMap *ColorMap;
static byte transtable[256];
struct Window *Window;

void SetPalette_WIN (unsigned char *palette)
{
        struct TagItem EmptyTags[] =
        {
                TAG_DONE,0
        };

        int i,r,g,b;
        unsigned char *p;
        struct ViewPort *VPort;

        p = palette;

        if (!aga) Window=((struct RtgScreenCGX *)MyScreen)->MyWindow;
        else Window=((struct RtgScreenAMI *)MyScreen)->MyWindow;

        ColorMap = Window->WScreen->ViewPort.ColorMap;
        VPort = &Window->WScreen->ViewPort;
        if (!(pen_obtained))
        {
            WBColorTable[0] = 0x01000000;
            WBColorTable[3*256+1] = 0;
            GetRGB32(ColorMap,0,256,WBColorTable+1);
            for (i=0;i<(3*256+2);i++)
                ColorTable[i] = WBColorTable[i];
            for (i=0; i<256; i++)
            {
                    r = ((ULONG)*p++)<<24;
                    g = ((ULONG)*p++)<<24;
                    b = ((ULONG)*p++)<<24;
                    transtable[i] = ObtainBestPenA(ColorMap,r,g,b,EmptyTags);
            }
        }
        p = palette;
        for (i=0; i<256; i++)
        {
                ColorTable[3*i+1/*3*transtable[i]+1*/] = ((ULONG)*p++)<<24;
                ColorTable[3*i+2/*3*transtable[i]+2*/] = ((ULONG)*p++)<<24;
                ColorTable[3*i+3/*3*transtable[i]+3*/] = ((ULONG)*p++)<<24;
        }
        LoadRGB32(VPort,ColorTable);
        pen_obtained = TRUE;
}

int Graphics::Open(void)
{
 
  int display_id, width, height;

#ifdef CHIRES
  struct TagItem rtag[] = {
    smr_MinWidth,       640,
    smr_MinHeight,      400,
    smr_MaxWidth,       640,
    smr_MaxHeight,      512,
    smr_ChunkySupport,  512,
    smr_PlanarSupport,  -1,
    smr_ProgramUsesC2P, 0,
    smr_Buffers,2,
    TAG_DONE,           NULL
};
#else
#ifdef TINY
  struct TagItem rtag[] = {
      smr_MinWidth,       160,
          smr_MinHeight,      100,
              smr_MaxWidth,       320,
                  smr_MaxHeight,      256,
                      smr_ChunkySupport,  512,
                          smr_PlanarSupport,  -1,
                              smr_ProgramUsesC2P, 0,
                                  smr_Buffers,2,
                                      TAG_DONE,           NULL
                                      };
#else

  struct TagItem rtag[] = {
    smr_MinWidth,       320,
    smr_MinHeight,      200,
    smr_MaxWidth,       320,
    smr_MaxHeight,      256,
    smr_ChunkySupport,  512,
    smr_PlanarSupport,  -1,
    smr_ProgramUsesC2P, 0,
    smr_Buffers,2,
    TAG_DONE,           NULL
};
#endif
#endif

  struct TagItem gtag[] = {
    grd_BytesPerRow,    0,
    grd_Width,          0,
    grd_Height,         0,
    grd_Depth,          0,
    grd_PixelLayout,    0,
    grd_ColorSpace,     0,
    grd_PlaneSize,      0,
    TAG_DONE,           0
};

  struct TagItem tacks[] = {
    rtg_Buffers,2,
    rtg_Workbench,0,
    rtg_ChangeColors,1,
    TAG_DONE,0
};


  RTGMasterBase = (struct RTGMasterBase *)OpenLibrary((STRPTR)"rtgmaster.library", 34);
  if (!RTGMasterBase)
  {
   printf("Could not open rtgmaster.library V34!\n");
   exit(0);
  }
  GfxBase=(struct GfxBase *)OpenLibrary("graphics.library",36);
  PowerPCBase=OpenLibrary("powerpc.library",7);
  if (PowerPCBase) CloseLibrary(PowerPCBase);
  else
  {
   printf("This program requires at least powerpc.library V7/warp.library V2.0\n");
   exit(0);
  }
  WarpBase=OpenLibrary("warp.library",2);
  if (WarpBase) CloseLibrary(WarpBase);
  else
  {
   printf("This program requires at least powerpc.library V7/warp.library V2.0\n");
   exit(0);
  }

  sr = PPCRtgScreenModeReq(rtag);

  if (sr->Flags&sq_WORKBENCH) {tacks[1].ti_Data=LUT8;Workbench=1;}

  if (sr==NULL) exit(0);
  MyScreen = PPCOpenRtgScreen(sr, tacks);
  if (!MyScreen) {PPCFreeRtgScreenModeReq(sr);exit(0);CloseLibrary((struct Library *)GfxBase);CloseLibrary((struct Library *)RTGMasterBase);}

  PPCGetRtgScreenData(MyScreen, gtag);
     
  width = FRAME_WIDTH;
  height = FRAME_HEIGHT;

  empty_pointer = (unsigned short *)AllocVec(8, MEMF_CHIP|MEMF_CLEAR);
  PPCRtgSetPointer(MyScreen, empty_pointer, 0, 0, 0, 0);
  if (gtag[4].ti_Data==grd_PLANAR)
  {
   struct Screen *scr;
   aga=TRUE;

   // Hack, as rtgmaster currently only supports LoadRGB32-type color
   // Loading, not SetRGB32-type color loading, i will probably
   // include this in the next version

   scr=((struct RtgScreenAMI *)MyScreen)->ScreenHandle;
   vp=&(scr->ViewPort);
  }
  else
  {
   struct Screen *scr;
   aga=FALSE;

   // Hack, as rtgmaster currently only supports LoadRGB32-type color
   // Loading, not SetRGB32-type color loading, i will probably
   // include this in the next version

   scr=((struct RtgScreenCGX *)MyScreen)->MyScreen;
   vp=&(scr->ViewPort);
  }
  return 1;
}

void Graphics::Close(void)
{
 if (pen_obtained)
 {
  int i;
  //for (i=0; i<256; i++)
   //ReleasePen(ColorMap,transtable[i]);
  //LoadRGB32(&(Window->WScreen->ViewPort),WBColorTable);
 }
 if (MyScreen) {PPCCloseRtgScreen(MyScreen);MyScreen=0;}
 if(empty_pointer) { FreeVec(empty_pointer); empty_pointer = NULL; }
 if(Memory) { FreeVec(Memory); Memory = NULL; }
 if (sr) {PPCFreeRtgScreenModeReq(sr);sr=NULL;}
 if (RTGMasterBase) {CloseLibrary((struct Library *)RTGMasterBase);RTGMasterBase=NULL;}
 if (GfxBase) {CloseLibrary((struct Library *)GfxBase);}
}

void Graphics::Print(void)
{
 if ((!aga)&&Workbench)
 {
  int xstop,ystop;
  Window=((struct RtgScreenCGX *)MyScreen)->MyWindow;
  //ConvertFrame(Memory,transtable,FRAME_WIDTH*FRAME_HEIGHT);
                xstop = FRAME_WIDTH-1;
                ystop = FRAME_HEIGHT-1;
                /*WritePixelArray8(Window->RPort,0,0,xstop,ystop,
                                 (UBYTE *)Memory,
                                 (struct RastPort *)((struct RtgScreenCGX *)MyScreen)->tempras);*/
   PPCCopyRtgBlit(MyScreen,PPCGetBufAdr(MyScreen,0),Memory,0,0,0,FRAME_WIDTH,FRAME_HEIGHT,FRAME_WIDTH,FRAME_HEIGHT,0,0);
 }
 else if (Workbench)
 {
  int xstop,ystop;
  Window=((struct RtgScreenAMI *)MyScreen)->MyWindow;
  //ConvertFrame(Memory,transtable,FRAME_WIDTH*FRAME_HEIGHT);
               xstop = FRAME_WIDTH-1;
               ystop = FRAME_HEIGHT-1;
               WritePixelArray8(Window->RPort,0,0,xstop,ystop,
                                (UBYTE *)Memory,
                                (struct RastPort *)((struct RtgScreenAMI *)MyScreen)->tempras);
 }
 else PPCCopyRtgBlit(MyScreen,PPCGetBufAdr(MyScreen,0),Memory,0,0,0,FRAME_WIDTH,FRAME_HEIGHT,FRAME_WIDTH,FRAME_HEIGHT,0,0);
}

void Graphics::Clear (int color)
{
  // Clear your graphic interface
  // this is the standard one
  if (Memory) memset (Memory, color, FRAME_WIDTH*FRAME_HEIGHT);
}

void Graphics::SetPixel (int x, int y, int color)
{
  // print a pixel on your graphic interface
  // this is the standard one
  if (Memory)
    {
      if (x < 0 || x >= FRAME_WIDTH) return;
      if (y < 0 || y >= FRAME_HEIGHT) return;
      y = FRAME_HEIGHT-y;
      *(Memory+y*FRAME_WIDTH+x) = color;
    }
}

void Graphics::SetLine (int x1, int y1, int x2, int y2, int color)
{
  // print a line on your graphic interface
  // this is the standard one
  if (Memory)
  {
    if (x1 < 0 || x1 > FRAME_WIDTH) { printf ("*"); return ;}
    if (x2 < 0 || x2 > FRAME_WIDTH) { printf ("*"); return ;}
    if (y1 < 0 || y1 > FRAME_HEIGHT) { printf ("*"); return ;}
    if (y2 < 0 || y2 > FRAME_HEIGHT) { printf ("*"); return ;}

    y2 = FRAME_HEIGHT-y2;
    y1 = FRAME_HEIGHT-y1;
    int i, x, y;
    for (i = 0 ; i < 200 ; i++)
    {
      x = (x2-x1)*i/200+x1;
      y = (y2-y1)*i/200+y1;
      *(Memory+y*FRAME_WIDTH+x) = color;
    }
  }
}

void Graphics::SetHorLine (int x1, int x2, int y, int color)
{
  // print a line with overflow on your graphic interface
  // this is the standard one
  /*if(Memory)
    {
      y = FRAME_HEIGHT-y;
      char* d = Memory+y*FRAME_WIDTH+x1;
      if (y < 0 || y >= FRAME_HEIGHT) { printf ("OVERFLOW draw_hor_line(y=%d)!\n", y); return; }
      if (x1 < 0 || x1 >= FRAME_WIDTH) { printf ("OVERFLOW draw_hor_line(x1=%d,x2=%d,y=%d)!\n", x1, x2, y); return; }
      if (x2 < 0 || x2 >= FRAME_WIDTH) { printf ("OVERFLOW draw_hor_line(x1=%d,x2=%d,y=%d)!\n", x1, x2, y); return; }
      if (x2 >= x1) memset (d, color, x2-x1+1);
      //for (x = x1 ; x < x2 ; x++) *d++ = color;
    } */
}

ULONG rtgpal[770];
char winpal[768];

void Graphics::SetRGB(int i, int r, int g, int b)
{
  // set a rgb color in the palette of your graphic interface

  // Hack, as rtgmaster currently only supports LoadRGB32-style Color loading,
  // will add this to the next version

  //SetRGB32(vp, i, r*0x01010101, g*0x01010101, b*0x01010101);

// dont't touch, please !
  //graphicsPalette[i].red = r;
  //graphicsPalette[i].green = g;
  //graphicsPalette[i].blue = b;
  //graphicsPalette_alloc[i] = TRUE;
  //if (!Planar) Window=((struct RtgScreenCGX *)MyScreen)->MyWindow;
  //else Window=((struct RtgScreenAMI *)MyScreen)->MyWindow;

  //vp = &Window->WScreen->ViewPort;


  //if (Workbench) LoadRGB32(vp,rtgpal);
  /*if (Workbench)
  {
   int f;
   for (f=0;f<256;f++)
   {
    winpal[3*f]=graphicsPalette[f].red;
    winpal[3*f+1]=graphicsPalette[f].green;
    winpal[3*f+2]=graphicsPalette[f].blue;
   }
   SetPalette_WIN(winpal);
  }
  else */PPCLoadRGBRtg(MyScreen,rtgpal);
}

// Keyboard fonctions
Keyboard::Keyboard(int argc, char *argv[])
{
  // Create your keyboard interface
}

Keyboard::~Keyboard(void)
{
  // Destroy your keyboard interface
  Close();
}

int Keyboard::Open(void)
{
  // Open your keyboard interface
  return (1);
}

void Keyboard::Close(void)
{
  // Close your keyboard interface
}

// don't touch, please !
void do_buttonpress (int x, int y, int shift, int alt, int ctrl);
void do_buttonrelease (int x, int y);
void do_mousemotion (int x, int y);
void do_stuff ();
void do_expose ();
void do_keypress (int key, int shift, int alt, int ctrl);


// System loop !
void System::Loop(void)
{
  struct Message *msg;
  struct IntuiMessage copy;
  int key = 0, shift = 0, alt = 0, ctrl = 0;
  int key_up = 0, key_down = 0, key_left = 0, key_right = 0;

  // don't touch, please !
  Graph->Clear(0);
  Shutdown=0;

  while(!Shutdown)
  {
    if (key) do_keypress(key, shift, alt, ctrl);
    if (key_up) do_keypress(key_up, shift, alt, ctrl);
    if (key_down) do_keypress(key_down, shift, alt, ctrl);
    if (key_left) do_keypress(key_left, shift, alt, ctrl);
    if (key_right) do_keypress(key_right, shift, alt, ctrl);
    
    do_stuff (); // don't remove, please !

    while((msg = (struct Message *)PPCRtgGetMsg(MyScreen)))
    {
      CopyMemPPC(msg, &copy, sizeof(struct IntuiMessage));
      PPCRtgReplyMsg(MyScreen,msg);

      if(copy.Class ==  IDCMP_RAWKEY)
      {
        if(copy.Code & IECODE_UP_PREFIX)
        {
          copy.Code &= ~IECODE_UP_PREFIX;
          switch(copy.Code)
          {
            case 0x4c: key_up = 0; break;
            case 0x4d: key_down = 0; break;
            case 0x4f: key_left = 0; break;
            case 0x4e: key_right = 0; break;
          }
          key = 0;
        }
        else
        {
          switch(copy.Code)
          {
            case 0x4c: key_up = KEY_UP; key = 0; break;
            case 0x4d: key_down = KEY_DOWN; key = 0; break;
            case 0x4f: key_left = KEY_LEFT; key = 0; break;
            case 0x4e: key_right = KEY_RIGHT; key = 0; break;
            case 0x41: key = KEY_BS; break;
            case 0x3f: key = KEY_PGUP; break;
            case 0x1f: key = KEY_PGDN; break;
            case 0x1d: key = KEY_END; break;
            case 0x45: key = KEY_ESC; break;
            case 0x35: key = 'b'; break;
            case 0x40: key = ' '; break;
            case 0x28: key = 'l'; break;
            case 0x12: key = 'e'; break;
            case 0x33: key = 'c'; break;
            case 0x21: key = 's'; break;
            case 0x10: key = 'q'; break;
            case 0x14: key = 't'; break;
            case 0x17: key = 'i'; break;
            case 0x13: key = 'r'; break;
            case 0x19: key = 'p'; break;
            default: key = 0; break;
          }
        }
        shift = copy.Qualifier & (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT);
        alt = copy.Qualifier & (IEQUALIFIER_LALT|IEQUALIFIER_RALT);
        ctrl = copy.Qualifier & IEQUALIFIER_CONTROL;
      }
    }
  } // while (!Shutdown)
}

#endif // DO_AMIGAOS
