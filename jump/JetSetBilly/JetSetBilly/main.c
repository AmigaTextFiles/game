/*
 * JetSetBilly 1.0	(William JetSet)
 *
 * Bugs:
 *	-	poor name JetSetBilly
 *
 * Features:
 *
 *	-	BorderLine of bobs is not set; can't use border collisions
 *		(but they are useless anyway)
 *
 *	-	must never use InitMasks
 *
 */
#include <exec/types.h>
#include <exec/memory.h>
#include <hardware/blit.h>
#include <graphics/gfx.h>
#include <graphics/gels.h>
#include <graphics/collide.h>
#include <graphics/rastport.h>
#include <graphics/gfxbase.h>
#include <graphics/view.h>
#include <libraries/asl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <ctype.h>

#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>

#include "animtools.h"
#include "lib/console.h"
#include "lib/externs.h"
#include "lib/ilbm.h"
#include "lib/proto.h"

#include "game.h"
#include "game_proto.h"

#define JSB_TITLE "JetSet Billy 1.00"
char version_string[] = "$VER: version 1.00 (3.7.93)";

#define MAPSIZE			(MAP_YSIZE * MAP_XSIZE)

#define BOB_DEPTH		3
#define BOB_IMAGE_SIZE		(BOB_DEPTH * 16 * 2)
#define BOB_SHADOW_SIZE		(16 * 2)
#define BOB_IMAGE_AREA_SIZE	(BOB_IMAGE_SIZE * 256 + BOB_SHADOW_SIZE * 256)
#define CLS_BOTTOM at(1,2); ConPuts(ERASE_TO_EOD)

/* Shapes */
#define SH_MVLEFT		1
#define SH_MVRIGHT		5
#define SH_SWIMLEFT		9
#define SH_SWIMRIGHT		13
#define SH_CLIMB		17
#define SH_DIVERIGHT		22
#define SH_DIVELEFT		21

/*
 * Game configuration definitions. NO_OF_... are maximum values
 */
#define FATAL_FALL		16
#define COLL_PLR_BIT		 1
#define COLL_MONS_BIT		 2

/* Default starting location on JSB.map */
#define DEF_MAP_START_X		6
#define DEF_MAP_START_Y		6

/* Borders for mobiles */
#define MOB_RIGHT_BND		(305)
#define MOB_LEFT_BND		(-1)
#define MOB_TOP_BND		(TOP_EDGE - 1)
#define MOB_BOTTOM_BND		(TOP_EDGE + ROOM_YSIZE * 16 - 16)

/* Game mode */
#define GAME_REAL		(1)
#define GAME_DEBUG		(1<<1)
#define GAME_TEST		(1<<2)

/* Function prototypes */
void bob_DrawGList(void);
void blockat(int b, int x, int y, BOOL mask);
void view_high_scores(void);

extern struct Library	*AslBase;
extern struct FileRequester *filereq;

extern char		error_message[];

static BOOL		the_end;
static UWORD		music;
static struct Picture	*gfx = NULL;
static UWORD		*bob_images = NULL, *shadows;

static struct Bob	*bobs[NO_OF_BOBS];
static struct GelsInfo	*my_ginfo;
static struct NewBob	new_bobs[NO_OF_BOBS];
static struct Mobile	mob[NO_OF_BOBS];
static struct JSBPlayer	plr[NO_OF_PLAYERS];
static struct JSBPlayer	plr_splr[NO_OF_PLAYERS];
static struct Mobile	plr_smob[NO_OF_PLAYERS];

static struct Room	map[MAPSIZE];
static struct Item	items[NO_OF_ITEMS];
static struct HiScore	hiscores[NO_OF_HISCORES];
static char		hifile[512];
static short		no_of_items;
static struct Item	room_items[16];
static unsigned short	room_item_no[16];
static UWORD		visited[MAPSIZE];

static UWORD		*bob_image_addr[256];
static UWORD		*bob_shadow_addr[256];

static char jump[25] = {
	4, 4, 4, 4, 3,
	3, 3, 2, 2, 2,
	1, 1, 0,-1,-1,
	-2,-2,-2,-3,-3,
	-3,-4,-4,-4,-4
};

void
bob_DrawGList()
{
	SortGList(rp);
	DrawGList(rp, ViewPortAddress(window));

	WaitTOF();
}

void
getBobImage(int b, int im)
{
	if (im > 255 || im < 0) return;

	if (bobs[b]) {
		bobs[b]->BobVSprite->ImageData = bob_image_addr[im];
		bobs[b]->ImageShadow = bob_shadow_addr[im];
		bobs[b]->BobVSprite->CollMask = bob_shadow_addr[im];

/*		InitMasks(bobs[b]->BobVSprite);   DON'T USE */
	}
}

void
clear_msg_area(void)
{
	SetAPen(rp, 0);
	RectFill(rp, 0, 191, 320, 208);
	SetAPen(rp, 1);
	ConPuts(COLOR01);
	at(1, 25);
}

void
msg(char *s)
{
	register int	len;

	clear_msg_area();
	SetAPen(rp, 1);
	Move(rp, 0, 197);
	len = strlen(s);
	Text(rp, s, len);
	at(1 + strlen(s), 25);
}

void
clear_hiscores(void)
{
	int	i;

	for (i = 0; i < NO_OF_HISCORES; i++) {
		/* Todo: list of funny hiscore names */
		(void)strcpy(hiscores[i].name, "Amiga");
		hiscores[i].score = (NO_OF_HISCORES + 1 - i);
		hiscores[i].lives = 0;
		hiscores[i].items = 0;
		hiscores[i].timeval = 0;
	}
}

BOOL
load_map(void)
{
	if (!filerequest(FR_LOAD)) return FALSE;

	buf[0] = 0;
	if (strlen(filereq->rf_Dir)) {
		(void)strcat(buf, filereq->rf_Dir);
		(void)strcat(buf, "/");
	}
	(void)strcat(buf, filereq->rf_File);
	if (!load_packed_file(buf, (UBYTE *)map, sizeof(map)))
		return FALSE;

	(void)strcpy(buf + strlen(buf) - 3, "itm");
	if (!load_packed_file(buf, (UBYTE *)items, sizeof(items)))
		return FALSE;

	(void)strcpy(buf + strlen(buf) - 3, "hi");
	/* If there isn't any high score file, make an empty one */
	if (!load_packed_file(buf, (UBYTE *)hiscores, sizeof(hiscores)))
		clear_hiscores();

	(void)strcpy(hifile, buf);
}

BOOL
save_map(void)
{
	if (!filerequest(FR_SAVE))
		return FALSE;

	buf[0] = 0;
	if (strlen(filereq->rf_Dir)) {
		(void)strcat(buf, filereq->rf_Dir);
		(void)strcat(buf, "/");
	}
	(void)strcat(buf, filereq->rf_File);

	clear_msg_area(); ConPuts("Save "); ConPuts(filereq->rf_File);
	ConPuts("\nAre you sure (y/n)? ");

	if (!yn()) return FALSE;

	if (!save_packed_file(buf, (UBYTE *)map, sizeof(map)))
		return FALSE;

	(void)strcpy(buf + strlen(buf) - 3, "itm");
	if (!save_packed_file(buf, (UBYTE *)items, sizeof(items)))
		return FALSE;

	(void)strcpy(buf + strlen(buf) - 3, "hi");
	(void)save_packed_file(buf, (UBYTE *)hiscores, sizeof(hiscores));
}

void
clear_map(void)
{
	register int	i, x, y;

	/* Clean item base */
	for (i = 0; i < NO_OF_ITEMS; i++) items[i].shape = 0;

	/* Clear map */
	for (i = 0; i < MAPSIZE; i++) {
		for (x = 0; x < 40; x++) map[i].name[x] = 0;

		map[i].charset = 0;
		map[i].flags = 0;

		for (y = 0; y < ROOM_YSIZE; y++) {
			for (x = 0; x < ROOM_XSIZE; x++) {
				map[i].block[y][x] = 0;
			}
		}

		for (x = 0; x < 4; x++) map[i].exits[x] = 0;

		for (x = 0; x < NO_OF_MONSTERS; x++) {
			map[i].monsters[x].on = FALSE;
		}
	}

	clear_hiscores();
}

void
draw_room_name(int rno)
{
	if (map[rno].name[0]) {
		sprintf(buf, "%s", map[rno].name);
	} else {
		sprintf(buf, "Nameless room, number %03d", rno);
	}
	SetAPen(rp, 7);
	Move(rp, 160 - (strlen(buf) * 4), 197);
	Text(rp, buf, strlen(buf));
}

