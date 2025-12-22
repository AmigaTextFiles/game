/*  :ts=8 bk=0
 *
 * ms2.c:	Munching Squares for the Amiga, now actually interesting.
 *
 * Leo L. Schwab			8706.4
 * With a respectful bow and flurry of my cape to Bill Gosper.
 * (I wonder if Gosper has an Amiga?)
 */

#include <exec/types.h>
#include <intuition/intuition.h>

extern void	*OpenLibrary(), *OpenScreen(), *OpenWindow(), *GetMsg();

struct NewScreen scrdef = {
	0, 0, 256, 256, 1,
	0, 1,
	LACE,
	CUSTOMSCREEN,
	NULL, NULL, NULL, NULL
};

struct NewWindow windef = {
	0, 0, 256, 256,
	-1, -1,
	CLOSEWINDOW,
	WINDOWCLOSE,
	NULL, NULL, NULL,
	NULL,		/*  Filled in later  */
	NULL,
	0, 0, 0, 0,
	CUSTOMSCREEN
};

struct Screen	*scr;
struct Window	*win;
void		*IntuitionBase, *GfxBase;

main (ac, av)
int ac;
char **av;
{
	register struct RastPort *rp;
	register unsigned int acc, x, y, seed;
	void *msg;

	openstuff ();
	rp = &scr -> RastPort;
	SetRast (rp, 0L);
	SetDrMd (rp, COMPLEMENT);

	if (++av, --ac)
		seed = atoi (*av);
	else
		seed = 1;

	acc = 0;
	while (1) {
		if (msg = GetMsg (win -> UserPort)) {	/*  Close gadget  */
			ReplyMsg (msg);
			break;
		}

/*		Move (rp, 0L, (long) (0 ^ t));	*/
		acc += seed;
		x = acc & 0xff;
		y = ((acc & 0xff00) >> 8) ^ x;

		WritePixel (rp, (long) x , (long) y);
	}

	closestuff ();
}

openstuff ()
{
	if (!(IntuitionBase = OpenLibrary ("intuition.library", 0L)))
		die ("-=RJ=- is on vacation.");

	if (!(GfxBase = OpenLibrary ("graphics.library", 0L)))
		die ("Dale?  Are you there?");

	if (!(scr = OpenScreen (&scrdef)))
		die ("Screens aren't happening.");

	windef.Screen = scr;
	if (!(win = OpenWindow (&windef)))
		die ("Window painted shut.");
}

closestuff ()
{
	if (win)		CloseWindow (win);
	if (scr)		CloseScreen (scr);
	if (GfxBase)		CloseLibrary (GfxBase);
	if (IntuitionBase)	CloseLibrary (IntuitionBase);
}

die (str)
char *str;
{
	puts (str);
	closestuff ();
	exit (20);
}
