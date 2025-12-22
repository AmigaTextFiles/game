
//
// Header File for China Challenge III - the C++ Version
//
// author	: Gunther Nikl
// created	: 9-may-94
// last change	: 2-nov-95
//


#ifndef _CC3_H
#define _CC3_H

//
// all includes
//

#include <sys/cdefs.h>

__BEGIN_DECLS

#include <exec/memory.h>
#include <dos/dosextens.h>
#include <devices/audio.h>
#include <hardware/cia.h>
#include <graphics/gfx.h>
#include <graphics/rastport.h>
#include <intuition/screens.h>
#include <intuition/intuition.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/alib.h>
#include <proto/exec.h>
#include <proto/dos.h>

LONG sprintf(STRPTR buffer, STRPTR fmt, ...);

LONG Main();

//
// oh - a c structure !
//

struct About
{ 
  UBYTE pens[2],x,y,text[24];
};

//
// some defines
//

#define DEPTH    3L
#define WIDTH  320L
#define HEIGHT 200L

#define MAXCOUNT 120L

#define SAMPLESIZE 104072L

#define ciaa (*((struct CIA*)0xbfe001L))

//
// common globals
//

static UBYTE ArpName[]       = "arp.library";
static UBYTE AudioName[]     = "audio.device";
static UBYTE TopazName[]     = "topaz.font";

static UBYTE SampleName[]    = "Sample";
static UBYTE PieceFmt[]      = "%3ld";
static UBYTE BlankStr[]      = "   ";

static UBYTE AboutStr[]      = "About";
static UBYTE QuitStr[]       = "Quit";
static UBYTE NewGameStr[]    = "New game";
static UBYTE UndoMoveStr[]   = "Undo last move";
static UBYTE UndoAllStr[]    = "Undo all moves";
static UBYTE LoadDragonStr[] = "Load Dragon";
static UBYTE SaveDragonStr[] = "Save Dragon";
static UBYTE PlayMusicStr[]  = "Play Music";
static UBYTE OptionsStr[]    = "Options";
static UBYTE ProjectStr[]    = "Project";

static struct About About1[] =
{ { {4,0},9,  9,"  China Challenge III  " },
  { {4,0},9, 16,"  -------------------  " },
  { {4,0},9, 29,"    written 1991 by    " },
  { {2,0},9, 44,"     Dirk Hoffmann     " },
  { {4,0},6, 60,"   rewritten 1993 by   " },
  { {2,0},9, 75,"     Gunther Nikl      " },
  { {3,0},9, 89,"This game is Freeware !" },
  { {3,0},9, 99,"       Enjoy ...       " },
  { {2,0},9,112," (dedicated to Astrid) " } };

static UBYTE Version[]       = "$VER: China Challenge III 1.1 (2.11.95)";
#define Title (Version+6)

static struct TextAttr TopazFont =
{ (STRPTR)TopazName,8,FS_NORMAL,FPF_ROMFONT };

static struct NewScreen NewScreen =
{ 0,0, WIDTH,HEIGHT, DEPTH, 4,2, 0 /* LORES */,
  SCREENQUIET | SCREENBEHIND | CUSTOMSCREEN, &TopazFont, Title, NULL, NULL };

static UWORD ColorTab[] =
{ 0x000,0xfeb,0xfe9,0xcb7,0xa43,0xc52,0x4a0,0x86b };

static struct NewWindow NewWindow =
{ 0,1, WIDTH,HEIGHT-2, 2,4,
  MENUPICK | MOUSEBUTTONS, ACTIVATE | BORDERLESS | BACKDROP,
  NULL,NULL,NULL,NULL,NULL,
  WIDTH,HEIGHT-2, WIDTH,HEIGHT-2, CUSTOMSCREEN };

static struct NewWindow AboutWindow =
{ 57,55, 200,120, 2,2,
  VANILLAKEY | MOUSEBUTTONS, NOCAREREFRESH | RMBTRAP | ACTIVATE | BORDERLESS,
  NULL,NULL,NULL,NULL,NULL,
  200,120,200,120, CUSTOMSCREEN };

