#include <exec/types.h>
#include <exec/memory.h>
#include <exec/execbase.h>
#include <dos/dos.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <graphics/gfxbase.h>
#include <graphics/rastport.h>
#include <graphics/view.h>
#include <graphics/displayinfo.h>
#include <stdio.h>
#include <string.h>
#include <h/rot.h>
#include <h/define.h>

extern struct ExecBase *SysBase;

extern struct gameinput in;
extern struct control control;
extern struct gameinfo gi;
extern struct ship ship[7];
extern struct asteroid a[32];
extern struct saucer saucer;
extern struct MsgPort *inputDevPort;
extern struct keys k;

struct NewWindow newmasterwindow =
{
0,0,
0,0,
0,0,
RAWKEY,
NOCAREREFRESH | ACTIVATE | BACKDROP | BORDERLESS,
NULL,
NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,
CUSTOMSCREEN};


struct TextAttr basic;
struct TextAttr hires;
struct TextAttr fixplain7;
struct TextFont *basicfont,*fixplain7font,*hiresfont;
struct TextFont *lfont,*mfont,*sfont;

struct BitMap *bm1[2];

struct RasInfo *ri1;
struct ViewPort *vp;
struct RastPort *rp1[2];

struct GfxBase *GfxBase;
struct IntuitionBase *IntuitionBase;
struct Library *DiskfontBase;
struct Library	*IFFParseBase;

struct Screen *screen;
struct Screen *screen2;
struct Window *masterwindow;
struct RastPort *mwrp;
UWORD *pdata;


LONG AllocateBitmaps();
LONG CreateDisplay();
LONG GetWorkbenchData();


Initialization()
{
LONG error;

LoadFonts();

error = AllocateBitmaps();
if (error == -1)
    {
	makerequest("Bitmap Allocation Error");
	DeallocateBitmaps();
	CloseFonts();
	CloseLibraries();
	exit(NULL);
    }


error = CreateDisplay();
if (error == -1)
    {
	ClearPointer(masterwindow);
	if (pdata) FreeMem(pdata,12);
	if (masterwindow) CloseWindow(masterwindow);
	if (screen) CloseScreen(screen);
	if (rp1[1]) FreeMem(rp1[1],sizeof(struct RastPort));

	DeallocateBitmaps();
	CloseFonts();
	CloseLibraries();
	exit(NULL);
    }


SetRGB4(vp,0,0,0,0);
SetRGB4(vp,1,15,15,15);
SetRGB4(vp,2,5,7,7);
SetRGB4(vp,3,15,10,10);

LoadAllImages();
DefineShips();
RendVectors();
LoadAllSounds();
LoadHighScores();
initaudio();
addtimer();
addgameport();
addhandler();
}


Cleanup()
{
removehandler();
removegameport();
removetimer();
closeaudio();
freeimages();

ClearPointer(masterwindow);
if (pdata) FreeMem(pdata,12);
if (masterwindow) CloseWindow(masterwindow);
if (screen) CloseScreen(screen);
if (rp1[1]) FreeMem(rp1[1],sizeof(struct RastPort));

DeallocateBitmaps();

CloseFonts();
CloseLibraries();
exit(0);
}


CloseFonts()
{
if (lfont) CloseFont(lfont);
if (mfont) CloseFont(mfont);
if (sfont) CloseFont(sfont);
}

CloseLibraries()
{
if (IFFParseBase)  CloseLibrary(IFFParseBase);
if (DiskfontBase)  CloseLibrary((struct Library *)DiskfontBase);
if (GfxBase)	    CloseLibrary(GfxBase);
if (IntuitionBase) CloseLibrary(IntuitionBase);
}

DeallocateBitmaps()
{
LONG i,x;

for (i=0;i<2;i++)
    {
	for (x=0;x<gi.de;x++)
		if (bm1[i]->Planes[x]) FreeRaster(bm1[i]->Planes[x],gi.wi,gi.he);

	if (bm1[i]) FreeMem(bm1[i],sizeof(struct BitMap));
    }
}


makerequest(string)
UBYTE *string;
{

struct EasyStruct es = 
{
 sizeof(struct EasyStruct),
 NULL,
 "AsteriodsII Error",
 "%s",
 "ok"
};

EasyRequest(masterwindow,&es,NULL,string);
}


