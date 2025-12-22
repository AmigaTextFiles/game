/*
 *	15 puzzle 
 */

#include	<intuition/intuition.h>
#include	<libraries/dos.h>		/* just for SIGBREAKF_CTRL_C */
#include	<proto/intuition.h>
#include	<proto/exec.h>

extern struct IntuitionBase	*IntuitionBase;
extern struct GfxBase		*GfxBase;

#define	NPZ	4		/* the square puzzle is NPZ x NPZ */
#define	PZ_MT	0		/* the value of the "empty" tile */

char	pz[NPZ][NPZ];		/* the puzzle array */
int	mtr, mtc;		/* location of the "empty" tile */

#define	R0	11		/* origin row/col of upper left */
#define	C0	4
#define	RS	(IMG_HT+1)	/* row/col scaling factors (match images!!) */
#define	CS	(IMG_WID+3)
#define	IMG_WID	0x1f		/* from the output of 'brush' */
#define	IMG_HT	0xd

struct Image img = {		/* shared Image struct for all "tiles" */
	0,0, IMG_WID,IMG_HT, 1, NULL, 1,0, NULL
};

/* the image data (in chip ram!) */
extern short	id0[], id1[],  id2[],  id3[],  id4[],  id5[],  id6[],  id7[], 
		id8[], id9[], id10[], id11[], id12[], id13[], id14[], id15[];

short	*imgs[] = {		/* array of pointers to the image data arrays */
	id0, id1,  id2,  id3,  id4,  id5,  id6,  id7,
	id8, id9, id10, id11, id12, id13, id14, id15
};

#define	W_WID	141
#define	W_HT	68
struct NewWindow newin = {
	100,50, W_WID,W_HT, 2,-1,
	MOUSEBUTTONS | CLOSEWINDOW | REFRESHWINDOW,
	WINDOWDEPTH | WINDOWCLOSE | WINDOWDRAG | SIMPLE_REFRESH,
	NULL, NULL, "Pz15", NULL, NULL, 0,0, 0,0, WBENCHSCREEN
};

struct Window	*win = NULL;
struct RastPort	*rp  = NULL;

/* Lattice likes prototypes: */
void	putpiece(unsigned short, unsigned short, unsigned short);
void	refrow(unsigned short), refcol(unsigned short);
short	pzmove(unsigned short, unsigned short);
void	byewin(long);

/*
 *	Repaint a single tile.
 */
void putpiece(r, c, v)
register unsigned short r, c, v;
{
	img.ImageData = imgs[v];
	DrawImage(rp, &img, (long) c*CS+C0, (long) r*RS+R0);
}

/*
 *	Repaint a specified row.
 */
void refrow(r)
register unsigned short r;
{
	register unsigned short c;

	for ( c = 0; c < NPZ; c++ )
		putpiece(r, c, (unsigned short)pz[r][c]);
}

/*
 *	Repaint a specified column.
 */
void refcol(c)
register unsigned short c;
{
	register unsigned short r;

	for ( r = 0; r < NPZ; r++ )
		putpiece(r, c, (unsigned short) pz[r][c]);
}

/*
 *	Move the "empty" tile (MT) to the "moused" row and column.
 */
short pzmove(mr, mc)
unsigned short mr, mc;
{
	register unsigned short	 r,  c;		/* row/col counters */
	register short	ir, ic;			/* row/col increments */

	if ( mtr == mr )		/* Are we in the same row as MT? */
		ir = 0;				/* yes, row-inc is zero */
	else
		ir = (mtr < mr) ? 1 : -1;	/* yes, row-inc is +/-1 */

	if ( mtc == mc )		/* Are we in the same col as MT? */
		ic = 0;				/* yes, col-inc is zero */
	else
		ic = (mtc < mc) ? 1 : -1;	/* yes, col-inc is +/-1 */

	if ( ir == 0 && ic == 0 )	/* If in same row and col as MT... */
		return 0;		/* ... nothing to do */
	if ( ir != 0 && ic != 0 )	/* If not in either row or col as MT... */
		return -1;		/* ... too much to do */

	/* "double-loop", but really only r _or_ c gets changed */
	for ( r = mtr, c = mtc; ; r += ir, c += ic ) {	/* start at MT */
		pz[r][c] = pz[r+ir][c+ic];	/* shift pieces towards MT */
		if ( r == mr && c == mc )	/* until we hit the 'moused' position */
			break;
	}
	pz[mr][mc] = PZ_MT;		/* mark the new empty square */
	mtr = mr;
	mtc = mc;
	if ( ir == 0 )			/* update the display */
		refrow(mr);		/* either change a row */
	else
		refcol(mc);		/* or a column */
	return 1;			/* say there was just enough to do */
}

/*
 *	Refresh the entire puzzle.
 */
void pzref()
{
	register unsigned short	r;

	for ( r = 0; r < NPZ; r++ )	
		refrow(r);
}

/*
 *	Setup the puzzle array.
 */
void pzinit()
{
	register unsigned short	r, c, i;

	i = 0;
	for ( r = 0; r < NPZ; r++ )
		for ( c = 0; c < NPZ; c++ )
			pz[c][r] = i++;		/* scramble a little */
}

/*
 *	Get mouse clicks and handle them.
 */
void dopuz()
{
	register struct IntuiMessage *msg;
	register unsigned short	r, c;
	unsigned long	class;
	unsigned short	code;
	long	flags, ret;

	flags = (1L << win->UserPort->mp_SigBit) | SIGBREAKF_CTRL_C;

	/* loop, get mouse clicks, call pzmove() with reduced coords */
	for ( ; ; ) {
		ret = Wait ( flags );
		while ( msg = (struct IntuiMessage *)GetMsg(win->UserPort) ) {
			class = msg->Class;
			code = msg->Code;
			r = (msg->MouseY - R0) / RS;
			c = (msg->MouseX - C0) / CS;
			ReplyMsg((struct Message *)msg);
			if ( class == MOUSEBUTTONS && code == SELECTDOWN ) {
				(void)pzmove(r, c);
			}
			else if ( class == REFRESHWINDOW ) {
				pzref();
			}
			else if ( class == CLOSEWINDOW ) {
				return;
			}
		}
		if ( ret & SIGBREAKF_CTRL_C ) {
			return;
		}
	}
}

/*
 *	Shut the window; put back the things we borrowed.
 */
void byewin(r)
long r;
{
	if ( win )
	 	CloseWindow(win);
	if ( GfxBase )
		CloseLibrary(GfxBase);
	if ( IntuitionBase )
		CloseLibrary(IntuitionBase);
	_exit(r);
}

/*
 *	Open some libraries and a window.
 */
void mkwin()
{
	if ( (IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library", 0L)) == NULL )
		byewin(-100L);
	if ( (GfxBase = (struct GfxBase *)OpenLibrary("graphics.library", 0L)) == NULL )
		byewin(-101L);
	if ( (win = (struct Window *)OpenWindow(&newin)) == NULL )
		byewin(-102L);
	rp = win->RPort;
}

/*
 *	FINALLY, here's where it all starts.
 */
void _main()
{
	mkwin();		/* open up our window */
	pzinit();		/* initialize the puzzle */
	pzref();		/* and show it */
	dopuz();		/* play it, until we close or get a ^C */
	byewin(0L);		/* then close the window and exit */
}

