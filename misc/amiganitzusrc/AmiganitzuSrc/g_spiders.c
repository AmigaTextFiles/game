/* g_spiders.c */
#include <clib/graphics_protos.h>
#include "g_video.h"
#include "g_headers.h"
#include "g_audio.h"

extern struct BitMap tile_bm[NUMBER_OF_TILE_BITMAPS];
extern struct player_struct player;
extern struct map_struct *map;
struct spiders_struct spi[10]; // up to 10 spiders per screen
extern int update;
extern int plx, ply;
extern unsigned char spider_anim_bm;
extern int is_spiders;
extern struct sample_struct sample[NUM_SAMPLES];
extern struct RastPort *rp;
extern ULONG vbcounter;
ULONG spi_time = 0;

int check_place(struct check_struct *check)
{
	int dx, dy, x, y;

	x = check->lx;
	y = check->ly;

	dx = x;
	dy = y;

	//printf("\ncheck_place %d %d - %d\n", x, y, check->place);

	// work out the tile to test
	switch(check->place)
	{
	case NW:
		dx = x - 1;
		dy = y - 1;
		break;
	case WST:
		dx = x - 1;
		break;
	case SW:
		dx = x - 1;
		dy = y + 1;
		break;
	case STH:
		dy = y + 1;
		break;
	case SE:
		dx = x + 1;
		dy = y + 1;
		break;
	case EST:
		dx = x + 1;
		break;
	case NE:
		dx = x + 1;
		dy = y - 1;
		break;
	case NTH:
		dy = y - 1;
		break;
	}

	check->dx = dx;
	check->dy = dy;
	if(dx < 0 || dy < 0 || dx > 15 || dy > 11) return 0;
	if(map->t[dx][dy].type == NOTHING || map->t[dx][dy].type == SPIDER) return 1;
	else return 0;
}



int check_spider_move_time()
{
	ULONG ticks;

	ticks = vbcounter;
	if(ticks >= spi_time + 12) {
		spi_time = ticks;
		return 1;
	}
	else return 0;
}

int spider_touch_player(int i)
{
	int x, y;
	int result = 0;

	x = spi[i].x;
	y = spi[i].y;

	// check counter clockwise from north
	if(y - 1 == ply && x == plx) result = 1;
	if(y == ply && x - 1 == plx) result = 1;
	if(y + 1 == ply && x == plx) result = 1;
	if(y == ply && x + 1 == plx) result = 1;

	return result;
}

