/* This handles drawing the pictures (gels) in the game Trippin. */


#include <exec/memory.h>
#include <graphics/gfx.h>
#include <graphics/sprite.h>
#include <graphics/rastport.h>
#include <graphics/gels.h>
#include <graphics/gfxbase.h>
#include <intuition/intuition.h>
#include "trip.h"


#define TMPIZE (long) RASSIZE(200, 50)


import void ShoveMenus();

import ubyte board[8][8];

import piece oo, bb;

import struct Menu manyou;


struct GfxBase *GfxBase;


struct NewWindow boardwin = {
    81, 12, 16 * SQIZE + 4 + MARGINWID, 8 * SQIZE + 12, -1, -1,
    MOUSEBUTTONS | MOUSEMOVE | MENUPICK | CLOSEWINDOW,
    REPORTMOUSE | WINDOWDRAG | WINDOWDEPTH | WINDOWCLOSE
			| SMART_REFRESH | ACTIVATE,
    null, null, (ubyte *) "Tripppin          by Paul Kienitz", null, null,
    0, 0, 0, 0, WBENCHSCREEN
};


struct Window *win;


/* image data created by GetImage program from fish 345 */

private UWORD ecks[23] = {
    0, 0,
    0, 0x60c0,
    0, 0x71c0,
    0, 0x3b80,
    0, 0x1f00,
    0, 0x0e00,
    0, 0x1f00,
    0, 0x3b80,
    0, 0x71c0,
    0, 0x60c0,
    0, 0, 0
};


WORD rawimage[IMHITE << 2] = {
    0x0000,0x0000,
    0x00fc,0x0000,
    0x017e,0x0000,
    0x00bc,0x0000,
    0x0058,0x0000,
    0x0038,0x0000,
    0x0078,0x0000,
    0x00bc,0x0000,
    0x057f,0xc000,
    0x2bff,0xf000,
    0x15ff,0xf000,
    0x02b5,0x0000,
    0x0000,0x0000,
 
    0x00fc,0x0000,
    0x03eb,0x0000,
    0x07f5,0x8000,
    0x03fb,0x0000,
    0x01fe,0x0000,
    0x00f4,0x0000,
    0x01f6,0x0000,
    0x0ffb,0xc000,
    0x7ffe,0xb800,
    0xffff,0x6c00,
    0xffff,0xfc00,
    0x7fff,0xf800,
    0x07ff,0x8000
};


struct Image olabel = {
    0, 0, IMWID, IMHITE, 2, null /* will be oonwhite */, 3, 0, null
}, blabel = {
    0, 0, IMWID, IMHITE, 2, null /* bonwhite */, 3, 0, null
};
/* these are used in the menu and margin stuff, not on the board */


struct SimpleSprite ox = { &ecks[0], 1, 0, 0, -1 },
			bx = { &ecks[1], 1, 0, 1, -1 };


extern struct Bob obob, bbob;		/* declared in full below */


struct VSprite ovs = {
    null, null, null, null, 0, 0,	/* system fields */
    SAVEBACK | OVERLAY,			/* is a Bob */
    0, 0, IMHITE, 2, 2,		/* y, x, height, width (in words), planes */
    0, 0, null,			/* memask, hitmask, image = oimd */
    null, null, null,		/* borderline, collmask = shadow, colormap */
    &obob, 3, 0			/* parent Bob, planepick, planeonoff */
}, bvs = {
    null, null, null, null, 0, 0,	/* system fields */
    SAVEBACK | OVERLAY,			/* is a Bob */
    0, 0, IMHITE, 2, 2,		/* y, x, height, width (in words), planes */
    0, 0, null,			/* memask, hitmask, image = bimd */
    null, null, null,		/* borderline, collmask = shadow, colormap */
    &bbob, 3, 0			/* parent Bob, planepick, planeonoff */
};


struct VSprite dummy1 = { 0 }, dummy2 = { 0 };


WORD nextline[8], *(lastcolor[8]);	/* lastcolor is array of pointers */