/* Todo: optimize this */
void
draw_room(int rno)
{
	unsigned short	b;
	int		i, x, y, sx, sy;

	SetRast(rp, 0);

	for (y = 0; y < ROOM_YSIZE; y++) {
		for (x = 0; x < ROOM_XSIZE; x++) {

			b = map[rno].block[y][x];

			sy = b / 20;
			sx = b - (sy * 20);

			BltBitMapRastPort(&gfx->bitmap, sx * 16, sy * 16,
				rp, x * 16, TOP_EDGE + (y * 16),
				16, 16, 0xc0);
		}
	}

	for (i = 0; i < 16; i++) room_items[i].shape = 0;

	x = 0;

	for (i = 0; i < NO_OF_ITEMS; i++) {
/* 		if (!items[i].shape) break; */

		if ((items[i].rno == rno) && (!plr[0].items_found[i])) {
			(void)memcpy(&room_items[x], &items[i], sizeof(struct Item));
			room_item_no[x] = i;
			blockat(room_items[x].shape,
				16 * room_items[x].x,
				TOP_EDGE + (16 * room_items[x].y),
				TRUE);
			if ((++x) >= 15) break;
		}
	}
}


int
b_solid(unsigned char b, int relx, int rely)
{
	return ((b) && (b < 36));
}

int
b_tilted(unsigned char b, int relx, int rely)
{
	return ((b >= 156 && b<= 165) || (b >= 201 && b <= 210));
}

int
b_liquid(unsigned char b, int relx, int rely)
{
	return (b >= 121 && b <= 145);
}

int
b_slide(unsigned char b, int relx, int rely)
{
	return (b >= 186 && b <= 195 && relx >= 6 && relx <= 10);
}

int
b_walkable(unsigned char b, int relx, int rely)
{
	/* half-height blocks */
	if ((rely > 7) &&
	    ((b >= 36 && b <= 66) || (b >= 146 && b <= 150) ||
		b == 171 || b == 181 || b == 191)) return FALSE;

	/* Slopes */
	if (b_tilted(b, relx, rely)) {
		return ((b & 1) ? (rely >= (15 - relx)) : (rely >= (relx)));
	}

	if ((b) &&
	    (b < 66 && rely < 8) || 
	    (b > 145 && b < 176) ||
	    (b > 190 && b < 196)) return TRUE;

	return FALSE;
}

void
copyMob(struct Mobile *m1, int n)
{
	if (m1 == NULL || n > NO_OF_BOBS || n < 0) return;

	(void)memcpy(&mob[n], m1, sizeof(struct Mobile));

	getBobImage(n, mob[n].shape);
}

/* Death special effect(s) (p = player #) */
void
dead_beep(int p)
{
	DisplayBeep(screen);
}

/* Collision handler */
void __saveds
collision(struct VSprite *gel1, struct VSprite *gel2)
{
	if (!mob[0].dead && (!gel1->VUserExt || !gel2->VUserExt)) {
		if (gel1->VUserExt != 1 && gel2->VUserExt != 1) {
			mob[0].dead = TRUE;
			dead_beep(0);
		}
	} else if (!mob[1].dead && (gel1->VUserExt == 1 || gel2->VUserExt == 1)) {
		if (gel1->VUserExt != 0 && gel2->VUserExt != 0) {
			mob[1].dead = TRUE;
			dead_beep(1);
		}
	}
}

void
moveMonster(int n)
{
	mob[n].x += mob[n].xd;
	mob[n].y += mob[n].yd;

	if (mob[n].x < mob[n].xs || mob[n].x > mob[n].xe) {
		mob[n].xd = (-(mob[n].xd));
		mob[n].x += mob[n].xd;
	}

	if (mob[n].y < mob[n].ys || mob[n].y > mob[n].ye) {
		mob[n].yd = (-(mob[n].yd));
		mob[n].y += mob[n].yd;
	}

	/* Animate monster */
	if (mob[n].shape < 246) {
		mob[n].delay += (abs(mob[n].xd) + abs(mob[n].yd) + 1);
		if (mob[n].delay > 4) {
			mob[n].delay = 0;
			mob[n].anim++;
			if ((mob[n].shape >= 220 && mob[n].anim > 1) ||
			    (mob[n].anim > 3)) mob[n].anim = 0;

			if (mob[n].shape >= 140 && mob[n].shape < 220)
				getBobImage(n, mob[n].shape +
	(mob[n].xd < 0 || mob[n].yd < 0 ? 0 : 4) + mob[n].anim);
			else getBobImage(n, mob[n].shape + mob[n].anim);
		}
	}
}

void
draw_room_mobs(void)
{
	int	i;

	for (i = 0; i < NO_OF_BOBS; i++) {
		if (mob[i].on) {

			if (i >= NO_OF_PLAYERS) moveMonster(i);

			bobs[i]->BobVSprite->X = mob[i].x;
			bobs[i]->BobVSprite->Y = mob[i].y;
		}
	}
	bob_DrawGList();

}

void
clearMob(struct Mobile *mob)
{
	mob->shape = 0;
	mob->on = TRUE;
	mob->anim = mob->xd = mob->yd = 0;
	mob->dead = 0;
}

void
monster_setup(int rno)
{
	int i;

	/* Set up monsters */
	for (i = 0; i < NO_OF_MONSTERS; i++) {
		copyMob(&map[rno].monsters[i], NO_OF_PLAYERS + i);
		bobs[NO_OF_PLAYERS + i]->BobVSprite->X = map[rno].monsters[i].x;
		bobs[NO_OF_PLAYERS + i]->BobVSprite->Y = map[rno].monsters[i].y;
		bobs[NO_OF_PLAYERS + i]->BobVSprite->PlanePick =
			map[rno].monsters[i].PlanePick;
		bobs[NO_OF_PLAYERS + i]->BobVSprite->PlaneOnOff =
			map[rno].monsters[i].PlaneOnOff;
	}
}

void draw_stats(struct JSBPlayer *p) {
	SetAPen(rp, 3); Move(rp, 68, 206);
	if (p->score < 1000000) sprintf(buf, "%06d", p->score);
	else strcpy(buf, "*HUGE*");
	Text(rp, buf, strlen(buf));

	SetAPen(rp, 3); Move(rp, 188, 206);
	sprintf(buf, "%03d", p->lives);
	Text(rp, buf, strlen(buf));

	SetAPen(rp, 3); Move(rp, 284, 206);
	sprintf(buf, "%04d", p->items);
	Text(rp, buf, strlen(buf));
}

void
player_setup(void)
{
	int	i, j;

	/* Player's setup */
	for (i = 0; i < NO_OF_PLAYERS; i++) {
		/* Lives */
		plr[i].lives = 8;

		clearMob(&mob[i]);
		plr[i].jump = plr[i].fall = plr[i].slide = 0;
		plr[i].climb = plr[i].swim = 0;
		plr[i].score = 0;
		plr[i].items = 0;
		mob[i].shape = SH_MVLEFT;
		mob[i].anim = 0;
		mob[i].xd = -1;
		for (j = 0; j < NO_OF_ITEMS; j++)
			plr[i].items_found[j] = 0;
	}

	for (i = 0; i < MAPSIZE; visited[i++] = 0);
}

void
draw_info(int rno, UBYTE mode)
{
	clear_msg_area();

	draw_room_name(rno);

	SetAPen(rp, 3);
	if (!(mode & GAME_TEST)) {
		Move(rp, 12, 206);
		Text(rp, "Score:         Lives:      Items:", 33);
		draw_stats(&plr[0]);
	} else {
		Move(rp, 92, 206);
		Text(rp, "Test playing mode", 17);
	}
}

UWORD
which_music(int rno)
{
	return (UWORD)(5 + ((rno >> 1) % 4));
}

/*
 * Mode:
 *	GAME_REAL	The real thing
 *	GAME_DEBUG	Cheat mode
 *	GAME_TEST	Test playing from editor
 */