OpenLibraries()
{
IntuitionBase = (struct IntuitionBase *) OpenLibrary("intuition.library",NULL);
if (IntuitionBase == NULL) makerequest("IntuitionBase Error");

GfxBase = (struct GfxBase *) OpenLibrary("graphics.library",NULL);
if (GfxBase == NULL) makerequest("GfxBase Error");

DiskfontBase = (struct Library *) OpenLibrary("diskfont.library",NULL);
if (DiskfontBase == NULL) makerequest("DiskfontBase Error");

IFFParseBase = (struct Library *)OpenLibrary("iffparse.library",37);
if (IFFParseBase == NULL) makerequest("IFFParseBase Error");

if ((IntuitionBase==NULL)||(GfxBase==NULL)||(DiskfontBase==NULL)||(IFFParseBase==NULL))
    {
	CloseLibraries();
	exit(NULL);
    }
}


LoadFonts()
{
basic.ta_Name  = "basic.font";
basic.ta_YSize = 32;
basicfont = (struct TextFont *)OpenDiskFont(&basic);
if (basicfont == NULL) makerequest("Basic.font Error");
lfont = basicfont;

fixplain7.ta_Name  = "diamond.font";
fixplain7.ta_YSize = 12;
fixplain7font = (struct TextFont *)OpenDiskFont(&fixplain7);
if (fixplain7font == NULL) makerequest("Diamond.font Error");
mfont = fixplain7font;

hires.ta_Name  = "hires-5a.font";
hires.ta_YSize = 8;
hiresfont = (struct TextFont *)OpenDiskFont(&hires);
if (hiresfont == NULL) makerequest("Hires-5a.font error");
sfont = hiresfont;

if ((lfont == NULL) || (mfont == NULL) || (sfont == NULL))
    {
	makerequest("Copy Game Fonts to FONTS:");
	CloseFonts();
	CloseLibraries();
	exit(NULL);
    }
}



LONG AllocateBitmaps()
{
LONG i,x;

for (i=0;i<2;i++)
    {
	bm1[i] = (struct BitMap *)AllocMem(sizeof(struct BitMap),MEMF_CLEAR);
	InitBitMap(bm1[i],gi.de,gi.wi,gi.he);

	for (x=0;x<gi.de;x++)
	    {
		bm1[i]->Planes[x] = (PLANEPTR)AllocRaster(gi.wi,gi.he);
		if (bm1[i]->Planes[x] == NULL) return(-1);
		else BltClear(bm1[i]->Planes[x],RASSIZE(gi.wi,gi.he),NULL);
	    }
    }

}

LONG CreateDisplay()
{
LONG i,error;

screen = (struct Screen *)OpenScreenTags(NULL,
					SA_BlockPen,0,
					SA_DetailPen,0,
					SA_Width,gi.wi,
					SA_Height,gi.he,
					SA_Depth,gi.de,
					SA_DisplayID,gi.screentype,
					SA_Quiet,TRUE,
					SA_Overscan, OSCAN_TEXT,
					SA_BitMap,bm1[0],
					SA_ErrorCode,&error,
					TAG_DONE);
if (screen == NULL)
    {
	makerequest("Unable to Open Screen");
	return(-1);
    }
else
    {
	rp1[0] = &(screen->RastPort);
	vp = &(screen->ViewPort);
	ri1 = vp->RasInfo;
	rp1[1] = (struct RastPort *)AllocMem(sizeof(struct RastPort),MEMF_CLEAR);
	InitRastPort(rp1[1]);
	rp1[1]->BitMap = bm1[1];

	newmasterwindow.Width = gi.wi;
	newmasterwindow.Height= gi.he;
	newmasterwindow.Screen = screen;
	masterwindow = (struct Window *)OpenWindow(&newmasterwindow);
	if (masterwindow == NULL)
	    {
		makerequest("Unable to Open Window");
		return(-1);
	    }
	mwrp = masterwindow->RPort;
	for (i=0;i<2;i++) SetDrMd(rp1[i],JAM1);

	pdata = (UWORD *)AllocMem(12,MEMF_CHIP|MEMF_CLEAR);
	SetPointer(masterwindow,pdata,1,16,0,0);

	return(0);
    }
}






changeview(bit)
LONG bit;
{
ri1->BitMap = bm1[bit];
MakeScreen(screen);
RethinkDisplay();
}


