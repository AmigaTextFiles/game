/* :ts=8 bk=0
 * tilt.c:	Something to make people giggle.
 *
 * by Leo L. Schwab			8702.23
 *
 * -=RJ Mical=- suggested that I should put my phone number in my PD stuff.
 *	(415) 456-6565
 */

#include <exec/types.h>
#include <intuition/intuition.h>

#define	DEPTH		2


extern void	*OpenLibrary(), *OpenWindow(), *OpenScreen();


struct NewScreen scrdef = {
	0, 0, 0, 0, DEPTH,	/*  Size filled in later  */
	0, 1,
	NULL,			/*  Modes filled in later  */
	CUSTOMSCREEN,
	NULL,
	(UBYTE *) "Dink!",	/*  Title filled in later  */
	NULL, NULL
};

struct NewWindow windef = {
	0, 30, 100, 10,
	-1, -1,
	NULL,
	WINDOWDRAG | WINDOWDEPTH | SMART_REFRESH | ACTIVATE,
	NULL, NULL,
	(UBYTE *) "Tilt",
	NULL, NULL,
	0, 0, 0, 0,
	WBENCHSCREEN
};

char *msg = "\001\034\022T I L T !\0";

struct Screen	*scr;
struct Window	*win;
void		*IntuitionBase, *GfxBase;


main ()
{
	struct Screen	*wb;
	struct RastPort *rp;
	struct BitMap	*wbm, *mbm;
	long x, y, n;
	register int i;

	openstuff ();

	wb = win -> WScreen;		/*  Workbench Screen  */
	scrdef.LeftEdge	= wb -> LeftEdge;
	scrdef.TopEdge	= wb -> TopEdge;
	scrdef.Width	= wb -> Width;
	scrdef.Height	= wb -> Height;
	scrdef.ViewModes = wb -> ViewPort.Modes;
	if (!(scr = OpenScreen (&scrdef)))
		die ("Screen open failed.");
	ScreenToBack (scr);

	rp = &scr -> RastPort;
	mbm = rp -> BitMap;
	wbm = win -> WScreen -> RastPort.BitMap;
	BltBitMap (wbm, 0L, 0L, mbm, 0L, 0L,
		   (long) scrdef.Width, (long) scrdef.Height,
		   0xc0L, 0xffL, NULL);

	y = scrdef.Height-1;
	for (i=0; i<40; i++) {
		x = i << 4;
		ScrollRaster (rp, 0L, i-20L, x, 0L, x+15L, y);
	}

	x = scrdef.Width-1;
	n = scrdef.Height/50;
	for (i=0; i<50; i++) {
		y = i * n;
		ScrollRaster (rp, 25L-i, 0L, 0L, y, x, y+n-1);
	}
	ScreenToFront (scr);

	Delay (50L);
	DisplayAlert (RECOVERY_ALERT, msg, 30L);
	closestuff ();
}


openstuff ()
{
	if (!(IntuitionBase = OpenLibrary ("intuition.library", 0L))) {
		puts ("Intuition missing.");
		exit (100);
	}

	if (!(GfxBase = OpenLibrary ("graphics.library", 0L))) {
		puts ("Art shop closed.");
		closestuff ();
		exit (100);
	}

	if (!(win = OpenWindow (&windef))) {
		puts ("Window painted shut.");
		closestuff ();
		exit (100);
	}
}

die (str)
char *str;
{
	puts (str);
	closestuff ();
	exit (100);
}

closestuff ()
{
	if (scr)		CloseScreen (scr);
	if (win)		CloseWindow (win);
	if (GfxBase)		CloseLibrary (GfxBase);
	if (IntuitionBase)	CloseLibrary (IntuitionBase);
}


