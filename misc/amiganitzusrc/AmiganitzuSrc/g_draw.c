// g_draw.c
#include <exec/exec.h>
#include <clib/exec_protos.h>
#include <graphics/gfx.h>
#include <clib/graphics_protos.h>
#include "g_headers.h"
#include "g_video.h"

extern int __asm AsmBlitAligned(void);
extern int __asm AsmBlit(void);


extern struct RastPort rp_menu, *rp;
extern struct statuspanel_struct spanel;
extern struct map_struct *map;
extern struct player_struct player;
extern struct game_struct game;
extern struct BitMap tile_bm[NUMBER_OF_TILE_BITMAPS];
extern int tile_w, tile_h;
extern int plx, ply;
extern int finished;
extern struct spiders_struct spi[10];
extern struct highscores_struct hscores[10];
unsigned char spider_anim_bm;
extern ULONG vbcounter;


void draw_instructions()
{
	int y;

	SetAPen(&rp_menu, 0);
	BltPattern(&rp_menu, NULL,0, 0, 639, 199, 0);
	SetAPen(&rp_menu, 1);
	y = 10;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Controls", 8);
	y+=9;
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Move left, right, up, down with joystick or cursor keys.", 56);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Fire or Escape to enter menu.", 29);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "P to pause - S to suicide (if you become stuck).", 48);
	y+=9;
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Gameplay", 8);
	y+=9;
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Collect all the keys, then exit via the door.", 45);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Spiders will kill you if you are caught adjacent to them.", 57);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Spiders will explode if they are unable to keep moving.", 55);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Snakes will spit poison and kill you if you are in their horizontal line", 72);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "of sight.", 9);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Traps will spring up and kill you if you are not quick, you can also", 68);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "block them with bloulders. After they are sprung they are deactivated.", 70);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "You can push boulders around and dig out dirt.", 46);
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "Collect gems for points and extra lives.", 40);
	y+=9;
	y+=9;
	Move(&rp_menu, 0, y);
	Text(&rp_menu, "There are 30 levels to enjoy (or frustrate).", 44);
}

void draw_highscores()
{
	int i, y;
	char str[48];
	
	SetAPen(&rp_menu, 0);
	BltPattern(&rp_menu, NULL,0, 0, 639, 199, 0);
	SetAPen(&rp_menu, 1);
	Move(&rp_menu, 213, 72);
	Text(&rp_menu, "High Scores", 11);

	for(i = 0, y = 88; i < 10; i++, y+=8) {
		Move(&rp_menu, 213, y);
		// points
		sprintf(str, "%d", hscores[i].points);
		Text(&rp_menu, str, strlen(str));
		// name
		sprintf(str, "%s", hscores[i].pname);
		Move(&rp_menu, 264, y);
		Text(&rp_menu, str, strlen(str));
	}
}

void draw_map_message()
{
	int i, length, x, y;

	map->update = 1;
	if(map->hard_code) hard_code();
	if(map->update) draw_map();

	set_to_offscreen();
	
	SetAPen(rp, 1);
	SetBPen(rp, 9);
	for(i = 0; i < map->num_lines; i++)	{
		length = strlen(map->line[i]);
		Move(rp, 5, (i * 8) + 10);
		Text(rp, map->line[i], length);
	}
	SetAPen(rp, 0);
	SetBPen(rp, 0);

	swap_buffers();
	WaitTOF();
	set_to_offscreen();

	SetAPen(rp, 1);
	SetBPen(rp, 9);
	for(i = 0; i < map->num_lines; i++)	{
		length = strlen(map->line[i]);
		Move(rp, 5, (i * 8) + 10);
		Text(rp, map->line[i], length);
	}
	SetAPen(rp, 0);
	SetBPen(rp, 0);

	// repair the tiles we wrote over
	for(y = 0; y < 6; y++) for(x = 0; x < MAP_W; x++) map->t[x][y].update = 1;
	map->update = 1;
}