int spider_enclosed(int i)
{
	int x, y, l;
	int result = 0;
	int anim_up = 0, anim_down = 0, anim_left = 0, anim_right = 0;
	ULONG anim_time = 0;

	if(spi[i].empty == 1) return 0;

	x = spi[i].x;
	y = spi[i].y;
	
	if(map->t[x - 1][y].type != NOTHING) result++;
	if(map->t[x][y + 1].type != NOTHING) result++;
	if(map->t[x + 1][y].type != NOTHING) result++;
	if(map->t[x][y - 1].type != NOTHING) result++;

	if(result == 4) {
		spi[i].empty = 1;
		
		if(map->t[x - 1][y].type == ROCK || map->t[x - 1][y].sub_type == PIPE1 || map->t[x - 1][y].sub_type == PIPE2 || map->t[x - 1][y].sub_type == PIPE7 || map->t[x - 1][y].sub_type == PIPE8) {
			map->t[x - 1][y].type = DIAMOND;
			map->t[x - 1][y].bm = BM_DIAMOND;
			map->t[x - 1][y].update = 1;
			anim_left = 1;
		}
		if(map->t[x][y + 1].type == ROCK || map->t[x][y + 1].sub_type == PIPE1 || map->t[x][y + 1].sub_type == PIPE2 || map->t[x][y + 1].sub_type == PIPE7 || map->t[x][y + 1].sub_type == PIPE8) {
			map->t[x][y + 1].type = DIAMOND;
			map->t[x][y + 1].bm = BM_DIAMOND;
			map->t[x][y + 1].update = 1;
			anim_down = 1;
		}
		if(map->t[x + 1][y].type == ROCK || map->t[x + 1][y].sub_type == PIPE1 || map->t[x + 1][y].sub_type == PIPE2 || map->t[x + 1][y].sub_type == PIPE7 || map->t[x + 1][y].sub_type == PIPE8) {
			map->t[x + 1][y].type = DIAMOND;
			map->t[x + 1][y].bm = BM_DIAMOND;
			map->t[x + 1][y].update = 1;
			anim_right = 1;
		}
		if(map->t[x][y - 1].type == ROCK || map->t[x][y - 1].sub_type == PIPE1 || map->t[x][y - 1].sub_type == PIPE2 || map->t[x][y - 1].sub_type == PIPE7 || map->t[x][y - 1].sub_type == PIPE8) {
			map->t[x][y - 1].type = DIAMOND;
			map->t[x][y - 1].bm = BM_DIAMOND;
			map->t[x][y - 1].update = 1;
			anim_up = 1;
		}
		
		map->t[x][y].type = DIAMOND;
		map->t[x][y].bm = BM_DIAMOND;
		map->t[x][y].update = 1;
		add_points(100);
		map->update = 1;
		// see if there are any spiders left, stop audio if not
		is_spiders = 0;
		for(l = 0; l < 10; l++) {
			if(!spi[l].empty && l != i) is_spiders = 1;
		}
		if(!is_spiders) stop_loop(3);
		play_sample(&sample[S_EXPLODE1], 2);
		
		// do an exploding animation
		set_to_onscreen();
		BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
		if(anim_up) BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, x * 16, (y-1) * 16, 16, 16, 0x0C0);
		if(anim_down) BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, x * 16, (y+1) * 16, 16, 16, 0x0C0);
		if(anim_right) BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, (x+1) * 16, y * 16, 16, 16, 0x0C0);
		if(anim_left) BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, (x-1) * 16, y * 16, 16, 16, 0x0C0);
		anim_time = vbcounter;
		while(vbcounter < anim_time + 4);
		BltBitMapRastPort(&tile_bm[BM_SPLODE1], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
		if(anim_up) BltBitMapRastPort(&tile_bm[BM_SPLODE1], 0, 0, rp, x * 16, (y-1) * 16, 16, 16, 0x0C0);
		if(anim_down) BltBitMapRastPort(&tile_bm[BM_SPLODE1], 0, 0, rp, x * 16, (y+1) * 16, 16, 16, 0x0C0);
		if(anim_right) BltBitMapRastPort(&tile_bm[BM_SPLODE1], 0, 0, rp, (x+1) * 16, y * 16, 16, 16, 0x0C0);
		if(anim_left) BltBitMapRastPort(&tile_bm[BM_SPLODE1], 0, 0, rp, (x-1) * 16, y * 16, 16, 16, 0x0C0);
		anim_time = vbcounter;
		while(vbcounter < anim_time + 4);
		BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
		if(anim_up) BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, x * 16, (y-1) * 16, 16, 16, 0x0C0);
		if(anim_down) BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, x * 16, (y+1) * 16, 16, 16, 0x0C0);
		if(anim_right) BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, (x+1) * 16, y * 16, 16, 16, 0x0C0);
		if(anim_left) BltBitMapRastPort(&tile_bm[BM_SPLODE2], 0, 0, rp, (x-1) * 16, y * 16, 16, 16, 0x0C0);
		anim_time = vbcounter;
		while(vbcounter < anim_time + 4);
		
		map->t[player.prev_x][player.prev_y].update = 1;
		
		return 1;
	}
	else return 0;
}