struct GelsInfo ginfo = {
    0xFC, 0, null, null, &nextline[0], &lastcolor[0],
    null, 0, 0, 0, 0, null, null
};


struct /* J.R. " */ Bob /* " Dobbs */ obob = {
    0, null, null, null, null,		/* flags, save, shadow, before, after */
    &ovs, null, null			/* vsprite, animcomp, dbufpacket */
}, bbob = {
    0, null, null, null, null,		/* flags, save, shadow, before, after */
    &bvs, null, null			/* vsprite, animcomp, dbufpacket */
};


/* pointers into chip ram: */
WORD *oimd, *bimd, *osav, *bsav, *shadow,
	*oonwhite, *bonwhite, *osprat, *bsprat, *nuth;


short sqite, thite;

bool lace;

struct RastPort *r;
struct ViewPort *vp;

struct TmpRas wtr;
PLANEPTR trp;

long imize = 0;



#define TFree(m, s) if (m) FreeMem(m, (long) s)

void DumpPrettyPictures()
{
    if (!imize) return;
    TFree(bsprat, 48);
    TFree(osprat, 48);
    TFree(nuth, 24);
    TFree(bonwhite, imize);
    TFree(oonwhite, imize);
    TFree(shadow, imize >> 1);
    TFree(bimd, imize);
    TFree(oimd, imize);
    TFree(bsav, imize << 1);
    TFree(osav, imize << 1);
    if (win) {
	ClearMenuStrip(win);
	CloseWindow(win);
    }
    TFree(trp, TMPIZE);
    if (~ox.num)
	FreeSprite((long) ox.num);
    if (~bx.num)
	FreeSprite((long) bx.num);
}



