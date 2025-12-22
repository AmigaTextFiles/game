#include <exec/types.h>
#include <exec/memory.h>
#include <graphics/gfxbase.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>

#include "lib/console.h"
#include "lib/externs.h"
#include "lib/ilbm.h"
#include "lib/proto.h"

#include "animtools.h"
#include "game.h"
#include "game_proto.h"

#define IM_SIZE	(2 * 16 * 3)
#define SIZE	(IM_SIZE * 256)

struct Picture	*gfx = NULL;

static UBYTE bobs[SIZE];

int
main(int argc, char **argv)
{
	int	sa, i, j;
	short	sx, sy, z;
	UWORD	*dest, *src;
	BOOL	the_end, done;

	openup(320, 256, 3, NULL, NULL, SCREEN_QUIET);

	ConPuts(CURSOFF);
	ConPuts(DISABLE_SCROLL);

	load_packed_file("Bobs.img", bobs, SIZE);

	SetRast(rp, 0);
	SetAPen(rp, 1);

	the_end = done = FALSE;

	z = 0;

	src = (UWORD *)bobs;

	at(2, 27); ConPuts("UnBobConv");

	while (!the_end) {

		if (z < 256) {

			sy = (z / 20);
			sx = (z - (sy * 20));

			sa = (sy * 40 * 16) + (sx * 2);

			for (i = 0; i < 3; i++) {
				dest = (UWORD *)(screen->BitMap.Planes[i] + sa);

				for (j = 0; j < 16; j++) {
					*dest = *src;
					dest += 20;
					src++;
				}
			}

			at(30, 27); ConPuts(ERASE_TO_EOL);
			at(30, 27); sprintf(buf, "%03d", z); ConPuts(buf);

			z++;

		} else if (!done) {
			done = TRUE;
			at(18, 29); ConPuts("Done");
		}

		if (inpos) {
			switch(inkey[0]) {
				case 0x1b: /* ESC: Quit */
					the_end = TRUE;
					break;

				default:
					break;

			} /* End of inkey switch */

			flush_inkey(0);
		}

		if (done) WaitIDCMP();
		HandleIDCMP();

	} /* End of main loop */

the_end:

	cleandown(0);
}
