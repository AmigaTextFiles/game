/* amiga.c */

#include <proto/asl.h>
#include <proto/icon.h>
#include <proto/intuition.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/gadtools.h>
#include <proto/graphics.h>
#include <proto/reqtools.h>
#include <clib/diskfont_protos.h>
#include <intuition/intuitionbase.h>
#include <libraries/iff.h>
#include <libraries/reqtools.h>
#include <workbench/startup.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include "glob.h"

#define GFX_DEPTH 4
#define GFX_WIDTH 640
#define GFX_HEIGHT 400

void amiga_readtooltypes(void);
void amiga_readargs(void);
void amiga_getscreenmode(void);
void amiga_close(void);

/* curses routines */

char *savefilename = NULL;
char *fontname = NULL;
char fontnamebuf[80];
char savefilenamebuf[80];
char *topazname = "topaz.font";
ULONG Graphics = 0;
ULONG nodelete = 0;
ULONG wbstartup = 0;
ULONG screenmode = INVALID_ID;

extern WINDOW *Levelw,*Dataw,*Flagw,*Timew,*Menuw,*Locw,*Morew,*Phasew;
extern WINDOW *Comwin,*Msg1w,*Msg2w,*Msg3w,*Msgw;

char *login_name = "";

WINDOW *newwin(int h,int w,int y,int x);
void touchwin(WINDOW *win);

struct Library *IFFBase = NULL;
struct Library *AslBase = NULL;
struct Library *diskfontbase = NULL;
struct ReqToolsBase *ReqToolsBase = NULL;
struct Screen *Screen = NULL;
struct Screen *DefaultPubScreen = NULL;
struct Window *Window = NULL;
struct Window *OldWindowPtr = NULL;
struct RastPort *RPort = NULL;
struct BitMap GfxBitMap;
struct Menu *Menus = NULL;
struct DiskObject *Icon = NULL;
APTR Visual = NULL;
ULONG ScreenMode = 0L;

char ver[] = "$VER: Omega 0.80.4 (14-Dec-1998)";

USHORT SystemPalette[16];
USHORT CustomPalette[] =
{
  0x0000,0x0432,0x0900,0x0000,0x0765,0x0008,0x0061,0x0999,
  0x0A0C,0x0F00,0x0DB8,0x000F,0x0FC0,0x06F4,0x00BF,0x0FFE
};

struct NewMenu NewMenus[] =
{
  { NM_TITLE,"Project",0,0,0,0 },
  { NM_ITEM,"About...","?",0,0,0 },
  { NM_ITEM,"Quit","Q",0,0,0 },
  { NM_END,0,0,0,0,0 }};

WINDOW *stdscr;
WINDOW *curscr;
int LINES,COLS;