void anim_collapse(int x, int y)
{
	ULONG anim_time;

	set_to_onscreen();

	anim_time = vbcounter;
	BltBitMapRastPort(&tile_bm[BM_COLLAPSE1], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
	while(vbcounter < anim_time + 4);
	anim_time = vbcounter;
	BltBitMapRastPort(&tile_bm[BM_COLLAPSE2], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
	while(vbcounter < anim_time + 4);
	anim_time = vbcounter;
	BltBitMapRastPort(&tile_bm[BM_COLLAPSE3], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
	while(vbcounter < anim_time + 4);
}



void draw_player()
{
	switch(player.anim_flag)
	{
	case ANIM_NONE:
		set_to_offscreen();
		if(map->t[player.prev_x][player.prev_y].type == NOTHING) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * 16, player.prev_y * 16, 16, 16, 0x0C0);
		if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST], 0, 0, rp, plx * 16, ply * 16, 16, 16, 0x0C0);
		if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST], 0, 0, rp, plx * 16, ply * 16, 16, 16, 0x0C0);
		player.update = 0;
		swap_buffers();
		WaitTOF();
		set_to_offscreen();
		if(map->t[player.prev_x][player.prev_y].type == NOTHING) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * 16, player.prev_y * 16, 16, 16, 0x0C0);
		if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST], 0, 0, rp, plx * 16, ply * 16, 16, 16, 0x0C0);
		if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST], 0, 0, rp, plx * 16, ply * 16, 16, 16, 0x0C0);
		break;
	case ANIM_WAIT:
		if(vbcounter >= player.anim_time + 6) player.anim_flag = ANIM_NONE;
		break;
	case ANIM_START:
		if(player.prev_y == ply - 1)
		{
			// we have moved south
			set_to_offscreen();
			if(map->t[player.prev_x][player.prev_y].type == NOTHING  && map->t[player.prev_x][player.prev_y].update) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * TILE_W, player.prev_y * TILE_H, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST2], 0, 0, rp, plx * 16, (ply * 16)-8, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST2], 0, 0, rp, plx * 16, (ply * 16)-8, 16, 16, 0x0C0);
			player.anim_flag = ANIM_WAIT;
			player.anim_time = vbcounter;
			swap_buffers();
			WaitTOF();
			set_to_offscreen();
			if(map->t[player.prev_x][player.prev_y].type == NOTHING  && map->t[player.prev_x][player.prev_y].update) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * TILE_W, player.prev_y * TILE_H, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST2], 0, 0, rp, plx * 16, (ply * 16)-8, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST2], 0, 0, rp, plx * 16, (ply * 16)-8, 16, 16, 0x0C0);
		}
		if(player.prev_y == ply + 1)
		{
			// we have moved north
			set_to_offscreen();
			if(map->t[player.prev_x][player.prev_y].type == NOTHING && map->t[player.prev_x][player.prev_y].update) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * TILE_W, player.prev_y * TILE_H, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST2], 0, 0, rp, plx * 16, (ply * 16)+8, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST2], 0, 0, rp, plx * 16, (ply * 16)+8, 16, 16, 0x0C0);
			player.anim_flag = ANIM_WAIT;
			player.anim_time = vbcounter;
			swap_buffers();
			WaitTOF();
			set_to_offscreen();
			if(map->t[player.prev_x][player.prev_y].type == NOTHING && map->t[player.prev_x][player.prev_y].update) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * TILE_W, player.prev_y * TILE_H, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST2], 0, 0, rp, plx * 16, (ply * 16)+8, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST2], 0, 0, rp, plx * 16, (ply * 16)+8, 16, 16, 0x0C0);
		}
		if(player.prev_x == plx + 1)
		{
			// we have moved west
			set_to_offscreen();
			if(map->t[player.prev_x][player.prev_y].type == NOTHING && map->t[player.prev_x][player.prev_y].update) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * TILE_W, player.prev_y * TILE_H, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST2], 0, 0, rp, (plx * 16)+8, ply * 16, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST2], 0, 0, rp, (plx * 16)+8, ply * 16, 16, 16, 0x0C0);
			player.anim_flag = ANIM_WAIT;
			player.anim_time = vbcounter;
			swap_buffers();
			WaitTOF();
			set_to_offscreen();
			if(map->t[player.prev_x][player.prev_y].type == NOTHING && map->t[player.prev_x][player.prev_y].update) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * TILE_W, player.prev_y * TILE_H, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST2], 0, 0, rp, (plx * 16)+8, ply * 16, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST2], 0, 0, rp, (plx * 16)+8, ply * 16, 16, 16, 0x0C0);
		}
		if(player.prev_x == plx - 1)
		{
			// we have moved east
			set_to_offscreen();
			if(map->t[player.prev_x][player.prev_y].type == NOTHING && map->t[player.prev_x][player.prev_y].update) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * TILE_W, player.prev_y * TILE_H, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST2], 0, 0, rp, (plx * 16)-8, ply * 16, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST2], 0, 0, rp, (plx * 16)-8, ply * 16, 16, 16, 0x0C0);
			player.anim_flag = ANIM_WAIT;
			player.anim_time = vbcounter;
			swap_buffers();
			WaitTOF();
			set_to_offscreen();
			if(map->t[player.prev_x][player.prev_y].type == NOTHING && map->t[player.prev_x][player.prev_y].update) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * TILE_W, player.prev_y * TILE_H, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == WEST) BltBitMapRastPort(&tile_bm[BM_PLAYWEST2], 0, 0, rp, (plx * 16)-8, ply * 16, 16, 16, 0x0C0);
			if(map->t[plx][ply].direction == EAST) BltBitMapRastPort(&tile_bm[BM_PLAYEAST2], 0, 0, rp, (plx * 16)-8, ply * 16, 16, 16, 0x0C0);
		}
		break;
	}
}

