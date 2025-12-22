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
#define SH_SIZE (2 * 16)
#define SIZE	(IM_SIZE * 256 + SH_SIZE * 256)

struct Picture	*gfx = NULL;
struct Picture	*shadow_gfx = NULL;
UWORD		*bob_images = NULL;

void
shadowshow(void)
{
	int	i, z, sa, sx, sy;
	UWORD	*shadows;

	shadows = (bob_images + (IM_SIZE * 256 / 2));

	for (z = 0; z < 256; z++) {

		sy = (z / 20);
		sx = (z - (sy * 20));

		sa = (sy * 40 * 16) + (sx * 2);

		for (i = 0; i < 16; i++) {
			*(UWORD *)(screen->BitMap.Planes[0] + sa) = *shadows;
			*(UWORD *)(screen->BitMap.Planes[1] + sa) = 0x0000;
			*(UWORD *)(screen->BitMap.Planes[2] + sa) = 0x0000;

			sa += 40;
			shadows++;
		}
	}

}


int
main(int argc, char **argv)
{
	int	sa, i, j;
	short	sx, sy, z;
	UWORD	*dest, *src, *shadows;
	BOOL	the_end, done;

	openup(320, 256, 3, NULL, NULL, SCREEN_QUIET);

	ConPuts(CURSOFF);
	ConPuts(DISABLE_SCROLL);

	if ((gfx = SimpleLoadILBM("Pics/Bobs.ilbm")) == NULL) {
		printf("Can't load bob picture!\n");
		cleandown(0);
	}

	if ((shadow_gfx = SimpleLoadILBM("Pics/Bobs_shadows.ilbm")) == NULL) {
		printf("Can't load shadows picture!\n");
		cleandown(0);
	}

	if ((bob_images = AllocMem(SIZE, MEMF_CHIP)) == NULL) {
		printf("Out of chip memory!\n");
		cleandown(0);
	}

	/* Get color table */
	LoadRGB4(vp, gfx->ColorTable, 8);

	SetRast(rp, 0);
	SetAPen(rp, 1);

	the_end = done = FALSE;

	z = 0;

	dest = bob_images;
	shadows = (bob_images + (IM_SIZE * 256 / 2));

	at(2, 27); ConPuts("BobConv");

	while (!the_end) {

		if (z < 256) {

			sy = (z / 20);
			sx = (z - (sy * 20));

			sa = (sy * 40 * 16) + (sx * 2);

			for (i = 0; i < 3; i++) {
				src = (UWORD *)(gfx->bitmap.Planes[i] + sa);

				for (j = 0; j < 16; j++) {
					*dest = *src;
					src += 20;
					dest++;
				}
			}

			for (i = 0; i < 16; i++) {
				*shadows =
				((*(UWORD *)(shadow_gfx->bitmap.Planes[0] + sa)));
				sa += 40;
				shadows++;
			}

			BltBitMapRastPort(&gfx->bitmap, sx * 16, sy * 16,
				&screen->RastPort, sx * 16, sy * 16,
				16, 16, 0xc0);

			at(30, 27); ConPuts(ERASE_TO_EOL);
			at(30, 27); sprintf(buf, "%03d", z); ConPuts(buf);

			z++;

		}

		if (inpos) {
			switch(inkey[0]) {
				case 0x1b: /* ESC: Quit */
					the_end = TRUE;
					break;

				case 's': /* Show/Edit Shadows */
					SetRast(rp, 0);
					shadowshow();
					break;

				case 'S': /* Save */
					if (!done) {
						save_packed_file("Bobs.img",
							(UBYTE *)bob_images, SIZE);
						at(14, 29); ConPuts("Saving done");
						done = TRUE;
					}
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

	if (gfx) FreePicture(gfx);
	if (shadow_gfx) FreePicture(shadow_gfx);
	if (bob_images) FreeMem(bob_images, SIZE);

	cleandown(0);
}