void initscr(void)
{
extern struct IntuitionBase *IntuitionBase;
char prog_name[256];
static WORD pens[] = {-1};
static struct TextAttr topaz8 = { topazname,8,FS_NORMAL,0 };
struct TextFont *tf;

  if (IntuitionBase->LibNode.lib_Version < 37) exit(0);

//  if (ReqToolsBase == NULL)
//    ReqToolsBase = (struct ReqToolsBase *)OpenLibrary("reqtools.library",38L);


	if (fontname != NULL)
		{
		diskfontbase = (struct Library *)OpenLibrary("diskfont.library", 36L);
		if (diskfontbase != NULL)
			{
			topaz8.ta_Name = (STRPTR)fontnamebuf;
			tf = (struct TextFont*)OpenDiskFont((struct TextAttr*)&topaz8);
			if (tf != NULL) CloseFont(tf);
			else topaz8.ta_Name = (STRPTR)topazname;
			CloseLibrary((struct Library *)diskfontbase);
	  	}
  	}


  if (Icon == NULL)
    if (GetProgramName(prog_name,256))
			Icon = GetDiskObject(prog_name);

	
	IFFBase = OpenLibrary("iff.library",21L);
  if (IFFBase == NULL) Graphics = 0;

  if (Graphics != 0)
	{
  int i;
  IFFL_HANDLE gfx_file;

    InitBitMap(&GfxBitMap,GFX_DEPTH,GFX_WIDTH,GFX_HEIGHT);
    for (i = 0; i < GFX_DEPTH; i++)
      if ((GfxBitMap.Planes[i] = AllocRaster(GFX_WIDTH,GFX_HEIGHT)) == NULL)
				{ amiga_close(); exit(0); }

    if ((gfx_file = IFFL_OpenIFF("PROGDIR:Omega.iff",IFFL_MODE_READ)))
    {
      if (!IFFL_DecodePic(gfx_file,&GfxBitMap)) Graphics = 0;
      IFFL_CloseIFF(gfx_file);
    }
    else Graphics = 0;
  }

  if ((DefaultPubScreen = LockPubScreen(0)) == NULL) { amiga_close(); exit(0); }

	if (screenmode == INVALID_ID)
		screenmode = GetVPModeID(&DefaultPubScreen->ViewPort);

  if ((Screen = OpenScreenTags(0,
		SA_Width, 640, //GFX_WIDTH,
		SA_Height, 400, //GFX_HEIGHT,
    SA_Font,&topaz8,
    SA_Pens,pens,
    SA_DisplayID, screenmode,
//	SA_DisplayID, GetVPModeID(&DefaultPubScreen->ViewPort),
//    SA_Overscan,OSCAN_TEXT,
    SA_Depth,GFX_DEPTH,
    SA_Type,CUSTOMSCREEN,
		SA_AutoScroll, TRUE,
    SA_ShowTitle,0,
    SA_Behind,1,TAG_DONE)) == NULL)
    	 { amiga_close(); exit(0); }

  if ((Window = OpenWindowTags(0,
    WA_Left,0,
    WA_Top,0,
    WA_NewLookMenus,1,
    WA_Width,Screen->Width,
    WA_Height,Screen->Height,
    WA_Flags,WFLG_ACTIVATE|WFLG_SMART_REFRESH|WFLG_BORDERLESS|WFLG_BACKDROP,
    WA_IDCMP,IDCMP_VANILLAKEY|IDCMP_MENUPICK,
    WA_CustomScreen,Screen,TAG_DONE)) == NULL) { amiga_close(); exit(0); }

  SystemPalette[0] = GetRGB4(DefaultPubScreen->ViewPort.ColorMap,0);
  SystemPalette[1] = GetRGB4(DefaultPubScreen->ViewPort.ColorMap,1);
  SystemPalette[2] = GetRGB4(DefaultPubScreen->ViewPort.ColorMap,2);
  SystemPalette[3] = GetRGB4(DefaultPubScreen->ViewPort.ColorMap,3);
  CopyMem(SystemPalette,SystemPalette+12,4*sizeof(USHORT));
  CopyMem(CustomPalette+8,SystemPalette+8,8*sizeof(USHORT));

  if ((Visual = GetVisualInfo(Window->WScreen,TAG_DONE)) == 0) { amiga_close(); exit(0); }
  if ((Menus = CreateMenus(NewMenus,GTMN_NewLookMenus,TRUE,TAG_DONE)) == 0)
    { amiga_close(); exit(0); }
  LayoutMenus(Menus,Visual,GTMN_NewLookMenus,TRUE,TAG_DONE);
  SetMenuStrip(Window,Menus);

  LoadRGB4(&Screen->ViewPort,CustomPalette,16);
  ScreenToFront(Screen);

  RPort = Window->RPort;
  SetDrMd(RPort,JAM2);
  SetAPen(RPort,15);
  SetBPen(RPort,0);
/*
  LINES = (Window->Height-Window->BorderTop-Window->BorderBottom)/
    RPort->TxHeight;
  COLS = (Window->Width-Window->BorderLeft-Window->BorderRight)/
    RPort->TxWidth;
*/

  LINES = Window->Height/RPort->TxHeight;
  COLS = Window->Width/RPort->TxWidth;
//printf("%ld %ld %ld LINES: %ld, COLS %ld\n", Screen->Width, Window->Width, RPort->TxWidth, LINES, COLS);
  stdscr = newwin(LINES,COLS,0,0);
  curscr = stdscr;
}

//__autoexit void amiga_close(void)
void amiga_close(void)
{
int i;

  if (Menus) FreeMenus(Menus);
  if (Visual) FreeVisualInfo(Visual);
  if (Window) CloseWindow(Window);
  if (Screen) CloseScreen(Screen);
  for (i = 0; i < GFX_DEPTH; i++)
    if (GfxBitMap.Planes[i])
      FreeRaster(GfxBitMap.Planes[i],GFX_WIDTH,GFX_HEIGHT);
  if (DefaultPubScreen) UnlockPubScreen(0,DefaultPubScreen);
  if (IFFBase) CloseLibrary(IFFBase);
  if (ReqToolsBase) CloseLibrary((struct Library *)ReqToolsBase);
  if (Icon) FreeDiskObject(Icon);
  exit(0);
}

void amiga_colours(int custom)
{
static USHORT previous;

  if (Screen)
    LoadRGB4(&Screen->ViewPort,custom ? CustomPalette : SystemPalette,16);
}

void amiga_busy(int busy)
{
  if (Window)
  {
    if (IntuitionBase->LibNode.lib_Version >= 39)
      SetWindowPointer(Window,WA_BusyPointer,busy,TAG_DONE);
  }
}

LONG amiga_req(int centre,UBYTE *text,UBYTE *gadgets,...)
{
va_list arguments;
LONG return_value;
static struct EasyStruct requester =
  { sizeof(struct EasyStruct),0,"Omega",0,0 };

  amiga_colours(0);
  if (ReqToolsBase == NULL)
  {
    requester.es_TextFormat = text;
    requester.es_GadgetFormat = gadgets;
    va_start(arguments,gadgets);
    amiga_busy(1);
    return_value = EasyRequestArgs(Window,&requester,0,(APTR)arguments);
    amiga_busy(0);
    va_end(arguments);
  }
  else
  {
    va_start(arguments,gadgets);
    return_value = rtEZRequestTags(text,gadgets,NULL,(APTR)arguments,
      RT_Window,Window,
      RT_ReqPos,centre ? REQPOS_CENTERSCR : REQPOS_TOPLEFTSCR,
      RT_LockWindow,TRUE,
      RTEZ_ReqTitle,"Omega",TAG_DONE);
    va_end(arguments);
  }
  amiga_colours(1);
  return return_value;
}

