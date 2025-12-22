// need to load the strings "new" "get" and "save"
// for load/save/new games when in menu, then set
// done to 1!!!

// NOTE THAT THE INPUT THREAD HAS TO BE THE ONE TO
// GETGAME AND SAVE GAME THOUGH!! so it must all change

/*#define EIGHT_BIT_SCREEN 1 */

/* main.c - C source for GNU CHESS
 *
 * Copyright (c) 1988,1989,1990 John Stanback
 * Copyright (c) 1992 Free Software Foundation
 *
 * This file is part of GNU CHESS.
 *
 * GNU Chess is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * GNU Chess is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GNU Chess; see the file COPYING.  If not, write to
 * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

int __aligned CheckIllegal = 0;
extern int IllegalMove;
#include "version.h"
#include "gnuchess.h"
#include <signal.h>
#include <ctype.h>

#ifdef AMIGA
#define EXCLUDE_PATT 0xffffff00L
#define __USE_SYSBASE
#include <exec/types.h>
#include <exec/exec.h>
#include <exec/semaphores.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <dos/dostags.h>
#include <proto/graphics.h>
#include <graphics/gfxbase.h>
#include <proto/intuition.h>
#include <utility/tagitem.h>
#include <graphics/modeid.h>
#include <lhlib.h>
#include <libraries/asl.h>
#include <proto/icon.h>
#include <proto/asl.h>
#include <workbench/startup.h>
#include <workbench/workbench.h>


#define mySetABPenDrMd(a,b,c,d) if (gfxversion > 38) {SetABPenDrMd(a,b,c,d);} else {SetAPen(a,b);SetDrMd(a,d);}

extern int backsrchaborted;
extern int __aligned bookflag;
struct TmpRas __aligned temp_rast;
unsigned char *tempras_bitplane=(unsigned char *)0L;

struct __iobuf __iob[1];

struct SignalSemaphore __aligned mySemaphore; // should be all zeroed



#define LN2 693147 /* .693147 */
#define LOGE_34 3526361 /* log2(34) = ln(34)/ln(2) = 5.087463 */
#define LOGE_16 2772589 /* ln(16) = */

void SetTimeControl2 (int);
void calc_pgm_rating(void);
void DoEasy(void);
void DoIntermediate(void);
void DoAdvanced(void);
int GetScreenMode(void);


/* this table index ln(2)*1e6 - ln(1202)*1e6 by 6's */
/* so take (#secs - 2)/6 for index into this table */


char __aligned __far UCProcName[16]="UCTurbo Engine";
char __aligned __far InputPortName[16]="UC Port";
struct TagItem __aligned __far ProcTagList[8] = {
{NP_Entry,(ULONG)InputThread},
{NP_StackSize,4096L},
{NP_Name,(ULONG)UCProcName},
{0,0}
};

extern INTSIZE __aligned amigaboard[64],amigacolor[64];
extern int __aligned RealThink;
int __aligned OpEntryRecvd=0;
struct MsgPort __aligned *InputReply=(struct MsgPort *)0L;
struct MsgPort *InThreadPort;
int __aligned InputThreadState=0;
struct myMsgStruct __aligned Global_Message;
char __aligned OpEntryStr[64];

long __aligned OrigResponse;
int __aligned __far log_e[]={
693147, 2079442, 2639057, 2995732, 3258097, 3465736, 3637586, 3784190, 
3912023, 4025352, 4127134, 4219508, 4304065, 4382027, 4454347, 4521789, 
4584967, 4644391, 4700480, 4753590, 4804021, 4852030, 4897840, 4941642, 
4983607, 5023881, 5062595, 5099866, 5135798, 5170484, 5204007, 5236442, 
5267858, 5298317, 5327876, 5356586, 5384495, 5411646, 5438079, 5463832, 
5488938, 5513429, 5537334, 5560682, 5583496, 5605802, 5627621, 5648974, 
5669881, 5690359, 5710427, 5730100, 5749393, 5768321, 5786897, 5805135, 
5823046, 5840642, 5857933, 5874931, 5891644, 5908083, 5924256, 5940171, 
5955837, 5971262, 5986452, 6001415, 6016157, 6030685, 6045005, 6059123, 
6073045, 6086775, 6100319, 6113682, 6126869, 6139885, 6152733, 6165418, 
6177944, 6190315, 6202536, 6214608, 6226537, 6238325, 6249975, 6261492, 
6272877, 6284134, 6295266, 6306275, 6317165, 6327937, 6338594, 6349139, 
6359574, 6369901, 6380123, 6390241, 6400257, 6410175, 6419995, 6429719, 
6439350, 6448889, 6458338, 6467699, 6476972, 6486161, 6495266, 6504288, 
6513230, 6522093, 6530878, 6539586, 6548219, 6556778, 6565265, 6573680, 
6582025, 6590301, 6598509, 6606650, 6614726, 6622736, 6630683, 6638568, 
6646391, 6654153, 6661855, 6669498, 6677083, 6684612, 6692084, 6699500, 
6706862, 6714171, 6721426, 6728629, 6735780, 6742881, 6749931, 6756932, 
6763885, 6770789, 6777647, 6784457, 6791221, 6797940, 6804615, 6811244, 
6817831, 6824374, 6830874, 6837333, 6843750, 6850126, 6856462, 6862758, 
6869014, 6875232, 6881411, 6887553, 6893656, 6899723, 6905753, 6911747, 
6917706, 6923629, 6929517, 6935370, 6941190, 6946976, 6952729, 6958448, 
6964136, 6969791, 6975414, 6981006, 6986566, 6992096, 6997596, 7003065, 
7008505, 7013915, 7019297, 7024649, 7029973, 7035269, 7040536, 7045777, 
7050989, 7056175, 7061334, 7066467, 7071573, 7076654, 7081709, 7086738, 
7091742};


/* Structure for transparent images */

#define PTRHEIGHT 55

#define BLANKDATA 0xffff

extern int SecsPerMove;
int __aligned lastpiece=BLANKDATA;

void Undo(void);

char __aligned __far vstring[64]={AVSTR};

long __far __aligned piecechar[12]={'p','n','b','r','q','k',
                          'P','N','B','R','Q','K'};
char __far __aligned oldboard[8][8];

int __far __aligned BACKPEN=1;

int __aligned BLACK=1;

//int __aligned Picasso=0L;
ULONG __far __aligned bpen;
int __aligned PlayMode = 2;
int __aligned global_tmp_score=0;
int __aligned previous_score=0;
extern short int ISZERO;
extern int thinkahead;
unsigned long int __aligned next = 1;
int __aligned doswap=0;
int __aligned doundo=0;
int __aligned doauto=0;
int __aligned gfxversion=0L;
int __aligned v15Khz=0L;
int __aligned teston=0;
int __aligned cmptr_sec,cmptr_min,hum_sec,hum_min;
struct TagItem __aligned __far myTagList[8] = {
{SA_DisplayID,VGAPRODUCT_KEY},
{SA_Overscan,OSCAN_STANDARD},
{0,0},
{0,0},
{0,0}
};

int __aligned MoveNowOK=0;

#define WINDOWSIGNAL (1L<<(wG->UserPort->mp_SigBit))
ULONG __aligned globalsignalset=0L;

ULONG __aligned RTG_ModeID=0x0L;
int __aligned Super72=0;
int __aligned RTG=0;
int __aligned SYSTEM_BOBS=1;
int __aligned procpri=3;
struct Process __aligned *myproc;

int __aligned __far ResignOffered=0;
//ULONG __far __aligned tmppal[4];

inline void TimeCalc (void);


int __far __aligned FasterDisplay=0;
int __aligned trying_again=0;
int __aligned SupervisorMode=0;
int __aligned MenuStripSet = 0;
int __aligned GlobalTgtDepth=3;

UWORD chip myPointer[]={
0,0,
31744,0,
4096,0,
4096,0,
4096,0,
4096,0,
5120,0,
5120,0,
1024,0,
1920,0,
1152,0,
1152,0,
1152,0,
256,0,
0,0,
768,0,
256,0,
256,0,
256,0,
896,0,
0,0,
896,0,
576,0,
576,0,
576,0,
576,0,
0,0,
512,0,
512,0,
576,0,
640,0,
896,0,
640,0,
576,0,
0,0,
256,0,
0,0,
768,0,
256,0,
256,0,
256,0,
896,0,
0,0,
0,0,
896,0,
576,0,
576,0,
576,0,
576,0,
0,0,
960,0,
576,0,
576,0,
960,0,
64,0,
960,0,
0,0
};


struct TransImage
{
    struct Image *ti_IM;	/* The plain image */
    struct BitMap *ti_sBM;	/* Shadow bitmap */
    struct RastPort *ti_sRP;	/* Shadow rastport */
    struct BitMap ti_BM;	/* Image bitmap */
    struct RastPort ti_RP;	/* Image rastport */
};

struct Image __aligned BobImage;

struct TransImage __aligned *BobTransImage;

struct TransImage *AllocTransImage (struct Image * im);
VOID FreeTransImage (struct TransImage * ti);
VOID ClipBlitTrans (struct RastPort *, WORD, WORD, struct RastPort *, WORD, WORD, WORD, WORD, struct RastPort *);
struct BitMap *AllocShadowBM (UWORD, UWORD, UWORD);
VOID FreeShadowBM (struct BitMap *);
struct RastPort *AllocShadowRP (struct BitMap *);
VOID FreeShadowRP (struct RastPort *);
long __aligned OrigCol,OrigRow,DestCol,DestRow;


#define TDEPTH 4
#define THEIGHT 400 /* tmp ht */
#define TBLOCKPEN 4 /* was 9 */
#define MENUPEN 11

#ifdef EIGHT_BIT_SCREEN
int __aligned DEPTH=8;
#ifdef MANYP
int __aligned HEIGHT=480;
int __aligned USERBOX=168;
int __aligned COMPUTERBOX=60;
int __aligned BACKGNDTEXTCOLOR=0xe0; /* for 256 use 0xe0 */
int __aligned BOBHEIGHT=55; /* 55 for 480 screens */
int __aligned ROW8=24; /* 24 for 480 screens */
int __aligned MBLOCKPEN=251;
#endif
#else
int __aligned DEPTH=4;
#endif

int __aligned TCadd = 0;
int __aligned thinking2=0; /* look for move now menu selection in elasped time when set */
int __aligned TIMEYCOORD1=100;
int __aligned TIMEYCOORD2=192;
int __aligned SYSBOXLEN=86;
int __aligned HEIGHT=400;
int __aligned USERBOX=140;
int __aligned SYSTEMBOX=233;
int __aligned COMPUTERBOX=50;
int __aligned BACKGNDTEXTCOLOR=15; /* for 256 use 0xe0 */
int __aligned BOBHEIGHT=46; /* 55 for 480 screens */
int __aligned ROW8=20; /* 24 for 480 screens */
int __aligned MBLOCKPEN=9;

#define MENUBARHT 11
#define WIDTH 640
#define VIEWMODES (HIRES|LACE)

int __aligned BOBDEPTH=TDEPTH;

#define BOARDWIDTH 640
#define BOARDWIDINW 40
#define BOARDSIZE (480*DEPTH*BOARDWIDINW*sizeof(WORD))
#define BOARDBLOCKSIZE ((BOARDSIZE+(BOARDWIDINW*sizeof(WORD))*(480+2))+(BOARDWIDINW*sizeof(WORD)))

#define BOBWIDTH 64 /* only 59 pixels are really used, rest are tranparent */
#define BOBWIDINW 4
#define BOBSIZE (BOBHEIGHT*BOBDEPTH*BOBWIDINW*sizeof(WORD))
#define BOBBLOCKSIZE ((BOBSIZE)+(BOBWIDINW*sizeof(WORD)*(BOBHEIGHT+2))+(BOBWIDINW*sizeof(WORD)))

#define BOBLW ((BOBBLOCKSIZE)/4)
#define BOBMEMASK 0
#define BOBHITMASK 0
int __aligned BOBPLANEPICK=0xf; /* if 16 colors should be 0xf if 256 should be 0xff */
#define BOBPLANEONOFF 0x0

#define SQUAREWIDTH 59
#define ROUNDEDSQUAREWIDTH 64
#define SQUAREHEIGHT BOBHEIGHT
#define COLA (16)
#define COLB (16+SQUAREWIDTH)
#define COLC (16+SQUAREWIDTH*2)
#define COLD (16+SQUAREWIDTH*3)
#define COLE (16+SQUAREWIDTH*4)
#define COLF (16+SQUAREWIDTH*5)
#define COLG (16+SQUAREWIDTH*6)
#define COLH (16+SQUAREWIDTH*7)
#define ROW7 (ROW8+SQUAREHEIGHT)
#define ROW6 (ROW8+SQUAREHEIGHT*2)
#define ROW5 (ROW8+SQUAREHEIGHT*3)
#define ROW4 (ROW8+SQUAREHEIGHT*4)
#define ROW3 (ROW8+SQUAREHEIGHT*5)
#define ROW2 (ROW8+SQUAREHEIGHT*6)
#define ROW1 (ROW8+SQUAREHEIGHT*7)


UWORD __aligned *BlankImageData;

UWORD __far __aligned *WhiteImageData[6];
UWORD __far __aligned *BlackImageData[6];

void LoadBobImage(long);

long __far __aligned ColArray[8]={COLA,COLB,COLC,COLD,COLE,COLF,COLG,COLH};
long __far __aligned RowArray[8];

struct VSprite __aligned *SpriteHead;
struct VSprite __aligned *SpriteTail;

struct GelsInfo __aligned *myGelsInfo;
struct VSprite __aligned *BobVSprite;
struct Bob __aligned *TheBob;

struct BitMap __aligned *WhiteBitMap,*BlackBitMap;
struct BitMap *textBitMap=(struct BitMap *)0L;

struct TextFont __aligned *myTextFont;

extern struct GfxBase __aligned *Gfxbase;
long __aligned __stack=50000L;
ULONG tt;
struct RastPort __aligned *rpG;
struct ViewPort __aligned *vP;
struct Screen __aligned *sC=0L;
struct Window __aligned *wG=0L;
struct Window __aligned *wGEdit;
unsigned char __far __aligned cookedchar[128]={'~',
			      '1',
			      '2',
			      '3',
			      '4',
			      '5',
			      '6',
			      '7',
			      '8',
			      '9',
			      '0', /* 10 */
			      '-',
			      '=',
			      ' ',
			      ' ',
			      '0',
			      'Q', /* 16 */
			      'W',
			      'E',
			      'R',
			      'T', /* 20 */
			      'Y',
			      'U',
			      'I',
			      'O',
			      'P', /* 25 */
			      '[',
			      ']',
			      ' ',
			      '1',
			      '2',
			      '3',
			      'A',
			      'S',
			      'D',
			      'F',
			      'G',
			      'H',
			      'J',
			      'K',
			      'L', /* 40 */
			      ':',
			      '"',
			      13,
			      ' ',
			      '4',
			      '5',
			      '6',
			      ' ',
			      'Z',
			      'X', /* 50 */
			      'C',
			      'V',
			      'B',
			      'N',
			      'M', /* 55 */
			      ',',
			      '.',
			      '/',
			      ' ',
			      '.',
			      '7',
			      '8',
			      '9',
			      ' ',
			      7,
			      8,
			      13,
			      13,
			      27,
			      7
};




char __aligned *Orig_PlanePtr;
struct BitMap __aligned *myBitMap;
struct BitMap __aligned *OrigmyBitMap=0L;

#include "Chess256Palette.c"

UWORD __far __aligned myPalette[16]=
{
0xfbc, 0x632, 0x455, 0x842, 0x549, 0xa53, 0x787, 0xa56, 
0x967, 0xa85, 0x3ab, 0xaaa, 0xe88, 0xdb8, 0x333, 0xeee
};

#ifdef OLDPAL
{
0x0, 0x222, 0x410, 0x333, 
0x621, 0x624, 0x952, 0x665, 
0x974, 0x887, 0xb85, 0xaa9, 
0xbb7, 0xcc8, 0xcc9, 0xddc};
#endif 

struct TextAttr __far __aligned TOPAZ80 = {
	(STRPTR)"topaz.font",
	TOPAZ_EIGHTY,0,0
};