void
game_loop(int mapx, int mapy, int px, int py, UBYTE mode)
{
	int		i, xx, yy;
	int		rx, ry, srx, sry, rno;
	unsigned char	surr_blocks[10];
	char		ch, bx, by, relx, rely;
	struct Room	*room;

#define B_UPLEFT	surr_blocks[0]
#define B_UP		surr_blocks[1]
#define B_UPRIGHT	surr_blocks[2]
#define B_LEFT		surr_blocks[3]
#define B_UPON		surr_blocks[4]
#define B_RIGHT		surr_blocks[5]
#define B_BELOW_LEFT	surr_blocks[6]
#define B_BELOW		surr_blocks[7]
#define B_BELOW_RIGHT	surr_blocks[8]
#define B_ITEM		surr_blocks[9]

	player_setup();

	/* Set main player on. Two player mode is not yet available. */
	mob[0].on = TRUE;
	mob[1].on = FALSE;

	rx = mapx; ry = mapy;

	mob[0].x = px;
	mob[0].y = py;

	/* Count items */
	for (no_of_items = i = 0; i < NO_OF_ITEMS; i++)
		if (items[i].shape) no_of_items++;

	rno = ry * MAP_XSIZE + rx;

	if (music != 0xffff) {
		music = which_music(rno);
		playmusic(music);
	}

restart_room:

	the_end = FALSE;

	if (mode & GAME_DEBUG) plr[0].lives = 999;

	/* Remove bobs */
	for (i = 0; i < NO_OF_BOBS; i++) {
		if (mob[i].on) RemBob(bobs[i]);
	}
	bob_DrawGList();

	for (i = NO_OF_PLAYERS; i < NO_OF_BOBS; i++) mob[i].on = FALSE;

	rno = ry * MAP_XSIZE + rx;
	room = &map[rno];
	monster_setup(rno);

	/* Store player's position if not falling. Got to handle two
	   player mode in some other way... */
	if (!plr[0].fall) {
		(void)memcpy(&plr_splr[0], &plr[0], sizeof(struct JSBPlayer));
		(void)memcpy(&plr_smob[0], &mob[0], sizeof(struct Mobile));
		srx = rx; sry = ry;
	}

	/* Just for fun, remember how many times we've been in each room */
	if (visited[rno] < 0xffff) {
		/* First visit? Massive. That's 1 point more score. */
		if (!visited[rno]) plr[0].score++;
		visited[rno]++;
	}

	/* Draw the room */
	draw_room(rno);

	/* Add bobs */
	for (i = 0; i < NO_OF_BOBS; i++) {
		if (mob[i].on) AddBob(bobs[i], rp);
	}

	mob[0].dead = 0;

	draw_info(rno, mode);

	if (music != 0xffff && (which_music(rno) != music)) {
		music = which_music(rno);
		playmusic(music);
	}

	while (!the_end) {

		/* Get the blocks surrounding us and
		   block relative x and y coords */

		bx = ((mob[0].x + 8) / 16);
		by = ((mob[0].y - TOP_EDGE) / 16);

		B_ITEM = 0;

		for (i = 0; i < 16; i++) {
			if (!room_items[i].shape) break;
			if (room_items[i].shape != 0xffff &&
			    bx == room_items[i].x && by == room_items[i].y) {
				B_ITEM = (i + 1);
			}
		}

		for (yy = -1; yy < 2; yy++) {
			for (xx = -1; xx < 2; xx++) {
				if ((by + yy) >= 0 && (by + yy) < 11 &&
				    (bx + xx) >= 0 && (bx + xx) < 20) {
				   surr_blocks[(yy + 1) * 3 + (xx + 1)] =
					room->block[by + yy][bx + xx];
				} else {
				   surr_blocks[(yy + 1) * 3 + (xx + 1)] = 0;
				}
			}
		}

		relx = (mob[0].x + 8) - bx * 16;
		rely = (mob[0].y - TOP_EDGE) - by * 16;

		/* We are in contact with ground if:
		 * 1.	we are not climbing
		 * 2.	we are not swimming
		 * 3.	block below can be walked
		 * 4.	block just below our left or...
		 * 5.	...right heel can be walked and is not a slope.
		 * With 3. and 4. we must not be jumping, otherwise we can
		 * travel up by jumping right beside a solid wall.
		 */
		if (!plr[0].climb && !plr[0].swim &&
		    ((b_walkable(B_BELOW, relx, rely)) ||
	(!plr[0].jump && relx < 4 &&
		b_walkable(B_BELOW_LEFT, relx, rely) &&
		!b_tilted(B_BELOW_LEFT, relx, rely)) ||
	(!plr[0].jump && relx > 12 &&
		b_walkable(B_BELOW_RIGHT, relx, rely) &&
		!b_tilted(B_BELOW_RIGHT, relx, rely)))) {

			/* We contact the ground after a fall? */
			if (plr[0].fall) {
				/* Fatal fall? Start squishing animation. */
				if (plr[0].fall > FATAL_FALL &&
				    !b_liquid(B_UPON, relx, rely)) {
					mob[0].shape = 24;
					mob[0].dead = 1;
					mob[0].anim = 0;
				}

				plr[0].fall = 0;
			}

			/* Our jump has reached its highest point? */
			if (plr[0].jump > 12) {
				plr[0].jump = 0;
			}

			/* Sliding ends? */
			if (plr[0].slide && !b_slide(B_BELOW, relx, rely)) {
				plr[0].slide = 0;
				mob[0].shape = (mob[0].xd == -1 ?
					SH_MVLEFT + mob[0].anim :
					SH_MVRIGHT + mob[0].anim);
			}

			/* Are we inside the ground?
			 * -	not jumping or sliding
			 *
			 * 1.	special cases on a tilted slope
			 * else
			 * 1.	not upon a rope, ladder or slide
			 * 2.	relative y not zero
			 */
			if (!plr[0].jump && !plr[0].slide) {

				if (b_tilted(B_BELOW, relx, rely)) {
					i = ((B_BELOW & 1) ?
						(15 - relx) : (relx));
					if (rely != i) {
						mob[0].y =
						    (mob[0].y - rely) + i;
						rely = i;
					}
				} else if ((B_UPON < 166 || B_UPON > 195) &&
					   (rely > 0)) {
					mob[0].y -= rely;
					rely = 0;
				}

				/* Get upon the steps */
				if (b_tilted(B_UPON, relx, rely)) {
					mob[0].y -= 2;
				}
			}

		} else {
			/* We are not in contact with ground */

			if (!plr[0].swim) {
				if (plr[0].slide &&
				    !b_slide(B_BELOW, relx, rely) &&
				    !b_slide(B_UPON, relx, rely))
					plr[0].slide = 0;

				/* If not jumping, climbing, sliding
				   or falling already */
				if (!plr[0].jump && !plr[0].fall &&
				    !plr[0].climb && !plr[0].slide) {
					plr[0].fall = 1; /* Start falling */
				}

				/* Are we in a climbing sequence? */
				if (plr[0].climb) {
					plr[0].climb--;
					mob[0].y += mob[0].yd;
				}

			} else {
				plr[0].fall = 0;
			}
		}

		/* Swimming mode? */
		if (!plr[0].jump && b_liquid(B_UPON, relx, rely)) {
			if (!plr[0].swim) {
				plr[0].swim = 1;
				if (mob[0].xd == 1)
					mob[0].shape = SH_DIVELEFT;
				else
					mob[0].shape = SH_DIVERIGHT;
			}
		} else plr[0].swim = 0;

		if (cursor_keys && !mob[0].dead) {

			/* We can move right if
			 * 1.	we are not falling or sliding
			 * 2.	there isn't any solid block to the right
			 */
			if ((cursor_keys & CUR_RIGHT) &&
			    (!plr[0].fall && !plr[0].slide) &&
			    (relx < 12 || !b_solid(B_RIGHT, relx, rely))) {

				/* If jumping and not on "ground level", the
				 * block up and right must not be solid.
				 */
				if (!plr[0].jump ||
				    rely < 3 || relx < 12 ||
				    !b_solid(B_BELOW_RIGHT, relx, rely)) {

					/* We are already moving right? */
					if (mob[0].xd == 1) {
						mob[0].anim++;
						if (mob[0].anim > 3) mob[0].anim = 0;
						mob[0].x += 2;
					} else {
					/* We don't move yet, we just turn. */
						mob[0].xd = 1;
						mob[0].anim = 1;
					}

					/* Animate */
					if (plr[0].swim)
						mob[0].shape = SH_SWIMRIGHT + mob[0].anim;
					else
						mob[0].shape = SH_MVRIGHT + mob[0].anim;
				}
			}
			/* We can move left if
			 * 1.	we are not falling or sliding
			 * 2.	there isn't any solid block to the left
			 */
			else if ((cursor_keys & CUR_LEFT) &&
			    (!plr[0].fall && !plr[0].slide) &&
			    (relx > 4 || !b_solid(B_LEFT, relx, rely))) {

				/* If jumping and not on "ground level", the
				 * block up and left must not be solid.
				 */
				if (!plr[0].jump ||
				    rely < 3 || relx > 4 ||
				    !b_solid(B_BELOW_LEFT, relx, rely)) {

					/* We are already moving left? */
					if (mob[0].xd == -1) {
						mob[0].anim--;
						if (mob[0].anim < 0) mob[0].anim = 3;
						mob[0].x -= 2;
					} else {
					/* We don't move yet, we just turn. */
						mob[0].xd = -1;
						mob[0].anim = 1;
					}

					/* Animate */
					if (plr[0].swim)
						mob[0].shape = SH_SWIMLEFT + mob[0].anim;
					else
						mob[0].shape = SH_MVLEFT + mob[0].anim;
				}
			}


			/* We might either jump, climb or swim here */
			if ((cursor_keys & CUR_UP) && !plr[0].fall) {

				/* Can climb up if not falling or jumping */
				/* plus we must be upon a ladder */
				if (!plr[0].fall && !plr[0].jump &&
				    !plr[0].climb) {
					if (B_UPON > 165 && B_UPON < 186 &&
					    rely == 0) {
						/* Climb up one step */
						plr[0].climb = 1;
						mob[0].yd = -2;
					}
				}

				/* Jumping/swim up is possible if the block
				 * above is not solid.
				 */
				if (!plr[0].climb && !plr[0].jump &&
				    !b_solid(B_UP, relx, rely)) {

					/* Swim up. */
					if (plr[0].swim &&
					    (b_solid(B_UP, relx, rely) ||
					     b_liquid(B_UPON, relx, rely) ||
					     mob[0].y < (TOP_EDGE + 16))) {
						mob[0].y -= 2;
						if (mob[0].xd == 1)
							mob[0].shape = SH_SWIMRIGHT + mob[0].anim;
						else
							mob[0].shape = SH_SWIMLEFT + mob[0].anim;
					} else {
						plr[0].jump = 1;
						plr[0].climb = plr[0].slide = 0;
					}
				}
			}
			/* We might climb, slide or swim down */
			else if ((cursor_keys & CUR_DOWN)) {

				/* Can climb if not falling or jumping */
				/* plus we must be on a ladder or rope */
				if (!plr[0].fall && !plr[0].jump && !plr[0].slide) {
					if (B_BELOW > 165 && B_BELOW < 186) {
						/* Climb down one step */
						plr[0].climb = 1;
						mob[0].yd = 2;
					}
				}

				/* Can't slide from a jump! */
				if (!plr[0].slide && !plr[0].fall &&
				    !plr[0].jump &&
				    b_slide(B_BELOW, relx, rely)) {
					plr[0].slide = 1;
					mob[0].shape = 29;
					mob[0].x = (mob[0].x - relx + 8);
					plr[0].jump = 0;
				}

				if ((!plr[0].climb && plr[0].swim) &&
				    (!b_solid(B_BELOW, relx, rely))) {
					mob[0].y += 2;
					if (mob[0].xd == 1)
						mob[0].shape = SH_DIVELEFT;
					else
						mob[0].shape = SH_DIVERIGHT;
				}
			}

		}

		if (inpos) {
			ch = inkey[0];
			flush_inkey(0);
		} else ch = 0;

		switch(ch) {
			case 0x1b: /* ESC: Quit/Pause */
				if (!(mode & GAME_TEST)) {
					if (music != 0xffff) playmusic(1);
					msg("Quit? Are you sure (y/n)? ");
					if (yn()) the_end = TRUE;
					else draw_info(rno, mode);
					if (music != 0xffff) playmusic(music);
				} else the_end = TRUE;
				break;

			case 'm': /* m: Toggle Music */
				if (music != 0xffff) {
					stopmusic();
					music = 0xffff;
				} else {
					music = which_music(rno);
					playmusic(music);
				}
				break;

			default:
				break;

		} /* End of inkey switch */

		/* Handle jumping */
		if (plr[0].jump) {

			/* Does our head bump on a solid block? */
			if ((rely < 2 && b_solid(B_UP, relx, rely)) ||
			    (rely > 13 && b_solid(B_UPON, relx, rely))) {
				plr[0].jump = 0;
			} else {

				/* Continue jump */
				mob[0].y -= jump[plr[0].jump - 1];
				if (++plr[0].jump > 25) {
					plr[0].jump = 0;
				}
			}
		} else {
		/* Escalators, currents, waterfalls? */
			if (B_BELOW > 130 && B_BELOW < 156) {
				if (B_BELOW == 131 || B_BELOW == 136)
					mob[0].y += 3;
				else if (B_BELOW == 132)
					mob[0].y -= 3;
				if (B_BELOW == 134 || B_BELOW == 136 ||
				    (B_BELOW >= 146 && B_BELOW <= 148))
					mob[0].x += 3;
				else if (B_BELOW == 133 || B_BELOW == 135)
					mob[0].x -= 3;
			}
		}

		/* Handle fall */
		if (plr[0].fall) {
			mob[0].y += 2 + (plr[0].fall / 4);
			plr[0].fall++;

			/* If this is going to kill us, start
			 * flapping arms or something. */
			if (plr[0].fall > FATAL_FALL) {
				mob[0].shape = 23;
				plr[0].fall = (FATAL_FALL + 1);
			}
		}

		/* Handle sliding */
		if (plr[0].slide) {
			plr[0].slide++;
			mob[0].y += 2;
		}

		/* Deadly block? */
		if (B_UPON >= 111 && B_UPON <= 120 && !mob[0].dead) {
			dead_beep(0);
			mob[0].dead = 1;
		}

		/* Found an item? */
		if ((!mob[0].dead) && (B_ITEM)) {

			/* First blit it out */
			RemBob(bobs[0]); bob_DrawGList();
			blockat(room->block[by][bx], bx * 16,
				TOP_EDGE + (by * 16), FALSE);
			AddBob(bobs[0], rp); bob_DrawGList();

			/* Mark it taken */
			room_items[B_ITEM - 1].shape = 0xffff;
			plr[0].items_found[room_item_no[B_ITEM - 1]] = 1;

			plr[0].items++;

			/* Do item's effects */
			if (room_items[B_ITEM - 1].type & ITEM_TREASURE) {
				plr[0].score += room_items[B_ITEM - 1].data;
			}

			/* Todo: Sound effects etc. here */

			if (!(mode & GAME_TEST)) {
				draw_stats(&plr[0]);

				/* Have we completed the game? */
				/* Todo: end animation, music etc. */
				if (plr[0].items >= no_of_items) {
					msg("You have completed the game! (press ESC)");
					music = 3; playmusic(music);
					do { ch = getch(); } while (ch != 0x1b);
					the_end = TRUE;
					goto exit_game_loop;
				}
			}
		}

		/* Squashing? */
		if (mob[0].shape == 24) {
			mob[0].anim++;
			if (mob[0].anim > 7) {
				mob[0].shape++;
			}
		} else {
			/* Dead? */
			if (mob[0].dead) {
				if (++mob[0].dead > 10) {
					mob[0].dead = 0;
					(void)memcpy(&plr[0], &plr_splr[0],
						sizeof(struct JSBPlayer));
					(void)memcpy(&mob[0], &plr_smob[0],
						sizeof(struct Mobile));
					rx = srx; ry = sry;

					if (--plr[0].lives < 1) {
						/* Game Over */
						music = 2; playmusic(music);
						clear_msg_area();
						at(13, 25);
						ConPuts("G A M E  O V E R");
						at(16, 26);
						ConPuts("Press  ESC");
						do { ch = getch();
						 } while (ch != 0x1b);
						the_end = TRUE;
						goto exit_game_loop;
					}

					if (!(mode & GAME_TEST)) {
						goto restart_room;
					} else {
						the_end = TRUE;
						goto exit_game_loop;
					}
				}
			}
		}

		/* Check if we are out of bounds */
		xx = yy = 0;

		if (mob[0].y > MOB_BOTTOM_BND) {
			mob[0].y = (MOB_TOP_BND + 2);
			yy = 1;
		}
		if (mob[0].y <= MOB_TOP_BND) {
			mob[0].y = (MOB_BOTTOM_BND - 2);
			yy = -1;
		}
		if (mob[0].x <= MOB_LEFT_BND) {
			mob[0].x = (MOB_RIGHT_BND - 1);
			xx = -1;
		}
		if (mob[0].x >= MOB_RIGHT_BND) {
			mob[0].x = (MOB_LEFT_BND + 1);
			xx = 1;
		}

		/* Change room? */
		if (xx || yy) {
			rx += xx;
			if (rx >= MAP_XSIZE) rx = 0; else if (rx < 0) rx = (MAP_XSIZE - 1);
			ry += yy;
			if (ry >= MAP_YSIZE) ry = 0; else if (ry < 0) ry = (MAP_YSIZE - 1);
			goto restart_room;
		}

		for (i = 0; i < NO_OF_BOBS; i++) {
			if (mob[i].on) {

				if (i >= NO_OF_PLAYERS) moveMonster(i);

				bobs[i]->BobVSprite->X = mob[i].x;
				bobs[i]->BobVSprite->Y = mob[i].y;
			}
		}

		/* Set shape of player */
		getBobImage(0, mob[0].shape);

		bob_DrawGList();

		DoCollision(rp);

		WaitBOVP(vp);	/* Gnh... */

/*		{
			UWORD goppa = 0x000;
			goppa ^= 0xf00;
			*(UWORD *)0xdff180 = goppa;
		} */

exit_game_loop:

		HandleIDCMP();

	} /* End of game loop */

	stopmusic();

	for (i = 0; i < NO_OF_BOBS; i++) RemBob(bobs[i]);
	bob_DrawGList();

	if (!(mode & GAME_TEST)) {
	    CLS;
	    Delay(25);

	    if (plr[0].score >= hiscores[NO_OF_HISCORES - 1].score) {

		for (xx = 0; xx < (NO_OF_HISCORES - 2); xx++) {
			if (plr[0].score >= hiscores[xx].score) break;
		}

		if (xx < (NO_OF_HISCORES - 1)) {
			for (yy = (NO_OF_HISCORES - 2); yy >= xx; yy--) {
				(void)memcpy(&hiscores[yy + 1],
					&hiscores[yy],
					sizeof(struct HiScore));
			}
		}

		hiscores[xx].score = plr[0].score;
		hiscores[xx].lives = plr[0].lives;
		hiscores[xx].items = plr[0].items;
		hiscores[xx].timeval = time(NULL);
		hiscores[xx].name[0] = 0;

		if (music != 0xffff) playmusic(4);

		view_high_scores();

		ConPuts(COLOR01); at(13, 26); ConPuts("Enter your name");

		at(6, 4 + xx); ConPuts(ERASE_TO_EOL); at(6, 4 + xx);
		(void)strcpy(hiscores[xx].name, get_string(25));

		(void)save_packed_file(hifile, (UBYTE *)hiscores,
			sizeof(hiscores));

		view_high_scores();
		ConPuts(COLOR01);
		at(13, 26); ConPuts("Press any key");
		flush_inkey(0); while(!getch());
		stopmusic();
	    }
	}
}