void amiga_about(void)
{
  amiga_req(0,"Omega 0.80.4\n\n"
	      "Written by Laurence R. Brothers and Erik Max Francis\n\n"
	      "Amiga release 1 and 2 by David Kinder\n"
	      "Amiga release 3-4 by Jarkko Vatjus-Anttila",
	      "Continue");
}

void endwin(void)
{
}

void waddch(WINDOW *win,int c)
{
  switch (c)
  {
    case '\n':
      win->_curx = 0;
      if (win->_cury < win->_maxy) win->_cury++;
      break;
    default:
      if (isprint(c))
      {
        *(win->_text+(win->_cury*(win->_maxx+1))+win->_curx) =
	  c+(win->_attr<<8);
	*(win->_lines+win->_cury) = 1;
	if (win->_curx < win->_maxx) win->_curx++;
      }
      break;
  }
}

void vwprintw(WINDOW *win,char *format,va_list list)
{
char buffer[256];
int i;

  vsprintf(buffer,format,list);
  for (i = 0; i < strlen(buffer); i++) waddch(win,*(buffer+i));
}

void draw_cursor(WINDOW *win)
{
  Move(RPort,
    Window->BorderLeft+((win->_offx+win->_curx)*RPort->TxWidth),
    Window->BorderTop+((win->_offy+win->_cury)*RPort->TxHeight));
  if (Graphics && (win == Levelw))
  {
    SetDrMd(RPort,COMPLEMENT);
    Draw(RPort,RPort->cp_x+RPort->TxWidth-1,RPort->cp_y);
    Draw(RPort,RPort->cp_x,RPort->cp_y+RPort->TxHeight-1);
    Draw(RPort,RPort->cp_x-RPort->TxWidth+1,RPort->cp_y);
    Draw(RPort,RPort->cp_x,RPort->cp_y-RPort->TxHeight+1);
    SetDrMd(RPort,JAM2);
    return;
  }
  SetDrMd(RPort,COMPLEMENT);
  RectFill(RPort,RPort->cp_x,RPort->cp_y,
    RPort->cp_x+RPort->TxWidth-1,
    RPort->cp_y+RPort->TxHeight-1);
  SetDrMd(RPort,JAM2);
}

int wgetch(WINDOW *win)
{
struct IntuiMessage *imsg;
ULONG class;
UWORD code;

  draw_cursor(win);
  for (;;)
  {
    while ((imsg = (struct IntuiMessage *)GetMsg(Window->UserPort)))
    {
      class = imsg->Class;
      code = imsg->Code;
      if (class == IDCMP_MENUVERIFY) amiga_colours(0);
      ReplyMsg((struct Message *)imsg);
      switch (class)
      {
	case IDCMP_VANILLAKEY:
	  if (code == 13) code = 10;
	  draw_cursor(win);
	  return code;
	  break;
	case IDCMP_MENUPICK:
	  amiga_colours(1);
	  if (code != MENUNULL)
	  {
	    if (MENUNUM(code) == 0)
	    {
	      switch (ITEMNUM(code))
	      {
		case 0:
		  amiga_about();
		  break;
		case 1:
			amiga_close();
		  exit(0);
		  break;
	      }
	    }
	  }
	  break;
      }
    }
    ModifyIDCMP(Window,Window->IDCMPFlags | IDCMP_MENUVERIFY);
    WaitPort(Window->UserPort);
    ModifyIDCMP(Window,Window->IDCMPFlags & ~IDCMP_MENUVERIFY);
  }
}

void getyx(WINDOW *win,int *y,int *x)
{
  *y = win->_cury;
  *x = win->_curx;
}

void werase(WINDOW *win)
{
int i;

  for (i = 0; i < (win->_maxx+1)*(win->_maxy+1); i++)
    *(win->_text+i) = SPACE;
  for (i = 0; i <= win->_maxy; i++) *(win->_lines+i) = 1;
  win->_curx = 0;
  win->_cury = 0;
}

void wprintw(WINDOW *win,char *format,...)
{
va_list arg;

  va_start(arg,format);
  vwprintw(win,format,arg);
  va_end(arg);
}

//    case OPEN_DOOR:    *x =  88; *y =  40; break;

