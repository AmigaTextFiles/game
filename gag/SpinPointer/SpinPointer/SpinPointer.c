/* Spinning Pointer - Great as a "busy" indicator.
 * Author:		Mark R. Rinfret
 * Date:		02/10/88
 * Description:
 *		The SpinPointer function allows you to indicate a task's
 *		relative "busy-ness" (sic) by creating the illusion of a
 *      spinning disk, using the mouse pointer.  This idea was 
 *		copied from an "other brand" computer that I use at work.
 *		The idea is to embed a call of the form
 *
 *			SpinPointer(window, 1); 	|* clockwise *|
 *				or 
 *			SpinPointer(window, -1);	|* counter clockwise *|
 *
 *		in a processing loop.  Care should be chosen in the placement
 *		of the call so that you don't introduce undue overhead.  At the
 *		same time, you want some amount of activity or the illusion of
 *		rotation won't be effective.  To reset the mouse pointer to its
 *		original condition, call SpinPointer with a value of 0:
 *			SpinPointer(window, 0);
 *
 *		I invite others to design a better representation (spiral disk? 
 *		with more phases?).  That is simply a matter of generating new 
 *		sprite image data.
 */

/* Define DEBUG if you want to compile and link the demo version. */

#define DEBUG

#include <stdio.h>
#include <exec/memory.h>

void *AllocMem();
#define USHORT unsigned short

/* The ambitious may want to use SetRGB4 with the following:
 * static USHORT sprite_colors[3] = { 0x0d22, 0x0000, 0x0fca }; 
 */

typedef struct sprite {				/* Give it some structure. */
	USHORT spriteData[36]; 
	} Sprite;

#define SPRITECOUNT		4

static Sprite spinSprites[SPRITECOUNT] = {	/* # phases of rotation */
	 {
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0ff0, 0x00f0,
		0x1ff8, 0x00f8,
		0x3fcc, 0x00fc,
		0x7fce, 0x00fe,
		0x7ffe, 0x00fe,
		0x7ffe, 0x00fe,
		0x7ffe, 0x7f00,
		0x7ffe, 0x7f00,
		0x7ffe, 0x7f00,
		0x3ffc, 0x3f00,
		0x1ff8, 0x1f00,
		0x0ff0, 0x0f00,
		0x0000, 0x0000,
		0x0000, 0x0000
	}, 


	{
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0ff0, 0x0f00,
		0x1ff8, 0x1f00,
		0x3ffc, 0x3f00,
		0x7ffe, 0x7f00,
		0x7ffe, 0x7f00,
		0x7ffe, 0x7f00,
		0x7ffe, 0x00fe,
		0x7ffe, 0x00fe,
		0x7fce, 0x00fe,
		0x3fcc, 0x00fc,
		0x1ff8, 0x00f8,
		0x0ff0, 0x00f0,
		0x0000, 0x0000,
		0x0000, 0x0000
	},


	{
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0ff0, 0x00f0,
		0x1ff8, 0x00f8,
		0x3ffc, 0x00fc,
		0x7ffe, 0x00fe,
		0x7ffe, 0x00fe,
		0x7ffe, 0x00fe,
		0x7ffe, 0x7f00,
		0x7ffe, 0x7f00,
		0x73fe, 0x7f00,
		0x33fc, 0x3f00,
		0x1ff8, 0x1f00,
		0x0ff0, 0x0f00,
		0x0000, 0x0000,
		0x0000, 0x0000
	},

	{
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0000, 0x0000,
		0x0ff0, 0x0f00,
		0x1ff8, 0x1f00,
		0x33fc, 0x3f00,
		0x73fe, 0x7f00,
		0x7ffe, 0x7f00,
		0x7ffe, 0x7f00,
		0x7ffe, 0x00fe,
		0x7ffe, 0x00fe,
		0x7ffe, 0x00fe,
		0x3ffc, 0x00fc,
		0x1ff8, 0x00f8,
		0x0ff0, 0x00f0,
		0x0000, 0x0000,
		0x0000, 0x0000
	}
};