void MakePrettyPictures()
{
    struct Preferences p;
    short i;
    long *o, *b, *rr = (long *) rawimage;
    ulong rgb;
    struct Screen *wbench = OpenWorkBench();

    if (!wbench)
	Die("Workbench inaccessible!\n");
    thite = wbench->Font->ta_YSize;
    /* that's a FAIR GUESS of the height of the font our window will use */
    if (thite < 8 || thite > 40)
	thite = 8;
    GetPrefs(&p, (long) sizeof(p));	/* why put LaceWB down at the end!? */
    lace = p.LaceWB == LACEWB;
    sqite = SQIZE << lace;
    boardwin.Height = thite + 4 + (sqite << 3) + lace;	/* room for title bar */
    boardwin.TopEdge -= thite - 8;		/* constant bottom edge */
    if (boardwin.TopEdge < 0)
	boardwin.TopEdge = 0;
    if (!(win = OpenWindow(&boardwin)))
	Die("Can't open window!\n");
    ShoveMenus();
    SetMenuStrip(win, &manyou);
    if (!(trp = AllocCP(TMPIZE)))
	Die("Can't allocate TmpRas for window!\n");
    InitTmpRas(&wtr, trp, TMPIZE);
    r = win->RPort;
    r->TmpRas = &wtr;
    vp = &win->WScreen->ViewPort;

    imize = RASSIZE(IMWID, IMHITE) << (1 + lace);
    /* probably should have used AllocEntry, but it just sorta grew ... */
    if (!(oimd = AllocCP(imize)) || !(bimd = AllocCP(imize)) ||
		!(osav = AllocCP(imize << 1)) ||	  /* 16 color WB! */
		!(bsav = AllocCP(imize << 1)) ||
		!(shadow = AllocCP(imize >> 1)) ||
		!(oonwhite = AllocCP(imize)) || !(bonwhite = AllocCP(imize)) ||
		!(osprat = AllocCP(48)) || !(bsprat = AllocCP(48)) ||
		!(nuth = AllocCPZ(24)))
	Die("Can't allocate chip ram for image data!\n");
    o = (long *) (ovs.ImageData = oimd);
    b = (long *) (bvs.ImageData = bimd);
    obob.SaveBuffer = osav;
    bbob.SaveBuffer = bsav;
    obob.ImageShadow = ovs.CollMask = bbob.ImageShadow = bvs.CollMask = shadow;
    ovs.BorderLine = bvs.BorderLine = nuth + 8;
    oo.face = &obob;
    bb.face = &bbob;
    if (lace)
	ovs.Height = bvs.Height = IMHITE << 1;
    for (i = 0; i < IMHITE; i++) {
	register short i1 = i << lace, i2 = (i + IMHITE) << lace;
	register long m, dw;
	m = dw = o[i1] = rr[i];
	if (lace) o[i1 + 1] = dw;		/* double each line for lace */
	m &= (dw = o[i2] = rr[i + IMHITE]);	/* bits on in m are orange */
	if (lace) o[i2 + 1] = dw;
	dw = b[i1] = rr[i] ^ m;		/* ^ m turns orange pixels blue */
	if (lace) b[i1 + 1] = dw;
	dw = b[i2] = rr[i + IMHITE] ^ m;
	if (lace) b[i2 + 1] = dw;
    }
    InitMasks(&ovs);				/* fill in shadow */
    for (i = 0; i < (IMHITE << lace); i++) {
	register short i2 = i + (IMHITE << lace);
	register long m, w;
	m = w = o[i];
	m |= ((long *) oonwhite)[i2] = o[i2];
	((long *) oonwhite)[i] = w | ~m;	/* turn blue background white */
	((long *) bonwhite)[i2] = b[i2];
	((long *) bonwhite)[i] = b[i] | ~m;
    }
    olabel.ImageData = (ushort *) oonwhite;
    blabel.ImageData = (ushort *) bonwhite;
    olabel.Height = blabel.Height = IMHITE << lace;
    ginfo.sprRsrvd &= ~GfxBase->SpriteReserved;
    r->GelsInfo = &ginfo;
    InitGels(&dummy1, &dummy2, &ginfo);

    for (i = 0; i < 11; i++) {
	((long *) osprat)[i] = ((long *) (&ecks[0]))[i];
	((long *) bsprat)[i] = ((long *) (&ecks[1]))[i];
    }
    for (i = 2; i <= 6; i += 2) {
	if (~GetSprite(&ox, (long) i) && ~GetSprite(&bx, (long) i + 1)) {
	    i = (i << 1) + 17;
	    rgb = GetRGB4(vp->ColorMap, 0L);	/* "blue" */
	    SetRGB4(vp, (long) i, rgb >> 8, (rgb >> 4) & 15, rgb & 15);
	    rgb = GetRGB4(vp->ColorMap, 3L);	/* "orange" */
	    SetRGB4(vp, i + 1L, rgb >> 8, (rgb >> 4) & 15, rgb & 15);
	    return;
	}
	if (~ox.num)
	    FreeSprite((long) ox.num);
	if (~bx.num)
	    FreeSprite((long) bx.num);
	ox.num = bx.num = -1;
    }
    Die("Can't find a free pair of sprites!\n");
}



void Win2Square(x, y, xp, yp) short x, y, *xp, *yp;
{
    *xp = (x + (SQIZE << 1) - 2) / (SQIZE << 1) - 1;
    *yp = (y + sqite - 2 - thite - lace) / sqite - 1;
}



void DropBob(who) piece *who;
{
    register struct Bob *b = who->face;
    b->BobVSprite->X = who->x * (SQIZE << 1) + 13;
    b->BobVSprite->Y = who->y * sqite + 2 + thite + (5 << lace);
    /* SortGList(r); */
    DrawGList(r, vp);			/* paint it in center of square */
    b->Flags |= SAVEBOB;
    RemIBob(b, r, vp);			/* dump it on the background */
}



void LiftBob(who) piece *who;
{
    who->face->Flags &= ~SAVEBOB;
    AddBob(who->face, r);
    /* SortGList(r); */
}



void DragBob(who, x, y) piece *who; short x, y;
{
    who->face->BobVSprite->X = x - 10;
    who->face->BobVSprite->Y = y - (((IMHITE >> 2) + 3) << lace);
    /* SortGList(r); */
    DrawGList(r, vp);		/* must already be LiftBobbed */
}