void findchar(long c,long *x,long *y)
{
  x[0] = 0; y[0] = 0;

  switch (c)
  {
    /* Objects */
    case FLOOR:        *x = 144; *y =  40; break;
    case PLAYER:       *x =  32; *y = 136; break;
    case SPACE:        *x =  32; *y =  40; break;
    case WALL:	       *x =  48; *y =  32; break;
    case PORTCULLIS:   *x =  40; *y =  40; break;
    case OPEN_DOOR:    *x =  88; *y =  40; break;
    case CLOSED_DOOR:  *x = 120; *y =  40; break;
    case WHIRLWIND:    *x = 280; *y = 264; break;
    case ABYSS:        *x = 264; *y =  32; break;
    case LAVA:         *x =  72; *y =  40; break;
    case HEDGE:        *x = 152; *y =  40; break;
    case WATER:        *x =  48; *y =  40; break;
    case FIRE:         *x =  80; *y = 160; break;
    case TRAP:         *x = 272; *y =  48; break;
    case LIFT:         *x = 208; *y =  40; break;
    case STAIRS_UP:    *x = 256; *y =  40; break;
    case STAIRS_DOWN:  *x = 272; *y =  40; break;
    case CORPSE:       *x =  88; *y = 120; break;
    case STATUE:       *x =  96; *y =  40; break;
    case RUBBLE:       *x = 240; *y =  40; break;
    case ALTAR:        *x = 192; *y =  40; break;
    case CASH:         *x = 136; *y =  32; break;
    case PILE:         *x = 216; *y =  32; break;
    case FOOD:         *x = 200; *y = 112; break;
    case WEAPON:       *x =  80; *y = 104; break;
    case MISSILEWEAPON:*x = 184; *y = 104; break;
    case SCROLL:       *x =  32; *y =  80; break;
    case POTION:       *x =  96; *y =  88; break;
    case ARMOR:        *x = 272; *y =  96; break;
    case SHIELD:       *x = 184; *y =  96; break;
    case CLOAK:        *x = 192; *y =  96; break;
    case BOOTS:        *x = 104; *y =  96; break;
    case STICK:        *x = 144; *y = 104; break;
    case RING:         *x =  56; *y =  48; break;
    case THING:        *x = 208; *y =  32; break;
    case ARTIFACT:     *x = 272; *y =  80; break;
    case CHAIR:        *x = 264; *y =  48; break;
    case SAFE:         *x = 256; *y =  48; break;
    case FURNITURE:    *x = 248; *y =  48; break;
    case BED:          *x = 240; *y =  48; break;
    /* Terrain */
    case PLAINS:       *x =  80; *y =  40; break;
    case TUNDRA:       *x = 104; *y =  40; break;
    case MOUNTAINS:    *x = 112; *y =  48; break;
    case PASS:         *x =  48; *y =  32; break;
    case CITY:         *x = 112; *y =  40; break;
    case VILLAGE:			/* Also snowball weapon */
      if (Current_Environment == E_COUNTRYSIDE)
	{ *x = 160; *y =  40; } else { *x = 176; *y =  72; }
      break;
    case FOREST:       *x = 152; *y =  40; break;
    case JUNGLE:       *x = 224; *y = 184; break;
    case SWAMP:        *x = 136; *y =  40; break;
    case VOLCANO:			/* Also succubus */
      if (Current_Environment == E_COUNTRYSIDE)
	{ *x = 48; *y = 184; } else { *x = 56; *y = 280; }
      break;
    case CASTLE:       *x = 112; *y =  40; break;
    case TEMPLE:       *x = 192; *y =  40; break;
    case CAVES:        *x = 272; *y =  40; break;
    case DESERT:       *x = 264; *y =  40; break;
    case CHAOS_SEA:    *x = 280; *y =  40; break;
    case STARPEAK:     *x = 280; *y =  88; break;
    case DRAGONLAIR:   *x = 144; *y =  32; break;
    case MAGIC_ISLE:   *x =  64; *y =  32; break;

    /* Magic weapons */
    case ('*'|COL_LIGHT_RED):		*x = 136; *y =  72; break;
    case ('^'|COL_LIGHT_BLUE):	*x = 160; *y =  72; break;
    case ('!'|COL_BROWN):				*x = 152; *y =  72; break;
    case ('@'|COL_PURPLE):			*x =  48; *y = 128; break;

    /* Monsters */
    case ('@'|COL_RED):					*x =  88; *y = 136; break;
    case ('A'|COL_GREY|COL_BG_WHITE):
 																*x = 240; *y = 224; break;
    case ('A'|COL_LIGHT_BLUE|COL_BG_WHITE):
				*x = 280; *y = 256; break;
    case ('A'|COL_WHITE|COL_BG_BLUE):
				*x =  40; *y = 272; break;
    case ('A'|COL_YELLOW|COL_BG_WHITE):
				*x = 208; *y = 144; break;
    case ('B'|COL_BLACK|COL_BG_BROWN):
				*x = 176; *y = 224; break;
    case ('B'|COL_GREEN):	*x = 256; *y = 168; break;
    case ('C'|COL_GREEN):	*x = 256; *y = 168; break;
    case ('C'|COL_GREY|COL_BG_BROWN):
				*x = 176; *y = 176; break;
    case ('D'|COL_BLACK|COL_BG_RED):
				*x =  32; *y = 280; break;
    case ('D'|COL_BLACK|COL_BG_WHITE):
				*x = 200; *y = 224; break;
    case ('D'|COL_BRIGHT_WHITE|COL_BG_RED):
				*x = 120; *y = 152; break;
    case ('D'|COL_GREY|COL_BG_RED):
				*x = 192; *y = 152; break;
    case ('E'|COL_BLACK|COL_BG_WHITE):
				*x =  96; *y = 224; break;
    case ('E'|COL_BROWN|COL_BG_WHITE):
				*x = 112; *y = 256; break;
    case ('E'|COL_WHITE|COL_BG_BROWN):
				*x =  72; *y = 272; break;
    case ('F'|COL_BLACK|COL_BG_WHITE):
				*x =  40; *y = 168; break;
    case ('F'|COL_GREY):	*x = 152; *y = 200; break;
    case ('F'|COL_GREY|COL_BG_RED):
				*x = 216; *y = 144; break;
    case ('F'|COL_LIGHT_BLUE|COL_BG_WHITE):
				*x = 192; *y = 256; break;
    case ('F'|COL_LIGHT_RED|COL_BG_WHITE):
				*x = 264; *y = 256; break;
    case ('F'|COL_WHITE|COL_BG_RED):
				*x =  56; *y = 272; break;
    case ('G'|COL_GREEN):       *x =  64; *y = 240; break;
    case ('G'|COL_GREY|COL_BG_GREEN):
				*x = 144; *y = 192; break;
    case ('G'|COL_RED):         *x = 256; *y = 248; break;
    case ('I'|COL_RED):		*x =  56; *y = 280; break;
    case ('J'|COL_BROWN|COL_BG_RED):
				*x = 192; *y = 216; break;
    case ('J'|COL_GREY|COL_BG_BROWN):
				*x = 104; *y = 224; break;
    case ('K'|COL_LIGHT_GREEN):	*x =  72; *y = 240; break;
    case ('L'|COL_BLACK|COL_BG_WHITE):
				*x = 104; *y = 160; break;
    case ('L'|COL_BRIGHT_WHITE|COL_BG_BLUE):
				*x = 256; *y = 256; break;
    case ('M'|COL_BLUE):	*x =  64; *y = 160; break;
    case ('M'|COL_PURPLE|COL_BG_WHITE):
				*x =  40; *y = 280; break;
    case ('M'|COL_YELLOW):	*x = 264; *y = 208; break;
    case ('N'|COL_BLACK|COL_BG_WHITE):
				*x = 232; *y = 256; break;
    case ('P'|COL_PURPLE):	*x = 168; *y = 152; break;
    case ('R'|COL_GREY):        *x = 192; *y = 264; break;
    case ('R'|COL_YELLOW|COL_BG_WHITE):
				*x = 160; *y = 168; break;
    case ('S'|COL_BLACK|COL_BG_WHITE):
				*x = 200; *y = 152; break;
    case ('S'|COL_GREEN|COL_BG_RED):
				*x =  96; *y = 216; break;
    case ('S'|COL_GREY):	*x = 184; *y = 200; break;
    case ('S'|COL_GREY|COL_BG_GREEN):
				*x = 176; *y = 240; break;
    case ('S'|COL_RED):		*x =  56; *y = 280; break;
    case ('S'|COL_YELLOW|COL_BG_BROWN):
				*x =  88; *y = 264; break;
    case ('T'|COL_BROWN):	*x =  72; *y = 272; break;
    case ('T'|COL_GREEN|COL_BG_BROWN):
				*x =  88; *y = 208; break;
    case ('T'|COL_GREY):	*x =  72; *y = 200; break;
    case ('T'|COL_LIGHT_GREEN|COL_BG_BLUE):
				*x = 192; *y = 240; break;
    case ('T'|COL_YELLOW|COL_BG_BLUE):
				*x = 200; *y = 232; break;
    case ('T'|COL_YELLOW|COL_BG_WHITE):
				*x = 120; *y = 256; break;
    case ('U'|COL_BLACK|COL_BG_WHITE):
				*x = 152; *y = 168; break;
    case ('V'|COL_BLACK|COL_BG_RED):
				*x =  80; *y = 264; break;
    case ('V'|COL_GREY):	*x = 160; *y = 200; break;
    case ('W'|COL_BLUE|COL_BG_WHITE):
				*x = 232; *y = 248; break;
    case ('W'|COL_GREEN|COL_BG_RED):
				*x = 224; *y = 216; break;
    case ('W'|COL_GREY|COL_BG_RED):
				*x = 184; *y = 240; break;
    case ('W'|COL_LIGHT_RED):	*x = 232; *y = 152; break;
    case ('W'|COL_WHITE|COL_BG_BLUE):
				*x =  32; *y = 272; break;
    case ('Z'|COL_BLACK|COL_BG_WHITE):
				*x = 200; *y = 224; break;
    case ('a'|COL_BROWN):       *x = 264; *y = 144; break;
    case ('a'|COL_GREY):	*x = 208; *y = 206; break;
    case ('a'|COL_RED):         *x = 176; *y = 208; break;
    case ('a'|COL_YELLOW):	*x =  64; *y = 176; break;
    case ('a'|COL_YELLOW|COL_BG_WHITE):
				*x = 208; *y = 144; break;
    case ('b'|COL_BRIGHT_WHITE|COL_FG_BLINK):
				*x = 104; *y = 192; break;
    case ('b'|COL_BROWN):       *x = 264; *y = 144; break;
    case ('b'|COL_CYAN):        *x = 120; *y =  48; break;
    case ('b'|COL_GREEN):       *x = 144; *y = 152; break;
    case ('b'|COL_GREY):	*x = 232; *y = 176; break;
    case ('b'|COL_RED):		*x =  32; *y = 256; break;
    case ('b'|COL_YELLOW|COL_BG_BROWN):
				*x = 216; *y = 168; break;
    case ('c'|COL_BROWN):       *x = 144; *y = 208; break;
    case ('c'|COL_GREEN):	*x =  96; *y = 216; break;
    case ('c'|COL_RED):		*x =  64; *y = 128; break;
    case ('d'|COL_BLACK|COL_BG_WHITE):
				*x = 136; *y = 200; break;
    case ('d'|COL_BROWN):       *x = 104; *y = 152; break;
    case ('d'|COL_LIGHT_RED):	*x = 272; *y = 216; break;
    case ('e'|COL_GREEN):       *x =  64; *y = 224; break;
    case ('e'|COL_GREY):        *x = 128; *y =  48; break;
    case ('e'|COL_RED):         *x =  48; *y = 264; break;
    case ('f'|COL_CYAN):        *x = 104; *y = 144; break;
    case ('f'|COL_GREY):        *x =  72; *y = 144; break;
    case ('f'|COL_LIGHT_BLUE):	*x = 176; *y = 272; break;
    case ('f'|COL_PURPLE):      *x = 224; *y = 168; break;
    case ('f'|COL_WHITE):	*x = 216; *y = 224; break;
    case ('f'|COL_YELLOW|COL_BG_WHITE):
				*x = 184; *y = 144; break;
    case ('g'|COL_BROWN):       *x = 168; *y = 248; break;
    case ('g'|COL_GREEN):       *x =  56; *y = 240; break;
    case ('g'|COL_GREY):        *x = 136; *y = 200; break;
    case ('g'|COL_WHITE):       *x =  56; *y = 136; break;
    case ('h'|COL_BROWN):       *x = 104; *y = 152; break;
    case ('h'|COL_GREY):	*x = 208; *y = 200; break;
    case ('h'|COL_YELLOW):	*x = 200; *y = 160; break;
    case ('i'|COL_BLACK|COL_BG_WHITE):
				*x = 120; *y = 168; break;
    case ('j'|COL_PURPLE):	*x = 224; *y = 216; break;
    case ('l'|COL_BLUE):	*x =  80; *y = 128; break;
    case ('l'|COL_YELLOW):	*x = 136; *y =  48; break;
    case ('m'|COL_GREY):	*x = 208; *y = 200; break;
    case ('m'|COL_PURPLE):	*x = 224; *y = 168; break;
    case ('m'|COL_RED):		*x = 136; *y = 184; break;
    case ('m'|COL_RED|COL_BG_WHITE):
 				*x = 176; *y = 200; break;
    case ('n'|COL_BLACK|COL_BG_WHITE):
				*x = 208; *y = 256; break;
    case ('n'|COL_GREY):        *x = 200; *y = 224; break;
    case ('n'|COL_RED):		*x =  32; *y = 264; break;
    case ('p'|COL_GREY):	*x =  88; *y = 200; break;
    case ('p'|COL_PURPLE):      *x =  48; *y = 224; break;
    case ('p'|COL_RED):         *x = 240; *y = 168; break;
    case ('q'|COL_BROWN):       *x = 232; *y = 208; break;
    case ('s'|COL_GREEN):	*x = 120; *y = 240; break;
    case ('s'|COL_LIGHT_RED):   *x = 136; *y = 184; break;
    case ('s'|COL_RED):		*x =  32; *y = 264; break;
    case ('s'|COL_WHITE):       *x =  48; *y = 208; break;
    case ('s'|COL_YELLOW):	*x = 144; *y = 224; break;
    case ('r'|COL_BLACK|COL_BG_BROWN):
				*x = 248; *y = 200; break;
    case ('r'|COL_BROWN):       *x =  64; *y = 152; break;
    case ('r'|COL_GREY|COL_BG_BROWN):
				*x = 112; *y = 272; break;
    case ('t'|COL_BROWN):	*x =  32; *y = 248; break;
    case ('t'|COL_CYAN):        *x = 120; *y =  48; break;
    case ('t'|COL_GREEN):       *x =  42; *y = 192; break;
    case ('t'|COL_LIGHT_BLUE):	*x = 248; *y = 152; break;
    case ('t'|COL_PURPLE):      *x = 248; *y = 160; break;
    case ('w'|COL_BROWN):       *x =  40; *y = 152; break;
  }

}