#ifndef _STRICT_ANSI
void
goppa(void)
{
	int	i;
	char	*zz;
	static	tmp[40];

	/* Remove extra blanks from room names */
	for (i = 0; i < MAPSIZE; i++) {
		if ((zz = stpblk(map[i].name))) {
			tmp[0] = 0;
			(void)strncpy(tmp, zz, 39);
			map[i].name[0] = 0;
			(void)strncpy(map[i].name, tmp, 39);
		}
	}
}
#endif /* _STRICT_ANSI */

/* Draw full screen map */
void
draw_large_map(UBYTE mode)
{
	int rx, ry, x, y, z;

	SetRast(rp, 0);

	for (z = 0; z < MAPSIZE; z++) {

		ry = (z / MAP_XSIZE);
		rx = z - (ry * MAP_XSIZE);

		ry = ry * 11;
		rx = rx * 20;

		for (y = 0; y < ROOM_YSIZE; y++) {
			for (x = 0; x < ROOM_XSIZE; x++) {
				/* Todo: better pen selection */
				SetAPen(rp, map[z].block[y][x] & 15);
				WritePixel(rp, rx + x, TOP_EDGE + ry + y);
			}
		}
	}

	if (mode & GAME_TEST) {
		msg("Press 'i' to view items");
	}
}

