#include <exec/types.h>
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

struct Picture *gfx = NULL;
static struct Room map[MAP_YSIZE * MAP_XSIZE];

/* Colors to blocks */
unsigned char colblo[16] = {
	0, 6, 36, 0, 0, 166, 156, 0, 0, 0,
	0, 0, 0, 121, 126, 0
};

int
main(int argc, char **argv)
{
	int	x, y, rx, rxx, ry, ryy, z;
	BOOL	the_end, done;

	openup(320, 200, 4, NULL, "JetSetBilly Map Converter", NULL);

	ConPuts(CURSOFF);
	ConPuts(DISABLE_SCROLL);
	ConPuts("\2330y"); /* Set console top offset to 0 */

	if ((gfx = SimpleLoadILBM("Pics/Roomspic.ilbm")) == NULL)
		fprintf(stderr, "Can't load room base!\n");

	/* Get color table */
	LoadRGB4(vp, gfx->ColorTable, 16);

	SetRast(rp, 0);
	SetAPen(rp, 1);

	the_end = done = FALSE;

	BltBitMapRastPort(&gfx->bitmap,0,0,rp,0,TOP_EDGE,320,(200-TOP_EDGE),0xc0);

	z = 0;

	SetAPen(rp, 2);
	SetDrMd(rp, COMPLEMENT);

	while (!the_end) {

		if (z < (MAP_YSIZE * MAP_XSIZE)) {
			ry = (z / MAP_XSIZE);
			rx = z - (ry * MAP_XSIZE);

			ry = ry * 11;
			rx = rx * 20;

			ryy = ry; rxx = rx;

			for (y = 0; y < ROOM_YSIZE; y++) {
				for (x = 0; x < ROOM_XSIZE; x++) {
					map[z].block[y][x] =
						colblo[ReadPixel(rp, rx + x, TOP_EDGE + ry + y)];
/*					SetAPen(rp, map[z].block[y][x] & 15);
					WritePixel(rp, rx + x, TOP_EDGE + ry + y);
*/
				}
			}

			RectFill(rp, rxx, TOP_EDGE + ryy,
		rxx + ROOM_XSIZE - 1, TOP_EDGE + ryy + ROOM_YSIZE - 1);

			z++;

		} else if (!done) {
			save_packed_file("JSB.map", (UBYTE *)map, sizeof(map));
			done = the_end = TRUE;
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

//		WaitIDCMP();
		HandleIDCMP();

	} /* End of main loop */

the_end:

	if (gfx) FreePicture(gfx);

	cleandown(0);
}