/* Set up, disable or spin the pointer.
 * Called with:
 *		w:		window in which to spin the pointer
 *		code:	controls behavior of pointer as follows -
 *              < 0 => Spin pointer backward
 *              > 0 => Spin pointer forward
 *				  0 => revert to original pointer
 * Returns:
 *		0	=> successful call
 *		1	=> Oops!
 */

#define IMAGESIZE	SPRITECOUNT * sizeof(Sprite)

static Sprite *images;
static int spriteIndex;

int
SpinPointer(w, value)
	struct Window *w; int value;
{

	if (value == 0) {
		ClearPointer();
		if (images) FreeMem(images, (long) IMAGESIZE);
		images = NULL;
	}
	else {
		if (!images) {		/* Must allocate image area in CHIP ram. */
			if (! (images = AllocMem((long) IMAGESIZE, MEMF_CHIP) ) ) 
				return 1;

			movmem(&spinSprites, images, IMAGESIZE);
			spriteIndex = 0;
		}
		else
			ClearPointer();
		if (value < 0) {
			if (--spriteIndex < 0) spriteIndex = 3;
		}
		else
			if (++spriteIndex >= SPRITECOUNT) spriteIndex = 0;

		/* If you change the sprite's dimensions, make sure you
		 * change the constants in this call.
		 */
		SetPointer(w, &images[spriteIndex], 16L, 16L, -7L, -7L);
	}
	return 0;
}


#ifdef DEBUG
#include <intuition/intuition.h>

void *OpenLibrary();
struct Window * OpenWindow();


/* Intuition handler for DEBUG mode. */

struct Window *testWindow;

/* New window structure */

struct NewWindow    nw = {
	0,0,640,200,0,1,

/* IDCMP Flags */

	NULL,	

/* Flags */
	WINDOWSIZING | WINDOWDRAG | WINDOWDEPTH,

	NULL,							/* First gadget */
	NULL,							/* Checkmark */
	(UBYTE *)"SpinPointer Demo - Click in this window",	/* Window title */
	NULL,							/* No custom streen */
	NULL,							/* Not a super bitmap window */
	100,60,							/* MinWidth, MinHeight */
	640,200,						/* Not used, but set up anyway */
	WBENCHSCREEN
};


struct IntuitionBase * IntuitionBase;
struct GfxBase *GfxBase;

CloseIntuition()
{
	if ( IntuitionBase ) {
		if ( testWindow ) {
			ClearMenuStrip( testWindow );
			CloseWindow( testWindow );
		}
		if ( GfxBase ) CloseLibrary( GfxBase );
		CloseLibrary( IntuitionBase );
	}						/* end if IntuitionBase */
}

int
InitIntuition()
{
 
	IntuitionBase = (struct IntuitionBase *)
		OpenLibrary("intuition.library", 0L);
	if ( ! IntuitionBase ) {
		puts("I can't open Intuition!\n");
		return 1;
	}

	GfxBase = (struct GfxBase *) OpenLibrary("graphics.library", 0L);
	if ( ! GfxBase ) {
		puts("I can't open the graphics library!\n");
		return 1;
	}

	testWindow = OpenWindow(&nw);	/* open the window */
	if ( testWindow == NULL ) {
		puts("I can't open the main window!\n");
		return 1;
	}

	return 0;
}

main()
{
	unsigned delay;
	long delayCount = 10L;

	if (InitIntuition()) {
		puts("Failed to initialize Intuition stuff.");
		exit(1);
	}
	while (delayCount > 1) {
		for (delay = 0; delay < 24; ++delay) {
			if (SpinPointer(testWindow, 1)) {
				puts("SpinPointer() call failed!");
				goto done;
				break;	
			}
			Delay(delayCount);
		}
		--delayCount; 
	}
	SpinPointer(testWindow, 0);
done:
	CloseIntuition();
}
#endif
/* EOF */