void
draw_large_map_items(void) {
	int	rno, i, x, y;

	SetAPen(rp, 1);

	for (i = 0; i < NO_OF_ITEMS; i++) {
		if (items[i].shape) {
			rno = items[i].rno;

			y = (rno / MAP_XSIZE);
			x = rno - (y * MAP_XSIZE);
			y = y * 11 + items[i].y;
			x = x * 20 + items[i].x;

			if (x >=   0 && y >= TOP_EDGE &&
			    x <= 319 && y <= 200)
				WritePixel(rp, x, y);
		}
	}
}

void
draw_ed_room(int rno)
{
	int i;

	for (i = 0; i < NO_OF_BOBS; i++) RemBob(bobs[i]);
	bob_DrawGList();

	draw_room(rno);

	draw_room_name(rno);

	sprintf(buf, "Room %03d - ESC to quit room editor", rno);
	at(1,26);
	ConPuts(buf);

	monster_setup(rno);

	mob[0].on = mob[1].on = FALSE;

	for (i = NO_OF_PLAYERS; i < NO_OF_BOBS; i++) {
		if (mob[i].on) AddBob(bobs[i], rp);
	}
	bob_DrawGList();
}

void
blockat(int b, int x, int y, BOOL mask)
{
	int sx, sy;

	if (b > 320) b = 255;

	sy = b / (gfx->Width / 16);
	sx = b - sy * (gfx->Width / 16);

	if (!mask)
		BltBitMapRastPort(&gfx->bitmap, sx * 16, sy * 16,
			rp, x, y, 16, 16, 0xc0);
	else
		BltMaskBitMapRastPort(&gfx->bitmap, sx * 16, sy * 16,
			rp, x, y, 16, 16, (ABC|ABNC|ANBC), gfx->MaskPlane);
}

void
editor_menu(int r, int cb, int b)
{
	int i, x, y;

	CLS;

	for (i = 0; i < NO_OF_BOBS; i++) RemBob(bobs[i]);
	bob_DrawGList();

	ConPuts(COLOR01);
	at(2, 3); ConPuts("n   Edit name          ESC Quit editor");
	at(2, 4); ConPuts("a   Add monster        l   Large map");
	at(2, 5); ConPuts("e   Edit monster       CR  Toggle edit");
	at(2, 6); ConPuts("i   Edit items         t   Test play");
	at(2, 7); ConPuts("S   Save map (Shift-s) m   Toggle music");

	at(2, 9); ConPuts("Use mouse button to select a block,");
	at(2, 10); ConPuts(" cursor keys to view more blocks.");

	blockat(b, 302, 60, FALSE);

	x = 0; y = 86;

	for (i = 0; i < 140; i++) {
		blockat(cb + i, x, y, FALSE);
		x += 16;
		if (x >= 320) {
			y += 16;
			x = 0;
		}
	}
}

void
edit_name(int rno)
{
	int		p;
	BOOL		end;

	map[rno].name[39] = 0;

	clear_msg_area();
	ConPuts(CURSON); ConPuts(map[rno].name);

	p = 0;
	end = FALSE;
	flush_inkey(0);

	do {
		at(1 + p, 25);

/*		WaitIDCMP(); */
		WaitBOVP(vp);
		HandleIDCMP();

		draw_room_mobs();

		if (incode & KEY_CURSOR) {
			if (inkey[0] == 3 && p < 38) p++;
			else if (inkey[0] == 4 && p > 0) p--;
		} else {
			if ((inkey[0] >= ' ' && inkey[0] <= '~') ||
			    (inkey[0] >= 161 && inkey[0] <= 255)) {
				map[rno].name[p++] = inkey[0];
				ConPutChar(inkey[0]);
				if (p > 38) p = 38;
			} else if (inkey[0] == 0x0d || inkey[0] == 0x1b) {
				end = TRUE;
			} else if (inkey[0] == 0x18) {
				at(1, 25); ConPuts(ERASE_TO_EOL);
				for (p = 0; p < 39; map[rno].name[p++] = 0);
				p = 0;
			} /* else backspace, del etc. */
		}

		flush_inkey(0);

	} while (!end);

	ConPuts(CURSOFF);
}

/* Let user to put a bob somewhere on the screen.
 * Results will remain in mob[0].x and mob[0].y
 * Mode 1: move in X direction only
 * Mode 2: move in Y direction only
 * Mode 3: move in blocks
 * Mode 4: move in mob[0] limits
 */
void
locate_bob(unsigned short shape, int sx, int sy, int mode)
{
	BOOL	end;
	int	tmp;

	getBobImage(0, shape);
	mob[0].x = sx; mob[0].y = sy; mob[0].on = TRUE;

	AddBob(bobs[0], rp);

	end = FALSE;

	while (!end) {

		draw_room_mobs();

		bobs[0]->BobVSprite->X = mob[0].x;
		bobs[0]->BobVSprite->Y = mob[0].y;

		bob_DrawGList();

		flush_inkey(0);

		WaitBOVP(vp);
		HandleIDCMP();

		if (inpos) {
			switch(inkey[0]) {
				case 0x0d: case 0x1b:
					end = TRUE;
					break;
				default:
					break;
			}
		}

		if (mode == 3) tmp = 16;
		else {
			if ((incode & KEY_LEFT_SHIFT) ||
			    (incode & KEY_RIGHT_SHIFT)) tmp = 8;
			else tmp = 1;
		}

		if (mode != 1 && (cursor_keys & CUR_UP)) mob[0].y -= tmp;
		if (mode != 1 && (cursor_keys & CUR_DOWN)) mob[0].y += tmp;
		if (mode != 2 && (cursor_keys & CUR_RIGHT)) mob[0].x += tmp;
		if (mode != 2 && (cursor_keys & CUR_LEFT)) mob[0].x -= tmp;

		if (mob[0].y > MOB_BOTTOM_BND) mob[0].y = (MOB_TOP_BND + 2);
		if (mob[0].y <= MOB_TOP_BND) mob[0].y = (MOB_BOTTOM_BND - 2);
		if (mob[0].x <= MOB_LEFT_BND) mob[0].x = (MOB_RIGHT_BND - 1);
		if (mob[0].x >= MOB_RIGHT_BND) mob[0].x = (MOB_LEFT_BND + 1);

		if (mode == 4) {
			if (mob[0].x < mob[0].xs) mob[0].x = mob[0].xs;
			if (mob[0].y < mob[0].ys) mob[0].y = mob[0].ys;
			if (mob[0].x > mob[0].xe) mob[0].x = mob[0].xe;
			if (mob[0].y > mob[0].ye) mob[0].y = mob[0].ye;
		}
	}

	mob[0].on = FALSE;
	RemBob(bobs[0]);
	bob_DrawGList();
}