void update_statuspanel()
{
	char str[16];
	
	if(spanel.update_background) {
		SetAPen(rp, 0);
		BltPattern(rp, NULL, (16 * TILE_W), 0, 318, 198, 0);
	}
	SetAPen(rp, 1);
	if(spanel.update_room) {
		if(spanel.update_labels) {
			Move(rp, (16 * TILE_W) + 4, 8);
			Text(rp, "Room", 4);
		}
		sprintf(str, "%d ", player.level);
		Move(rp, (16 * TILE_W) + 4, 16);
		Text(rp, str, 2);
	}
	if(spanel.update_lives) {
		if(spanel.update_labels) {
			Move(rp, (16 * TILE_W) + 4, 32);
			Text(rp, "Lives", 5);
		}
		sprintf(str, "%d ", player.lives);
		Move(rp, (16 * TILE_W) + 4, 40);
		Text(rp, str, 2);
	}
	if(spanel.update_score) {
		if(spanel.update_labels) {
			Move(rp, (16 * TILE_W) + 4, 56);
			Text(rp, "Score", 5);
		}
		Move(rp, (16 * TILE_W) + 4, 64);
		sprintf(str, "%d      ", player.score);
		Text(rp, str, 6);
	}
	if(spanel.update_bonus) {
		if(spanel.update_labels) {
			Move(rp, (16 * TILE_W) + 4, 80);
			Text(rp, "Bonus", 5);
		}
		Move(rp, (16 * TILE_W) + 4, 88);
		sprintf(str, "%d    ", player.bonus);
		Text(rp, str, 3);
	}
	SetAPen(rp, 0);
}

void draw_statuspanel()
{
	set_to_offscreen();
	update_statuspanel();
	swap_buffers();
	WaitTOF();
	set_to_offscreen();
	update_statuspanel();

	spanel.update = 0;
	spanel.update_labels = 0;
	spanel.update_room = 0;
	spanel.update_bonus = 0;
	spanel.update_score = 0;
	spanel.update_lives = 0;
	spanel.update_background = 0;
}

void draw_map_updates()
{
	static int x, y;

	// draw to back screen
	set_to_offscreen();
	for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) {	
		if(map->t[x][y].update) {
			if(map->t[x][y].type == NOTHING || map->t[x][y].type == PLAYER) {
				BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
			}
			else {
				BltBitMapRastPort(&tile_bm[map->t[x][y].bm], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
			}
		}
	}
	// switch screens
	swap_buffers();
	WaitTOF();
	// keep other buffer up to date
	set_to_offscreen();
	for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) {	
		if(map->t[x][y].update) {
			if(map->t[x][y].type == NOTHING || map->t[x][y].type == PLAYER) {
				BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
			}
			else {
				BltBitMapRastPort(&tile_bm[map->t[x][y].bm], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
			}
			map->t[x][y].update = 0;
		}
	}
}

void draw_map()
{
	draw_map_updates();	
	map->update = 0;
}

void death_animation()
{
	int i, offset;
	ULONG time_stamp = 0, ticks;
	
	map->update = 1;
	if(map->hard_code) hard_code();
	if(map->update) draw_map();

	i = 0;
	offset = BM_DEATH1;
	player.update = 1;
	draw_player();
	ticks = vbcounter;
	while(vbcounter < ticks + 8);
	draw_player();
	set_to_onscreen();
	if(map->t[player.prev_x][player.prev_y].type == NOTHING) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, player.prev_x * 16, player.prev_y * 16, 16, 16, 0x0C0);
	while(i < 7) {
		ticks = vbcounter;
		if(ticks >= time_stamp + 6) {
			time_stamp = ticks;
			// draw the players bitmap
			BltBitMapRastPort(&tile_bm[i + offset], 0, 0, rp, plx * 16, ply * 16, 16, 16, 0x0C0);
			i++;
		}
	}
}

void set_topaz8_font()
{
	struct TextAttr text_attr;
	struct TextFont *text_font = NULL;
	char font_name[16];

	sprintf(font_name, "topaz.font");
	text_attr.ta_Name = font_name;
	text_attr.ta_YSize = 8;
	text_attr.ta_Style = FS_NORMAL;
	text_attr.ta_Flags = FPB_ROMFONT;

	text_font = OpenFont(&text_attr);
	if(!text_font) {
		printf("\nopening font %s didn't work\n", text_attr.ta_Name);
		finished = 1;
		return;
	}
	SetFont(&rp_menu, text_font);
	set_to_onscreen();
	SetFont(rp, text_font);
	set_to_offscreen();
	SetFont(rp, text_font);
}

