/* Fix old maps */

#include <exec/types.h>
#include <graphics/gfxbase.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include <proto/exec.h>

#include "game.h"
#include "game_proto.h"

struct OldMobile
{
	unsigned short	shape;
	BOOL		on;
	short		anim;
	short		x, y;
	short		xd, yd;
	short		xs, ys, xe, ye;
	short		delay;
	short		dead;
};

/* Each room takes 274 bytes plus monster data (416), total 690 */
struct OldRoom
{
	unsigned short	n;
	char		name[40];
	unsigned short	charset;
	unsigned short	flags;
	unsigned char	block[ROOM_YSIZE][ROOM_XSIZE];
	unsigned short	exits[4];
	struct OldMobile	monsters[NO_OF_MONSTERS];
};

static struct OldRoom oldmap[MAP_YSIZE * MAP_XSIZE];
static struct Room newmap[MAP_YSIZE * MAP_XSIZE];

int
main(int argc, char **argv)
{
	int	r, m;

	if (argc < 3) {
		fprintf(stderr, "Usage: %s old_file.map new_file.map\n",
			argv[0]);
	}

	load_packed_file(argv[1], (UBYTE *)oldmap, sizeof(oldmap));

	for (r = 0; r < (MAP_YSIZE * MAP_XSIZE); r++) {
		(void)memcpy(&newmap[r], &oldmap[r], sizeof(struct OldRoom));

		for (m = 0; m < NO_OF_MONSTERS; m++) {

	newmap[r].monsters[m].shape = oldmap[r].monsters[m].shape;
	newmap[r].monsters[m].on = oldmap[r].monsters[m].on;
	newmap[r].monsters[m].anim = oldmap[r].monsters[m].anim;
	newmap[r].monsters[m].x = oldmap[r].monsters[m].x;
	newmap[r].monsters[m].y = oldmap[r].monsters[m].y;
	newmap[r].monsters[m].xd = oldmap[r].monsters[m].xd;
	newmap[r].monsters[m].yd = oldmap[r].monsters[m].yd;
	newmap[r].monsters[m].xs = oldmap[r].monsters[m].xs;
	newmap[r].monsters[m].ys = oldmap[r].monsters[m].ys;
	newmap[r].monsters[m].xe = oldmap[r].monsters[m].xe;
	newmap[r].monsters[m].ye = oldmap[r].monsters[m].ye;
	newmap[r].monsters[m].delay = oldmap[r].monsters[m].delay;
	newmap[r].monsters[m].dead = oldmap[r].monsters[m].dead;

			newmap[r].monsters[m].PlanePick = 0x07;
			newmap[r].monsters[m].PlaneOnOff = 0x00;
		}
	}

	save_packed_file(argv[2], (UBYTE *)newmap, sizeof(newmap));

}