void
edit_monster_start(int rno, int m)
{
	msg("Select start coordinates");
	locate_bob(mob[0].shape, 10 * 16, TOP_EDGE + 5 * 16, 0);
	map[rno].monsters[m].xs = mob[0].x;
	map[rno].monsters[m].ys = mob[0].y;
}

void
edit_monster_init_start(int rno, int m)
{
	msg("Select initial start coordinates");

	mob[0].xs = map[rno].monsters[m].xs;
	mob[0].ys = map[rno].monsters[m].ys;
	mob[0].xe = map[rno].monsters[m].xe;
	mob[0].ye = map[rno].monsters[m].ye;

	locate_bob(mob[0].shape, mob[0].xs, mob[0].ys, 4);
	map[rno].monsters[m].x = mob[0].x;
	map[rno].monsters[m].y = mob[0].y;
}

void
edit_monster_shape(int rno, int m)
{
	char	ch;

	/* Select shape */
	mob[0].shape = 40;
	AddBob(bobs[0], rp);
	msg("Select monster shape");
	flush_inkey(0);
	do {
		getBobImage(0, mob[0].shape);
		bob_DrawGList();
		ch = getch();
		if (ch == '.') {
			if (mob[0].shape < 140) mob[0].shape += 4;
			else if (mob[0].shape < 220) mob[0].shape += 8;
			else if (mob[0].shape < 246) mob[0].shape += 2;
			else mob[0].shape += 1;
		} else if (ch == ',') {
			if (mob[0].shape <= 140) mob[0].shape -= 4;
			else if (mob[0].shape <= 220) mob[0].shape -= 8;
			else if (mob[0].shape <= 246) mob[0].shape -= 2;
			else mob[0].shape -= 1;
		}
		if (mob[0].shape < 40) mob[0].shape = 255;
		else if (mob[0].shape > 255) mob[0].shape = 40;
	} while (ch != 0x0d && ch != 0x1b);
	flush_inkey(0); RemBob(bobs[0]); bob_DrawGList();
	map[rno].monsters[m].shape = mob[0].shape;
}

void
edit_monster_planepick(int rno, int m)
{
	BYTE	pp;
	char	ch;

	pp = 0x7;
	getBobImage(0, map[rno].monsters[m].shape);
	AddBob(bobs[0], rp);
	msg("PlanePick (0-F/CR accept/ESC cancel)?");
	flush_inkey(0);
	do {
		bobs[0]->BobVSprite->PlanePick = pp;
		bob_DrawGList();
		ch = getch();
		if (ch >= '0' && ch <= '9') {
			pp = (ch - '0');
			at(38, 26); ConPutChar(ch);
		}
		ch = toupper(ch);
		if (ch >= 'A' && ch <= 'F') {
			pp = (ch - 'A') + 10;
			at(38, 26); ConPutChar(ch);
		}
	} while (ch != 0x0d && ch != 0x1b);
	flush_inkey(0); RemBob(bobs[0]); bob_DrawGList();

	map[rno].monsters[m].PlanePick = pp;
	bobs[0]->BobVSprite->PlanePick = 0x7;
}

char
ask_monster_xy(void)
{
	char	ch;

	msg("Move in X or Y direction? ");

	ConPuts(CURSON);
	do {
		ch = getch();
		ch = tolower(ch);
	} while (ch != 'x' && ch != 'y');
	ConPutChar(ch); flush_inkey(0);
	ConPuts(CURSOFF);

	return ch;
}

void
edit_monster_end(int rno, int m, char d)
{
	msg("Select end coordinates");
	if (d == 'x') {
		map[rno].monsters[m].yd = 0;
		locate_bob(mob[0].shape, map[rno].monsters[m].xs,
			map[rno].monsters[m].ys, 1);
	} else {
		map[rno].monsters[m].xd = 0;
		locate_bob(mob[0].shape, map[rno].monsters[m].xs,
			map[rno].monsters[m].ys, 2);
	}
	map[rno].monsters[m].xe = mob[0].x;
	map[rno].monsters[m].ye = mob[0].y;
}

void
edit_monster_speed(int rno, int m, char d)
{
	int	tmp;
	char	ch;

	msg("Speed (0-8)? ");
	do {
		ch = getch();
		ch = ch - '0';
	} while (ch < 0 || ch > 8);

	if (d == 'x') {
		if (map[rno].monsters[m].xe < map[rno].monsters[m].xs) {
			tmp = map[rno].monsters[m].xe;
			map[rno].monsters[m].xe = map[rno].monsters[m].xs;
			map[rno].monsters[m].xs = tmp;
		}
		map[rno].monsters[m].xd = ch;
	} else {
		if (map[rno].monsters[m].ye < map[rno].monsters[m].ys) {
			tmp = map[rno].monsters[m].ye;
			map[rno].monsters[m].ye = map[rno].monsters[m].ys;
			map[rno].monsters[m].ys = tmp;
		}
		map[rno].monsters[m].yd = ch;
	}
}

/* Monster add/edit */
int
edit_monster(int rno, int mno)
{
	int	m, i;
	char	ch, d;

	if (mno == -1) {

		/* Get a new monster */

		for (m = 0; m < NO_OF_MONSTERS; m++) {
			if (map[rno].monsters[m].on == FALSE) goto boing;
		}
		return 0;	/* No room for more monsters */
boing:
		msg("Add a monster - are you sure (y/n)? ");
		if (!yn()) return 0;
	} else {

		/* Edit an existing monster */
		if (!map[rno].monsters[0].on)
			return 0; /* There are no monsters to edit */

		msg("Edit which monster (ESC to cancel)?");
		m = 0;

		AddBob(bobs[0], rp);
		getBobImage(0, 255);

		do {
			bobs[0]->BobVSprite->X = mob[NO_OF_PLAYERS + m].x;
			bobs[0]->BobVSprite->Y = mob[NO_OF_PLAYERS + m].y;
			bob_DrawGList();

			ch = getch();

			if (ch == 0x1b) {
				RemBob(bobs[0]);
				bob_DrawGList();
				return 0;	/* Cancel */
			}
			if ((((incode & KEY_CURSOR) && (ch == 1 || ch == 4)) ||
			     ch == ',')) {
				m++; incode = 0;
			}

			if ((((incode & KEY_CURSOR) && (ch == 2 || ch == 3)) ||
			     ch == '.')) {
				m--; incode = 0;
			}

			while (!map[rno].monsters[m].on && m > 0) m--;

			if (m >= NO_OF_MONSTERS) m = (NO_OF_MONSTERS - 1);
			else if (m < 0) m = 0;

		} while (ch != 0x0d);

moned:
		for (i = 0; i < NO_OF_BOBS; i++) RemBob(bobs[i]);
		bob_DrawGList();

		CLS;
		at(2, 4); ConPuts("F1   Edit location\n");
		at(2, 6); ConPuts("F2   Edit initial start\n");
		at(2, 8); ConPuts("F3   Edit shape\n");
		at(2,10); ConPuts("F4   Edit PlanePick\n");
		at(2,14); ConPuts("ESC  End monster edition\n");

		if (map[rno].monsters[m].xd) d = 'x'; else d = 'y';

		do {
		    ch = 0;
		    ch = getch();

		    if (ch && (incode & KEY_FUNCTION)) {
			switch (ch) {
			    case 1:
				draw_ed_room(rno);
				mob[0].shape = map[rno].monsters[m].shape;
				RemBob(bobs[m + NO_OF_PLAYERS]);
				bob_DrawGList();
				edit_monster_start(rno, m);
				d = ask_monster_xy();
				edit_monster_end(rno, m, d);
				edit_monster_speed(rno, m, d);
				edit_monster_init_start(rno, m);
				goto moned;
				break;
			    case 2:
				draw_ed_room(rno);
				mob[0].shape = map[rno].monsters[m].shape;
				RemBob(bobs[m + NO_OF_PLAYERS]);
				bob_DrawGList();
				edit_monster_init_start(rno, m);
				goto moned;
				break;
			    case 3:
				draw_ed_room(rno);
				RemBob(bobs[m + NO_OF_PLAYERS]);
				bob_DrawGList();
				edit_monster_shape(rno, m);
				goto moned;
				break;
			    case 4:
				draw_ed_room(rno);
				RemBob(bobs[m + NO_OF_PLAYERS]);
				bob_DrawGList();
				edit_monster_planepick(rno, m);
				goto moned;
				break;
			    default:
				break;
			} /* End of switch */
		    }
		} while (ch != 0x1b && ch != 0x0d);

		return 1;
	}

	map[rno].monsters[m].on = FALSE;
	RemBob(bobs[m + NO_OF_PLAYERS]);
	bob_DrawGList();

	map[rno].monsters[m].shape = mob[0].shape = 255;
	getBobImage(0, mob[0].shape);

	edit_monster_start(rno, m);
	edit_monster_shape(rno, m);
	d = ask_monster_xy();
	edit_monster_end(rno, m, d);
	edit_monster_speed(rno, m, d);
	edit_monster_init_start(rno, m);
	edit_monster_planepick(rno, m);

	map[rno].monsters[m].on = TRUE;
	AddBob(bobs[m + NO_OF_PLAYERS], rp);
	bob_DrawGList();

	return 1;
}