void printchrs(WINDOW *win,int f,int b,char *s,int l,char a)
{
long x, y, i;

  if (Graphics && (win == Levelw))
  {
//  int i;

    for (i = 0; i < l; i++)
    {
//    int x,y;

      findchar(*(s+i)+(a<<8),&x,&y);
      if (x == 0)
      {
			SetAPen(RPort,f);
			RectFill(RPort, RPort->cp_x+(i*RPort->TxWidth),
							 RPort->cp_y-RPort->TxBaseline,
							 RPort->cp_x+((i+1)*RPort->TxWidth)-1,
							 RPort->cp_y-RPort->TxBaseline+RPort->TxHeight-1);
      }
      else BltBitMapRastPort(&GfxBitMap,x,y,RPort,
														 RPort->cp_x+(i*RPort->TxWidth),
														 RPort->cp_y-RPort->TxBaseline,
														 8,8,0xC0);
    }
    Move(RPort,RPort->cp_x+(l*RPort->TxWidth),RPort->cp_y);
  }
  else
  {
    SetAPen(RPort,f);
    SetBPen(RPort,b);
    Text(RPort,s,l);
  }
}

void chrsout(WINDOW *win,int y)
{
static int fore_col[] = { 3,5,6,11,2,8,4,15,7,14,13,14,9,9,12,15 };
static int back_col[] = { 3,5,6,11,2,8,4,15,3 };

char buffer[256];
int c,i,j;
char attr,prev_attr;

  prev_attr = ((*(win->_text+((win->_maxx+1)*y)))&0xFF00)>>8;
  j = 0;
  Move(RPort,
    Window->BorderLeft+(win->_offx*RPort->TxWidth),
    Window->BorderTop+((win->_offy+y)*RPort->TxHeight)+RPort->TxBaseline);

  for (i = 0; i <= win->_maxx; i++)
  {
    c = *(win->_text+((win->_maxx+1)*y)+i);
    attr = (c&0xFF00)>>8;

    if (c == *(win->_disp+((win->_maxx+1)*y)+i))
    {
      if (j > 0)
      {
	printchrs(win,*(fore_col+(prev_attr&0x0F)),
	  *(back_col+((prev_attr&0xF0)>>4)),buffer,j,prev_attr);
        j = 0;
      }
      Move(RPort,RPort->cp_x+RPort->TxWidth,RPort->cp_y);
    }
    else
    {
      if (attr != prev_attr)
      {
	if (j > 0)
	{
	  printchrs(win,*(fore_col+(prev_attr&0x0F)),
	    *(back_col+((prev_attr&0xF0)>>4)),buffer,j,prev_attr);
          j = 0;
	}
      }

      *(buffer+j++) = c&0x00FF;
    }
    prev_attr = attr;
  }

  if (j > 0)
    printchrs(win,*(fore_col+(prev_attr&0x0F)),
      *(back_col+((prev_attr&0xF0)>>4)),buffer,j,prev_attr);
}