static struct IntuiText MenuText[] =
{ { 2,4, JAM2,  3,1, NULL, AboutStr,      NULL },
  { 2,4, JAM2,  3,1, NULL, QuitStr,       NULL },
  { 2,4, JAM2,  3,1, NULL, NewGameStr,    NULL },
  { 2,4, JAM2,  3,1, NULL, UndoMoveStr,   NULL },
  { 2,4, JAM2,  3,1, NULL, UndoAllStr,    NULL },
  { 2,4, JAM2,  3,1, NULL, LoadDragonStr, NULL },
  { 2,4, JAM2,  3,1, NULL, SaveDragonStr, NULL },
  { 2,4, JAM2, 13,1, NULL, PlayMusicStr,  NULL } };

#define IFLAGS1 (HIGHCOMP | ITEMENABLED | COMMSEQ | ITEMTEXT)
#define IFLAGS2 (CHECKED | IFLAGS1 | MENUTOGGLE | CHECKIT)

static struct MenuItem MenuItems[] =
{ { &MenuItems[1], 2, 2, 80,11, IFLAGS1, NULL, &MenuText[0], NULL, 'a', NULL, 0 },
  { NULL,          2,14, 80,11, IFLAGS1, NULL, &MenuText[1], NULL, 'q', NULL, 0 },

  { &MenuItems[3], 2, 2,150,11, IFLAGS1, NULL, &MenuText[2], NULL, 'n', NULL, 0 },
  { &MenuItems[4], 2,14,150,11, IFLAGS1, NULL, &MenuText[3], NULL, 'b', NULL, 0 },
  { &MenuItems[5], 2,26,150,11, IFLAGS1, NULL, &MenuText[4], NULL, 'g', NULL, 0 },
  { &MenuItems[6], 2,38,150,11, IFLAGS1, NULL, &MenuText[5], NULL, 'l', NULL, 0 },
  { &MenuItems[7], 2,50,150,11, IFLAGS1, NULL, &MenuText[6], NULL, 's', NULL, 0 },
  { NULL         , 2,62,150,11, IFLAGS2, NULL, &MenuText[7], NULL, 'm', NULL, 0 } };

static struct Menu MenuStrip[] =
{ { &MenuStrip[1],  2,2, 60,10, MENUENABLED, (BYTE *)ProjectStr, &MenuItems[0], 0,0,0,0 },
  { NULL,          70,2, 60,10, MENUENABLED, (BYTE *)OptionsStr, &MenuItems[2], 0,0,0,0 } };

static WORD Coords[] =
{ 0,0, 28,0, 28,33, 0,33, 0,0 };

static struct Border Border1[] =
{ {   2,84, 1,2, JAM2, 5, &Coords[0], &Border1[1] },
  { 290,84, 1,2, JAM2, 5, &Coords[0], NULL        } };

static struct IntuiText MoveIText =
{ 2,5, JAM2, 283,53, NULL, BlankStr, NULL };

static UBYTE PosTable[] =
{ 0xFF,0x8F,0x1F,0xFE,0xE7,0x7F,0xF8,0xF1,0xFF,
  0xFC,0x03,0x0F,0xF8,0x81,0x1F,0xF0,0xC0,0x3F,
  0x60,0x00,0x0F,0xF0,0x00,0x0F,0xF0,0x00,0x06,
  0x00,0x00,0x00,0xF0,0x00,0x0F,0x00,0x00,0x00 };

static ULONG APenTab[] = { 0,5,0,2 };

static UBYTE ChannelMap[4] = { 3,5,10,12 };

static ULONG BackGroundTab[] = { 0,0,160,0,0,99,160,99 };

extern struct Image Images[];

/* arp filerequest structure */