void
edit_items(int rno)
{
	char	ch;
	int	i, im;

	msg("(A)dd/(D)elete item (ESC to cancel)? ");
	flush_inkey(0); ConPuts(CURSON);
	do {
		ch = getch();
		ch = tolower(ch);
	} while (ch != 'a' && ch != 'd' && ch != 0x1b);
	flush_inkey(0); ConPuts(CURSOFF);

	if (ch == 0x1b) return;

	if (ch == 'd') {
		im = 0;

		for (i = 0; i < 16; i++)
			if (room_items[i].shape) im++; else break;

		if (!im) return; /* No items to delete */

		msg("Delete which item (ESC to cancel)?");

		AddBob(bobs[0], rp);
		getBobImage(0, 255);

		i = 0;

		do {
			bobs[0]->BobVSprite->X = room_items[i].x * 16;
			bobs[0]->BobVSprite->Y = TOP_EDGE + (16 * room_items[i].y);
			bob_DrawGList();

			ch = getch();
			if (ch == 0x1b) {
				RemBob(bobs[0]);
				bob_DrawGList();
				return;
			}
			if (((incode & KEY_CURSOR && (ch == 1 || ch == 4)) ||
			     ch == ',') &&
			     i < (im - 1)) {
				i++;
			}
			if (((incode & KEY_CURSOR && (ch == 2 || ch == 3)) ||
			     ch == '.') && i > 0) {
				i--;
			}

		} while (ch != 0x0d);

		RemBob(bobs[0]);
		bob_DrawGList();

		items[room_item_no[i]].shape = 0;

		return;
	}

	/* Add item... */
	for (im = 0; im < NO_OF_ITEMS; im++) {
		if (items[im].shape == 0) goto goppa7;
	}
	DisplayBeep(screen);
	return; /* Can't add more items (total max. 256 per map) */

goppa7:
	msg("Add an item - are you sure (y/n)? ");
	if (!yn()) return;

	items[im].rno = rno;

	msg("Place the item");
	locate_bob(255, 9 * 16, TOP_EDGE + 5 * 16, 3);

	items[im].x = (mob[0].x / 16);
	items[im].y = ((mob[0].y - TOP_EDGE) / 16);

	/* Select shape */
	items[im].shape = 256;
	flush_inkey(0);
	msg("Select item shape");
	do {
		blockat(items[im].shape, items[im].x * 16,
			TOP_EDGE + items[im].y * 16, FALSE);
		ch = getch();
		if (ch == '.') {
			items[im].shape++;
			if (items[im].shape > 319) items[im].shape = 256;
		} else if (ch == ',') {
			items[im].shape--;
			if (items[im].shape < 256) items[im].shape = 319;
		}
	} while (ch != 0x0d && ch != 0x1b);
	flush_inkey(0); RemBob(bobs[0]); bob_DrawGList();

	/* Todo: user must select this... */
	items[im].type = ITEM_TREASURE;

	if (items[im].type & ITEM_TREASURE) {
		msg("Item value (1..9)? ");
		flush_inkey(0); ConPuts(CURSON);
		do {
			ch = getch();
			ch = tolower(ch);
		} while (ch < '1' || ch > '9');
		flush_inkey(0); ConPuts(CURSOFF);

		items[im].data = (ch - '1' + 1);
	}

	return;
}

/*
 * Room editor
 *
 */
void
editor_loop(void)
{
 	int		x, y, rx, ry, rno, old_rno, b, old_b, goppa, selb;
	BOOL		large_map, menu;

	player_setup(); /* Reset items etc. */

	the_end = FALSE;
	rx = DEF_MAP_START_X; ry = DEF_MAP_START_Y;
	rno = (ry * MAP_XSIZE + rx);
	x = y = old_rno = old_b = selb = 0;
	b = 6;

	large_map = FALSE;
	menu = TRUE;

	editor_menu(rno, selb, b);

	while (!the_end) {

		if (rx < 0) rx = 0;
		if (rx > (MAP_XSIZE - 1)) rx = (MAP_XSIZE - 1);
		if (ry < 0) ry = 0;
		if (ry > (MAP_YSIZE - 1)) ry = (MAP_YSIZE - 1);

		rno = (ry * MAP_XSIZE + rx);

		if (rno != old_rno && !large_map && !menu) {
			draw_ed_room(rno);
			blockat(b, SWidth - 16, SHeight - 16, FALSE);
			old_rno = rno;
			large_map = FALSE;
		}

		if (b != old_b && !large_map) {
			if (b < 0) b += 256;
			else if (b > 255) b -= 256;
			if (!menu) blockat(b, SWidth - 16, SHeight - 16, FALSE);
			else blockat(b, 302, 60, FALSE);
			old_b = b;
		}

		if (inpos) {

			switch(inkey[0]) {
				case 0x1b: /* ESC: Quit map/editing/editor */
					if (large_map) {
						large_map = FALSE;
						old_rno = -1;
					} else {
						if (!menu) {
							editor_menu(rno, selb, b);
							menu = TRUE;
						} else {
							the_end = TRUE;
						}
					}
					break;

				case 'a': /* Add monster */
					if (!edit_monster(rno, -1))
						DisplayBeep(screen);
					else
						old_rno = -1; /* Redraw */
					break;

				case 'e': /* Edit monster */
					edit_monster(rno, 0);
					old_rno = -1; /* Redraw */
					break;

				case 'i': /* Edit/View items */
					if (!large_map) {
						edit_items(rno);
						old_rno = -1; /* Redraw */
					} else {
						draw_large_map_items();
					}
					break;

				case 'l': /* Large map */
					if (!large_map) {
						draw_large_map(GAME_TEST);
						large_map = TRUE;
					}
					break;

				case 'm': /* m: Toggle Music */
					if (music != 0xffff) {
						stopmusic();
						music = 0xffff;
					} else {
						music = Random(9);
						playmusic(music);
					}
					break;

				case 'n':
					/* Edit room name */
					if (!menu && !large_map) {
						edit_name(rno);
						old_rno = -1; /* Redraw */
					}
					break; 

				case 't':
					/* Test play room */
					if (!large_map) {
						for (x = 0; x < NO_OF_BOBS; x++)
							RemBob(bobs[x]);
						bob_DrawGList();
						msg("Select start location");
						locate_bob(1, 152, TOP_EDGE + 80, 0);
						game_loop(rx, ry, mob[0].x, mob[0].y, GAME_TEST);
						the_end = FALSE;
						player_setup();
						old_rno = -1;
					}
					break;

				case 0x0d:
					if (large_map) {
						large_map = FALSE;
						old_rno = -1;
					} else {
						if (menu) {
							menu = FALSE;
							old_rno = -1;
						} else {
							editor_menu(rno, selb, b);
							menu = TRUE;
						}
					}
					break;

				/* Select room */
				case '1': ry++; rx--; break;
				case '2': ry++; break;
				case '3': ry++; rx++; break;
				case '4': rx--; break;
				case '6': rx++; break;
				case '7': rx--; ry--; break;
				case '8': ry--; break;
				case '9': ry--; rx++; break;

				/* Block selection */
				case '.': b++; break;
				case ',': b--; break;
				case '>': b += 10; break;
				case '<': b -= 10; break;

				/* shift-S: save map */
				case 'S':
					(void)save_map();
					old_rno = -1;
					break;

				default:
					break;
			}

			flush_inkey(0);

		}

		if (cursor_keys & MOUSE_SELECT_BUTTON ||
		    cursor_keys & MOUSE_MENU_BUTTON) {

			if (large_map) {
				/* Select room from map */
				if (cursor_keys & MOUSE_SELECT_BUTTON) {
					/*** room number to rno here ***/
					large_map = FALSE;
				}
			} else if (menu) {
				/* Select block */
				x = mousex / 16;
				y = (mousey - 86) / 16;

				if (y >= 0) {
					b = selb + y * 20 + x;
					blockat(b, 302, 60, FALSE);
				}
			} else {
				/* Editing: draw block */
				x = mousex / 16;
				y = (mousey - TOP_EDGE) / 16;

				goppa = (cursor_keys & MOUSE_SELECT_BUTTON ? b : 0);

				if (x >= 0 && x < ROOM_XSIZE &&
				    y >= 0 && y < ROOM_YSIZE) {
					blockat(goppa, x * 16, TOP_EDGE + y * 16, FALSE);
					map[rno].block[y][x] = goppa;
				}
			}
		}

		if ((cursor_keys & (CUR_UP | CUR_DOWN)) && menu) {
			selb = (selb == 140 ? 0 : 140);
			editor_menu(rno, selb, b);
		}

		if (menu || large_map) WaitIDCMP();
		else WaitBOVP(vp);

		HandleIDCMP();

		draw_room_mobs();

	} /* End of editor loop */

	for (x = 0; x < NO_OF_BOBS; x++) RemBob(bobs[x]);
	bob_DrawGList();
}