void move_spiders()
{
	int move_success, place = 0, i;
	struct check_struct check;
	int sx, sy, old_bm;

	for(i = 0; i < 10; i++) {
		if(!spi[i].empty) {
			move_success = 0;
			old_bm = map->t[spi[i].x][spi[i].y].bm;

			// check if we are enclosed or touching the player first
			if(spider_touch_player(i)) {
				player_dies();
				return;
			}
			if(spider_enclosed(i)) {
				move_success = 1;
				break;
			}
			
			sx = spi[i].x;
			sy = spi[i].y;
			// try move this spider
			while(!move_success) {
				// move to next place
				if(spi[i].orientation == CCW) {
					place = spi[i].latched_edge + 1;
					if(place == 8) place = 0;
				}
				if(spi[i].orientation == CW) {
					place = spi[i].latched_edge - 1;
					if(place == -1) place = 7;
				}
				check.lx = spi[i].lx;
				check.ly = spi[i].ly;
				check.place = place;

				if(check_place(&check))	{
					// good, move here
					map->t[spi[i].x][spi[i].y].type = NOTHING;
					map->t[spi[i].x][spi[i].y].bm = BM_BLANK;
					map->t[spi[i].x][spi[i].y].update = 1;
					spi[i].latched_edge = place;
					spi[i].x = check.dx;
					spi[i].y = check.dy;
					spi[i].lx = check.lx;
					spi[i].ly = check.ly;
					map->t[spi[i].x][spi[i].y].type = SPIDER;
					map->t[spi[i].x][spi[i].y].update = 1;
				}
				else {
					// second pass
					// we now have this tile that is blocking us
					// se if we can latch onto the edge of this tile
					if(spi[i].orientation == CCW) {
						place = spi[i].latched_edge - 1;
						if(place == -1 ) place = 7;
					}
					if(spi[i].orientation == CW) {
						place = spi[i].latched_edge + 1;
						if(place == 8 ) place = 0;
					}
					check.lx = check.dx;
					check.ly = check.dy;
					check.place = place;

					if(check_place(&check))	{
						// good, move here
						map->t[spi[i].x][spi[i].y].type = NOTHING;
						map->t[spi[i].x][spi[i].y].bm = BM_BLANK;
						map->t[spi[i].x][spi[i].y].update = 1;
						spi[i].latched_edge = place;
						spi[i].x = check.dx;
						spi[i].y = check.dy;
						spi[i].lx = check.lx;
						spi[i].ly = check.ly;
						map->t[spi[i].x][spi[i].y].type = SPIDER;
						map->t[spi[i].x][spi[i].y].update = 1;
					}
					else {
						// third pass
						if(spi[i].orientation == CCW) {
							place = spi[i].latched_edge - 4;
							if(place == -4) place = 4;
							if(place == -3) place = 5;
							if(place == -2) place = 6;
							if(place == -1) place = 7;
						}
						if(spi[i].orientation == CW) {
							place = spi[i].latched_edge + 4;
							if(place == 11) place = 3;
							if(place == 10) place = 2;
							if(place == 9) place = 1;
							if(place == 8) place = 0;
						}
						check.lx = check.dx;
						check.ly = check.dy;
						check.place = place;

						if(check_place(&check)) {
							// good, move here
							map->t[spi[i].x][spi[i].y].type = NOTHING;
							map->t[spi[i].x][spi[i].y].bm = BM_BLANK;
							map->t[spi[i].x][spi[i].y].update = 1;
							spi[i].latched_edge = place;
							spi[i].x = check.dx;
							spi[i].y = check.dy;
							spi[i].lx = check.lx;
							spi[i].ly = check.ly;
							map->t[spi[i].x][spi[i].y].type = SPIDER;
							map->t[spi[i].x][spi[i].y].update = 1;
						}
						else move_success = 1;
					}
				}
				if(!(sx == spi[i].x && sy == spi[i].y)) {
					move_success = 1;
					map->update = 1;
				}
			}
			if(old_bm == BM_SPIDER1) map->t[spi[i].x][spi[i].y].bm = BM_SPIDER2;
			else map->t[spi[i].x][spi[i].y].bm = BM_SPIDER1;

			// check if we are enclosed or touching the player after moving
			if(spider_touch_player(i)) {
				player_dies();
				return;
			}
			if(spider_enclosed(i)) move_success = 1;
		}
	}
}