struct FileReq
{
  APTR  fr_Hail;
  APTR  fr_File;
  APTR  fr_Dir;
  APTR  fr_Window;
  UBYTE fr_Flags;
  UBYTE fr_res1;
  APTR  fr_Func;
  LONG  fr_res2;
};

/* cc3 request definition */

struct ChinaReq
{
  struct FileReq FReq;
  UWORD  Pad;
  UBYTE  DirBuf[256];
  UBYTE  FileBuf[128];
};

/* arp inlines */

static __inline ULONG
FileRequest (struct Library *ArpBase,struct FileReq *req)
{
  register ULONG _res __asm("d0");
  register struct Library *a6 __asm("a6") = ArpBase;
  register struct FileReq *a0 __asm("a0") = req;
  __asm __volatile ("jsr a6@(-294)"
  : "=r" (_res)
  : "r" (a6), "r" (a0)
  : "a0","a1","d0","d1", "memory");
  return _res;
}

static __inline VOID
TackOn (struct Library *ArpBase,UBYTE *dir, UBYTE *file)
{
  register struct Library *a6 __asm("a6") = ArpBase;
  register UBYTE *a0 __asm("a0") = dir;
  register UBYTE *a1 __asm("a1") = file;
  __asm __volatile ("jsr a6@(-624)"
  : /* no output */
  : "r" (a6), "r" (a0), "r" (a1)
  : "a0","a1","d0","d1", "memory");
}
  
static __inline BPTR 
ArpOpen (struct Library *ArpBase,UBYTE *name,LONG accessMode)
{
  register BPTR  _res  __asm("d0");
  register struct Library *a6 __asm("a6") = ArpBase;
  register UBYTE *d1 __asm("d1") = name;
  register LONG d2 __asm("d2") = accessMode;
  __asm __volatile ("jsr a6@(-0x1e)"
  : "=r" (_res)
  : "r" (a6), "r" (d1), "r" (d2)
  : "a0","a1","d0","d1","d2", "memory");
  return _res;
}

__END_DECLS

//
// class definitions
//

// one undo entry :)

class Undo
{
 public:
   UWORD pos1,pos2;
};

// game class

struct Dragon
{
 public:
   class Undo UndoTable[60];
   BYTE PieceTable[288];
};

// main class

class China
{
   // public class functions

 public:
   China();
   ~China() { FreeMusic(); CloseGfx(); };

   LONG Init();
   VOID Game();

 private:

   // private class functions

   VOID InitMusic();
   LONG MakeGfx();

   VOID CloseGfx();
   VOID FreeMusic();

   VOID DoIDCMP(ULONG imClass, ULONG imCode);

   VOID ProjectAbout();
   VOID ProjectQuit();

   VOID OptNewGame();
   VOID OptUndoMove();
   VOID OptUndoAll();
   VOID OptLoadDragon();
   VOID OptSaveDragon();
   VOID OptMusic();

   LONG CheckPos();

   VOID MakeDragon();
   LONG Random(ULONG);
   VOID ShowDragon();
   VOID PrintPieces();

   BPTR ReqFile(LONG);

   // variables

   struct Screen *ScrPtr;
   struct Window *WinPtr;
   APTR SampleBuf;
   LONG PiecePos1,PiecePos2;
   ULONG RandVal,PieceCount;
   ULONG TwoSelected,OnePiece;
   BYTE Music,EndAll,AudioOpen;
   struct MsgPort AudioPort;
   struct IOAudio AudioIO;
   struct RastPort RastPort;
   struct BitMap BitMap;
   UBYTE EntryTable[MAXCOUNT];
   class Dragon NewDragon;
};

VOID ChangeFunc();

//
// NewList() as macro
//

#define NEWLIST(l) ((l)->lh_Head = (struct Node *)&(l)->lh_Tail, \
                    (l)->lh_TailPred = (struct Node *)&(l)->lh_Head)

#endif /* _CC3_H */

//
// end of Header File for China Challenge III - the C++ Version
//