void
view_high_scores(void)
{
	int	i;

	CLS;

	for (i = 0; i < NO_OF_HISCORES; i++) {
		ConPuts(COLOR03);
		at( 2, 4 + i); sprintf(buf, "%2d.", i + 1); ConPuts(buf);

		ConPuts(COLOR04);
		at( 6, 4 + i); ConPuts(hiscores[i].name);

		ConPuts(COLOR05);
		if (hiscores[i].score < 1000000)
			sprintf(buf, "%06d", hiscores[i].score);
		else strcpy(buf, "*HUGE*");
		at(33, 4 + i); ConPuts(buf);
	}
}

/*
 * Main program
 *
 */
int
main(int argc, char **argv)
{
	int		i;
	char		ch;

	openup(320, 208, 4, NULL, JSB_TITLE, NULL);

	ConPuts(CURSOFF);
	ConPuts(DISABLE_SCROLL);
	ConPuts("\2330y"); /* Set console top offset to 0 */

/*	ShowTitle(screen, FALSE); */

	/* Load block graphics */
	if ((gfx = SimpleLoadILBM("Pics/graphics.ilbm")) == NULL) {
		fprintf(stderr, "Can't load backround graphics!\n");
		goto the_end;
	}

	/* Get color table */
	LoadRGB4(vp, gfx->ColorTable, 16);

	/* Allocate and load bob images */
	if ((bob_images = AllocMem(BOB_IMAGE_AREA_SIZE, MEMF_CHIP)) == NULL) {
		fprintf(stderr, "Out of chip memory!\n");
		goto the_end;
	}
	load_packed_file("Bobs.img", (UBYTE *)bob_images, BOB_IMAGE_AREA_SIZE);

	/* ImageShadows' address */
	shadows = (bob_images + (BOB_IMAGE_SIZE * 256 / 2));

	/* Make bob image and shadow address tables */
	for (i = 0; i < 256; i++) {
		bob_image_addr[i] = (bob_images + (i * (BOB_IMAGE_SIZE / 2)));
		bob_shadow_addr[i] = (shadows + (i * (BOB_SHADOW_SIZE / 2)));
	}

	/* Load base map */
	load_packed_file("maps/JSB.map", (UBYTE *)map, sizeof(map));

	/* Load base items */
	load_packed_file("maps/JSB.itm", (UBYTE *)items, sizeof(items));

	/* Load high scores */
	if (!load_packed_file("maps/JSB.hi",
		(UBYTE *)hiscores, sizeof(hiscores))) clear_hiscores();

	(void)strcpy(hifile, "maps/JSB.hi");

	/* Load music and init player */
	initmusic();

	/* Initialize filerequester stuff */
	setup_asl();

	SetAPen(rp, 1);

	for (i = 0; i < NO_OF_BOBS; i++) {
		bobs[i] = NULL;
	}

	if ((my_ginfo = setupGelSys(rp, 0xfc)) == NULL) {
		goto the_end;
	}

	/* Allocate bobs */
	for (i = 0; i < NO_OF_BOBS; i++) {

		new_bobs[i].nb_Image = bob_images;
		new_bobs[i].nb_WordWidth = 1;
		new_bobs[i].nb_LineHeight = 16;
		new_bobs[i].nb_ImageDepth = 3;
		new_bobs[i].nb_PlanePick = 0x07;
		new_bobs[i].nb_PlaneOnOff = 0x00;
		new_bobs[i].nb_BFlags = SAVEBACK | OVERLAY;
		new_bobs[i].nb_DBuf = 0;
		new_bobs[i].nb_RasDepth = SDepth;

		if ((bobs[i] = makeBob(&new_bobs[i], NO_MASKS)) == NULL) {
			goto the_end;
		}

		/* Need both bits on both masks of both kinds of gels to
		   detect collisions from both sides. Don't believe Rom
		   Kernel Manual. */
		bobs[i]->BobVSprite->HitMask = (1 << COLL_PLR_BIT);
		bobs[i]->BobVSprite->MeMask = (1 << COLL_PLR_BIT);

		bobs[i]->BobVSprite->VUserExt = i;  /* Store mob/bob number */
	}

	/* Don't use (1 << COLL_PLR_BIT) here. It doesn't work very well... */
	SetCollision(COLL_PLR_BIT, &collision, rp->GelsInfo);

/* Doesn't work this easily...some bobs are not on, and rest are not drawn */
#if 0
	/* Bob 0 is first, then the rest */
	bobs[0]->Before = bobs[1];
	for (i = 1; i < (NO_OF_BOBS - 2); i++) {
		bobs[i]->After  = bobs[i - 1];
		bobs[i]->Before = bobs[i + 1];
	}
	bobs[(NO_OF_BOBS - 1)]->After = bobs[(NO_OF_BOBS - 2)];
#endif

restart_game:

	music = 0;
	playmusic(music);

	SetRast(rp, 0);

dont_cls:

	ConPuts(COLOR01);
	at(7, 4); ConPuts("William JetSet");

	ConPuts(COLOR03);
	at(4, 7); ConPuts("F1   Play JetSet Billy");
	at(4, 8); ConPuts("F2   Edit rooms");
	at(4, 9); ConPuts("F3   Load map");
	at(4,10); ConPuts("F4   New map");
	at(4,11); ConPuts("F5   View high scores");
	at(4,12); ConPuts("m	Toggle music\n");
	at(4,13); ConPuts("ESC  Quit");

	at(1, 20); ConPuts(COLOR07);
	ConPuts("Code, graphics, music: Niilo Paasivirta\n");
	ConPuts("Packer               : Risto Paasivirta\n");
	ConPuts("Help and utilities   : Timo Rossi\n");
	ConPuts("MED and modplayer    : Teijo Kinnunen");
	ConPuts(COLOR01);

	the_end = FALSE;
	incode = 0;

	/* Main loop */
	while (!the_end) {

		if (inpos) {
			ch = inkey[0];
			flush_inkey(0);
		} else ch = 0;

		/* Function keys? */
		if (ch && (incode & KEY_FUNCTION)) {
			switch (ch) {
			    case 1:
				if (music != 0xffff) {
					music = 5;
					playmusic(music);
				}
				game_loop(DEF_MAP_START_X, DEF_MAP_START_Y,
					48, TOP_EDGE + 9 * 16, GAME_REAL);
				/* Play the game in real mode */
				goto restart_game;
				break;
			    case 2:
				stopmusic();
				editor_loop();
				goto restart_game;
				break;
			    case 3:
				load_map();
				if (error_message[0]) {
					clear_msg_area();
					ConPuts(error_message);
				}
				goto dont_cls;
				break;
			    case 4:
				msg("Are you sure (y/n)? ");
				if (!yn()) break;
				clear_map();
				msg("Map, items, monsters and hiscore cleared.");
				goto dont_cls;
				break;
			    case 5:
				if (music != 0xffff) playmusic(4);
				view_high_scores();
				ConPuts(COLOR01);
				at(13, 26); ConPuts("Press any key");
				flush_inkey(0); while(!getch());
				if (music != 0xffff) playmusic(music);
				goto restart_game;
			    case 6:
				if (music != 0xffff) {
					music = 5;
					playmusic(music);
				}
				game_loop(DEF_MAP_START_X, DEF_MAP_START_Y,
					48, TOP_EDGE + 9 * 16, GAME_DEBUG | GAME_REAL);
				/* Play the game, start in debug (cheat) mode */
				goto restart_game;
				break;
			    default:
				break;
			}
		} else if (ch) {
			switch(ch) {
				case 0x1b: /* ESC: 	Quit */
					msg("Quit? Are you sure (y/n)? ");
					if (yn()) goto the_end;
					clear_msg_area();
					goto dont_cls;
					break;

				case 'm': /* m: Toggle Music */
					if (music != 0xffff) {
						stopmusic();
						music = 0xffff;
					} else {
						music = 0;
						playmusic(music);
					}
					break;

				default:
					break;

			} /* End of inkey switch */
		}

		WaitIDCMP();
		HandleIDCMP();

	} /* End of main loop */

the_end:
	cleanmusic();

	if (my_ginfo) {

		for (i = 0; i < NO_OF_BOBS; i++) RemBob(bobs[i]);

		bob_DrawGList();

		/* Free bobs */
		for (i = 0; i < NO_OF_BOBS; i++) {
			if (bobs[i]) {
			  freeBob(bobs[i], new_bobs[i].nb_RasDepth, NO_MASKS);
			}
		}

		cleanupGelSys(my_ginfo, rp);
	}

	if (gfx) FreePicture(gfx);

	if (bob_images) FreeMem(bob_images, BOB_IMAGE_AREA_SIZE);

	cleandown_asl();
	cleandown(0);
}
