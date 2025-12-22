/* ---------------------------------------------------------------------
        Alert Picture - Display an IFF picture in a system alert.
    by Tim Ferguson (Vision Beyond) of Alchemy Software Development.

  A small silly idea I had some years back but never got around to
  implementing it, till now.....  This is VERY memory hungry and needs
  six bytes for every pixel set on the source bitmap.  It takes ages to
  display the picture.  Thanks to Jim Kent for his iff display routine
  (VERY old, but hey, it works).

  As the text in a system alert can be placed anywhere inside the alert,
  (possibly using the graphics library Move() and Text() functions) all I
  do is place full stop characters in positions defined by a source bitmap.
  As the full stop character is 2 by 2 pixels in size, this has the effect
  of doubling the size of the bitmap.  Note that the alert is displayed in
  hi-resolution, and with the doubling of the width of the pixels, it
  effectively gives low-resolution width.

  You may do whatever you wish to this source, although credit to its
  authour would be nice :)  It should compile with most C compliers,
  although it may need a little modification on the header files.
   --------------------------------------------------------------------- */
#include <exec/types.h>
#include <intuition/intuition.h>
#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <stdlib.h>
#include <stdio.h>
#include "work:Programing/IFF/jiff.h"

#define WIDTH			40
#define HEIGHT			(256/2)
#define X_OFFSET		2
#define Y_OFFSET		2

struct ILBM_info iff_info;
UBYTE *alertMsg;

struct Library *IntuitionBase;

/* --------------------------------------------------------------------- */
void main(int argc, char **argv)
{
int line, col, x_pos, y_pos, loop;
unsigned char *ch, val;
UBYTE *ap;

	printf("Alert Picture by Tim Ferguson of Alchemy Software Development, 1993.\n\n");
	printf("Generating image.....  This is gonna take a while.... Please wait. \n");

	if(argc < 2)
		{
		printf("Error in arguments.  Format:  `AlertPicture IFF_file'.\n");
		return;
		}

		/* ---------- Read IFF picture ---------- */
	if(!(read_iff(argv[1], &iff_info, FALSE)))
		{
		printf("Error, cannot find an IFF file called `%s'.\n\n", argv[1]);
		return;
		}

		/* ---------- Check IFF picture dimensions ---------- */
	if(iff_info.bitmap.BytesPerRow < WIDTH || iff_info.bitmap.Rows < HEIGHT)
		{
		free_planes(&iff_info.bitmap);
		printf("Error in IFF dimensions.  Picture must be at least %d by %d pixels.\n\n", WIDTH*8, HEIGHT);
		return;
		}

		/* ---------- Allocate memory for alert message ---------- */
	if(!(alertMsg = malloc((WIDTH*8*HEIGHT*6)+100)))
		{
		free_planes(&iff_info.bitmap);
		printf("Error allocating memory.  Need %d bytes free space.\n", (WIDTH*8*HEIGHT*6)+100);
		return;
		}

		/* ---------- Generate alert message ---------- */
	for(ap = alertMsg, ch = iff_info.bitmap.Planes[0], y_pos = Y_OFFSET, line = 0; line < HEIGHT-2; line++, y_pos += 2)
		{
		for(x_pos = X_OFFSET, col = 0; col < WIDTH; col++, ch++)
			for(val = *ch, loop = 0; loop < 8; loop++, val = val << 1, x_pos += 2)
				if(val & 0x80)
					{
					*(ap++) = (x_pos>>8) & 0xff;		/* 2 byte X position */
					*(ap++) = x_pos & 0xff;
					*(ap++) = y_pos & 0xff;				/* 1 byte Y position */
					*(ap++) = '.';							/* Text - 4 pixels   */
					*(ap++) = 0;							/* Null termination  */
					*(ap++) = 1;							/* Continued         */
					}

		ch += iff_info.bitmap.BytesPerRow - WIDTH;	/* add modulo for next scan */
		}

	*(ap-1) = 0;
	*ap = 0;

	free_planes(&iff_info.bitmap);

		/* ---------- Display alert message ---------- */
	if(IntuitionBase = OpenLibrary("intuition.library",33))
		{
		DisplayAlert(RECOVERY_ALERT, alertMsg, HEIGHT*2);
		CloseLibrary(IntuitionBase);
		}
	else printf("Error in opening the intuition library.\n\n");
}