SHORT __far __aligned BorderVectors6[] = {
	0,0,
	44,0,
	44,19,
	0,19,
	0,0
};
struct Border __far __aligned Border6 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors6,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText __far __aligned IText93 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	12,6,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"OK",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget __far __aligned Gadget9 = {
	NULL,	/* next gadget */
	109,64,	/* origin XY of hit box relative to window TopLeft */
	43,18,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border6,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText93,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

UBYTE __aligned Gadget8SIBuff[8];
struct StringInfo __aligned Gadget8SInfo = {
	Gadget8SIBuff,	/* buffer where text will be edited */
	NULL,	/* optional undo buffer */
	0,	/* character position in buffer */
	5,	/* maximum number of characters to allow */
	0,	/* first displayed character buffer position */
	0,0,0,0,0,	/* Intuition initialized and maintained variables */
	0,	/* Rastport of gadget */
	0,	/* initial value for integer gadgets */
	NULL	/* alternate keymap (fill in if you set the flag) */
};

SHORT __far __aligned BorderVectors7[] = {
	0,0,
	45,0 /* was 45 */,
	45,14, /* was 17 */
	0,14,
	0,0
};
struct Border __far __aligned Border7 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors7,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct Gadget __far __aligned Gadget8 = {
	&Gadget9,	/* next gadget */
	136,32,	/* origin XY of hit box relative to window TopLeft */
	44,16,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	STRGADGET,	/* gadget type flags */
	(APTR)&Border7,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	(APTR)&Gadget8SInfo,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};


UBYTE __aligned Gadget6SIBuff[8];
struct StringInfo __aligned Gadget6SInfo = {
	Gadget6SIBuff,	/* buffer where text will be edited */
	NULL,	/* optional undo buffer */
	0,	/* character position in buffer */
	4,	/* maximum number of characters to allow */
	0,	/* first displayed character buffer position */
	0,0,0,0,0,	/* Intuition initialized and maintained variables */
	0,	/* Rastport of gadget */
	0,	/* initial value for integer gadgets */
	NULL	/* alternate keymap (fill in if you set the flag) */
};

struct Border __far __aligned Border9 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors7,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct Gadget __far __aligned Gadget6 = {
	&Gadget8,	/* next gadget */
	14,32,	/* origin XY of hit box relative to window TopLeft */
	44,16,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	STRGADGET,	/* gadget type flags */
	(APTR)&Border9,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	(APTR)&Gadget6SInfo,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

struct Gadget __far __aligned Gadget6b = {
	&Gadget9,	/* next gadget */
	14,32,	/* origin XY of hit box relative to window TopLeft */
	44,16,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	STRGADGET,	/* gadget type flags */
	(APTR)&Border9,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	(APTR)&Gadget6SInfo,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};




struct IntuiText __aligned IText47 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	195,36,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"Minutes.",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct IntuiText __far __aligned IText46 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	64,35,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"Moves in",	/* pointer to text */
	&IText47	/* next IntuiText structure */
};

#define IntuiTextList5 IText46

struct NewWindow __far __aligned NewWindowStructure5 = {
	161,23,	/* window XY origin relative to TopLeft of screen */
	270,90,	/* window width and height */
	0,TBLOCKPEN,	/* detail and block pens */
	GADGETUP,	/* IDCMP flags */
	SIMPLE_REFRESH+ACTIVATE+NOCAREREFRESH,	/* other window flags */
	&Gadget6,	/* first gadget in gadget list */
	NULL,	/* custom CHECKMARK imagery */
	"Computer Time Ctrl",	/* window title */
	NULL,	/* custom screen pointer */
	NULL,	/* custom bitmap */
	5,5,	/* minimum width and height */
	0xffff,0xffff,	/* maximum width and height */
	CUSTOMSCREEN	/* destination screen type */
};


struct ExtNewScreen __far __aligned NewScreenStructure = {
	0,0,	/* screen XY origin relative to View */
	WIDTH,THEIGHT,	/* screen width and height */
	4,	/* screen depth (number of bitplanes) */
	0,TBLOCKPEN,	/* detail and block pens */
	VIEWMODES,	/* display modes for this screen */
	CUSTOMBITMAP|CUSTOMSCREEN,	/* screen type */
	&TOPAZ80,	/* pointer to default screen font */
	VERSTRING,	/* screen title */
	NULL,	/* first in list of custom screen gadgets */
	NULL	/* pointer to custom BitMap structure */
};

struct ExtNewScreen __far __aligned NewScreenStructure2 = {
	0,0,	/* screen XY origin relative to View */
	WIDTH,480,	/* screen width and height */
	8,	/* screen depth (number of bitplanes) */
	0,251,	/* detail and block pens */
	VIEWMODES,	/* display modes for this screen */
	CUSTOMSCREEN|SCREENBEHIND,	/* screen type */
	&TOPAZ80,	/* pointer to default screen font */
	" ",	/* screen title */
	NULL,	/* first in list of custom screen gadgets */
	NULL	/* pointer to custom BitMap structure */
};


struct IntuiText __far __aligned IText37 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"New Game",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct IntuiText __far __aligned IText1r = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Set Depth",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem3r = {
	NULL,	/* next MenuItem structure */
	0,32,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText1r,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText1 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Set Time",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem3 = {
	&MenuItem3r,	/* next MenuItem structure */
	0,24,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText1,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText2x = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Rate Pgm",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem3x = {
	&MenuItem3,	/* next MenuItem structure */
	0,16,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText2x,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText2 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Test",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem2 = {
	&MenuItem3x,	/* next MenuItem structure */
	0,8,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText2,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText3 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Hint",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem1 = {
	&MenuItem2,	/* next MenuItem structure */
	0,0,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText3,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'H',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct Menu __aligned Menu4 = {
	NULL,	/* next Menu structure */
	162,0,	/* XY origin of Menu hit box relative to screen TopLeft */
	63,0,	/* Menu hit box width and height */
	MENUENABLED,	/* Menu flags */
	"Special",	/* text of Menu name */
	&MenuItem1	/* MenuItem linked list pointer */
};

struct IntuiText __far __aligned IText4cc = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Easy",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem8cc = {
	NULL,	/* next MenuItem structure */
	0,80,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	CHECKIT+MENUTOGGLE+ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	EXCLUDE_PATT^(0x400),	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText4cc,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'E',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText4dd = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Intrmdt",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem8dd = {
	&MenuItem8cc,	/* next MenuItem structure */
	0,72,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	CHECKIT+MENUTOGGLE+ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	EXCLUDE_PATT^(0x200),	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText4dd,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'I',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText4ee = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Advancd",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem8ee = {
	&MenuItem8dd,	/* next MenuItem structure */
	0,64,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	CHECKED+CHECKIT+MENUTOGGLE+ITEMTEXT+COMMSEQ+HIGHCOMP,	/* Item flags */
	EXCLUDE_PATT^(0x100),	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText4ee,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'A',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText4aa = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Supvsr",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem8aa = {
	&MenuItem8ee,	/* next MenuItem structure */
	0,56,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	CHECKIT+MENUTOGGLE+ITEMTEXT+COMMSEQ+/*ITEMENABLED+*/HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText4aa,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'Y',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText4ab = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Book",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem8ab = {
  	&MenuItem8aa,	/* next MenuItem structure */
	0,48,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	CHECKIT+CHECKED+MENUTOGGLE+ITEMTEXT+COMMSEQ+/*ITEMENABLED+*/HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText4ab,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'B',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText4a = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"ShwThnk",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem8a = {
	&MenuItem8ab,	/* next MenuItem structure */
	0,40,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	CHECKIT+MENUTOGGLE+ITEMTEXT+COMMSEQ+/*ITEMENABLED+*/HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText4a,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'V',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText4 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Thinking",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem8 = {
	&MenuItem8a,	/* next MenuItem structure */
	0,32,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	CHECKIT+MENUTOGGLE+ITEMTEXT+COMMSEQ/*+ITEMENABLED*/+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText4,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'T',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText5 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Undo",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem7 = {
	&MenuItem8,	/* next MenuItem structure */
	0,24,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText5,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'U',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText6 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Move Now",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem6 = {
	&MenuItem7,	/* next MenuItem structure */
	0,16,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+/*ITEMENABLED+*/HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText6,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'M',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText7 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"AutoPlay",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem5 = {
	&MenuItem6,	/* next MenuItem structure */
	0,8,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText7,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText8 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Swap Sides",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem4 = {
	&MenuItem5,	/* next MenuItem structure */
	0,0,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	123,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText8,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'S',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct Menu __aligned Menu3 = {
	&Menu4,	/* next Menu structure */
	92,0,	/* XY origin of Menu hit box relative to screen TopLeft */
	63,0,	/* Menu hit box width and height */
	MENUENABLED,	/* Menu flags */
	"Control",	/* text of Menu name */
	&MenuItem4	/* MenuItem linked list pointer */
};

struct IntuiText __far __aligned IText9 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"ReverseBoard",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem11 = {
	NULL,	/* next MenuItem structure */
	0,16,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	96,8,	/* hit box width and height */
	ITEMTEXT+/*ITEMENABLED+*/HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText9,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText10 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Edit Board",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem10 = {
	&MenuItem11,	/* next MenuItem structure */
	0,8,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	96,8,	/* hit box width and height */
	ITEMTEXT+HIGHCOMP+ITEMENABLED,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText10,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText11 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	19,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"2-D",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem9 = {
	&MenuItem10,	/* next MenuItem structure */
	0,0,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	96,8,	/* hit box width and height */
	CHECKED+CHECKIT+ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText11,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct Menu __aligned Menu2 = {
	&Menu3,	/* next Menu structure */
	46,0,	/* XY origin of Menu hit box relative to screen TopLeft */
	39,0,	/* Menu hit box width and height */
	MENUENABLED,	/* Menu flags */
	"View",	/* text of Menu name */
	&MenuItem9	/* MenuItem linked list pointer */
};

struct IntuiText __far __aligned IText12 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Quit",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem15 = {
	NULL,	/* next MenuItem structure */
	0,40,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+COMMSEQ+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText12,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	'Q',	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText13a = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"List Game",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem14a = {
	&MenuItem15,	/* next MenuItem structure */
	0,32,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText13a,/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText13 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Save Game",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem14 = {
	&MenuItem14a,	/* next MenuItem structure */
	0,24,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText13,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText14 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Load Game",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem13 = {
	&MenuItem14,	/* next MenuItem structure */
	0,16,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText14,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct MenuItem __aligned MenuItem28 = {
	&MenuItem13,	/* next MenuItem structure */
	0,8,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText37,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct IntuiText __far __aligned IText15 = {
	MENUPEN,1,JAM1,//TBLOCKPEN,1,COMPLEMENT,	/* front and back text pens, drawmode and fill byte */
	0,0,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"About..",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct MenuItem __aligned MenuItem12 = {
	&MenuItem28,	/* next MenuItem structure */
	0,0,	/* XY of Item hitbox relative to TopLeft of parent hitbox */
	72,8,	/* hit box width and height */
	ITEMTEXT+ITEMENABLED+HIGHCOMP,	/* Item flags */
	0,	/* each bit mutually-excludes a same-level Item */
	(APTR)&IText15,	/* Item render  (IntuiText or Image or NULL) */
	NULL,	/* Select render */
	NULL,	/* alternate command-key */
	NULL,	/* SubItem list */
	MENUNULL	/* filled in by Intuition for drag selections */
};

struct Menu __aligned Menu1 = {
	&Menu2,	/* next Menu structure */
	0,0,	/* XY origin of Menu hit box relative to screen TopLeft */
	39,0,	/* Menu hit box width and height */
	MENUENABLED,	/* Menu flags */
	"File",	/* text of Menu name */
	&MenuItem12	/* MenuItem linked list pointer */
};

#define MenuList1 Menu1

struct NewWindow __aligned NewWindowStructure1 = {
	0,0,	/* window XY origin relative to TopLeft of screen */
	WIDTH,THEIGHT,	/* window width and height */
	0,TBLOCKPEN,	/* detail and block pens */
	MOUSEBUTTONS|MENUPICK|RAWKEY,	/* IDCMP flags */
	BACKDROP+BORDERLESS+ACTIVATE+NOCAREREFRESH,	/* other window flags */
	NULL,	/* first gadget in gadget list */
	NULL,	/* custom CHECKMARK imagery */
	" ",	/* window title */
	NULL,	/* custom screen pointer */
	NULL,	/* custom bitmap */
	WIDTH,THEIGHT,	/* minimum width and height */
	0xffff,0xffff,	/* maximum width and height */
	CUSTOMSCREEN	/* destination screen type */
};

SHORT __far __aligned BorderVectors1[] = {
	0,0,
	81,0,
	81,38,
	0,38,
	0,0
};
struct Border __far __aligned Border1 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	BorderVectors1,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText __far __aligned IText16 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	31,15,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"OK",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget __far __aligned Gadget1 = {
	NULL,	/* next gadget */
	155,233,	/* origin XY of hit box relative to window TopLeft */
	80,37,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&Border1,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&IText16,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

#define GadgetList2 Gadget1

struct IntuiText __far __aligned IText22 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	143,130,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"of Computers.",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct IntuiText __far __aligned IText21 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	115,117,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"For the Amiga Family",	/* pointer to text */
	&IText22	/* next IntuiText structure */
};

struct IntuiText __far __aligned IText20 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	104,102,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"Chess Program Available",	/* pointer to text */
	&IText21	/* next IntuiText structure */
};

struct IntuiText __far __aligned IText19 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	108,87,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"The strongest Playing",	/* pointer to text */
	&IText20	/* next IntuiText structure */
};

struct IntuiText __far __aligned IText18 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	126,31,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"by Roger Uzun",	/* pointer to text */
	&IText19	/* next IntuiText structure */
};

struct IntuiText __far __aligned IText17 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	131,18,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	VERSTRING,	/* pointer to text */
	&IText18	/* next IntuiText structure */
};

struct NewWindow __far __aligned NewWindowStructure2 = {
	125,30,	/* window XY origin relative to TopLeft of screen */
	390,290,	/* window width and height */
	0,TBLOCKPEN,	/* detail and block pens */
	VANILLAKEY|GADGETUP,	/* IDCMP flags */
	SIMPLE_REFRESH+NOCAREREFRESH+ACTIVATE,	/* other window flags */
	&Gadget1,	/* first gadget in gadget list */
	NULL,	/* custom CHECKMARK imagery */
#ifdef _M68040
	"UChess Pro",	/* window title */
#else
#ifndef TINYCHESS
	"UChess Jr.",	/* window title */
#else
	"UChess Tiny",	/* window title */
#endif
#endif
	NULL,	/* custom screen pointer */
	NULL,	/* custom bitmap */
	5,5,	/* minimum width and height */
	0xffff,0xffff,	/* maximum width and height */
	CUSTOMSCREEN	/* destination screen type */
};


SHORT __far __aligned aBorderVectors1[] = {
	0,0,
	77,0,
	77,25,
	0,25,
	0,0
};
struct Border __far __aligned aBorder1 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	aBorderVectors1,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText __far __aligned aIText1 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	16,8,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"KNIGHT",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget __far __aligned aGadget4 = {
	NULL,	/* next gadget */
	55,124,	/* origin XY of hit box relative to window TopLeft */
	76,24,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&aBorder1,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&aIText1,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT __far __aligned aBorderVectors2[] = {
	0,0,
	77,0,
	77,25,
	0,25,
	0,0
};
struct Border __far __aligned aBorder2 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	aBorderVectors2,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText __far __aligned aIText2 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	15,8,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"BISHOP",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget __far __aligned aGadget3 = {
	&aGadget4,	/* next gadget */
	55,92,	/* origin XY of hit box relative to window TopLeft */
	76,24,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&aBorder2,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&aIText2,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT __far __aligned aBorderVectors3[] = {
	0,0,
	77,0,
	77,25,
	0,25,
	0,0
};
struct Border __far __aligned aBorder3 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	aBorderVectors3,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText __far __aligned aIText3 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	19,8,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"ROOK",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget __far __aligned aGadget2 = {
	&aGadget3,	/* next gadget */
	55,60,	/* origin XY of hit box relative to window TopLeft */
	76,24,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&aBorder3,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&aIText3,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT __far __aligned aBorderVectors4[] = {
	0,0,
	77,0,
	77,25,
	0,25,
	0,0
};
struct Border __far __aligned aBorder4 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	aBorderVectors4,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText __far __aligned aIText4 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	16,8,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"QUEEN",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget __far __aligned aGadget1 = {
	&aGadget2,	/* next gadget */
	55,28,	/* origin XY of hit box relative to window TopLeft */
	76,24,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&aBorder4,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&aIText4,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};


struct IntuiText __far __aligned aIText5 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	33,14,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Promote Pawn to",	/* pointer to text */
	NULL	/* next IntuiText structure */
};


struct NewWindow __aligned NewWindowStructure6 = {
	220,35,	/* window XY origin relative to TopLeft of screen */
	200,170,	/* window width and height */
	0,TBLOCKPEN,	/* detail and block pens */
	GADGETUP,	/* IDCMP flags */
	SIMPLE_REFRESH+ACTIVATE+NOCAREREFRESH,	/* other window flags */
	&aGadget1,	/* first gadget in gadget list */
	NULL,	/* custom CHECKMARK imagery */
	"Promote Piece",	/* window title */
	NULL,	/* custom screen pointer */
	NULL,	/* custom bitmap */
	5,5,	/* minimum width and height */
	0xffff,0xffff,	/* maximum width and height */
	CUSTOMSCREEN	/* destination screen type */
};

#define MOVENOWMENUNUM 0x42
#define THINKMENUNUM 0x82
#define SHOWMENUNUM 0xa2
#define BOOKMENUNUM 0xc2
#define SUPERMENUNUM 0xe2
#define ADVANCEDMENUNUM 0x102
#define INTERMEDIATEMENUNUM 0x122
#define EASYMENUNUM 0x142


SHORT __far __aligned pBorderVectors1[] = {
	0,0,
	68,0,
	68,31,
	0,31,
	0,0
};
struct Border __far __aligned pBorder1 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	pBorderVectors1,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText __far __aligned pIText1 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	13,11,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"DONE",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget __far __aligned pGadget4 = {
	NULL,	/* next gadget */
	104,172,	/* origin XY of hit box relative to window TopLeft */
	67,30,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&pBorder1,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&pIText1,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT __far __aligned pBorderVectors2[] = {
	0,0,
	68,0,
	68,31,
	0,31,
	0,0
};
struct Border __far __aligned pBorder2 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	pBorderVectors2,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText __far __aligned pIText2 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	117,132,	/* was 13,11 XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"WHITE",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct IntuiText __far __aligned pIText2a = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	117,132,	/* was 13,11 XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"BLACK",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget __far __aligned pGadget3 = {
	&pGadget4,	/* next gadget */
	104,121,	/* origin XY of hit box relative to window TopLeft */
	67,30,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&pBorder2,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

SHORT __far __aligned pBorderVectors3[] = {
	0,0,
	68,0,
	68,31,
	0,31,
	0,0
};
struct Border __far __aligned pBorder3 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	pBorderVectors3,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct IntuiText __far __aligned pIText3 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	0,12,	/* XY origin relative to container TopLeft */
	&TOPAZ80,	/* font pointer or NULL for default */
	"Clear BD",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct Gadget __far __aligned pGadget2 = {
	&pGadget3,	/* next gadget */
	105,82,	/* origin XY of hit box relative to window TopLeft */
	67,30,	/* hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	BOOLGADGET,	/* gadget type flags */
	(APTR)&pBorder3,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	&pIText3,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	NULL,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

UBYTE __aligned pppSIBuff[4];
struct StringInfo __aligned pppSInfo = {
	pppSIBuff,	/* buffer where text will be edited */
	NULL,	/* optional undo buffer */
	0,	/* character position in buffer */
	4,	/* maximum number of characters to allow */
	0,	/* first displayed character buffer position */
	0,0,0,0,0,	/* Intuition initialized and maintained variables */
	0,	/* Rastport of gadget */
	0,	/* initial value for integer gadgets */
	NULL	/* alternate keymap (fill in if you set the flag) */
};

SHORT __far __aligned pBorderVectors4[] = {
	0,0,
	55,0,
	55,16, /* was 55,24 and 0, 24 */
	0,16,
	0,0
};
struct Border __far __aligned pBorder4 = {
	-1,-1,	/* XY origin relative to container TopLeft */
	TBLOCKPEN,0,JAM1,	/* front pen, back pen and drawmode */
	5,	/* number of XY vectors */
	pBorderVectors4,	/* pointer to XY vectors */
	NULL	/* next border in list */
};

struct Gadget __far __aligned pGadget1 = {
	&pGadget2,	/* next gadget */
	180,57,	/* origin XY of hit box relative to window TopLeft */
	54,15,	/* was 54, 23 hit box width and height */
	NULL,	/* gadget flags */
	RELVERIFY,	/* activation flags */
	STRGADGET,	/* gadget type flags */
	(APTR)&pBorder4,	/* gadget border or image to be rendered */
	NULL,	/* alternate imagery for selection */
	NULL,	/* first IntuiText structure */
	NULL,	/* gadget mutual-exclude long word */
	(APTR)&pppSInfo,	/* SpecialInfo structure */
	NULL,	/* user-definable data */
	NULL	/* pointer to user-definable data */
};

struct IntuiText __far __aligned pIText8a = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	32,44,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"use space to clr a square",	/* pointer to text */
	NULL	/* next IntuiText structure */
};

struct IntuiText __far __aligned pIText7 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	26,34,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"Bd is updated after edit session",	/* pointer to text */
	&pIText8a	/* next IntuiText structure */
};

struct IntuiText __far __aligned pIText6 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	68,62,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"Piece to add",	/* pointer to text */
	&pIText7	/* next IntuiText structure */
};

struct IntuiText __far __aligned pIText5 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	59,24,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"pa1 for pawn at a1, etc.",	/* pointer to text */
	&pIText6	/* next IntuiText structure */
};

struct IntuiText __far __aligned pIText4 = {
	TBLOCKPEN,0,JAM2,	/* front and back text pens, drawmode and fill byte */
	63,14,	/* XY origin relative to container TopLeft */
	NULL,	/* font pointer or NULL for default */
	"Enter Pieces in format",	/* pointer to text */
	&pIText5	/* next IntuiText structure */
};

struct NewWindow __far __aligned pNewWindowStructure1 = {
	170,30,	/* window XY origin relative to TopLeft of screen */
	300,220,	/* window width and height */
	0,TBLOCKPEN,	/* detail and block pens */
	GADGETUP+CLOSEWINDOW,	/* IDCMP flags */
	WINDOWCLOSE+SIMPLE_REFRESH+ACTIVATE+NOCAREREFRESH,	/* other window flags */
	&pGadget1,	/* first gadget in gadget list */
	NULL,	/* custom CHECKMARK imagery */
	"Edit Board",	/* window title */
	NULL,	/* custom screen pointer */
	NULL,	/* custom bitmap */
	5,5,	/* minimum width and height */
	0xffff,0xffff,	/* maximum width and height */
	CUSTOMSCREEN	/* destination screen type */
};

void mysprintf(char *,char *,int);
void mysprintf2(char *,char *,int,int);


void
SetTimeControl2 (color)
int color;
{
 int tmp;
 int other;

  other = color ^ 1;
  if (TCflag)
    {
      TimeControl.moves[color] = TCmoves;
      TimeControl.clock[color] += (6000L * TCminutes + TCseconds * 100);
      tmp = (TCminutes*60+TCseconds)/TCmoves;
      if (color == computer)
       {
      SecsPerMove = tmp;
      if (tmp < 10)
       {
        GlobalTgtDepth = 2;
       }
      else if (tmp < 180)
       {
        GlobalTgtDepth = 3;
       }
      else
       GlobalTgtDepth = 4;
      }
      TimeControl.moves[other] = TCmoves;
      TimeControl.clock[other] += (6000L * TCminutes + TCseconds * 100);
      tmp = (TCminutes*60+TCseconds)/TCmoves;
      if (other == computer)
       {
      SecsPerMove = tmp;
      if (tmp < 10)
       {
        GlobalTgtDepth = 2;
       }
      else if (tmp < 180)
       {
        GlobalTgtDepth = 3;
       }
      else
       GlobalTgtDepth = 4;
      }
    }
  else
    {
      TimeControl.moves[color] = 0;
      TimeControl.clock[color] = 0;
      TimeControl.moves[other] = 0;
      TimeControl.clock[other] = 0;
    }
  flag.onemove = (TCmoves == 1);
  et = 0;
  ElapsedTime (1);
}

void DoEasy()
{

    PlayMode = 0;
    BobVSprite->X = WIDTH-1-BOBWIDTH;
    BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
    LoadBobImage(BLANKDATA);
    if (SYSTEM_BOBS)
     {
      SortGList(rpG);
      DrawGList(rpG,vP);
      MakeVPort(GfxBase->ActiView,vP);
      MrgCop(GfxBase->ActiView);
      WaitTOF();
      RethinkDisplay();
     }
    NewGame();
}

void DoAdvanced()
{

    PlayMode = 2;
    BobVSprite->X = WIDTH-1-BOBWIDTH;
    BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
    LoadBobImage(BLANKDATA);
    if (SYSTEM_BOBS)
     {
      SortGList(rpG);
      DrawGList(rpG,vP);
     }
    MakeVPort(GfxBase->ActiView,vP);
    MrgCop(GfxBase->ActiView);
    WaitTOF();
    RethinkDisplay();
    NewGame();
}

void DoIntermediate()
{

    PlayMode = 1;
    BobVSprite->X = WIDTH-1-BOBWIDTH;
    BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
    LoadBobImage(BLANKDATA);
    if (SYSTEM_BOBS)
     {
      SortGList(rpG);
      DrawGList(rpG,vP);
     }
    MakeVPort(GfxBase->ActiView,vP);
    MrgCop(GfxBase->ActiView);
    WaitTOF();
    RethinkDisplay();
    NewGame();
}

void mysprintf(ostr,fstr,num)
char *ostr,*fstr;
int num;
{ // formats string "%d: xxx"

 int index;
 int thou,hun,ten,one,rem;
 

 if (num < 0) 
  {
   num = -num;
   index = 1;
   strcpy(ostr,"-");
  }
 else
  {
   index = 0;
   ostr[0] = 0;
  }
 thou = num / 1000;
 rem = num-(num / 1000)*1000;
 hun = (rem / 100);
 rem = rem-(hun * 100);
 ten = rem / 10;
 rem = rem-(ten * 10);
 one = rem;
 if (thou)
  {
   ostr[index++] = thou+'0';
  }
 if ((hun)||(thou))
  {
   ostr[index++] = hun+'0';
  }
 if ((ten)||(hun)||(thou))
  {
   ostr[index++] = ten+'0';
  }
 ostr[index++] = one+'0';
 ostr[index] = 0;
 strcat(ostr,&fstr[2]);
}

void mysprintf2(ostr,fstr,num,num2)
char *ostr,*fstr;
int num,num2;
{ // formats string "%d: xxx"

 int index;
 int thou,hun,ten,one,rem;
 

 if (num < 0) 
  {
   num = -num;
   index = 1;
   strcpy(ostr,"-");
  }
 else
  {
   index = 0;
   ostr[0] = 0;
  }
 thou = num / 1000;
 rem = num-(num / 1000)*1000;
 hun = (rem / 100);
 rem = rem-(hun * 100);
 ten = rem / 10;
 rem = rem-(ten * 10);
 one = rem;
 if (thou)
  {
   ostr[index++] = thou+'0';
  }
 if ((hun)||(thou))
  {
   ostr[index++] = hun+'0';
  }
 if ((ten)||(hun)||(thou))
  {
   ostr[index++] = ten+'0';
  }
 ostr[index++] = one+'0';
 ostr[index++] = ':';

 ten = num2 / 10;
 one = num2 % 10;
 ostr[index++] = ten+'0';
 ostr[index++] = one+'0';
 ostr[index] = 0;
 strcat(ostr,&fstr[7]);
}

void
gsrand (unsigned int seed);


void calc_pgm_rating()
{
 /* 34 secs on an RS/6000 which is about 2338, so to rate itself
    rating = 2338 - 75*(log2(time) - log2(34)) */

 int st;
 unsigned int secs;
 int rating;
 int tmpbk,Old,oldtc;
 int OldPM;
 char tstr[32],tstr2[32];

 OldPM = PlayMode;
 PlayMode = 2;
 tmpbk = Book;
 oldtc = TCflag;
 Old = MaxSearchDepth;
 NewGame ();
 UpdateDisplay (0, 0, 1, 0);
 MaxSearchDepth = 6;
 Book = 0;
 TCflag = 0;
 computer = computer ^ 1;
 opponent = opponent ^ 1;
 xwndw = (computer == white) ? WXWNDW : BXWNDW;
 flag.force = false;
 Sdepth = 0;
 ShowMessage("Calculating.");
 ShowMessage("Please wait.");
 SetPointer(wG,myPointer,PTRHEIGHT,0x10L,0L,0L);
 st = time(0L);
 SelectMove (computer, 1);
 secs = st = time(0L) - st;
 ClearPointer(wG);
 if (st<4)
  st = 4;
 st = (st - 2)/6;
 if (st > 200)
  {
   strcpy(tstr,"too slow Cannot rate");
  }
 else
  {
   if (st < 4)
    st = 4;
#ifdef PL_60
   rating = 2350 - (((75*log_e[st]) - (75*LOGE_34))/LN2);
#else /* patch level 61 */
   rating = 2350 - (((75*log_e[st]) - (75*LOGE_16))/LN2);
#endif
#ifndef _M68040 /* small mem model */
#ifdef TINYCHESS
   rating -= 41;
#else
   rating -= 21;
#endif
#endif
   rating -= 40;
   sprintf(tstr,"USCF %04d",rating);
  }
 Book = tmpbk;
 MaxSearchDepth = Old;
 TCflag = oldtc;
 PlayMode = OldPM;
 NewGame ();
 UpdateDisplay (0, 0, 1, 0);
 sprintf(tstr2," %d secs",secs);
 ShowMessage(tstr2);
 ShowMessage(tstr);
}

int DoResign()
{
 struct EasyStruct __aligned resignES = {
    sizeof (struct EasyStruct),
    0,
    "Resignation Alert",
    "Accept UChess's Resignation",
    "Yes|No",
  };

 ULONG __aligned iflags=0L;
 UBYTE	__aligned volname[4]={0,0,0,0};

 Delay(30L);
 DisplayBeep(0L);
 ResignOffered = -1;
/* return 0 if no resign accepted, yes if accepted */
 return(EasyRequest( wG, &resignES, &iflags, volname ));
}


void GetEditText(s,color)
char *s;
int *color;
{ /* gets the edit string from the user */
  /* returns # for clr bd, c for change colors and pa1 to put a pawn at a1*/
  /* YOU MUST RETURN THE STRING IN ALL LOWER CASE! */

  int dun;
  long code,class;
  int i;
  APTR object;
  struct IntuiMessage *message;

  dun = 0;
  s[0] = 0;
  pppSIBuff[0] = '\0';
  ActivateGadget(&pGadget1,wGEdit,NULL);
  do {
  WaitPort(wGEdit->UserPort);
  while(message = (struct IntuiMessage *)GetMsg(wGEdit->UserPort))
  {
   code = message->Code;
   object = message->IAddress;
   class = message->Class;
   ReplyMsg((struct Message *)message);
   if (class == CLOSEWINDOW)
    {
     strcpy(s,".");
     dun = 1;
    }
   else if (class == GADGETUP)
    { /* text */
     if (object == (APTR)&pGadget1)
      {
       if (pppSIBuff[0])
        {
         dun = 1;
         strcpy(s,pppSIBuff);
         for(i=0;i<4;i++)
          s[i] = tolower(s[i]);
        }
      }
     else if (object == (APTR)&pGadget2)
      {
       dun = 1;
       strcpy(s,"#");
      }
     else if (object == (APTR)&pGadget3)
      { /* white/black */
       if (*color == white)
        *color = black;
       else
        *color = white;
       SetDrMd(wGEdit->RPort,JAM1);
       SetAPen(wGEdit->RPort,0L);
       RectFill(wGEdit->RPort,107,124,167,145);
       if (*color == white)
        PrintIText(wGEdit->RPort,&pIText2,0L,0L); /* white label */
       else
        PrintIText(wGEdit->RPort,&pIText2a,0L,0L); /* white label */
      }
     else if (object == (APTR)&pGadget4)
      { /* done */
       strcpy(s,".");
       dun = 1;
      }
    }
  }
 } while (!dun);
 DisplayBeep(0L);
}

void CloseAmigaEditWindow()
{
 struct IntuiMessage *message;

  while(message = (struct IntuiMessage *)GetMsg(wGEdit->UserPort))
  {
   ReplyMsg((struct Message *)message);
  }
 CloseWindow(wGEdit);
// if (DEPTH >= 6)
//  {
//   SetRGB32(vP,1,tmppal[0],tmppal[1],tmppal[2]);
//  }
// else
//  {
//   SetRGB4(vP,1,((tmppal[0]>>8)&0xf),((tmppal[0]>>4)&0xf),((tmppal[0])&0xf));
//  }
}


int OpenAmigaEditWindow() /* opens a window for edit board */
 {
  if (!(wGEdit = OpenWindow(&pNewWindowStructure1)))
   {
    DisplayBeep(0L);
    return(0);
   }
// if (DEPTH >= 6)
//  {
//   tmppal[0] = BigColorPalette[4];
//   tmppal[1] = BigColorPalette[5];
//   tmppal[2] = BigColorPalette[6];
//   SetRGB32(vP,1,0xaaaaaaaa,0xaaaaaaaa,0xaaaaaaaa);
//  }
// else
 // {
 //  tmppal[0] = myPalette[1];
//   SetRGB4(vP,1,0xa,0xa,0xa);
//  }
  pppSIBuff[0] = 0;
  pppSIBuff[3] = 0;
  PrintIText(wGEdit->RPort,&pIText4,0L,0L);
  PrintIText(wGEdit->RPort,&pIText2,0L,0L); /* white label */
  return(1);
 }


void EnableMoveNow()
{
 if (MenuStripSet)
  {
   MoveNowOK = 1;
   OnMenu(wG,MOVENOWMENUNUM); 
  }
}

void DisableMoveNow()
{
 if (MenuStripSet)
  {
   MoveNowOK = 0;
   OffMenu(wG,MOVENOWMENUNUM); 
  }
}

int GetFileName(char *s)
{
 int tmp;
 struct FileRequester *myFileReq;
 struct  TagItem  Tags[2] = {
 {ASLFR_Window,0L},
 {0,0}
 };

 Tags[0].ti_Data = (ULONG)wG;
 myFileReq = AllocAslRequest(ASL_FileRequest,Tags);
 if (myFileReq)
  {
   tmp = AslRequest(myFileReq,Tags);
   if (!tmp)
    {
     FreeAslRequest(myFileReq);
     return(0);
    }
   strcpy(s,myFileReq->fr_Drawer);
   if (s[0])
    {
     if ((s[strlen(s)-1] != ':')&&(s[strlen(s)-1] != '/'))
      {
       strcat(s,"/");
      }
    }
   strcat(s,myFileReq->fr_File);
   FreeAslRequest(myFileReq);
   return(0xff);
  }
 else
  return(0);
}

int GetScreenMode()
{
 int tmp;
 struct ScreenModeRequester *myScreenReq;
 struct TagItem  Tags[4] = {
 {ASLSM_InitialDisplayID,HIRES|LACE|DEFAULT_MONITOR_ID},
 {ASLSM_InitialAutoScroll,FALSE},
 {0,0}
 };

 myScreenReq = AllocAslRequest(ASL_ScreenModeRequest,0L);
 if (myScreenReq)
  {
   tmp = AslRequest(myScreenReq,Tags);
   if (!tmp)
    {
     FreeAslRequest(myScreenReq);
     return(0);
    }
   RTG_ModeID = myScreenReq->sm_DisplayID;
   FreeAslRequest(myScreenReq);
   return(0xff);
  }
 else
  return(0);
}

void
UpdateClocks (void)
{
  char tempstr[16];
  long ycoord;
  INTSIZE ref_min,ref_sec;
  ULONG max_time;
  INTSIZE m, s;
  int score_diff;

  m = (INTSIZE) (et / 6000);
  s = (INTSIZE) (et - 6000 * (long) m) / 100;
  if (TCflag)
    {
      m = (INTSIZE) ((TimeControl.clock[player] - et) / 6000);
      s = (INTSIZE) ((TimeControl.clock[player] - et - 6000 * (long) m) / 100);
    }
  if (m < 0)
    m = 0;
  if (s < 0)
    s = 0;
  if (player == computer)
   {
    ref_min = cmptr_min;
    ref_sec = cmptr_sec;
    ycoord = TIMEYCOORD1;
   }
  else
   {
    ref_min = hum_min;
    ref_sec = hum_sec;
    ycoord = TIMEYCOORD2;
   }
  if ((ref_min != m)||(ref_sec != s))
   {
    mysprintf2(tempstr,"%d:%02d     ",m,s);
    ObtainSemaphore(&mySemaphore);
    Move(rpG,540,ycoord);
    mySetABPenDrMd(rpG,BACKGNDTEXTCOLOR,bpen,JAM1);
    RectFill(rpG,540,ycoord-6,621,ycoord+5);
    mySetABPenDrMd(rpG,BLACK,bpen,JAM1);
    Move(rpG,540,ycoord);
    Text(rpG,tempstr,strlen(tempstr));
    ReleaseSemaphore(&mySemaphore);
    if (player == computer)
     {
      score_diff = global_tmp_score - previous_score;
      cmptr_min = m;
      cmptr_sec = s;
      if (TCflag)
       {
        max_time = s + m*60;
        if ((TimeControl.moves[computer] < ((TCmoves/2)-2))&&(Sdepth > GlobalTgtDepth)&&
            (score_diff >= -55)&&(ResponseTime < 9999998)&&
            (max_time<(((TimeControl.moves[computer]-1)*SecsPerMove)>>1)))
         {//have little time available on 2nd half of game
          flag.back = true;
         }
        if ((!m)&&(s <= 1)&&(Sdepth > MINDEPTH))
         {
          flag.back = true;
         }
        if ((Sdepth > MINDEPTH)&&(!m)&&
            (s<((TimeControl.moves[player]-1)*5)))
         { // less than 1 min left on clock, less than 5 secs/move!
          flag.back = true;
         }
      }
//printf("prev score = %d  global_tmp_score = %d\n",previous_score,global_tmp_score);
//printf("score_diff = %d  Sdepth = %d GlobalTgtDepth = %d\n",score_diff,Sdepth,GlobalTgtDepth);
      if (((score_diff > -16))&&(Sdepth > GlobalTgtDepth)
          &&(OrigResponse > 2500)&&(global_tmp_score > -55))
       { // more than 25 secs/move and am not losing by too much
        ycoord = OrigResponse >> 1;
        if (ycoord > 3101)
         ycoord = 3101;
        max_time = OrigResponse + ycoord; // 1.5Xorig OR orig + 31 whichver is smaller
//printf("max time = %lu et = %lu\n",max_time,et);
       }
      else if (Sdepth > (GlobalTgtDepth))
       max_time = (OrigResponse<<1) + ExtraTime + 101;
      else
       max_time = ((OrigResponse<<1) + ExtraTime + OrigResponse);
      if ((TCflag) && (!trying_again) && (ResponseTime < 9999998) && (Sdepth > MINDEPTH)
          && ((et) >= max_time))
       {
//printf("Considering the move!\n");
        if (score_diff >= -75)
          {
           flag.back = true;
          }
       } 
     }
    else // human player
     {
      hum_min = m;
      hum_sec = s;
     }
   } // 1 sec or more has elapsed
}


char DisplayPromoteRequestor(void);

char DisplayPromoteRequestor()
{
// ULONG tmp[4];
 int dun;
 struct IntuiMessage __aligned *message;
 struct Window __aligned *wG3;
 UWORD __aligned code;
 ULONG __aligned class;
 APTR object;
 char retchar='q';

// if (DEPTH >= 6)
//  {
//   tmp[0] = BigColorPalette[4];
//   tmp[1] = BigColorPalette[5];
//   tmp[2] = BigColorPalette[6];
//   SetRGB32(vP,1,0xaaaaaaaa,0xaaaaaaaa,0xaaaaaaaa);
// }
// else
//  {
//   tmp[0] = myPalette[1];
//   SetRGB4(vP,1,0xa,0xa,0xa);
//  }
 if (!(wG3 = OpenWindow(&NewWindowStructure6)))
 {
  DisplayBeep(0L);
  return('q');
 }
 PrintIText(wG3->RPort,&aIText5,0L,0L);
 dun = 0;
 do {
 WaitPort(wG3->UserPort);
 while(message = (struct IntuiMessage *)GetMsg(wG3->UserPort))
  {
   code = message->Code;
   object = message->IAddress;
   class = message->Class;
   ReplyMsg((struct Message *)message);
   dun = 1;
   if (object == (APTR)&aGadget1)
      {
       retchar = 'q';
      }
    else if (object == (APTR)&aGadget2)
      {
       retchar = 'r';
      }
    else if (object == (APTR)&aGadget3)
      {
       retchar = 'b';
      }
    else if (object == (APTR)&aGadget4)
      {
       retchar = 'n';
      }
  }
 } while (!dun);
 CloseWindow(wG3);
// if (DEPTH >= 6)
//  {
//   SetRGB32(vP,1,tmp[0],tmp[1],tmp[2]);
//  }
// else
 // {
 //  SetRGB4(vP,1,((tmp[0]>>8)&0xf),((tmp[0]>>4)&0xf),((tmp[0])&0xf));
//  }
 return(retchar);
}

void tFreeBitMap(struct BitMap *);
void sFreeBitMap(struct BitMap *);
struct BitMap *tAllocBitMap(int,int,int,int,struct BitMap *);
struct BitMap *sAllocBitMap(int,int,int,int,struct BitMap *);

struct BitMap *tAllocBitMap(wid,ht,depth,flags,friend)
int wid,ht,depth,flags;
struct BitMap *friend;
{
 int i;
 unsigned long tt;
 LONG image_data;
 ULONG planes;
 struct BitMap *tmp;

 if (gfxversion < 39)
  {
   planes = RASSIZE(wid,ht);
   if (!(tmp = AllocMem(sizeof (struct BitMap),MEMF_CLEAR)))
    {
     return(0);
    }
   InitBitMap(tmp,depth,wid,ht);
   tt = planes*depth;
   if (!(tmp->Planes[0] = AllocMem(tt,MEMF_CHIP|MEMF_CLEAR)))
    {
     FreeMem(tmp,sizeof(struct BitMap));
     return(0);
    }
   image_data = (LONG)tmp->Planes[0];
   for(i=1;i<depth;i++)
    {
     tmp->Planes[i] = (PLANEPTR) (image_data + i * planes);
    }
  }
 else
  {
   tmp = AllocBitMap(wid,ht,depth,flags,friend);
  }
 return(tmp);
}

struct BitMap *sAllocBitMap(wid,ht,depth,flags,friend)
int wid,ht,depth,flags;
struct BitMap *friend;
{
 int i;
 unsigned long tt;
 ULONG image_data;
 ULONG planes;
 struct BitMap *tmp;


 if (!(tmp = AllocMem(sizeof (struct BitMap),MEMF_CLEAR)))
  {
   return(0);
  }
 InitBitMap(tmp,8,640,480);
 planes = RASSIZE(640,480);
 tmp->BytesPerRow = 640;
 tmp->Flags = 0x0;
 tmp->Rows = 480;
 tmp->Depth = 8;
 tmp->pad = 32860;
 tt = planes*8;
 if (!(tmp->Planes[0] = AllocMem(tt,MEMF_CHIP|MEMF_CLEAR)))
  {
   FreeMem(tmp,sizeof(struct BitMap));
   return(0);
  }
 image_data = (ULONG)tmp->Planes[0];
 planes = 0x50;
 for(i=1;i<depth;i++)
  {
   tmp->Planes[i] = (PLANEPTR) (image_data + i * planes);
  }
 return(tmp);
}

void tFreeBitMap(bmap)
struct BitMap *bmap;
{
 ULONG numbytes;

 if (gfxversion < 39)
  {
   numbytes = bmap->Rows*bmap->BytesPerRow*bmap->Depth;
   FreeMem(bmap->Planes[0],numbytes);
   FreeMem(bmap,sizeof(struct BitMap));
  }
 else
  {
   FreeBitMap(bmap);
  }
}

void sFreeBitMap(bmap)
struct BitMap *bmap;
{
 ULONG numbytes,planes;

  planes = RASSIZE(640,480);
  numbytes = planes*8;
  FreeMem(bmap->Planes[0],numbytes);
  FreeMem(bmap,sizeof(struct BitMap));
}


int HandleEvent(object)
APTR object;
{
 int tmpdone=0;
 UWORD nextcode;
 struct MenuItem *myMenuItem;

 do {
  if (!RealThink)
   {
    if (object == (APTR)&MenuItem15) { DoQuit();return(1); }
    if (object == (APTR)&MenuItem1) { DoHint(); }
    if (object == (APTR)&MenuItem12) { DoAbout(); }
    //if (object == (APTR)&MenuItem6) { }
    if (object == (APTR)&MenuItem13) { LoadAGame(); }
    if (object == (APTR)&MenuItem14) { SaveAGame(); }
    if (object == (APTR)&MenuItem14a) { ListAGame();  }
    if (object == (APTR)&MenuItem9) { Go2D(); }
    if (object == (APTR)&MenuItem10) { EditBoard(); }
    if (object == (APTR)&MenuItem11) { DoReverse(); }
    if (object == (APTR)&MenuItem4) { DoSwap();  }
    if (object == (APTR)&MenuItem5) { DoAutoPlay(); }
    if (object == (APTR)&MenuItem7) { TakeBack();  }
    if (object == (APTR)&MenuItem8) { DoThinking();  }
    if (object == (APTR)&MenuItem8a) { DoShwThnk();  }
    if (object == (APTR)&MenuItem8aa) { DoSuper(); }
    if (object == (APTR)&MenuItem8ab) { DoBookToggle(); }
    if (object == (APTR)&MenuItem8ee) {strcpy(OpEntryStr,"advan");tmpdone = 1;}
    if (object == (APTR)&MenuItem8dd) {strcpy(OpEntryStr,"interm");tmpdone = 1;}
    if (object == (APTR)&MenuItem8cc) {strcpy(OpEntryStr,"easy");tmpdone = 1;}
    if (object == (APTR)&MenuItem2) { DoTest();  }
    if (object == (APTR)&MenuItem3) { SetTime(); }
    if (object == (APTR)&MenuItem3x) { strcpy(OpEntryStr,"calc");tmpdone = 1;}
    if (object == (APTR)&MenuItem3r) { ChangeSearchDepth();}
    if (object == (APTR)&MenuItem28) 
     {
#ifndef OLDNEW
      tmpdone = 1;
      strcpy(OpEntryStr,"new");
#else
      BobVSprite->X = WIDTH-1-BOBWIDTH;
      BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
      LoadBobImage(BLANKDATA);
      if (SYSTEM_BOBS)
       {
        SortGList(rpG);
        DrawGList(rpG,vP);
       }
      MakeVPort(GfxBase->ActiView,vP);
      MrgCop(GfxBase->ActiView);
      WaitTOF();
      RethinkDisplay();
      NewGame();
#endif
     }
   } // !RealThink
  else
   { // realthink
    if (object == (APTR)&MenuItem15) {MoveNow();while (RealThink) Delay(20L);DoQuit();return(1);}
    if (object == (APTR)&MenuItem6) { MoveNow();  }
    if (object == (APTR)&MenuItem8ab) { DoBookToggle(); }
    if (object == (APTR)&MenuItem8) { DoThinking();  }
    if (object == (APTR)&MenuItem8aa) { MoveNow();while (RealThink) Delay(20L);DoSuper(); }
    if (object == (APTR)&MenuItem8a) { DoShwThnk();  }
    if (object == (APTR)&MenuItem8ee) {MoveNow();while (RealThink) Delay(20L);strcpy(OpEntryStr,"advan");tmpdone = 1;}
    if (object == (APTR)&MenuItem8dd) {MoveNow();while (RealThink) Delay(20L);strcpy(OpEntryStr,"interm");tmpdone = 1;}
    if (object == (APTR)&MenuItem8cc) {MoveNow();Delay(50L);strcpy(OpEntryStr,"easy");tmpdone = 1;}
   }
  myMenuItem = (struct MenuItem *)object;
  nextcode = myMenuItem->NextSelect;
  if (nextcode != MENUNULL)
   {
    object = (APTR)ItemAddress(&MenuList1,nextcode);
   }
  } while (nextcode != MENUNULL);
 return(tmpdone);
}


void DoAbout()
{
 int done=0;
 struct IntuiMessage __aligned *message;
 struct Window __aligned *wG3;
 ULONG class,code;

 if (!(wG3 = OpenWindow(&NewWindowStructure2)))
 {
  DisplayBeep(0L);
  return;
 }
 PrintIText(wG3->RPort,&IText17,0L,0L);
 do {
  WaitPort(wG3->UserPort);
  while(message = (struct IntuiMessage *)GetMsg(wG3->UserPort))
   {
    class = message->Class;
    code = message->Code;
    ReplyMsg((struct Message *)message);
    if (class == GADGETUP)
     done = 1;
    else if (class == VANILLAKEY)
     {
      if ((code == 13)||(code == 10))
       done = 1;
     }
   }
 } while (!done);
 CloseWindow(wG3);
}


void LoadAGame(void)
{
// strcpy(OpEntryStr,"get");
 if (thinkahead)
   {
    flag.back = true;
    while (thinkahead)
     {
      Delay(20L);
     }
   }
 GetGame();
}

void SaveAGame(void)
{
// strcpy(OpEntryStr,"save");
 if (thinkahead)
   {
    flag.back = true;
    while (thinkahead)
     {
      Delay(20L);
     }
   }
 SaveGame();
}

void ListAGame(void)
{
 if (thinkahead)
   {
    flag.back = true;
    while (thinkahead)
     {
      Delay(20L);
     }
   }
 ListGame(0xff);
}

void DoQuit(void)
{
 flag.quit = true;
}

void Go2D(void)
{
}

void DoReverse(void)
{
}

void DoSwap(void)
{
 doswap = 1;
}

void DoAutoPlay(void)
{
 hint = 0;
 SetPointer(wG,myPointer,PTRHEIGHT,0x10L,0L,0L);
 doauto = 1;
}

void MoveNow(void)
{
 if ((RealThink))
  {
   if (!flag.timeout)
    {
     flag.back = true;
     flag.musttimeout = true;
    }
   flag.bothsides = false;
  }
}

void TakeBack(void)
{
 char mvnstr[16];
 int currpiece;
 long tmp1,tmp2;
 int r,c,l;


 if (thinkahead)
  {
   flag.back = true;
   do {
    Delay(20L);
   } while(thinkahead);
  }
 MoveMem128(amigaboard,board);
 MoveMem128(amigacolor,color);
 doundo = 1;
 hint = 0;
 if (GameCnt <= 0)
  return;
 for (r = 7; r >= 0; r--)
  {
   for (c = 0; c <= 7; c++)
    {
      l = ((flag.reverse) ? locn (7 - r, 7 - c) : locn (r, c));
      if (amigacolor[l] == neutral)
	oldboard[r][c] = ' ';
      else if (amigacolor[l] == white)
	oldboard[r][c] = qxx[amigaboard[l]];
      else
	oldboard[r][c] = pxx[amigaboard[l]];
    }
  }
 BobVSprite->X = WIDTH-1-BOBWIDTH;
 BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
 LoadBobImage(BLANKDATA);
 if (SYSTEM_BOBS)
  {
   SortGList(rpG);
   DrawGList(rpG,vP);
  }
 Undo();
 for (r = 7; r >= 0; r--)
    {
     for (c = 0; c <= 7; c++)
      {
        l = ((flag.reverse) ? locn (7 - r, 7 - c) : locn (r, c));
        if ((color[l] == neutral)&&(oldboard[r][c] != ' '))
         {
	  tmp1 = r & 1L;
          tmp2 = c & 1L;
          if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
           {
            BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[c],
			RowArray[r],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
           }
          else
           {
            BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[c],
			RowArray[r],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
           }
         }
        else
         {
          if (color[l] == white)
	   currpiece = qxx[board[l]];
          else
	   currpiece = pxx[board[l]];
          if (currpiece != oldboard[r][c])
           {
	    tmp1 = r & 1L;
            tmp2 = c & 1L;
            if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
             {
              BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[c],
				RowArray[r],SQUAREWIDTH,SQUAREHEIGHT,
				0xc0L,0xffL,0L);
             }
            else
             {
              BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[c],
				RowArray[r],SQUAREWIDTH,SQUAREHEIGHT,
				0xc0L,0xffL,0L);
             }
	    LoadBobImage(currpiece);
            ClipBlitTrans (
		&(BobTransImage->ti_RP),	/* Source RastPort */
	     	0, 0,		/* Source LeftEdge, TopEdge */
	     	rpG,		/* Destination RastPort */
	     	ColArray[c],RowArray[r],/* Destination LeftEdge, TopEdge */
	     	BobTransImage->ti_IM->Width,	/* Width of Image */
	     	BobTransImage->ti_IM->Height,/* Height of Image */
	     	BobTransImage->ti_sRP);	/* Shadow RastPort */
            BobVSprite->X = WIDTH-1-BOBWIDTH;
            BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
            LoadBobImage(BLANKDATA);
            if (SYSTEM_BOBS)
             {
              SortGList(rpG);
              DrawGList(rpG,vP);
             }
           }
         }
      }
    }
 BobVSprite->X = WIDTH-1-BOBWIDTH;
 BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
 LoadBobImage(BLANKDATA);
 if (SYSTEM_BOBS)
  {
   SortGList(rpG);
   DrawGList(rpG,vP);
  }
 if (computer != black)
  mysprintf(mvnstr,"%d: ",(GameCnt+1)>>1);
 else
  mysprintf(mvnstr,"%d: ",(GameCnt+2)>>1);
 ObtainSemaphore(&mySemaphore);
 mySetABPenDrMd(rpG,BACKGNDTEXTCOLOR,bpen,JAM1);
 RectFill(rpG,520,USERBOX,621,USERBOX+30);
 Move(rpG,520,USERBOX+6);
 mySetABPenDrMd(rpG,BLACK,bpen,JAM1);
 Text(rpG,mvnstr,strlen(mvnstr));
 ReleaseSemaphore(&mySemaphore);
}

void DoThinking(void)
{
 flag.easy = !flag.easy;
}

void DoShwThnk(void)
{
 flag.post = !flag.post;
}

void DoSuper(void)
{
 SupervisorMode = !SupervisorMode;
}

void DoBookToggle(void)
{
	Book = Book ? 0 : BOOKFAIL;
        bookflag = Book;
}

void DoHint(void)
{
 GiveHint();
}

void DoTest(void)
{
 teston = 1;
}

int SetAmigaDepth()
{
 int dun;
 struct IntuiMessage __aligned *message;
 struct Window __aligned *wG3;
 UWORD __aligned code;
 ULONG __aligned class;
 APTR object;
// ULONG tmp[3];

// if (DEPTH >= 6)
//  {
//   tmp[0] = BigColorPalette[4];
//   tmp[1] = BigColorPalette[5];
//   tmp[2] = BigColorPalette[6];
//   SetRGB32(vP,1,0xaaaaaaaa,0xaaaaaaaa,0xaaaaaaaa);
//  }
// else
//  {
//   tmp[0] = myPalette[1];
//   SetRGB4(vP,1,0xa,0xa,0xa);
//  }
 mysprintf(Gadget6SIBuff,"%d",MaxSearchDepth);
 NewWindowStructure5.FirstGadget = &Gadget6b;
 if (!(wG3 = OpenWindow(&NewWindowStructure5)))
 {
  DisplayBeep(0L);
  return(0);
 }
 Move(wG3->RPort,66,39);
 Text(wG3->RPort,"Depth",5);
 ActivateGadget(&Gadget6,wG3,NULL);
 dun = 0;
 do {
 WaitPort(wG3->UserPort);
 while(message = (struct IntuiMessage *)GetMsg(wG3->UserPort))
  {
   code = message->Code;
   object = message->IAddress;
   class = message->Class;
   ReplyMsg((struct Message *)message);
#ifdef SELECTIVEBB
   if (object != (APTR)&Gadget6b)
      {
       dun = 1;
      }
#else
   dun = 1;
#endif
  }
 } while (!dun);
 CloseWindow(wG3);
// if (DEPTH >= 6)
//  {
//   SetRGB32(vP,1,tmp[0],tmp[1],tmp[2]);
//  }
// else
//  {
//   SetRGB4(vP,1,((tmp[0]>>8)&0xf),((tmp[0]>>4)&0xf),((tmp[0])&0xf));
//  }
 dun = atoi(Gadget6SIBuff);
 if (dun > (MAXDEPTH-1))
  dun = MAXDEPTH -1;
 if (dun < MINDEPTH)
  dun = MINDEPTH;
 NewWindowStructure5.FirstGadget = &Gadget6;
 return(dun);
}

void SetTime(void)
{
 int dun;
 char str[128];
 struct IntuiMessage __aligned *message;
 struct Window __aligned *wG3;
 UWORD __aligned code;
 ULONG __aligned class;
 APTR object;
// ULONG tmp[3];
 struct Gadget *tg;

// if (DEPTH >= 6)
//  {
//   tmp[0] = BigColorPalette[4];
//   tmp[1] = BigColorPalette[5];
//   tmp[2] = BigColorPalette[6];
//   SetRGB32(vP,1,0xaaaaaaaa,0xaaaaaaaa,0xaaaaaaaa);
//  }
 //else
//  {
//   tmp[0] = myPalette[1];
//   SetRGB4(vP,1,0xa,0xa,0xa);
//  }
 mysprintf(Gadget6SIBuff,"%d",TCmoves);
 mysprintf(Gadget8SIBuff,"%d",(TCminutes));
 if (!(wG3 = OpenWindow(&NewWindowStructure5)))
 {
  DisplayBeep(0L);
  return;
 }
 PrintIText(wG3->RPort,&IText46,0L,0L);
 ActivateGadget(&Gadget6,wG3,NULL);
 dun = 0;
 do {
 WaitPort(wG3->UserPort);
 while(message = (struct IntuiMessage *)GetMsg(wG3->UserPort))
  {
   code = message->Code;
   object = message->IAddress;
   class = message->Class;
   ReplyMsg((struct Message *)message);
   if (object != (APTR)&Gadget9)
      {
       if (object == (APTR)&Gadget6)
        {
         tg = &Gadget8;
         ActivateGadget(tg,wG3,NULL);
        }
       else if (object == (APTR)&Gadget8)
        dun = 1;
      }
     else
      {
       dun = 1;
      }
  }
 } while (!dun);
 CloseWindow(wG3);
// if (DEPTH >= 6)
//  {
//   SetRGB32(vP,1,tmp[0],tmp[1],tmp[2]);
//  }
// else
//  {
//   SetRGB4(vP,1,((tmp[0]>>8)&0xf),((tmp[0]>>4)&0xf),((tmp[0])&0xf));
//  }
 strcpy(str,Gadget6SIBuff);
 strcat (str," ");
 strcat(str,Gadget8SIBuff);
 SelectLevel(str);
 et = 0;
 dun = player;
 player = white;
 UpdateClocks();
 player = black;
 UpdateClocks();
 player = dun;
}



void DisplayError(str)
char *str;
{
 struct IntuiMessage __aligned *message;
 struct Window __aligned *wG3;
 char __aligned c2;
 char __aligned helpstr[64];
 BPTR __aligned mywindow;
 long __aligned temp;

 DisplayBeep(0L);
 if (wG)
  {
   if (!(wG3 = OpenWindow(&NewWindowStructure2)))
   {
    DisplayBeep(0L);
    return;
   }
   Move(wG3->RPort,2,25);
   Text(wG3->RPort,str,strlen(str));
   WaitPort(wG3->UserPort);
   while(message = (struct IntuiMessage *)GetMsg(wG3->UserPort))
    ReplyMsg((struct Message *)message);
   CloseWindow(wG3);
  }
 else
  { // open on wb screen
   (void)WBenchToFront();
   strcpy(helpstr,"RAW:120/10/400/100/Program Error");
   if (!(mywindow = Open(helpstr,MODE_NEWFILE)))
    {
     DisplayBeep(0L);
     return;
    }
   strcat(str,"\n\n\n");
   temp = strlen(str);
   if (Write(mywindow,str,temp) != temp)
    {
      DisplayBeep(0L);
      Close(mywindow);
      return;
    }
   strcpy(helpstr,"      Press any key to continue...");
   temp = strlen(helpstr);
   if (Write(mywindow,helpstr,temp) != temp)
    {
      DisplayBeep(0L);
      Close(mywindow);
      return;
    }
   Read(mywindow,&c2,1L);
   Close(mywindow);
  }
}

struct Library *LhBase;
struct LhBuffer *myLHBuffer;

int LoadBobData(void);
void FreeBobData(void);
int InitmyGels(void);
void CloseGels(void);


void LoadBobImage(piece)
long piece; /* loads bob with pieces image */
{
 int i;
 UWORD *temp;
 LONG image_data;
 WORD planes = RASSIZE (BOBWIDTH, BOBHEIGHT);
 
 if (piece == BLANKDATA)
  {
   temp = BlankImageData;
  }
 else if (piece >= 'a') /* white pieces */
  {
   if (piece == 'p')
    temp = WhiteImageData[0];
   else if (piece == 'n')
    temp = WhiteImageData[1];
   else if (piece == 'b')
    temp = WhiteImageData[2];
   else if (piece == 'r')
    temp = WhiteImageData[3];
   else if (piece == 'q')
    temp = WhiteImageData[4];
   else if (piece == 'k')
    temp = WhiteImageData[5];
  }
 else /* black pieces */
  {
   if (piece == 'P')
    temp = BlackImageData[0];
   else if (piece == 'N')
    temp = BlackImageData[1];
   else if (piece == 'B')
    temp = BlackImageData[2];
   else if (piece == 'R')
    temp = BlackImageData[3];
   else if (piece == 'Q')
    temp = BlackImageData[4];
   else if (piece == 'K')
    temp = BlackImageData[5];
  }
 BobImage.ImageData = BobVSprite->ImageData = temp;
 image_data = (LONG) BobImage.ImageData;
 /* Map the image data to planes */
 for (i = 0L; i < BOBDEPTH; ++i)
  BobTransImage->ti_BM.Planes[i] = (PLANEPTR) (image_data + i * planes);
 temp += (BOBHEIGHT*BOBDEPTH*BOBWIDINW);
 TheBob->ImageShadow = BobVSprite->CollMask = temp;
 temp += ((BOBHEIGHT+2)*BOBWIDINW);
 BobVSprite->BorderLine = temp;
 BobImage.ImageData = BobVSprite->ImageData;
 BobTransImage->ti_sBM->Planes[0] = (char *)TheBob->ImageShadow;
 for (i = 1; i < BOBDEPTH; i++)
   BobTransImage->ti_sBM->Planes[i] = BobTransImage->ti_sBM->Planes[0];
 lastpiece = piece;
}

int LoadBobData()
{
 USHORT __aligned len;
 long __aligned templong;
 BPTR fh;
 UBYTE *srcbuf;
 int i;

 if (!(srcbuf = AllocMem(BOBBLOCKSIZE,0L)))
  {
   return(0);
  }
 if (DEPTH < 6)
  {
   if (!(fh = Open("uchess:Pieces.lzw",MODE_OLDFILE)))
    {
    return(0);
   }
  }
 else if (FasterDisplay)
  {
   if (!(fh = Open("uchess:Pieces64.lzw",MODE_OLDFILE)))
    {
    return(0);
   }
  }
 else
  {
   if (!(fh = Open("uchess:Pieces256.lzw",MODE_OLDFILE)))
    {
    return(0);
   }
  }
 if (!(LhBase = OpenLibrary(LH_NAME,LH_VERSION)))
  {
   DisplayError("Cannot open lh.lib\n");
   return(0);
  }
 if (!(myLHBuffer = CreateBuffer(TRUE))) /* small buffer for only decomp*/
  {
   DisplayError("Cannot Create Buffer\n");
   CloseLibrary(LhBase);
   return(0);
  }
 for(i=0;i<6;i++)
  {
   if (Read(fh,(char *)&len,2L) != 2L)
    {
     Close(fh);
     return(0);
    }
   templong = len;
   if (Read(fh,srcbuf,templong) != templong)
    {
     Close(fh);
     return(0);
    }
   if (!(WhiteImageData[i] = 
        (UWORD *)AllocMem(BOBBLOCKSIZE,MEMF_CHIP|MEMF_CLEAR)))
    {
     return(0);
    }
   LoadBobImage(piecechar[i]);
   myLHBuffer->lh_Src = (APTR)srcbuf;
   myLHBuffer->lh_Dst = (APTR)BobVSprite->ImageData;
   myLHBuffer->lh_SrcSize = templong;
   myLHBuffer->lh_DstSize = BOBBLOCKSIZE;
   LhDecode(myLHBuffer);
   InitMasks(BobVSprite);
   if (Read(fh,(char *)&len,2L) != 2L)
    {
     Close(fh);
     return(0);
    }
   templong = len;
   if (Read(fh,srcbuf,templong) != templong)
    {
     Close(fh);
     return(0);
    }
   if (!(BlackImageData[i] = 
        (UWORD *)AllocMem(BOBBLOCKSIZE,MEMF_CHIP|MEMF_CLEAR)))
    {
     return(0);
    }
   LoadBobImage(piecechar[i+6]);
   myLHBuffer->lh_Src = (APTR)srcbuf;
   myLHBuffer->lh_Dst = (APTR)BobVSprite->ImageData;
   myLHBuffer->lh_SrcSize = templong;
   myLHBuffer->lh_DstSize = BOBBLOCKSIZE;
   LhDecode(myLHBuffer);
   InitMasks(BobVSprite);
  }
 Close(fh);
 FreeMem(srcbuf,BOBBLOCKSIZE);
 DeleteBuffer(myLHBuffer);
 CloseLibrary(LhBase);
 LoadBobImage(BLANKDATA);
 return(1);
}

void FreeBobData()
{
 int i;
 
 for(i=0;i<6;i++)
  {
   FreeMem((char *)WhiteImageData[i],BOBBLOCKSIZE);
   FreeMem((char *)BlackImageData[i],BOBBLOCKSIZE);
  }
 FreeMem((char *)BlankImageData,BOBBLOCKSIZE);
}

int InitmyGels()
{

#ifdef EXTRAINIT
 struct BitMap __aligned tmpBitMap;
#endif
 int i;
 UWORD *temp;

 if (!(SpriteHead = (struct VSprite *)
       AllocMem(sizeof(struct VSprite),MEMF_PUBLIC|MEMF_CLEAR)))
  {
   return(0);
  }
 if (!(SpriteTail = (struct VSprite *)
       AllocMem(sizeof(struct VSprite),MEMF_PUBLIC|MEMF_CLEAR)))
  {
   return(0);
  }
 if (!(BobVSprite = (struct VSprite *)
       AllocMem(sizeof(struct VSprite),MEMF_PUBLIC|MEMF_CLEAR)))
  {
   return(0);
  }
 if (!(TheBob = (struct Bob *)
       AllocMem(sizeof(struct Bob),MEMF_PUBLIC|MEMF_CLEAR)))
  {
   return(0);
  }
 if (!(myGelsInfo = (struct GelsInfo *)
       AllocMem(sizeof(struct GelsInfo),MEMF_PUBLIC|MEMF_CLEAR)))
  {
   return(0);
  }
 if (!(myGelsInfo->nextLine = (WORD *)AllocMem(sizeof(WORD)*32,
    MEMF_PUBLIC|MEMF_CLEAR)))
  {
   return(0);
  }
 if (!(myGelsInfo->lastColor = (WORD **)AllocMem(sizeof(WORD)*32,
    MEMF_PUBLIC|MEMF_CLEAR)))
  {
   return(0);
  }
 if (!(myGelsInfo->collHandler = (struct collTable *)
    AllocMem(sizeof(struct collTable),MEMF_PUBLIC|MEMF_CLEAR)))
  {
   return(0);
  }
 if (!(TheBob->SaveBuffer = (WORD *)
    AllocMem(sizeof(SHORT)*BOBWIDINW*BOBHEIGHT*BOBDEPTH,MEMF_CHIP|MEMF_CLEAR)))
  {
   return(0);
  }
 if (!(temp = BobVSprite->ImageData = 
        (UWORD *)AllocMem(BOBBLOCKSIZE,MEMF_CHIP|MEMF_CLEAR)))
    {
     return(0);
    }
 BlankImageData = temp;
 temp += (BOBHEIGHT*BOBDEPTH*BOBWIDINW);
 TheBob->ImageShadow = BobVSprite->CollMask = temp;
 temp += ((BOBHEIGHT+2)*BOBWIDINW);
 BobVSprite->BorderLine = temp;
#ifdef DBL_BUFF
 if (!(TheBob->DBuffer = (struct DBufPacket *)AllocMem
        (sizeof(struct DBufPacket),MEMF_CHIP|MEMF_CLEAR)))
    {
     return(0);
    }
 if (!(TheBob->DBuffer->BufBuffer = 
       (WORD *)AllocRaster(BOBWIDTH,BOBHEIGHT*BOBDEPTH)))
  {
     return(0);
  }
#endif

 BOBPLANEPICK = 1;
 for(i=0;i<DEPTH;i++)
  {
   BOBPLANEPICK *= 2;
  }
 BOBPLANEPICK--;
 BobImage.LeftEdge = 0;
 BobImage.TopEdge = 0;
 BobImage.Width = BOBWIDTH;
 BobImage.Height = BOBHEIGHT;
 BobImage.Depth = BOBDEPTH; 
 BobImage.ImageData = BobVSprite->ImageData;
 BobImage.PlanePick = BOBPLANEPICK;
 BobImage.PlaneOnOff = BOBPLANEONOFF;
 BobImage.NextImage = NULL;
 if (!(BobTransImage = AllocTransImage(&BobImage)))
  {
   return(0);
  }
 
 if (SYSTEM_BOBS)
  {
   myGelsInfo->leftmost = COLA;
   myGelsInfo->rightmost = COLH+BOBWIDTH+1;
   myGelsInfo->topmost = ROW8;
   myGelsInfo->bottommost = ROW1+BOBHEIGHT+1; 
   rpG->GelsInfo = myGelsInfo;
   InitGels((struct VSprite *)SpriteHead,SpriteTail,myGelsInfo);
   WaitTOF();
  }
 BobVSprite->Flags = SAVEBACK | OVERLAY;
 BobVSprite->X = WIDTH-1-BOBWIDTH;
 BobVSprite->Y = HEIGHT-1-BOBHEIGHT;  
 BobVSprite->Height = BOBHEIGHT;
 BobVSprite->Width = BOBWIDINW;
 BobVSprite->Depth = BOBDEPTH;
 BobVSprite->MeMask = BOBMEMASK;
 BobVSprite->HitMask = BOBHITMASK;
 BobVSprite->VSBob = TheBob;
 BobVSprite->PlanePick = BOBPLANEPICK;
 BobVSprite->PlaneOnOff = BOBPLANEONOFF;  
 BobVSprite->VUserExt = 0;
 TheBob->BobVSprite = BobVSprite;

 if (!LoadBobData())
  {
   DisplayError("Cannot Load BOB data\n");
   //CloseWindow(wG);
   CloseScreen(sC);
  }


 InitMasks(BobVSprite);
 return(1);
}

void CloseGels()
{
     FreeBobData();
   
#ifdef DBL_BUFF
   FreeRaster((PLANEPTR)TheBob->DBuffer->BufBuffer,BOBWIDTH,BOBHEIGHT*BOBDEPTH);
   FreeMem((char *)TheBob->DBuffer,sizeof(struct DBufPacket));
#endif
   FreeTransImage(BobTransImage);
   FreeMem((char *)TheBob->SaveBuffer,
     sizeof(SHORT)*BOBWIDINW*BOBHEIGHT*BOBDEPTH);
   FreeMem((char *)myGelsInfo->collHandler,sizeof(struct collTable));
   FreeMem((char *)myGelsInfo->lastColor,sizeof(WORD)*32);
   FreeMem((char *)myGelsInfo->nextLine,sizeof(WORD)*32);
   FreeMem((char *)myGelsInfo,sizeof(struct GelsInfo));
   FreeMem((char *)TheBob,sizeof(struct Bob));
   FreeMem((char *)BobVSprite,sizeof(struct VSprite));
   FreeMem((char *)SpriteTail,sizeof(struct VSprite));
   FreeMem((char *)SpriteHead,sizeof(struct VSprite));
}

struct TransImage *
AllocTransImage (struct Image * im)
{
    if (im)
    {
	LONG msize = sizeof (struct TransImage);
	struct TransImage *ti;

	if (ti = (struct TransImage *) AllocMem (msize, MEMF_CLEAR))
	{
	    LONG image_data = (LONG) im->ImageData;
	    UWORD depth = im->Depth;
	    UWORD width = im->Width;
	    UWORD height = im->Height;
	    WORD planes = RASSIZE (width, height);
	    WORD i;

	    /* Remember the image */
	    ti->ti_IM = im;

	    /* Initialize the Image bitmap */
	    InitBitMap (&ti->ti_BM, depth, width, height);

	    /* Map the image data to planes */
	    for (i = 0L; i < depth; ++i)
		ti->ti_BM.Planes[i] = (PLANEPTR) (image_data + i * planes);

	    /* Initialize the Image rastport */
	    InitRastPort (&ti->ti_RP);
	    ti->ti_RP.BitMap = &ti->ti_BM;

	    if (ti->ti_sBM = AllocShadowBM (depth, width, height))
	    {
		if (ti->ti_sRP = AllocShadowRP (ti->ti_sBM))
		{
		    return (ti);
		}
		FreeShadowBM (ti->ti_sBM);
	    }
	    FreeMem ((APTR) ti, msize);
	}
    }

    return (NULL);
}

VOID
FreeTransImage (struct TransImage * ti)
{

    if (ti)
    {
	LONG msize = sizeof (struct TransImage);

	/* Free the shadow RastPort */
	FreeShadowRP (ti->ti_sRP);

	/* Free the shadow BitMap */
	FreeShadowBM (ti->ti_sBM);

	/* Free the temporary buffer */
	FreeMem ((APTR) ti, msize);
    }
}

VOID
FreeShadowBM (struct BitMap *sbm)
{

    if (sbm)
    {

#ifdef ALLOCFORREAL
	LONG msize;

	msize = RASSIZE (8 * (sbm->BytesPerRow), sbm->Rows);



	if (sbm->Planes[0])
	{
	    FreeMem ((APTR)sbm->Planes[0], msize);
	}
#else

	FreeMem ((APTR)sbm, sizeof (struct BitMap));
#endif
    }
}

VOID
FreeShadowRP (struct RastPort *srp)
{

    if (srp)
    {
	FreeMem (srp, sizeof (struct RastPort));
    }
}

struct BitMap *
AllocShadowBM (UWORD depth, UWORD width, UWORD height)
{
    LONG msize = sizeof (struct BitMap);
    struct BitMap *bm;
    WORD i;

    /* Allocate a bitmap */
    if (bm = (struct BitMap *) AllocMem (msize, MEMF_CLEAR))
    {
#ifdef ALLOCFORREAL
	LONG rsize = RASSIZE (width, height);
#endif

	/* Initialize the bitmap */
	InitBitMap (bm, depth, width, height);

#ifdef ALLOCFORREAL
	/* Allocate one plane */
	if (bm->Planes[0] = (PLANEPTR) AllocMem (rsize, MEMF_CHIP | MEMF_CLEAR))
	{
	    /* All planes point to the first plane */
	    for (i = 1; i < depth; i++)
		bm->Planes[i] = bm->Planes[0];

	    return (bm);
	}

	FreeMem ((APTR) bm, msize);
#else
     bm->Planes[0] = (char *)TheBob->ImageShadow;
     for (i = 1; i < depth; i++)
	bm->Planes[i] = bm->Planes[0];
     return (bm);
#endif
    }
    return (NULL);
}

struct RastPort *
AllocShadowRP (struct BitMap *bm)
{
    LONG msize = sizeof (struct RastPort);
    struct RastPort *rp;

    /* Allocate a RastPort */
    if (rp = (struct RastPort *) AllocMem (msize, MEMF_CHIP))
    {
	/* Initialize the new RastPort */
	InitRastPort (rp);

	/* Point the RastPort's BitMap... */
	rp->BitMap = bm;
    }

    return (rp);
}


VOID
ClipBlitTrans (
    struct RastPort *rp,	/* source RastPort */
    WORD sx, WORD sy,		/* source top-left edge */
    struct RastPort *drp,	/* destination RastPort */
    WORD dx, WORD dy,		/* destination top-left edge */
    WORD width, WORD height,	/* width & height of image to blit */
    struct RastPort *Srp)	/* shadow RastPort */
{

    /* make the shadow */
    ClipBlit (rp, sx, sy, Srp, 0, 0, width, height, 0xe0);
    ClipBlit (Srp, 0, 0, drp, dx, dy, width, height, 0x20); /* blit cookie cutter outline */
    ClipBlit (rp, sx, sy, drp, dx, dy, width, height, 0xe0); /* now fill in image */
}


int LoadFullBitMap(void);

int LoadFullBitMap()
{
 unsigned long i;
 char errstr[40];
 char fname[80];
 long count;
 USHORT len;
 char *srcbuf;
 ULONG tt;
 BPTR fh;
 BPTR __aligned fp;
 struct BitMap *tmpBitMap;
 struct BitMap *PlanarBitMap;
 struct FileInfoBlock __aligned *myFileInfoBlock;
//LONG tmp1,tmp2;
//char tstr[40];

 if (DEPTH < 6)
  strcpy(fname,"uchess:Chess.lzw");
 else if (FasterDisplay)
  strcpy(fname,"uchess:Chess64.lzw");
 else
  strcpy(fname,"uchess:Chess256.lzw");


  if (!(myFileInfoBlock = 
     (struct FileInfoBlock *)AllocMem(sizeof(struct FileInfoBlock),MEMF_PUBLIC)))
   {
     DisplayError("No Mem now for finfo block");
     return(0);
   }
  if (!(fp = Lock(fname,ACCESS_READ)))
   {
     FreeMem((char *)myFileInfoBlock,sizeof(struct FileInfoBlock));
     return(0);
   }
  if (!(Examine(fp,myFileInfoBlock)))
   {
     DisplayError("Cannot get finfo");
     UnLock(fp);
     FreeMem((char *)myFileInfoBlock,sizeof(struct FileInfoBlock));
     return(0);
   }
  UnLock(fp);
  count = myFileInfoBlock->fib_Size - 2L;
  FreeMem((char *)myFileInfoBlock,sizeof(struct FileInfoBlock));


/* before unpacking the bitmap, save the titlebar area in a tmp bitmap */
 if (!RTG)
  {
   if (!(tmpBitMap = tAllocBitMap(WIDTH,MENUBARHT,DEPTH,BMF_CLEAR,myBitMap)))
    {
     return(0);
    }
   BltBitMap(myBitMap,0,0,tmpBitMap,0L,0L,WIDTH,MENUBARHT,0xc0L,0xffL,0L);
  }
 else
  {
   if (!(tmpBitMap = tAllocBitMap(WIDTH,MENUBARHT,DEPTH,BMF_CLEAR,0L)))
    {
     return(0);
    }
   BltBitMap(sC->RastPort.BitMap,0,0,tmpBitMap,0L,0L,WIDTH,MENUBARHT,0xc0L,0xffL,0L);
  }
 if (!(srcbuf = AllocMem(count,0L)))
  {
   sprintf(errstr,"Cannot allocate lharc %d byte buffer",count);
   DisplayError(errstr);
   return(0);
  }
 if (!(LhBase = OpenLibrary(LH_NAME,LH_VERSION)))
  {
   DisplayError("Cannot open lh.lib");
   return(0);
  }
 if (!(myLHBuffer = CreateBuffer(TRUE))) /* small buffer for only decomp*/
  {
   DisplayError("Cannot Create Buffer");
   CloseLibrary(LhBase);
   return(0);
  }

   if (!(fh = Open(fname,MODE_OLDFILE)))
    {
     DisplayError("Cannot open chess file");
     return(0);
    }
   if (Read(fh,(char *)&len,2L) != 2L)
    {
     DisplayError("Cannot read chess file");
     Close(fh);
     return(0);
    }
   if (Read(fh,srcbuf,count) != count)
    {
     DisplayError("Cannot read chess file2");
     Close(fh);
     return(0);
    }
   Close(fh);
   if ((RTG)&&(!OrigmyBitMap))
    { // allocate the BitMap to unpack to
     if (!(OrigmyBitMap = myBitMap = sAllocBitMap(WIDTH,HEIGHT,DEPTH,BMF_INTERLEAVED|BMF_CLEAR|BMF_DISPLAYABLE,
                       0L)))
      {
       return(0);
      }
    }

   myLHBuffer->lh_Src = (APTR)srcbuf;
   myLHBuffer->lh_Dst = (APTR)myBitMap->Planes[0];
   myLHBuffer->lh_SrcSize = count;
   tt = WIDTH/8L;
   tt = tt*HEIGHT;
   tt = tt*DEPTH;
   myLHBuffer->lh_DstSize = tt;
   LhDecode(myLHBuffer);

 FreeMem(srcbuf,count); 
 DeleteBuffer(myLHBuffer);
 CloseLibrary(LhBase);
 BltBitMap(tmpBitMap,0,0,myBitMap,0L,0L,WIDTH,MENUBARHT,0xc0L,0xffL,0L);
 tFreeBitMap(tmpBitMap);
 if (RTG)
  {
     if (!(PlanarBitMap = tAllocBitMap(WIDTH,HEIGHT/10,DEPTH,BMF_CLEAR,0L)))
      {
       return(0);
      }
     for(i=0;i<10;i++)
      {
       BltBitMap(myBitMap,0,(i*(HEIGHT/10)),PlanarBitMap,0,0,WIDTH,(HEIGHT/10),0xc0L,0xffL,0L);
       BltBitMap(PlanarBitMap,0,0,sC->RastPort.BitMap,0,(i*(HEIGHT/10)),WIDTH,(HEIGHT/10),0xc0L,0xffL,0L);
      }
     // then free the non-interleaved bitmap...
     tFreeBitMap(PlanarBitMap);
  }

#ifdef _M68040
 strcpy(fname,"UChess Pro:");
#else
#ifndef TINYCHESS
 strcpy(fname,"UChess Jr.:");
#else
 strcpy(fname,"UChess Tiny:");
#endif
#endif
 ObtainSemaphore(&mySemaphore);
 mySetABPenDrMd(rpG,BLACK,bpen,JAM1);
 Move(rpG,511,COMPUTERBOX-10);
 Text(rpG,fname,strlen(fname));
 Move(rpG,511,USERBOX-10);
 strcpy(fname,"Puny Human:");
 Text(rpG,fname,strlen(fname));
 ReleaseSemaphore(&mySemaphore);
 if (!RTG)
  {
   BltBitMap(myBitMap,COLB,ROW5,WhiteBitMap,0L,0L,SQUAREWIDTH,SQUAREHEIGHT,0xc0L,0xffL,0L);
   BltBitMap(myBitMap,COLA,ROW5,BlackBitMap,0L,0L,SQUAREWIDTH,SQUAREHEIGHT,0xc0L,0xffL,0L);
  }
 else
  {
   BltBitMap(sC->RastPort.BitMap,COLB,ROW5,WhiteBitMap,0L,0L,SQUAREWIDTH,SQUAREHEIGHT,0xc0L,0xffL,0L);
   BltBitMap(sC->RastPort.BitMap,COLA,ROW5,BlackBitMap,0L,0L,SQUAREWIDTH,SQUAREHEIGHT,0xc0L,0xffL,0L);
  }
 RethinkDisplay();
 if (RTG)
  {
   myBitMap = sC->RastPort.BitMap;
   sFreeBitMap(OrigmyBitMap);
   OrigmyBitMap = 0L;
  }
 if (!textBitMap)
  {
   if (!(textBitMap = tAllocBitMap(160,160,DEPTH,BMF_CLEAR,myBitMap)))
    {
     DisplayBeep(0L);
     Delay(10L);
     DisplayBeep(0L);
     Delay(15L);
     DisplayBeep(0L);
     Delay(25L);
     DisplayBeep(0L);
     return(0);
    }
  }
 return(1);
}


int mAllocBitMap(void);

int mAllocBitMap()
{

 if (!RTG)
  {
   if (!(OrigmyBitMap = myBitMap = tAllocBitMap(WIDTH,HEIGHT,DEPTH,BMF_INTERLEAVED|BMF_CLEAR|BMF_DISPLAYABLE,
                    0L)))
    {
     return(0);
    }
   tempras_bitplane = AllocMem(WIDTH*HEIGHT/8,MEMF_CLEAR|MEMF_CHIP);
   if (!tempras_bitplane)
    {
     return(0);
    }
  }
 else
  {
   if (!(OrigmyBitMap = myBitMap = sAllocBitMap(WIDTH,HEIGHT,DEPTH,BMF_INTERLEAVED|BMF_CLEAR|BMF_DISPLAYABLE,
                    0L)))
    {
     return(0);
    }
  }
 if (RTG)
  {
   if ((RTG_ModeID == VGAPRODUCT_KEY)||
       (RTG_ModeID == (HIRES|LACE|DEFAULT_MONITOR_ID))||
       (RTG_ModeID == (HIRES|LACE|PAL_MONITOR_ID))|| 
       (RTG_ModeID == (HIRES|LACE|NTSC_MONITOR_ID)) || 
       (RTG_ModeID == (HIRES|LACE|DBLPAL_MONITOR_ID))|| 
       (RTG_ModeID == (HIRES|LACE|DBLNTSC_MONITOR_ID)) || 
       (RTG_ModeID == (LORES_KEY|LACE|DEFAULT_MONITOR_ID))|| 
       (RTG_ModeID == (LORES_KEY|LACE|PAL_MONITOR_ID))|| 
       (RTG_ModeID == (LORES_KEY|LACE|NTSC_MONITOR_ID)) || 
       (RTG_ModeID == (LORES_KEY|LACE|DBLPAL_MONITOR_ID))|| 
       (RTG_ModeID == (LORES_KEY|LACE|DBLNTSC_MONITOR_ID)) || 
       (RTG_ModeID == (HIRES|DEFAULT_MONITOR_ID))||
       (RTG_ModeID == (HIRES|PAL_MONITOR_ID))|| 
       (RTG_ModeID == (HIRES|NTSC_MONITOR_ID)) || 
       (RTG_ModeID == (HIRES|DBLNTSC_MONITOR_ID)) || 
       (RTG_ModeID == (HIRES|DBLPAL_MONITOR_ID)) || 
       (RTG_ModeID == (LORES_KEY|DEFAULT_MONITOR_ID))|| 
       (RTG_ModeID == (LORES_KEY|PAL_MONITOR_ID))|| 
       (RTG_ModeID == (LORES_KEY|NTSC_MONITOR_ID)) || 
       (RTG_ModeID == (LORES_KEY|DBLPAL_MONITOR_ID)) || 
       (RTG_ModeID == (LORES_KEY|DBLNTSC_MONITOR_ID)) || 
       (RTG_ModeID == (SUPER72_MONITOR_ID | SUPERLACE_KEY)))
     {
      myTagList[3].ti_Tag = SA_Interleaved;
      myTagList[3].ti_Data = TRUE;
     }
   NewScreenStructure.Type = CUSTOMSCREEN | NS_EXTENDED; // no custom bitmap
   NewScreenStructure.CustomBitMap = 0L;
   if (!(WhiteBitMap = tAllocBitMap(ROUNDEDSQUAREWIDTH,SQUAREHEIGHT,DEPTH,
                        BMF_CLEAR,0L)))
    {
     return(0);
    }
   if (!(BlackBitMap = tAllocBitMap(ROUNDEDSQUAREWIDTH,SQUAREHEIGHT,DEPTH,
                          BMF_CLEAR,0L)))
    {
     return(0);
    }
  }
 else
  {
   NewScreenStructure.CustomBitMap = myBitMap;
   if (!(WhiteBitMap = tAllocBitMap(ROUNDEDSQUAREWIDTH,SQUAREHEIGHT,DEPTH,
                        BMF_CLEAR,myBitMap)))
    {
     return(0);
    }
   if (!(BlackBitMap = tAllocBitMap(ROUNDEDSQUAREWIDTH,SQUAREHEIGHT,DEPTH,
                          BMF_CLEAR,myBitMap)))
    {
     return(0);
    }
  }
 return(1);
}

void FreeTheBitMap(void);

void FreeTheBitMap()
{
 tFreeBitMap(BlackBitMap);
 tFreeBitMap(WhiteBitMap);
 if (OrigmyBitMap)
  if (!RTG)
   tFreeBitMap(OrigmyBitMap);
  else
   sFreeBitMap(OrigmyBitMap);
 if (textBitMap)
  tFreeBitMap(textBitMap);
}

void AmigaShutDown(void);
int AmigaStartup(void);

int AmigaStarted = 0;

int AmigaStartup()
{
	flag.post = false;
        if (!(myTextFont = OpenFont(&TOPAZ80)))
         {
	  return(0);
         }
        if (gfxversion < 39)
         DEPTH = 4;
        else if (RTG)
         { // use screen requestor to ask guy what he wants
          if (!GetScreenMode())
           {
             return(0);
           }
          DEPTH = 8; // only support 8 bit RTG screens
          myTagList[0].ti_Data = RTG_ModeID;
	  myTagList[2].ti_Tag = SA_AutoScroll;
          myTagList[2].ti_Data = TRUE;
         }
        else
         {
          if (v15Khz)
           {
            myTagList[0].ti_Data = HIRES|LACE|DEFAULT_MONITOR_ID;
            myTagList[2].ti_Data = TRUE;
            myTagList[2].ti_Tag = SA_AutoScroll;
           }
          if (Super72)
           myTagList[0].ti_Data = (SUPER72_MONITOR_ID | SUPERLACE_KEY);
          NewScreenStructure2.Type |= NS_EXTENDED;
          NewScreenStructure2.Extension = myTagList;
          NewScreenStructure2.Height = 480;
          NewScreenStructure2.Depth = 8; 
          NewScreenStructure2.BlockPen = 251;
	  if ((sC = OpenScreen((struct NewScreen *)&NewScreenStructure2)))
           {
            CloseScreen(sC);
            DEPTH = 8;
           }
          else
           {
            myTagList[0].ti_Data = HIRES|LACE|DEFAULT_MONITOR_ID;
	    myTagList[2].ti_Tag = SA_AutoScroll;
            myTagList[2].ti_Data = TRUE;
	    if ((sC = OpenScreen((struct NewScreen *)&NewScreenStructure2)))
             {
              CloseScreen(sC);
              DEPTH = 8;
             }
            else
             {
  	      myTagList[2].ti_Tag = 0;
              myTagList[2].ti_Data = 0;
              myTagList[0].ti_Data = HIRES|LACE;
              DEPTH = 4;
             }
           }
         }
        if (DEPTH == 8)
         {
          BLACK = 2;
          if (FasterDisplay)
           {
            DEPTH = 6;
            MBLOCKPEN = 0;//61;
            BACKGNDTEXTCOLOR = 57;
            BACKPEN =61;
           }
          else
           {
            MBLOCKPEN = 0;//251;
            BACKGNDTEXTCOLOR = 0xe0;
            BACKPEN = 251;
           }
	  TIMEYCOORD1 = 120;
	  TIMEYCOORD2 = 230;
          USERBOX=168;
          SYSTEMBOX = USERBOX + 112;
          SYSBOXLEN = 102;
          COMPUTERBOX=60;
          BOBDEPTH = DEPTH;
          ROW8 = 24;
          BOBHEIGHT = 55;
          HEIGHT = 480;
          NewScreenStructure.Type |= NS_EXTENDED;
          NewScreenStructure.Extension = myTagList;
          NewScreenStructure.Height = HEIGHT;
          NewScreenStructure.Depth = DEPTH;
          NewScreenStructure.BlockPen = BACKPEN;
          NewWindowStructure1.Height = HEIGHT;
          NewWindowStructure1.MaxHeight = HEIGHT;
          NewWindowStructure1.BlockPen = BACKPEN;
          NewWindowStructure2.BlockPen = BACKPEN;
          NewWindowStructure5.BlockPen = BACKPEN;
          NewWindowStructure6.BlockPen = BACKPEN;
          pNewWindowStructure1.BlockPen = BACKPEN;
          Border6.FrontPen = Border7.FrontPen = 
          Border9.FrontPen = Border1.FrontPen = BACKPEN;
          aBorder1.FrontPen = aBorder2.FrontPen = 
          aBorder3.FrontPen = aBorder4.FrontPen = 
          pBorder1.FrontPen = pBorder2.FrontPen = 
          pBorder3.FrontPen = pBorder4.FrontPen = BACKPEN;
          pIText1.FrontPen = 
          pIText2.FrontPen = 
          pIText2a.FrontPen = 
          pIText3.FrontPen = 
          pIText4.FrontPen = 
          pIText5.FrontPen = 
          pIText6.FrontPen = 
          pIText7.FrontPen = 
          pIText8a.FrontPen = 
          IText93.FrontPen = 
          IText47.FrontPen = 
          IText46.FrontPen = 
          IText37.FrontPen = 
          IText1.FrontPen = 
          IText1r.FrontPen = 
          IText2.FrontPen = 
          IText2x.FrontPen = 
          IText3.FrontPen = 
          IText4.FrontPen = 
          IText4aa.FrontPen = 
          IText4ab.FrontPen = 
          IText4cc.FrontPen = 
          IText4dd.FrontPen = 
          IText4ee.FrontPen = 
          IText4a.FrontPen = 
          IText5.FrontPen = 
          IText6.FrontPen = 
          IText7.FrontPen = 
          IText8.FrontPen = 
          IText9.FrontPen = 
          IText10.FrontPen = 
          IText11.FrontPen = 
          IText12.FrontPen = 
          IText13.FrontPen = 
          IText13a.FrontPen = 
          IText14.FrontPen = 
          IText15.FrontPen = 
          IText16.FrontPen = 
          IText22.FrontPen = 
          IText21.FrontPen = 
          IText20.FrontPen = 
          IText19.FrontPen = 
          IText18.FrontPen = 
          aIText1.FrontPen = 
          aIText2.FrontPen = 
          aIText3.FrontPen = 
          aIText4.FrontPen = 
          aIText5.FrontPen = 
          IText17.FrontPen = BACKPEN;

          IText37.BackPen = 
          IText1.BackPen = 
          IText1r.BackPen = 
          IText2.BackPen = 
          IText2x.BackPen = 
          IText3.BackPen = 
          IText4.BackPen = 
          IText4aa.BackPen = 
          IText4ab.BackPen = 
          IText4cc.BackPen = 
          IText4dd.BackPen = 
          IText4ee.BackPen = 
          IText4a.BackPen = 
          IText5.BackPen = 
          IText6.BackPen = 
          IText7.BackPen = 
          IText8.BackPen = 
          IText9.BackPen = 
          IText10.BackPen = 
          IText11.BackPen = 
          IText12.BackPen = 
          IText13.BackPen = 
          IText13a.BackPen = 
          IText14.BackPen = 
          IText15.BackPen = BACKPEN;

          IText37.FrontPen = 
          IText1.FrontPen = 
          IText1r.FrontPen = 
          IText2.FrontPen = 
          IText2x.FrontPen = 
          IText3.FrontPen = 
          IText4.FrontPen = 
          IText4aa.FrontPen = 
          IText4ab.FrontPen = 
          IText4cc.FrontPen = 
          IText4dd.FrontPen = 
          IText4ee.FrontPen = 
          IText4a.FrontPen = 
          IText5.FrontPen = 
          IText6.FrontPen = 
          IText7.FrontPen = 
          IText8.FrontPen = 
          IText9.FrontPen = 
          IText10.FrontPen = 
          IText11.FrontPen = 
          IText12.FrontPen = 
          IText13.FrontPen = 
          IText13a.FrontPen = 
          IText14.FrontPen = 
          IText15.FrontPen = MBLOCKPEN;
         }
        if (!(mAllocBitMap()))
         {
          CloseFont(myTextFont);
          return(0);
         }
        RowArray[0] = ROW1;
        RowArray[1] = ROW2;
        RowArray[2] = ROW3;
        RowArray[3] = ROW4;
        RowArray[4] = ROW5;
        RowArray[5] = ROW6;
        RowArray[6] = ROW7;
        RowArray[7] = ROW8;
	if (!(sC = OpenScreen((struct NewScreen *)&NewScreenStructure)))
         {
          if (RTG)
           {
  	    myTagList[2].ti_Tag = 0; // kill autoscroll and try again
            myTagList[2].ti_Data = 0;
  	    if (!(sC = OpenScreen((struct NewScreen *)&NewScreenStructure)))
             {
              //FreeTheBitMap();
              CloseFont(myTextFont);
              DisplayError("256 color screen in this mode not avail");
              return(0);
             }
           }
          else // not rtg
           {
            FreeTheBitMap();
            CloseFont(myTextFont);
            DisplayError("FATAL:Screen mode not avail");
            return(0);
           }
         }
        vP = &sC->ViewPort;
        if (DEPTH >= 6)
         {
          if (!FasterDisplay)
  	   LoadRGB32(&(sC->ViewPort),BigColorPalette);
          else
  	   LoadRGB32(&(sC->ViewPort),Big64Palette);
         }
        else
	 LoadRGB4(&(sC->ViewPort),myPalette,16);
        if (gfxversion > 38)
         {
          NewWindowStructure1.Flags |= WFLG_NEWLOOKMENUS;
         }
	NewWindowStructure1.Screen = sC;
	pNewWindowStructure1.Screen = sC;
	NewWindowStructure2.Screen = sC;
	NewWindowStructure5.Screen = sC;
	NewWindowStructure6.Screen = sC;
        InitSemaphore(&mySemaphore);
	if (!(InputReply = CreatePort(0L,0L)))
  	 {
          DisplayError("Cannot create reply");
          return(0);
         }
        if (!CreateNewProc(ProcTagList))
         {
          DisplayError("Cannot create new proc");
          return(0);
         }
        Delay(15L);
        while (InputThreadState < 1)
         Delay(10L);
        if (InputThreadState != 1)
         {
          DisplayError("Trbl with child process");
          return(0);
         }
        Forbid();
        if (!(InThreadPort = FindPort(InputPortName)))
          {
           Permit();
           DisplayError("Cannot find input port");
           return(0);
          }
        Permit();
        Global_Message.myData = 0L;
        Global_Message.MainMsg.mn_Length = sizeof(Global_Message);
        Global_Message.MainMsg.mn_Node.ln_Type = NT_MESSAGE;
        Global_Message.MainMsg.mn_ReplyPort = InputReply;
	rpG = wG->RPort;	/* get a rastport pointer for the window */
        if (!RTG)
         {
          InitTmpRas(&temp_rast,tempras_bitplane,WIDTH*HEIGHT/8);
          rpG->TmpRas = &temp_rast;
         }
	SetFont(rpG,myTextFont);
        Delay(25L); /* crashes from wb if I do not do this! */
        SetDrMd(rpG,JAM1);
        if (!InitmyGels())
         {
	  CloseScreen(sC);
          CloseFont(myTextFont);
//          FreeTheBitMap();
          return(0);
         }
        else
         {
          if (!LoadFullBitMap())
           {
            //CloseWindow(wG);
            CloseScreen(sC);
   	    return(0);
           }
// finish GEL init and add the bob
          if (SYSTEM_BOBS)
           AddBob(TheBob,rpG);
	  WaitTOF();
 	  MakeScreen(sC);
	  RethinkDisplay();
 	  if (SYSTEM_BOBS)
  	    {
  	     SortGList(rpG);
  	     DrawGList(rpG,vP);
  	     MakeVPort(GfxBase->ActiView,vP);
  	     MrgCop(GfxBase->ActiView);
  	     WaitTOF();
  	     SortGList(rpG);
  	     DrawGList(rpG,vP);
  	     MakeVPort(GfxBase->ActiView,vP);
  	     MrgCop(GfxBase->ActiView);
 	     WaitTOF();
 	     SortGList(rpG);
  	     DrawGList(rpG,vP);
	    }
	  MakeVPort(GfxBase->ActiView,vP);
	  MrgCop(GfxBase->ActiView);
 	  WaitTOF();
    	  MakeScreen(sC);
 	  RethinkDisplay();
 	  WaitTOF();
          AmigaStarted = 1;
          if (gfxversion > 38)
 	   bpen = GetBPen(rpG);
	  return(1);
         }
}



void AmigaShutDown()
{
 int tmpargcnt;

// need to wake up the input thread so it can exit 1st
    Global_Message.myData = 0xff;
    Forbid();
    PutMsg(InThreadPort,(struct Message *)&Global_Message);
    Permit();
    tmpargcnt = 0;
    Delay(25L);
    while ((InputThreadState < 2)&&(tmpargcnt < 10))
     {
      tmpargcnt++;
      Delay(25L);
     }
    CloseGels();
    CloseScreen(sC);
    if (!RTG)
     {
      if (tempras_bitplane)
       FreeMem(tempras_bitplane,WIDTH*HEIGHT/8);
     }
    FreeTheBitMap();
    CloseFont(myTextFont);
    if (InputReply)
     DeletePort(InputReply);
}

void ShowMessage(str)
char *str;
{
 char tstr[16];
 int done = 0;
 int i=0;
 int j,k,lim;
 int ycoord;

 if (str[strlen(str)-1] == '\n')
  {
   str[strlen(str)-1] = 0;
  }
 ycoord = SYSTEMBOX+6;
/* scroll down 3 lines (30 pixels) */
 ObtainSemaphore(&mySemaphore);
 BltBitMap(myBitMap,510,SYSTEMBOX,textBitMap,0L,0L,621-510+1,SYSBOXLEN,0xc0L,0xffL,0L);
 BltBitMap(textBitMap,0,0,myBitMap,510,SYSTEMBOX+30,621-510+1,SYSBOXLEN-30,0xc0L,0xffL,0L);
 mySetABPenDrMd(rpG,BACKGNDTEXTCOLOR,bpen,JAM1);
 RectFill(rpG,510,SYSTEMBOX-1,621,SYSTEMBOX+29);
 ReleaseSemaphore(&mySemaphore);
 do {
 j = i;
 if (strlen(str) <= 14)
  {
   done = 1;
   strcpy(tstr,str);
  }
 else
  {
   lim = j + 14;
   if (lim >= strlen(str))
    {
     done = 1;
     lim = strlen(str);
    }
   for(k=0;i<lim;i++,k++)
    tstr[k] = str[i];
   tstr[k] = 0;
  }
 ObtainSemaphore(&mySemaphore);
 mySetABPenDrMd(rpG,BLACK,bpen,JAM1);
 Move(rpG,510,ycoord); /* was 509,ycord */
 Text(rpG,tstr,strlen(tstr));
 ReleaseSemaphore(&mySemaphore);
 ycoord += 10;
 } while (!done);
}



void DisplayComputerMove(str)
char *str;
{
 char tstr[16];
 int done = 0;
 int i=0;
 int j,k,lim;
 int ycoord;

 if (str[strlen(str)-1] == '\n')
  {
   str[strlen(str)-1] = 0;
  }
 ObtainSemaphore(&mySemaphore);
 mySetABPenDrMd(rpG,BACKGNDTEXTCOLOR,bpen,JAM1);
 RectFill(rpG,520,COMPUTERBOX,621,COMPUTERBOX+30);
 ReleaseSemaphore(&mySemaphore);
 ycoord = COMPUTERBOX+6;
 do {
 j = i;
 if (strlen(str) <= 12)
  {
   done = 1;
   strcpy(tstr,str);
  }
 else
  {
   lim = j + 12;
   if (lim >= strlen(str))
    {
     done = 1;
     lim = strlen(str);
    }
   for(k=0;i<lim;i++,k++)
    tstr[k] = str[i];
   tstr[k] = 0;
  }
 ObtainSemaphore(&mySemaphore);
 mySetABPenDrMd(rpG,BLACK,bpen,JAM1);
 Move(rpG,520,ycoord);
 Text(rpG,tstr,strlen(tstr));
 ReleaseSemaphore(&mySemaphore);
 ycoord += 10;
 } while (!done);
}

void DoLegalMove(str)
char *str;
{
 long mpiece;
 char piece;
 int r,c,l;
 int ecol,erow,scol,srow,side,tmp1,tmp2,incrx,incry,i;

   if (SYSTEM_BOBS)
    {
     SortGList(rpG);
     DrawGList(rpG,vP);
    }
   MakeVPort(GfxBase->ActiView,vP);
   MrgCop(GfxBase->ActiView);
   if (SYSTEM_BOBS)
    {
     RemIBob(TheBob,rpG,vP);
     SortGList(rpG);
     DrawGList(rpG,vP);
    }
   MakeVPort(GfxBase->ActiView,vP);
   MrgCop(GfxBase->ActiView);
   r = str[3] - '1';
   c = str[2] - 'a';
   tmp1 = r & 1;
   tmp2 = c & 1;
   if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
    {
     BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[c],
			RowArray[r],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
    }
   else
    {
     BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[c],
			RowArray[r],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
    }
   MakeVPort(GfxBase->ActiView,vP);
   MrgCop(GfxBase->ActiView);
   RethinkDisplay();
   WaitTOF();
   l = ((flag.reverse) ? locn (7 - r, 7 - c) : locn (r, c));
   if ((color[l] == neutral))
    {
     ExitChess();
     return;
    }
   else if (color[l] == white)
    piece = qxx[board[l]]; /* white are lower case pieces */
   else
    piece = pxx[board[l]]; /* black are upper case pieces */
   if ((DestRow == 7)||(!DestRow))
    { /* possible promotion */
      mpiece = piece;
      LoadBobImage(mpiece);
    }
   ClipBlitTrans (
		&(BobTransImage->ti_RP),	/* Source RastPort */
	     	0, 0,		/* Source LeftEdge, TopEdge */
	     	rpG,		/* Destination RastPort */
	     	ColArray[DestCol],RowArray[DestRow],/* Destination LeftEdge, TopEdge */
	     	BobTransImage->ti_IM->Width,	/* Width of Image */
	     	BobTransImage->ti_IM->Height,/* Height of Image */
	     	BobTransImage->ti_sRP);	/* Shadow RastPort */
   BobVSprite->X = WIDTH-1-BOBWIDTH;
   BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
   LoadBobImage(BLANKDATA);
   if (SYSTEM_BOBS)
    {
     AddBob(TheBob,rpG);
     SortGList(rpG);
     DrawGList(rpG,vP);
    }
   MakeVPort(GfxBase->ActiView,vP);
   MrgCop(GfxBase->ActiView);
   if (piece >= 'a')
    {
     mpiece = 'r';
     srow = 0;
     erow = 0;
     side = white;
     if (str[2] == 'g') /* king side white */
      {
       scol = 7;
       ecol = 5;
      }
     else
      {
       ecol = 3;
       scol = 0;
      }
    }
   else
    {
     mpiece = 'R';
     srow = 7;
     erow = 7;
     side = black;
     if (str[2] == 'g') /* king side black */
      {
       scol = 7;
       ecol = 5;
      }
     else
      {
       ecol = 3;
       scol = 0;
      }
    }
   if (Castled[side])
    {
     Castled[side] = 0;
     tmp1 = srow & 1;
     tmp2 = scol & 1;
     if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
      {
       BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[scol],
			RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
      }
     else
      {
       BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[scol],
			RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
      }
     BobVSprite->X = ColArray[scol];
     BobVSprite->Y = RowArray[srow];
     if (SYSTEM_BOBS)
      {
       SortGList(rpG);
       DrawGList(rpG,vP);
      }
     MakeVPort(GfxBase->ActiView,vP);
     MrgCop(GfxBase->ActiView);
     LoadBobImage(mpiece);
     if (SYSTEM_BOBS)
      {
       SortGList(rpG);
       DrawGList(rpG,vP);
      }
     MakeVPort(GfxBase->ActiView,vP);
     MrgCop(GfxBase->ActiView);
     incry = (RowArray[erow] - RowArray[srow])/8;
     incrx = (ColArray[ecol] - ColArray[scol])/8;
     for(i=0;i<8;i++)
      {
       BobVSprite->X += incrx;
       BobVSprite->Y += incry;
       if (SYSTEM_BOBS)
        {
         SortGList(rpG);
         DrawGList(rpG,vP);
        }
       MakeVPort(GfxBase->ActiView,vP);
       MrgCop(GfxBase->ActiView);
      }
     if (SYSTEM_BOBS)
      {
       RemIBob(TheBob,rpG,vP);
       SortGList(rpG);
       DrawGList(rpG,vP);
      }
     MakeVPort(GfxBase->ActiView,vP);
     MrgCop(GfxBase->ActiView);
     ClipBlitTrans (
			&(BobTransImage->ti_RP),	/* Source RastPort */
		     	0, 0,		/* Source LeftEdge, TopEdge */
		     	rpG,		/* Destination RastPort */
		     	ColArray[ecol],RowArray[erow],/* Destination LeftEdge, TopEdge */
		     	BobTransImage->ti_IM->Width,	/* Width of Image */
		     	BobTransImage->ti_IM->Height,/* Height of Image */
		     	BobTransImage->ti_sRP);	/* Shadow RastPort */
     LoadBobImage(BLANKDATA);
     if (SYSTEM_BOBS)
      {
       AddBob(TheBob,rpG);
      }
     MakeVPort(GfxBase->ActiView,vP);
     MrgCop(GfxBase->ActiView);
    }
   else /* check EnPassant */
    {
     side ^= 1;
     if (myEnPassant[side])
      {
       myEnPassant[side] = 0;
       scol = str[2] - 'a';
       if (str[3] == '3') /* white is removed from bd at 4*/
        {
         srow = 3;
        }
       else /* black is removed at pos 5 */
        {
         srow = 4;
        }
       tmp1 = srow & 1;
       tmp2 = scol & 1;
       if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
        {
         BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[scol],
			RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
        }
       else
        {
         BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[scol],
			RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
        }
      }
    }
}

void DrawAmigaBoard()
{
 int r,c,l,tmp1,tmp2;
 int piece;

 LoadBobImage(BLANKDATA);
 BobVSprite->X = WIDTH-1-BOBWIDTH;
 BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
 if (SYSTEM_BOBS)
  {
   SortGList(rpG);
   DrawGList(rpG,vP);
   RemIBob(TheBob,rpG,vP);
   SortGList(rpG);
   DrawGList(rpG,vP);
  }
 for(r=0;r<8;r++)
  for(c=0;c<8;c++)
   {
       tmp1 = r & 1;
       tmp2 = c & 1;
       if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
        {
         BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[c],
			RowArray[r],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
        }
       else
        {
         BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[c],
			RowArray[r],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
        }    
    l = ((flag.reverse) ? locn (7 - r, 7 - c) : locn (r, c));
    if (color[l] == white)
     piece = qxx[board[l]]; /* white are lower case pieces */
    else
     piece = pxx[board[l]]; /* black are upper case pieces */
    if (color[l] != neutral)
     {
      BobVSprite->X = ColArray[c];
      BobVSprite->Y = RowArray[r];
      LoadBobImage(piece);
      ClipBlitTrans (
		&(BobTransImage->ti_RP),	/* Source RastPort */
	     	0, 0,		/* Source LeftEdge, TopEdge */
	     	rpG,		/* Destination RastPort */
	     	ColArray[c],RowArray[r],/* Destination LeftEdge, TopEdge */
	     	BobTransImage->ti_IM->Width,	/* Width of Image */
	     	BobTransImage->ti_IM->Height,/* Height of Image */
	     	BobTransImage->ti_sRP);	/* Shadow RastPort */
     }
   }
 BobVSprite->X = WIDTH-1-BOBWIDTH;
 BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
 LoadBobImage(BLANKDATA);
 if (SYSTEM_BOBS)
  AddBob(TheBob,rpG);
}


#define INPUTSIGNAL (1<<InputPort->mp_SigBit)

void __saveds InputThread()
{
 struct IntuiMessage __aligned *message;
 struct myMsgStruct *InputMsg;
 ULONG cmd; 
 struct MsgPort *InputPort;

// Init The Port We will use to communicate
 InputThreadState = 0;
 wG = OpenWindow(&NewWindowStructure1);	/* open the window */
 if ( wG == NULL )
  {
   CloseScreen(sC);
   CloseFont(myTextFont);
   FreeTheBitMap();
   InputThreadState = 0x7ffe;
  }
 else // window opened
  {
   globalsignalset = WINDOWSIGNAL;
   if (!(InputPort = CreatePort(InputPortName,0)))
    {
     InputThreadState = 0x7fff;
    }
   else
    {
     InputThreadState = 1;
     do {
       if (Wait(INPUTSIGNAL) & INPUTSIGNAL)
        {
         InputMsg = (struct myMsgStruct *)GetMsg(InputPort);
         cmd = InputMsg->myData;
         if (!flag.quit)
          {
           if (cmd == 1L) // do get op entry
            {
             OpEntryRecvd = 0;
             do {
             GetOperatorEntry(); // TMP DEBUG COMMENTED OUT!
             if ((!OpEntryRecvd)&&(!RealThink)) // do not set if already set by movenow
              OpEntryRecvd = 1;
             if (OpEntryRecvd)
              ReplyMsg((struct Message *)InputMsg); // let caller know you are done
             } while (!OpEntryRecvd);
            }
          }
        }
       else
        { // strange wake up should not happen
        }
     } while ((cmd != 0xff));
    } // input port ok
   ClearPointer(wG);
   if (SYSTEM_BOBS)
    RemIBob(TheBob,rpG,vP);
   while(message = (struct IntuiMessage *)GetMsg(wG->UserPort))
    ReplyMsg((struct Message *)message);
   CloseWindow(wG);
   wG = 0L;
  } // window opened
 DeletePort(InputPort);
 Forbid(); // make sure we end first!
 InputThreadState = 2;
}

void GetOperatorEntry(void)
{
 char *str;
 char __aligned PromoteChar;
 char mvnstr[32];
 ULONG signals;
 char __aligned tempstr[40];
 struct IntuiMessage __aligned *message;
 long done=0;
 long done2;
 int ilen=0;
 int r,c,l,piece;
 long __aligned class,code;
 int MouseX,MouseY;
 long tmp1,tmp2;
 int tmovenum;
 static int movenum;



 str = OpEntryStr;
 if (CheckIllegal)
  {
   CheckIllegal = 0;
   if (IllegalMove)
    { /* put guy back! */
      IllegalMove = 0;
      if (SYSTEM_BOBS)
       {
        RemIBob(TheBob,rpG,vP);
        SortGList(rpG); 
        DrawGList(rpG,vP);
       }
      MakeVPort(GfxBase->ActiView,vP);
      MrgCop(GfxBase->ActiView);
      ClipBlitTrans (
		&(BobTransImage->ti_RP),	/* Source RastPort */
	     	0, 0,		/* Source LeftEdge, TopEdge */
	     	rpG,		/* Destination RastPort */
	     	ColArray[OrigCol],RowArray[OrigRow],/* Destination LeftEdge, TopEdge */
	     	BobTransImage->ti_IM->Width,	/* Width of Image */
	     	BobTransImage->ti_IM->Height,/* Height of Image */
	     	BobTransImage->ti_sRP);	/* Shadow RastPort */
      BobVSprite->X = WIDTH-1-BOBWIDTH;
      BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
      LoadBobImage(BLANKDATA);
      if (SYSTEM_BOBS)
       AddBob(TheBob,rpG);
      MakeVPort(GfxBase->ActiView,vP);
      MrgCop(GfxBase->ActiView);
    }
  }
 while (message = (struct IntuiMessage *)GetMsg(wG->UserPort))
   {
     ReplyMsg((struct Message *)message);
   }
// when an illegal move is made
// the tmovenum used to be 1 too many for computer == black
 if (!thinkahead)
  {
   if (computer == white)
    {
      movenum = (GameCnt)>>1;
    }
   else
    {
     movenum = (GameCnt+1)>>1; // was +2
    }
  }
 else
  {
    movenum++;
  }
 if (!GameCnt)
  tmovenum = 1;
 else
  {
   if (thinkahead)
    {
    if (computer == white)
     {
      tmovenum = movenum - 1;
     }
    else
     tmovenum = movenum;
    }
   else
    {
     tmovenum = movenum + 1;
    }
  }
 if (tmovenum < 1)
  tmovenum = 1;
 mysprintf(mvnstr,"%d: ",tmovenum);
 ObtainSemaphore(&mySemaphore);
 mySetABPenDrMd(rpG,BACKGNDTEXTCOLOR,bpen,JAM1);
 RectFill(rpG,520,USERBOX,621,USERBOX+30);
 Move(rpG,520,USERBOX+6);
 mySetABPenDrMd(rpG,BLACK,bpen,JAM1);
 Text(rpG,mvnstr,strlen(mvnstr));
 ReleaseSemaphore(&mySemaphore);
 tempstr[0] = 0;
 PromoteChar = 0;
 OnMenu(wG,SHOWMENUNUM); 
 OnMenu(wG,SUPERMENUNUM); 
 OnMenu(wG,THINKMENUNUM); 
 OnMenu(wG,BOOKMENUNUM); 
 do {
// if (!globalmessage_valid)
//  signals = Wait(globalsignalset);
 WaitPort(wG->UserPort);
// if ((signals & WINDOWSIGNAL)||(globalmessage_valid))
//  {
//  message = (struct IntuiMessage *)1;
  while ((message = (struct IntuiMessage *)GetMsg(wG->UserPort)))
  {
  //if (!globalmessage_valid)
   //message = (struct IntuiMessage *)GetMsg(wG->UserPort);
  //if ((message)) //||(globalmessage_valid))
   //{
   //     if (!globalmessage_valid)
   //      {
   	  class = message->Class;
	  code = message->Code;
          MouseX = message->MouseX;
          MouseY = message->MouseY;
	  ReplyMsg((struct Message *)message);
//         }
//        else
//         {
//	  class = globalmessage.Class;
//	  code = globalmessage.Code;
//          MouseX = globalmessage.MouseX;
//          MouseY = globalmessage.MouseY;
//          globalmessage_valid = 0L;
//         }
        if (RealThink)
         { // we are in the middle of Selectmove iop == 1!!
          if (class == MENUPICK)
           {
            if (code != MENUNULL)
             {
 	      done = HandleEvent((APTR)ItemAddress(&MenuList1,code));
              if (done)
               strcpy(tempstr,OpEntryStr);
             }
           }
          else if ((class == MOUSEBUTTONS)&&(code == SELECTDOWN))
           {
            if (flag.bothsides)
             {
              if (!flag.timeout)
               {
                flag.back = true;
               }
              flag.bothsides = false;
             }
           }
         }
	else if ( class == MENUPICK )	/* MenuItems */
         { // ! realthink
          if (code != MENUNULL)
           {
 	    done = HandleEvent((APTR)ItemAddress(&MenuList1,code));
            if (done)
             strcpy(tempstr,OpEntryStr);
            if (flag.quit) 
             done = 1;
            else if (!done)
             {
              if (teston)
               {
                done = 1;
                teston = 0;
                strcpy(tempstr,"test");
               }
              else if (doswap)
               {
                done = 1;
                doswap = 0;
                strcpy(tempstr,"switch");
               }
              else if (doauto)
               {
                done = 1;
                doauto = 0;
                strcpy(tempstr,"both");
               }
              else if (doundo)
               {
                done = 1;
                doundo = 0;
                strcpy(tempstr,"help");
               }
             }
           }
         }
	else if ((class == RAWKEY) && (!RealThink))
	 {
          if (code < 80)
           {
          code = cookedchar[code];
          if ((code == 13)||(code == 10))
	   {
            if (tempstr[0])
             done = 1;
	   }
          else if ((code == 7)&&(ilen)) /* backspace */
           {
            tempstr[strlen(tempstr)-1] = '\0';
            mysprintf(mvnstr,"%d: ",tmovenum);
            ObtainSemaphore(&mySemaphore);
            mySetABPenDrMd(rpG,BACKGNDTEXTCOLOR,bpen,JAM1);
            RectFill(rpG,520,USERBOX,621,USERBOX+30);
            mySetABPenDrMd(rpG,BLACK,bpen,JAM1);
            Move(rpG,520,USERBOX+6);
            Text(rpG,mvnstr,strlen(mvnstr));
            Text(rpG,tempstr,strlen(tempstr));
            ReleaseSemaphore(&mySemaphore);
            ilen--;
           }
          else if ((isalnum(code)||(code == '-')||(code == '/')) && (strlen(tempstr) < 12))
           {
            tempstr[ilen] = tolower(code);
            ilen++;
            tempstr[ilen] = 0;
            mysprintf(mvnstr,"%d: ",tmovenum);
            ObtainSemaphore(&mySemaphore);
            mySetABPenDrMd(rpG,BLACK,bpen,JAM1);
            Move(rpG,520,USERBOX+6);
            Text(rpG,mvnstr,strlen(mvnstr));
            Text(rpG,tempstr,strlen(tempstr));
            ReleaseSemaphore(&mySemaphore);
           }
          } /* code < 80 */
	 }
        else if ((class == MOUSEBUTTONS)&&(!(flag.quit || flag.mate || flag.force))
                   &&(!RealThink))
         {
          if ((code == SELECTDOWN) && 
              ((MouseY <= (ROW1+SQUAREHEIGHT)) && (MouseY >= ROW8) && (MouseX <= (COLH+BOBWIDTH)) &&
               (MouseX >= COLA)))
           {
            if (MouseX < COLB)
             OrigCol = 0;
            else if (MouseX < COLC)
             OrigCol = 1;
            else if (MouseX < COLD)
             OrigCol = 2;
            else if (MouseX < COLE)
             OrigCol = 3;
            else if (MouseX < COLF)
             OrigCol = 4;
            else if (MouseX < COLG)
             OrigCol = 5;
            else if (MouseX < COLH)
             OrigCol = 6;
            else 
             OrigCol = 7;
            if (MouseY < ROW7)
             OrigRow = 7;
            else if (MouseY < ROW6)
             OrigRow = 6;
            else if (MouseY < ROW5)
             OrigRow = 5;
            else if (MouseY < ROW4)
             OrigRow = 4;
            else if (MouseY < ROW3)
             OrigRow = 3;
            else if (MouseY < ROW2)
             OrigRow = 2;
            else if (MouseY < ROW1)
             OrigRow = 1;
            else 
             OrigRow = 0;
            tmp1 = OrigRow & 1L;
            tmp2 = OrigCol & 1L;
            done2 = 0;
            r = OrigRow;
            c = OrigCol;
            l = ((flag.reverse) ? locn (7 - r, 7 - c) : locn (r, c));
            if ((amigacolor[l] == neutral)||(opponent != amigacolor[l]))
             {
              done2 = 1;
             }
            else if (amigacolor[l] == white)
             piece = qxx[amigaboard[l]]; /* white are lower case pieces */
            else
             piece = pxx[amigaboard[l]]; /* black are upper case pieces */
            if (!done2)
             {
              if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
               {
                BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[OrigCol],
			RowArray[OrigRow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
               }
              else
               {
                BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[OrigCol],
			RowArray[OrigRow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
               }
              BobVSprite->X = WIDTH-1-BOBWIDTH;
              BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
              LoadBobImage(BLANKDATA);
              if (SYSTEM_BOBS)
               {
                SortGList(rpG);
                DrawGList(rpG,vP);
               }
              MakeVPort(GfxBase->ActiView,vP);
              MrgCop(GfxBase->ActiView);
              CheckIllegal = 1;
              IllegalMove = 0;
 /* NOW POSITION BOB AND LOAD IN ITS CORRECT PIECE IMAGE */
	      LoadBobImage(piece);
              BobVSprite->X = MouseX - 24;
              BobVSprite->Y = MouseY - 16;
              if (SYSTEM_BOBS)
               {
                SortGList(rpG);
                DrawGList(rpG,vP);
               }
              MakeVPort(GfxBase->ActiView,vP);
              MrgCop(GfxBase->ActiView);
             }
            ModifyIDCMP(wG,NewWindowStructure1.IDCMPFlags | INTUITICKS);
            do {
            signals = Wait(globalsignalset);
            if (signals & WINDOWSIGNAL)
             {
              while ( (message = (struct IntuiMessage *)
	      GetMsg(wG->UserPort) ))
              {
	      class = message->Class;
	      code = message->Code;
              MouseX = message->MouseX;
              MouseY = message->MouseY;
	      ReplyMsg((struct Message *)message);
              if (!done2)
               {
              if ((class == MOUSEBUTTONS)&&(code == SELECTUP))
               { /* now try and make the move */
                done2 = 1;
		if ((MouseX > (COLH+SQUAREWIDTH)) || (MouseX < COLA) ||
                    (MouseY < ROW8) || (MouseY > (ROW1+BOBHEIGHT)))
                 { /* Put the Piece Back */
                   BobVSprite->X = WIDTH-1-BOBWIDTH;
                   BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
                   tmp1 = lastpiece;
		   LoadBobImage(BLANKDATA);
                   if (SYSTEM_BOBS)
                    {
                     SortGList(rpG);
                     DrawGList(rpG,vP);
                     RemIBob(TheBob,rpG,vP);
                     SortGList(rpG);
                     DrawGList(rpG,vP);
                    }
                   MakeVPort(GfxBase->ActiView,vP);
                   MrgCop(GfxBase->ActiView);
		   LoadBobImage(tmp1);
                   ClipBlitTrans (
		      &(BobTransImage->ti_RP),	/* Source RastPort */
		      0, 0,		/* Source LeftEdge, TopEdge */
		      rpG,		/* Destination RastPort */
		      ColArray[OrigCol],RowArray[OrigRow],/* Destination LeftEdge, TopEdge */
		      BobTransImage->ti_IM->Width,	/* Width of Image */
		      BobTransImage->ti_IM->Height,/* Height of Image */
		      BobTransImage->ti_sRP);	/* Shadow RastPort */
                   BobVSprite->X = WIDTH-1-BOBWIDTH;
                   BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
                   LoadBobImage(BLANKDATA);
                   if (SYSTEM_BOBS)
                    {
                     AddBob(TheBob,rpG);
                     SortGList(rpG);
                     DrawGList(rpG,vP);
                    }
                   MakeVPort(GfxBase->ActiView,vP);
                   MrgCop(GfxBase->ActiView);
                 }
                else
                 {
                  done = 1; /* try the move */
                  if (MouseX < COLB)
                   DestCol = 0;
                  else if (MouseX < COLC)
                   DestCol = 1;
                  else if (MouseX < COLD)
                   DestCol = 2;
                  else if (MouseX < COLE)
                   DestCol = 3;
                  else if (MouseX < COLF)
                   DestCol = 4;
                  else if (MouseX < COLG)
                   DestCol = 5;
                  else if (MouseX < COLH)
                   DestCol = 6;
                  else 
                   DestCol = 7;
                  if (MouseY < ROW7)
                   DestRow = 7;
                  else if (MouseY < ROW6)
                   DestRow = 6;
                  else if (MouseY < ROW5)
                   DestRow = 5;
                  else if (MouseY < ROW4)
                   DestRow = 4;
                  else if (MouseY < ROW3)
                   DestRow = 3;
                  else if (MouseY < ROW2)
                   DestRow = 2;
                  else if (MouseY < ROW1)
                   DestRow = 1;
                  else 
                   DestRow = 0;
                  if ((DestRow == OrigRow) && (DestCol == OrigCol))
                   {
                    done = 0;
		    tmp1 = lastpiece;
		    LoadBobImage(BLANKDATA);
                    BobVSprite->X = WIDTH-1-BOBWIDTH;
                    BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
                    if (SYSTEM_BOBS)
                     {
                      SortGList(rpG);
                      DrawGList(rpG,vP);
                      RemIBob(TheBob,rpG,vP);
                      SortGList(rpG);
                      DrawGList(rpG,vP);
                     }
                    MakeVPort(GfxBase->ActiView,vP);
                    MrgCop(GfxBase->ActiView);
		    LoadBobImage(tmp1);
                    ClipBlitTrans (
			&(BobTransImage->ti_RP),	/* Source RastPort */
		     	0, 0,		/* Source LeftEdge, TopEdge */
		     	rpG,		/* Destination RastPort */
		     	ColArray[OrigCol],RowArray[OrigRow],/* Destination LeftEdge, TopEdge */
		     	BobTransImage->ti_IM->Width,	/* Width of Image */
		     	BobTransImage->ti_IM->Height,/* Height of Image */
		     	BobTransImage->ti_sRP);	/* Shadow RastPort */
                    BobVSprite->X = WIDTH-1-BOBWIDTH;
                    BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
                    LoadBobImage(BLANKDATA);
                    if (SYSTEM_BOBS)
                     {
                      AddBob(TheBob,rpG);
                      SortGList(rpG);
                      DrawGList(rpG,vP);
                     }
                    MakeVPort(GfxBase->ActiView,vP);
                    MrgCop(GfxBase->ActiView);
                   }
                  else
                  {
                   MouseDropped = 1;
 		   if (((piece == 'p')&&(DestRow == 7))||/* possible prom wht */
                       ((piece == 'P')&&(!DestRow))) /* possible blk promotion */
                     {
                      PromoteChar = DisplayPromoteRequestor();
                     }
                   tempstr[4] = 0;
                   tempstr[0] = OrigCol + 'a';
                   tempstr[1] = OrigRow + '1';
                   tempstr[2] = DestCol + 'a';
                   tempstr[3] = DestRow + '1';
                   mysprintf(mvnstr,"%d: ",tmovenum);
                   ObtainSemaphore(&mySemaphore);
                   mySetABPenDrMd(rpG,BLACK,bpen,JAM1);
                   Move(rpG,520,USERBOX+6);
                   Text(rpG,mvnstr,strlen(mvnstr));
                   Text(rpG,tempstr,strlen(tempstr));
                   ReleaseSemaphore(&mySemaphore);
		   if ((thinkahead)&&(!flag.bothsides))
                    { // code to abort quickly and drop piece!
                     (void)SetTaskPri((struct Task *)myproc,procpri);
                     if (!TCflag)
                      backsrchaborted = 1;
                     if (!flag.timeout)
                      {
                       flag.back = true;
                      }
                    }
                  }
                 }
               }
              else if (class == INTUITICKS)
               {
                BobVSprite->X = MouseX - 24;
                BobVSprite->Y = MouseY - 16;
                if (SYSTEM_BOBS)
                 {
                  SortGList(rpG);
                  DrawGList(rpG,vP);
                 }
                MakeVPort(GfxBase->ActiView,vP);
                MrgCop(GfxBase->ActiView);
               }
               } /* ! done2 */
              }
             } /* signals & WINDOWSIGNAL */
            } while (!done2);
            ModifyIDCMP(wG,NewWindowStructure1.IDCMPFlags);
            while ( (message = (struct IntuiMessage *)
	     GetMsg(wG->UserPort) ))
             {
	      ReplyMsg((struct Message *)message);
             }
           }
         }
   //} // if message
//    if (done)
//     {
//       while ((message = (struct IntuiMessage *)GetMsg(wG->UserPort)))
//	  ReplyMsg((struct Message *)message);
//     }
  } /* while message */
  //} /* signals & windowsignal */
  } while (!done);
OffMenu(wG,SHOWMENUNUM); 
OffMenu(wG,BOOKMENUNUM); 
OffMenu(wG,SUPERMENUNUM); 
OffMenu(wG,THINKMENUNUM); 
if (tempstr[0])
 {
  if (tempstr[2] == '-')
   {
    for(ilen=2;ilen<strlen(tempstr);ilen++)
     tempstr[ilen] = tempstr[ilen+1];
   }
  if (tempstr[4] == '/')
   {
    for(ilen=4;ilen<strlen(tempstr);ilen++)
     tempstr[ilen] = tempstr[ilen+1];
   }
 }
if ((!PromoteChar)&&((strlen(tempstr) == 2) || (strlen(tempstr) == 4)))
 {
  r = tempstr[1] - '1';
  if ((strlen(tempstr) == 2)&&(opponent == white))
   {
    r--;
   }
  else if ((strlen(tempstr) == 2)&&(opponent == black))
   {
    r++;
   }
  c = tempstr[0] - 'a';
  l = ((flag.reverse) ? locn (7 - r, 7 - c) : locn (r, c));
  if ((amigacolor[l] == neutral)||(opponent != amigacolor[l]))
   {
    done2 = 1;
   }
  else if (amigacolor[l] == white)
   piece = qxx[amigaboard[l]]; /* white are lower case pieces */
  else
   piece = pxx[amigaboard[l]]; /* black are upper case pieces */
  if (strlen(tempstr) == 4)
   {
     r = tempstr[3] - '1';
   }
  else
   {
    if (opponent == white)
     {
      r++;
     }
     else
     {
      r--;
     }
   }
  if (((piece == 'p')&&(r == 7))||/* possible prom wht */
      ((piece == 'P')&&(!r))) /* possible blk promotion */
    {
     PromoteChar = DisplayPromoteRequestor();
     if (strlen(tempstr) == 2)
      {
       if (!r)
        {
         tempstr[4] = 0;
         tempstr[3] = tempstr[1];
         tempstr[2] = tempstr[0];
         tempstr[1]++;
        }
       else
        {
         tempstr[4] = 0;
         tempstr[3] = tempstr[1];
         tempstr[2] = tempstr[0];
         tempstr[1]--;  
        }
      }
    }
 }
if (PromoteChar)
 {
  ilen = strlen(tempstr);
  tempstr[ilen] = PromoteChar;
  tempstr[ilen+1] = 0;
 }
strcpy(str,tempstr);
if (!(stricmp(str,"new")))
 {
    BobVSprite->X = WIDTH-1-BOBWIDTH;
    BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
    LoadBobImage(BLANKDATA);
    if (SYSTEM_BOBS)
     {
      SortGList(rpG);
      DrawGList(rpG,vP);
     }
    MakeVPort(GfxBase->ActiView,vP);
    MrgCop(GfxBase->ActiView);
    WaitTOF();
    RethinkDisplay();
 }
}

void AnimateAmigaMove(str,piece)
char *str;
char piece; /* black are upper case pieces, white lower case */
{
 int side;
 int tmp1,tmp2;
 int srow,scol,erow,ecol,incrx,incry,i;
 long mpiece;


 if ((piece == ' ')||(flag.quit))
  return;
 mpiece = piece;
 if (!MouseDropped)
  {
   BobVSprite->X = WIDTH-1-BOBWIDTH;
   BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
   LoadBobImage(BLANKDATA);
   if (SYSTEM_BOBS)
    {
     SortGList(rpG);
     DrawGList(rpG,vP);
    }
   MakeVPort(GfxBase->ActiView,vP);
   MrgCop(GfxBase->ActiView);
   scol = str[0] - 'a';
   srow = str[1] - '1';
   ecol = str[2] - 'a';
   erow = str[3] - '1';
   tmp1 = srow & 1;
   tmp2 = scol & 1;
   if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
    {
     BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[scol],
		RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
		0xc0L,0xffL,0L);
    }
   else
    {
     BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[scol],
		RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
		0xc0L,0xffL,0L);
    }
   tmp1 = erow & 1;
   tmp2 = ecol & 1;
   if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
    {
     BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[ecol],
		RowArray[erow],SQUAREWIDTH,SQUAREHEIGHT,
		0xc0L,0xffL,0L);
    }
   else
    {
     BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[ecol],
		RowArray[erow],SQUAREWIDTH,SQUAREHEIGHT,
		0xc0L,0xffL,0L);
    }
   BobVSprite->X = ColArray[scol];
   BobVSprite->Y = RowArray[srow];
   LoadBobImage(mpiece);
   if (SYSTEM_BOBS)
    {
     SortGList(rpG);
     DrawGList(rpG,vP);
    }
   MakeVPort(GfxBase->ActiView,vP);
   MrgCop(GfxBase->ActiView);
   incry = (RowArray[erow] - RowArray[srow])/8;
   incrx = (ColArray[ecol] - ColArray[scol])/8;
   for(i=0;i<8;i++)
    {
     BobVSprite->X += incrx;
     BobVSprite->Y += incry;
     if (SYSTEM_BOBS)
      {
       SortGList(rpG);
       DrawGList(rpG,vP);
      }
     MakeVPort(GfxBase->ActiView,vP);
     MrgCop(GfxBase->ActiView);
    }
   if (SYSTEM_BOBS)
    {
     RemIBob(TheBob,rpG,vP);
     SortGList(rpG);
     DrawGList(rpG,vP);
    }
   MakeVPort(GfxBase->ActiView,vP);
   MrgCop(GfxBase->ActiView);
   ClipBlitTrans (
		&(BobTransImage->ti_RP),	/* Source RastPort */
	     	0, 0,		/* Source LeftEdge, TopEdge */
	     	rpG,		/* Destination RastPort */
	     	ColArray[ecol],RowArray[erow],/* Destination LeftEdge, TopEdge */
	     	BobTransImage->ti_IM->Width,	/* Width of Image */
	     	BobTransImage->ti_IM->Height,/* Height of Image */
	     	BobTransImage->ti_sRP);	/* Shadow RastPort */
   BobVSprite->X = WIDTH-1-BOBWIDTH;
   BobVSprite->Y = HEIGHT-1-BOBHEIGHT;
   LoadBobImage(BLANKDATA);
   if (SYSTEM_BOBS)
    {
     AddBob(TheBob,rpG);
    }
   MakeVPort(GfxBase->ActiView,vP);
   MrgCop(GfxBase->ActiView);
   if (piece >= 'a')
    {
     mpiece = 'r';
     srow = 0;
     erow = 0;
     side = white;
     if (str[2] == 'g') /* king side white */
      {
       scol = 7;
       ecol = 5;
      }
     else
      {
       ecol = 3;
       scol = 0;
      }
    }
   else
    {
     mpiece = 'R';
     srow = 7;
     erow = 7;
     side = black;
     if (str[2] == 'g') /* king side black */
      {
       scol = 7;
       ecol = 5;
      }
     else
      {
       ecol = 3;
       scol = 0;
      }
    }
   if (Castled[side])
    {
     Castled[side] = 0;
     tmp1 = srow & 1;
     tmp2 = scol & 1;
     if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
      {
       BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[scol],
			RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
      }
     else
      {
       BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[scol],
			RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
      }
     BobVSprite->X = ColArray[scol];
     BobVSprite->Y = RowArray[srow];
     if (SYSTEM_BOBS)
      {
       SortGList(rpG);
       DrawGList(rpG,vP);
      }
     MakeVPort(GfxBase->ActiView,vP);
     MrgCop(GfxBase->ActiView);
     LoadBobImage(mpiece);
     if (SYSTEM_BOBS)
      {
       SortGList(rpG);
       DrawGList(rpG,vP);
      }
     MakeVPort(GfxBase->ActiView,vP);
     MrgCop(GfxBase->ActiView);
     incry = (RowArray[erow] - RowArray[srow])/8;
     incrx = (ColArray[ecol] - ColArray[scol])/8;
     for(i=0;i<8;i++)
      {
       BobVSprite->X += incrx;
       BobVSprite->Y += incry;
       if (SYSTEM_BOBS)
        {
         SortGList(rpG);
         DrawGList(rpG,vP);
        }
       MakeVPort(GfxBase->ActiView,vP);
       MrgCop(GfxBase->ActiView);
      }
     if (SYSTEM_BOBS)
      {
       RemIBob(TheBob,rpG,vP);
       SortGList(rpG);
       DrawGList(rpG,vP);
      }
     MakeVPort(GfxBase->ActiView,vP);
     MrgCop(GfxBase->ActiView);
     ClipBlitTrans (
			&(BobTransImage->ti_RP),	/* Source RastPort */
		     	0, 0,		/* Source LeftEdge, TopEdge */
		     	rpG,		/* Destination RastPort */
		     	ColArray[ecol],RowArray[erow],/* Destination LeftEdge, TopEdge */
		     	BobTransImage->ti_IM->Width,	/* Width of Image */
		     	BobTransImage->ti_IM->Height,/* Height of Image */
		     	BobTransImage->ti_sRP);	/* Shadow RastPort */
     LoadBobImage(BLANKDATA);
     if (SYSTEM_BOBS)
      {
       AddBob(TheBob,rpG);
      }
     MakeVPort(GfxBase->ActiView,vP);
     MrgCop(GfxBase->ActiView);
    }
   else /* check EnPassant */
    {
     side ^= 1;
     if (myEnPassant[side])
      {
       myEnPassant[side] = 0;
       scol = str[2] - 'a';
       if (str[3] == '3') /* white is removed from bd at 4*/
        {
         srow = 3;
        }
       else /* black is removed at pos 5 */
        {
         srow = 4;
        }
       tmp1 = srow & 1;
       tmp2 = scol & 1;
       if (((!tmp1) && (!tmp2)) || ((tmp1)&&(tmp2)))
        {
         BltBitMap(BlackBitMap,0,0,myBitMap,ColArray[scol],
			RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
        }
       else
        {
         BltBitMap(WhiteBitMap,0,0,myBitMap,ColArray[scol],
			RowArray[srow],SQUAREWIDTH,SQUAREHEIGHT,
			0xc0L,0xffL,0L);
        }
      }
    }
  }
}

#endif /* AMIGA */


void GetTimeString(str)
char *str;
{
#ifdef AMIGA
#endif
}



char __aligned *ColorStr[2];
char __far __aligned *CP[CPSIZE];
/*
 * In a networked enviroment gnuchess might be compiled on different hosts
 * with different random number generators, that is not acceptable if they
 * are going to share the same transposition table.
 */

unsigned int urand (void);


unsigned long __aligned hashkey, hashbd;
#ifdef LONGINTS2
struct hashval __far hashcode[2][7][64];
#else
struct hashval __aligned hashcode[2][7][64];
#endif

#ifdef CACHE
#ifdef ttblsz
struct hashentry huge __aligned *ttable[2];
unsigned int __aligned ttblsize;
#endif

#else

#ifdef ttblsz
struct hashentry __aligned __far ttable[2][vttblsz + MAXrehash];
unsigned int __aligned ttblsize;
#endif

#endif

char __far __aligned savefile[128] = "";
char __far __aligned listfile[128] = "";
#ifdef HISTORY
unsigned char __far __aligned history[32768];
#endif
INTSIZE __aligned rpthash[2][256];
struct leaf __far __aligned Tree[TREE];
struct leaf  __aligned *root;
INTSIZE __aligned TrPnt[MAXDEPTH];
INTSIZE __aligned PieceList[2][64], PawnCnt[2][8];
INTSIZE __aligned castld[2], Mvboard[64];
INTSIZE __aligned svalue[64];
struct flags __aligned flag;
INTSIZE __aligned opponent, computer, WAwindow, WBwindow, BAwindow, BBwindow, dither, INCscore;
long __aligned ResponseTime, ExtraTime, MaxResponseTime, et, et0, time0, ft;
long __aligned GenCnt, NodeCnt, ETnodes, EvalNodes, HashCnt, HashAdd, FHashCnt, FHashAdd, HashCol,
 THashCol, filesz;
long __aligned replus, reminus;
INTSIZE __aligned HashDepth = HASHDEPTH, HashMoveLimit = HASHMOVELIMIT;
INTSIZE __aligned player, xwndw, rehash;
struct GameRec __aligned GameList[MAXMOVES + MAXDEPTH];
INTSIZE __aligned Sdepth, GameCnt, Game50, MaxSearchDepth;
INTSIZE __aligned epsquare, contempt;
int __aligned Book;
struct TimeControlRec __aligned TimeControl;
INTSIZE __aligned TCflag, TCmoves, TCminutes, TCseconds, OperatorTime;
INTSIZE __aligned XCmoves[3], XCminutes[3], XCseconds[3], XC, XCmore;
const INTSIZE __aligned otherside[3] =
{black, white, neutral};
unsigned INTSIZE __aligned hint;
INTSIZE int __aligned TOflag;		/* force search re-init if we backup search */

INTSIZE __aligned mtl[2], pmtl[2], hung[2];
INTSIZE __aligned Pindex[64];
INTSIZE __aligned PieceCnt[2];
INTSIZE __aligned FROMsquare, TOsquare;
INTSIZE __aligned HasKnight[2], HasBishop[2], HasRook[2], HasQueen[2];
INTSIZE __aligned ChkFlag[MAXDEPTH], CptrFlag[MAXDEPTH], PawnThreat[MAXDEPTH];
INTSIZE __aligned Pscore[MAXDEPTH], Tscore[MAXDEPTH];
const INTSIZE __aligned qrook[3] =
{0, 56, 0};
const INTSIZE __aligned krook[3] =
{7, 63, 0};
const INTSIZE __aligned kingP[3] =
{4, 60, 0};
const INTSIZE __aligned rank7[3] =
{6, 1, 0};
const INTSIZE __aligned sweep[8] =
{false, false, false, true, true, true, false, false};
unsigned INTSIZE __aligned killr0[MAXDEPTH], killr1[MAXDEPTH];
unsigned INTSIZE __aligned killr2[MAXDEPTH], killr3[MAXDEPTH];
unsigned INTSIZE __aligned PV, SwagHt, Swag0, Swag1, Swag2, Swag3, Swag4;

#ifdef USE_SIDEBIT
unsigned INTSIZE __aligned sidebit;
#endif

#ifdef KILLT
INTSIZE __far __aligned killt[0x4000];
#endif
const INTSIZE __aligned value[7] =
{0, valueP, valueN, valueB, valueR, valueQ, valueK};
const INTSIZE __aligned control[7] =
{0, ctlP, ctlN, ctlB, ctlR, ctlQ, ctlK};
INTSIZE __aligned stage, stage2, Developed[2];
FILE __aligned *hashfile;
unsigned int __aligned starttime;
INTSIZE int __aligned ahead = true, hash = true;

#if defined CHESSTOOL || defined XBOARD
void
TerminateChess (int sig)
{
  ExitChess();
}
#endif

int __aligned timeopp[MINGAMEIN], timecomp[MINGAMEIN];
int __aligned compptr, oppptr;

inline void
TimeCalc ()
{
/* adjust number of moves remaining in gamein games */
  int increment = 0;
  int topsum = 0;
  int tcompsum = 0;
  int me,him;
  int i;
/* dont do anything til you have enough numbers */
  if (GameCnt < (MINGAMEIN * 2)) return;
/* calculate average time in sec for last MINGAMEIN moves */
  for (i = 0; i < MINGAMEIN; i++)
    {
      tcompsum += timecomp[i];
      topsum += timeopp[i];
    }
  topsum /= (100 * MINGAMEIN);
  tcompsum /= (100 * MINGAMEIN);
/* if I have less time than opponent add another move */
	me = TimeControl.clock[computer]/100; 
	him = TimeControl.clock[opponent]/100;
	if(me < him) increment += 2;
/* if I am losing more time with each move add another */
  /*if ( !((me - him) > 60) && tcompsum > topsum) increment++;*/
  if ( tcompsum > topsum) increment +=2;
/* but dont let moves go below MINMOVES */
  else if (TimeControl.moves[computer] < MINMOVES && !increment) increment++;
/* if I am doing really well use more time per move */
  else if (me > him && tcompsum < topsum) increment = -1;
  TimeControl.moves[computer] += increment;
}


/* hmm.... shouldn`t main be moved to the interface routines */
int
main (int aargc, char **aargv)
{
  char cstring[40];
  char *xwin = 0;
  char *Lang = NULL;

#ifdef AMIGA
 int tmpargcnt;
 struct WBStartup *startmsg;
 struct ExecBase **execbaseptr=(struct ExecBase **)4L;
 UWORD cpuid;
 struct ExecBase *execbase;
 BPTR fp;
 APTR tempxx;
 struct WBArg *mywbptr;
 struct DiskObject *dob;

 execbase = *execbaseptr;
 cpuid = execbase->AttnFlags;
 
 if (!(cpuid & AFF_68020))
  {
   exit(0);
  }
 gfxversion = GfxBase->LibNode.lib_Version;
 if (gfxversion < 37)
  exit(-1);
 if (!aargc)
  {
   startmsg = (struct WBStartup *)aargv;
   mywbptr = startmsg->sm_ArgList; 
   if (dob = GetDiskObject (mywbptr->wa_Name))
    {
     xwin = FindToolType(dob->do_ToolTypes,"PRI");
     if (xwin)
      {
       procpri = xwin[0] - '0';
       if (procpri < 0)
        procpri = 0;
       if (procpri > 4)
        procpri = 4;
      }
     xwin = FindToolType(dob->do_ToolTypes,"COLORS");
     if (xwin)
      {
       if ((xwin[0] == '1')&&(xwin[1] == '6'))
        gfxversion = 37;
       else if ((xwin[0] == '6')&&(xwin[1] == '4'))
        FasterDisplay = 1;
      }
     xwin = FindToolType(dob->do_ToolTypes,"MONITOR");
     if (xwin)
      {
       if ((xwin[0] == '1')&&(xwin[1] == '5'))
        v15Khz = 1;
      }
     xwin = FindToolType(dob->do_ToolTypes,"FASTAGA");
     if (xwin)
      {
       if ((xwin[0] == '1')||(xwin[0] == 'O')||(xwin[0] == 'o'))
        FasterDisplay = 1;
      }
     xwin = FindToolType(dob->do_ToolTypes,"SUPER72");
     if (xwin)
      {
       if ((xwin[0] == '1')||(xwin[0] == 'O')||(xwin[0] == 'o'))
        Super72 = 1;
      }
     xwin = FindToolType(dob->do_ToolTypes,"RTG");
     if (xwin)
      {
       if ((xwin[0] == '1')||(xwin[0] == 'O')||(xwin[0] == 'o'))
        RTG = 1;
      }
//     xwin = FindToolType(dob->do_ToolTypes,"PICASSO");
//     if (xwin)
//      {
//       if ((xwin[0] == '1')||(xwin[0] == 'O')||(xwin[0] == 'o'))
//        Picasso = 1;
//      }
     xwin = FindToolType(dob->do_ToolTypes,"NO_BOBS");
     if (xwin)
      {
       if ((xwin[0] == '1')||(xwin[0] == 'O')||(xwin[0] == 'o'))
        SYSTEM_BOBS = 0;
      }
     FreeDiskObject (dob);
    }
   xwin = 0L;
  }
 else if (aargc > 1)
  {
   for(tmpargcnt=1;tmpargcnt<aargc;tmpargcnt++)
    {
     if (!(strcmp(aargv[tmpargcnt],"16")))
      {
       gfxversion = 37;
      }
     else if (!(stricmp(aargv[tmpargcnt],"Super72")))
      {
       Super72 = 1;
      }
     else if (!(stricmp(aargv[tmpargcnt],"RTG")))
      {
       RTG = 1;
      }
     else if (!(stricmp(aargv[tmpargcnt],"NOBOBS")))
      {
       SYSTEM_BOBS = 0;
      }
     else if (!(stricmp(aargv[tmpargcnt],"15KHZ")))
      {
       v15Khz = 1;
      }
//     else if (!(stricmp(aargv[tmpargcnt],"PICASSO")))
//      {
//       Picasso = 1;
//      }
     else if ((!(stricmp(aargv[tmpargcnt],"FASTAGA")))||((!(strcmp(aargv[tmpargcnt],"64")))))
      {
       FasterDisplay = 1;
      }
     else if (strcmp(aargv[tmpargcnt],"256"))
      {
       procpri=atoi(aargv[tmpargcnt]);
       if (procpri < 0)
         procpri = 0;
       if (procpri > 4)
        procpri = 4;
      }
    }
  }
 if (gfxversion < 39)
  RTG = Super72 = 0;
 if (RTG)
  {
   FasterDisplay = 0;
   v15Khz = 0;
  }
// if (!RTG)
//  Picasso = 0;
 Delay(3L);
 myproc = (struct Process *)FindTask(0L);
 tempxx = myproc->pr_WindowPtr;
 Delay(3L);
 myproc->pr_WindowPtr = (APTR)-1L;
 if (!(fp = Open("uchess:uchess.lang",MODE_OLDFILE)))
  {
   system("Assign >nil: uchess: \"\"");
  }
 else
  Close(fp);
 myproc->pr_WindowPtr = tempxx;
#endif

  
  gsrand (starttime = ((unsigned int) time ((long *) 0)));	/* init urand */
#ifdef ttblsz
  ttblsize = ttblsz;
  rehash = -1;
#endif /* ttblsz */
  flag.easy = 0;
#ifndef AMIGA
  if (argc > 2)
    {
      if (argv[1][0] == '-' && argv[1][1] == 'L')
	{
	  Lang = argv[2];
	  argv += 2;
	  argc -= 2;
	}
    }
#endif
  InitConst (Lang);
  ColorStr[0] = CP[118];
  ColorStr[1] = CP[119];

#ifndef AMIGA
  while (argc > 1 && ((argv[1][0] == '-') || (argv[1][0] == '+')))
    {
      switch (argv[1][1])
	{
	case 'a':
	  ahead = ((argv[1][0] == '-') ? false : true);
	  break;
	case 'h':
	  hash = ((argv[1][0] == '-') ? false : true);
	  break;
	case 's':
	  argc--;
	  argv++;
	  if (argc > 1)
	    strcpy (savefile, argv[1]);
	  break;
	case 'l':
	  argc--;
	  argv++;
	  if (argc > 1)
	    strcpy (listfile, argv[1]);
	  break;

#if ttblsz
	case 'r':
	  if (argc > 2)
	    rehash = atoi (argv[2]);
	  argc--;
	  argv++;
	  if (rehash > MAXrehash)
	    rehash = MAXrehash;
	  break;
	case 'T':
	  if (argc > 2)
	    ttblsize = atoi (argv[2]);
	  argc--;
	  argv++;
	  if (ttblsize > 0 && ttblsize < 24)
	    ttblsize = (1 << ttblsize);
	  else
	    ttblsize = ttblsz;
	  break;
#ifdef HASHFILE
	case 't':		/* create or test persistent transposition
				 * table */
	  hashfile = fopen (HASHFILE, RWA_ACC);
	  if (hashfile)
	    {
	      fseek (hashfile, 0L, SEEK_END);
	      filesz = (ftell (hashfile) / sizeof (struct fileentry)) - 1;
	    }
	  if (hashfile != NULL)
	    {
	      long i, j;
	      int nr[MAXDEPTH];
	      struct fileentry n;

	      /*ShowMessage (CP[49]);*/
	      for (i = 0; i < MAXDEPTH; i++)
		nr[i] = 0;
	      fseek (hashfile, 0L, SEEK_END);
	      i = ftell (hashfile) / sizeof (struct fileentry);
	      fseek (hashfile, 0L, SEEK_SET);
	      for (j = 0; j < i + 1; j++)
		{
		  fread (&n, sizeof (struct fileentry), 1, hashfile);
		  if (n.depth)
		    {
		      nr[n.depth]++;
		      nr[0]++;
		    }
		}
	      sprintf (astr,CP[109],
		      nr[0], i);
              /*ShowMessage(astr);*/
	      for (j = 1; j < MAXDEPTH; j++)
               /*
		printf ("%d ", nr[j]);
	      printf ("\n")*/;
	    }
	  return 0;
	case 'c':		/* create or test persistent transposition
				 * table */
	  if (argc > 2)
	    filesz = atoi (argv[2]);
	  if (filesz > 0 && filesz < 24)
	    filesz = (1 << filesz) - 1 + MAXrehash;
	  else
	    filesz = Deffilesz + MAXrehash;
	  if ((hashfile = fopen (HASHFILE, RWA_ACC)) == NULL)
	    hashfile = fopen (HASHFILE, WA_ACC);
	  if (hashfile != NULL)
	    {
	      long j;
	      struct fileentry n;

	      /*printf (CP[66]);*/
	      for (j = 0; j < 32; j++)
		n.bd[j] = 0;
	      n.f = n.t = 0;
	      n.flags = 0;
	      n.depth = 0;
	      n.sh = n.sl = 0;
	      for (j = 0; j < filesz + 1; j++)
		fwrite (&n, sizeof (struct fileentry), 1, hashfile);
	      fclose (hashfile);
	    }
	 /* else
	    printf (CP[50], HASHFILE);*/
	  return (0);
#endif /* HASHFILE */
#endif /* ttblsz */
	case 'x':
	  xwin = &argv[1][2];
	  break;
	case 'v':
/*	  fprintf (stderr, CP[102], version, patchlevel);*/
	  exit (1);
	default:
	  /*fprintf (stderr, CP[113]);*/
	  exit (1);
	}
      argv++;
      argc--;
    }
#endif
  XC = 0;
  MaxResponseTime = 0;
#if defined CHESSTOOL || defined XBOARD
  signal (SIGTERM, TerminateChess);
  TCflag = true;
  TCmoves = 40;
  TCminutes = 120;
  TCseconds = 0;
  TCadd = 0;
  OperatorTime = 0;
#else
/*  TCflag = false;*/
/*  OperatorTime = 0;*/
  TCflag = true;
  TCmoves = 60;
  TCminutes = 10;
  TCseconds = 0;
  OperatorTime = 0;
#endif
#ifndef AMIGA
  if (argc == 2)
    {
      char *p;

      MaxResponseTime = 100L*strtol(argv[1], &p, 10);
      if (*p == ':')
	MaxResponseTime = 60L*MaxResponseTime + 
	    100L*strtol(++p, (char **) NULL, 10);
      TCflag = false;
      TCmoves = 0;
      TCminutes = 0;
      TCseconds = 0;
    }
  if (argc >= 3)
    {
      char *p;
      if (argc > 9)
	{
	 /* printf ("%s\n", CP[220]);*/
	  exit (1);
	}
      TCmoves = atoi (argv[1]);
      TCminutes = strtol (argv[2], &p, 10);
      if (*p == ':')
	TCseconds = strtol (p + 1, (char **) NULL, 10);
      else
	TCseconds = 0;
      TCflag = true;
      argc -= 3;
      argv += 3;
      while (argc > 1)
	{
	  XCmoves[XC] = atoi (argv[0]);
	  XCminutes[XC] = strtol (argv[1], &p, 10);
	  if (*p == ':')
	    XCseconds[XC] = strtol (p + 1, (char **) NULL, 10);
	  else
	    XCseconds[XC] = 0;
	  if (XCmoves[XC] && (XCminutes[XC] || XCseconds[XC]))
	    XC++;
	  else
	    {
	      /*printf (CP[220]);*/
	      exit (1);
	    }
	  argc -= 2;
	  argv += 2;
	}
      if (argc)
	{
	  /*printf ("%s\n", CP[220]);*/
	  exit (1);
	}
    }
#endif /* AMIGA */
#ifdef AMIGA
 (void)SetTaskPri((struct Task *)myproc,procpri);
 Delay(3L);
 if (!AmigaStartup())
  {
   exit(2);
  }
#endif
  Initialize ();
#ifndef CACHE
#ifdef ttblsz
  Initialize_ttable ();
#endif /* ttblsz */
#endif
  Initialize_dist ();
  Initialize_moves ();
  FirstTime = 1;
  NewGame ();
  flag.easy = ahead;
  flag.hash = hash;
  if (xwin)
    xwndw = atoi (xwin);

  hashfile = NULL;
#if ttblsz
#ifdef HASHFILE
  hashfile = fopen (HASHFILE, RWA_ACC);
  if (hashfile)
    {
      fseek (hashfile, 0L, SEEK_END);
      filesz = ftell (hashfile) / sizeof (struct fileentry) - 1;
    }
#if !defined CHESSTOOL && !defined XBOARD
  else
    ShowMessage (CP[98]);
#endif
#endif /* HASHFILE */
#endif /* ttblsz */
#ifdef AMIGA
 SetMenuStrip(wG,&MenuList1);	/* attach any Menu */
 MenuStripSet = 1;
 EnableMoveNow();
#endif
  while (!(flag.quit))
    {
      oppptr = (oppptr + 1) % MINGAMEIN;
      if (flag.bothsides && !flag.mate)
       {
        SetPointer(wG,myPointer,PTRHEIGHT,0x10L,0L,0L);
	SelectMove (opponent, 1);
       }
      else
        {
 	 InputCommand (cstring);
        }

      if (opponent == black)
	if (flag.gamein || TCadd)
	  {
	    TimeCalc ();
	  }
	else if (TimeControl.moves[opponent] == 0)
	  {
	    if (XC)
	      if (XCmore < XC)
		{
		  TCmoves = XCmoves[XCmore];
		  TCminutes = XCminutes[XCmore];
		  TCseconds = XCseconds[XCmore];
		  XCmore++;
		}
	    SetTimeControl2 (opponent);
	  }

      compptr = (compptr + 1) % MINGAMEIN;


      if (SupervisorMode)
       {
	  computer = computer ^ 1;
	  opponent = opponent ^ 1;
	  xwndw = (computer == white) ? WXWNDW : BXWNDW;
	  flag.force = false;
	  Sdepth = 0;
       }
      else if (!(flag.quit || flag.mate || flag.force))
	{
          SetPointer(wG,myPointer,PTRHEIGHT,0x10L,0L,0L);
	  SelectMove (computer, 1);
	  if (computer == black)
	    if (flag.gamein)
	      {
		TimeCalc ();
	      }
	    else if (TimeControl.moves[computer] == 0)
	      {
		if (XC)
		  if (XCmore < XC)
		    {
		      TCmoves = XCmoves[XCmore];
		      TCminutes = XCminutes[XCmore];
		      TCseconds = XCseconds[XCmore];
		      XCmore++;
		    }
		SetTimeControl2 (computer);
	      }
	}
      if ((flag.mate)&&(!Mate)&&(!DrawnGame))
       ShowMessage("CheckMate");
      if (Mate)
       {
        ShowMessage(MateString);
       }
      else if (DrawnGame)
       {
        ShowMessage("Draw..");
       }
      else if ((!flag.mate)&&(PlayMode == 2)&&(!ResignOffered)&&(!flag.quit))
       {
        if (global_tmp_score < -950)
         {
          if (DoResign())
           {
            ClearPointer(wG);
            flag.mate = true;
            flag.back = true;
            Mate = 1;
            ShowMessage("You Win!");
            ShowMessage("UChess Resigns");
           }
         }
       }
    }
#if ttblsz
#ifdef HASHFILE
  if (hashfile)
    fclose (hashfile);
#endif /* HASHFILE */
#endif /* ttblsz */

  ExitChess ();
}