SwapScreen()
{
LONG error;

ClearPointer(masterwindow);
if (pdata) FreeMem(pdata,12);
if (masterwindow) CloseWindow(masterwindow);
if (screen) CloseScreen(screen);
if (rp1[1]) FreeMem(rp1[1],sizeof(struct RastPort));
DeallocateBitmaps();


SetGameScreen();

error =  AllocateBitmaps();
if (error == -1)
    {
	makerequest("Error Allocating Bitmap");
	Cleanup();
    }

error = CreateDisplay();
if (error == -1)
    {
	makerequest("Error Changing Screen");
	Cleanup();
    }

SetRGB4(vp,0,0,0,0);
SetRGB4(vp,1,15,15,15);
SetRGB4(vp,2,5,7,7);
SetRGB4(vp,3,15,10,10);

RethinkDisplay();
}


GetDefaults()
{
LONG x;

k.left = L;
k.right= R;
k.fire = F;
k.thrust=T;
k.hyperspace=P;
k.pause= SPACE;

control.screentype = 0;
control.fontsize = 0;
 
gi.largefontheight = 32;
gi.mediumfontheight = 12;
gi.smallfontheight = 8;

gi.de = 2;
gi.wi = 640;
gi.he = 440;
gi.screentype = HIRESLACE_KEY;

control.delay = 42000;
control.maxenemynum = 4;
control.maxplayernum = 2;
control.enemyonscreen = 3;
control.playmode = 0;
control.difficulty = 2;

#if REGISTERED == TRUE
	control.game = 2;
#else
	control.game = 0;
#endif

for(x=0;x<control.maxenemynum+control.playernum;x++)
	ship[x].pilot = DESTROYED;

for(x=0;x<control.maxplayernum;x++)
    {
	control.wait[x] = 30;
	control.firedelay[x] = 4;
    }
saucer.flag = FALSE;
control.input[0] = 0;
control.input[1] = 1;
control.playernum = 1;
control.asteroidnum = 16;
control.explosionnum = 32;
control.hypernum = 40;
control.boxnum = 20;
control.thrustlength = 17;
control.ftrnum = 8;
control.minenum = 40;
control.debrisnum = 60;
control.battleshipnum = 1;
control.startlevel = 1;
control.standarddebris = 16;
control.audio = TRUE;
}



SetGameFont()
{
if (control.fontsize == 0)
    {
	gi.smallfontheight = 8;
	hiresfont = sfont;
    }
else
if (control.fontsize == 1)
    {
	gi.smallfontheight = 12;
	hiresfont = mfont;
    }
}


SetGameScreen()
{
LONG error;

if (control.screentype == 0)
    {
	gi.de = 2;
	error = GetWorkbenchData();
	if (error == -1)
	    {
		makerequest("Cant Find Public Screen");
		control.screentype = 1;
	    }
    }

if (control.screentype == 1)
    {
	gi.de = 2;
	gi.wi = 640;
	gi.he = 440;
	gi.screentype = HIRESLACE_KEY;
    }

if (control.screentype == 2)
    {
	gi.de = 2;
	gi.wi = 640;
	gi.he = 520;
	gi.screentype = HIRESLACE_KEY | PAL_MONITOR_ID;
    }

if (control.screentype == 3)
    {
	gi.de = 2;
	gi.wi = 1280;
	gi.he = 440;
	gi.screentype = SUPERLACE_KEY;
    }

if (control.screentype == 4)
    {
	gi.de = 2;
	gi.wi = 1280;
	gi.he = 520;
	gi.screentype = SUPERLACE_KEY | PAL_MONITOR_ID;
    }


gi.x1 = 45;
gi.y1 = 45;
gi.x2 = gi.wi-45;
gi.y2 = gi.he-45;
gi.dx = gi.x2-gi.x1;
gi.dy = gi.y2-gi.y1;
}


LONG GetWorkbenchData()
{
struct Screen *clone;
UBYTE *name = "Workbench";

clone = (struct Screen *)LockPubScreen(name);

if (clone == NULL) return(-1);
else
    {
	gi.screentype = GetVPModeID(&(clone->ViewPort));
	gi.wi = clone->Width;
	gi.he = clone->Height;
    }

UnlockPubScreen(name,clone);
}