void wrefresh(WINDOW *win)
{
int i;

  if (win == stdscr || win == Menuw)
  {
    touchwin(Msgw);
    touchwin(Msg1w);
    touchwin(Msg2w);
    touchwin(Msg3w);
    touchwin(Levelw);
    touchwin(Timew);
    touchwin(Flagw);
    touchwin(Dataw);
    touchwin(Locw);
    touchwin(Morew);
    touchwin(Phasew);
    touchwin(Comwin);
    touchwin(Menuw); 
    touchwin(stdscr);
  }

  for (i = 0; i <= win->_maxy; i++)
  {
    if (*(win->_lines+i) != 0)
    {
      chrsout(win,i);
      *(win->_lines+i) = 0;
    }
  }
  for (i = 0; i < (win->_maxx+1)*(win->_maxy+1); i++)
    *(win->_disp+i) = *(win->_text+i);
}

void wmove(WINDOW *win,int y,int x)
{
  if (y > win->_maxy) y = win->_maxy;
  if (x > win->_maxx) x = win->_maxx;
  win->_cury = y;
  win->_curx = x;
}

void wattrset(WINDOW *win,int attr)
{
  win->_attr = attr;
}

void touchwin(WINDOW *win)
{
int i;

  for (i = 0; i < (win->_maxx+1)*(win->_maxy+1); i++)
    *(win->_disp+i) = '\0';
  for (i = 0; i <= win->_maxy; i++) *(win->_lines+i) = 1;
}

WINDOW *newwin(int h,int w,int y,int x)
{
WINDOW *new;

  if ((new = malloc(sizeof(WINDOW))) == NULL) { amiga_close(); exit(0); }
  new->_cury = 0;
  new->_curx = 0;
  new->_maxy = h-1;
  new->_maxx = w-1;
  new->_offy = y;
  new->_offx = x;
  if ((new->_text = malloc(w*h*sizeof(int))) == NULL) { amiga_close(); exit(0); }
  if ((new->_disp = calloc(w*h*sizeof(int),1)) == NULL) { amiga_close(); exit(0); }
  if ((new->_lines = malloc(h)) == NULL) { amiga_close(); exit(0); }
  wattrset(new,COL_WHITE>>8);
  werase(new);
  return new;
}

void scrollok(WINDOW *win,int ok)
{
}

void wstandout(WINDOW *win)
{
  if (win == Levelw) return;
  win->_attr = (COL_BG_WHITE|COL_BLACK)>>8;
}

void wstandend(WINDOW *win)
{
  if (win == Levelw) return;
  win->_attr = (COL_BG_BLACK|COL_WHITE)>>8;
}

void waddstr(WINDOW *win,char *s)
{
  wprintw(win,s);
}

void clear(void)
{
  werase(stdscr);
}

void printw(char *format,...)
{
va_list arg;

  va_start(arg,format);
  vwprintw(stdscr,format,arg);
  va_end(arg);
}

void refresh(void)
{
  wrefresh(stdscr);
}

void move(int y,int x)
{
  wmove(stdscr,y,x);
}

int getch(void)
{
  wgetch(stdscr);
}

void noecho(void)
{
}

void crmode(void)
{
}

/* file routines */

char *getlogin(void)
{
  return login_name;
}

int getpid(void)
{
  return 0;
}

int chown(char *o,int u,int g)
{
  return 0;
}
/*
int file_req(char *buffer)
{
static char *title = "Restore an Omega Game";
int rcode = 0;

  if (ReqToolsBase)
  {
  static char file[108];
  struct rtFileRequester *freq;

    if ((freq = (struct rtFileRequester *)rtAllocRequest(RT_FILEREQ,TAG_DONE)))
    {
      strcpy(file,"");
      if ((rcode = (int)rtFileRequest(freq,file,title,TAG_DONE)))
      {
	strcpy(buffer,freq->Dir);
	AddPart(buffer,file,256);
      }
      rtFreeRequest(freq);
    }
  }
  else
  {
  struct FileRequester *freq;

    if ((AslBase = OpenLibrary("asl.library",37)))
    {
      if ((freq = AllocAslRequestTags(ASL_FileRequest,
	ASLFR_RejectIcons,1,TAG_DONE)))
      {
	if ((rcode = AslRequestTags(freq,ASLFR_TitleText,title,TAG_DONE)))
	{
	  strcpy(buffer,freq->fr_Drawer);
	  AddPart(buffer,freq->fr_File,256);
	}
	FreeAslRequest(freq);
      }
      CloseLibrary(AslBase);
    }
  }
  return rcode;
}
*/
void wbmain(struct WBStartup *wbmsg)
	{
	struct Library *iconbase;
	struct WBArg *wbarg = NULL;
	char *argv[256];
	int argc = 1, olddir = -1;
	ULONG i;

	iconbase = (struct Library*)OpenLibrary("icon.library", 36L);
	if (iconbase != NULL)
		{
		for (i=0, wbarg=wbmsg->sm_ArgList; i<wbmsg->sm_NumArgs; i++, wbarg++)
			{
			if ((wbarg->wa_Lock)&&(*wbarg->wa_Name))
				olddir = CurrentDir(wbarg->wa_Lock);
			if ((*wbarg->wa_Name) && (Icon = GetDiskObject(wbarg->wa_Name)))
				{
				amiga_readtooltypes();
				FreeDiskObject(Icon);
				Icon = NULL;
				}
			}
		if (olddir != -1) CurrentDir(olddir);
		CloseLibrary(iconbase);
		}

	wbstartup = 1;

	if (savefilename != NULL)
		{
    argc = 2;
		argv[1] = savefilename;
    }

  argv[0] = "Omega";
  main(argc,argv);
  exit(0);
}

void amiga_readtooltypes(void)
	{
	char *icon_str = NULL;

//	printf("ReadToolTypes\n");

	screenmode = GetVPModeID(&DefaultPubScreen->ViewPort);

	icon_str = FindToolType((UBYTE **)(Icon->do_ToolTypes),"SAVEFILE");
		if (icon_str != NULL)
			{ strcpy(savefilenamebuf, icon_str); savefilename = (char *)savefilenamebuf;	}

	icon_str = FindToolType((UBYTE **)(Icon->do_ToolTypes),"FONTNAME");
		if (icon_str != NULL)
			{ strcpy(fontnamebuf, icon_str); fontname = icon_str;	}

	if (FindToolType((UBYTE **)(Icon->do_ToolTypes),"SCREENREQ"))
			amiga_getscreenmode();

	if (FindToolType((UBYTE **)(Icon->do_ToolTypes),"GRAPHICS"))
		Graphics = 1; else Graphics = 0;

	if (FindToolType((UBYTE **)(Icon->do_ToolTypes),"NODELETE"))
		nodelete = 1; else nodelete = 0;
	}

void amiga_readargs(void)
	{
  ULONG params[10], i;
	struct RDArgs *rdargs = NULL;
	char usage[] = "SF=SAVEFILE/K,FN=FONTNAME/K,GFX=GRAPHICS/S,NDEL=NODELETE/S,SC=SCREENREQ/S";

	for (i=0; i<10; i++) params[i] = 0;

	rdargs = (struct RDArgs *)ReadArgs(usage, (LONG*)params, NULL);
	if (rdargs == NULL) return;

	if (params[0] != 0) savefilename = (char *)params[0];
	if (params[1] != 0) { strcpy(fontnamebuf, (char *)params[1]); fontname = (char *)params[1];	}
	if (params[2] != 0) Graphics = 1; else Graphics = 0;
	if (params[3] != 0) nodelete = 1; else nodelete = 0;
	if (params[4] != 0) amiga_getscreenmode();

	FreeArgs(rdargs);
	}


void amiga_getscreenmode(void)
	{
	struct rtScreenModeRequester *req = NULL;
	BOOL result;

	if (ReqToolsBase == NULL)
	  ReqToolsBase = (struct ReqToolsBase *)OpenLibrary("reqtools.library",38L);

	if (ReqToolsBase != NULL)
		{
		req = rtAllocRequest(RT_SCREENMODEREQ, NULL);
		if (req != NULL)
			{
			result = rtScreenModeRequest(req, "Select Omega Screenmode:", TAG_END, 0);
			if (result != FALSE) screenmode = req->DisplayID;
			rtFreeRequest(req);
			}
		}
	}



