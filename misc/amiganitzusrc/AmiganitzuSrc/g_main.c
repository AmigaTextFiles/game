
/* 
	Amiganitzu version 1.5
	By Simon Keogh
	2012-2013

	g_main.c 
*/
#include <graphics/gfx.h>
#include <intuition/intuition.h>
#include <clib/dos_protos.h>
#include <clib/exec_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>
#include <graphics/gfxmacros.h>
#include <exec/memory.h>
#include <exec/interrupts.h>
#include <dos/dos.h>
#include <hardware/custom.h>
#include <hardware/intbits.h>
#include "g_headers.h"
#include "g_video.h"
#include "g_ilbm.h"
#include "g_input.h"
#include "g_ui.h"
#include "g_audio.h"
#include "g_8svx.h"


extern struct View view_menu;
extern struct timeval sys_time;
extern struct RastPort rp_menu, *rp;
extern struct input_state ips;
WORD  mouse_x, mouse_y;
extern struct tport_struct tport[10];
extern int num_tports;
extern struct menu_element_struct m_elements[10];
extern struct menu_screen_struct m_screens[6];
extern struct sample_struct sample[NUM_SAMPLES];
extern struct UCopList *coplist_menu, *coplist_play;
extern int is_spiders, is_water;
unsigned char no_audio;
ULONG pl_time = 0;
extern void __asm VertBServer();
ULONG vbcounter;
struct Interrupt *vbint = NULL;
struct palette_struct no_pal;
char keycodes[128];
struct statuspanel_struct spanel;
struct map_struct *map = NULL;
struct joy_data jd;
struct player_struct player;
struct game_struct game;
struct highscores_struct hscores[10];
struct BitMap tile_bm[NUMBER_OF_TILE_BITMAPS];
int plx, ply;
int finished = 0;


int main(int argc, char *argv[])
{
	int load_tiles_fail = 0;
	char level_name[48];
	ULONG ambient_time = 0;
	
	// allocate memory for game structures
	map = AllocMem(sizeof(struct map_struct), 0L);
	if(!map) {
		printf("Could not allocate memory for map->\n");
		return 0;
	}

	// player pos 
	plx = 0;
	ply = 0;
	player.score = 0;
	player.keys = 0;
	player.level = 1;
	player.lives = 5;
	player.lives_score = 0;
	player.prev_x = plx;
	player.prev_y = ply;
	player.anim_flag = ANIM_NONE;
	player.anim_time = 0;
	player.update = 1;
	player.bonus = 0;
	player.audio_channel = 0; // player sounds
	player.audio_channelB = 0; // other sounds
	
	game.player_anim = 1;
	game.state = IN_MENU;
	game.cur_menu = MS_MAIN;
	game.in_progress = 0;
	game.sound_on = 1;
	game.volume = 64;
	game.menu_copperbars = BLUEBARS;
	game.play_copperbars = NOBARS;
	
	spanel.update = 1;
	spanel.update_labels = 1;
	spanel.update_room = 1;
	spanel.update_score = 1;
	spanel.update_lives = 1;
	spanel.update_bonus = 1;
	spanel.update_background = 1;
	
	init_keycodes();

	
	vbcounter = 0;
	if(!install_vbinterrupt()) {
		printf("unable to install VBLANK interrupt\n");
		return 0;
	}

	init_menus();

	sprintf(level_name, "data/map%d.txt", player.level);
	if(!load_map(level_name)) {
		printf("cant load map %s\n", level_name);
		remove_vbinterrupt();
		FreeMem(map, sizeof(struct map_struct));
		return 0;
	}
	player.prev_x = plx;
	player.prev_y = ply;
	map->update = 1;
	
	// start input
	if(!init_input()) {
		printf("init input failed\n");
		finished = 1;
	}

	set_mouse_pos(360, 300);
	

	// set up display
	if(!init_display(320, 200, 5)) {
		printf("Could not init display \n");
		video_exit();
		exit(0);
	}
	/*
	make_copperlist(coplist_play, game.play_copperbars, 0);
	LoadView(&view);*/
	make_copperlist(coplist_menu, game.menu_copperbars, 1);
	LoadView(&view_menu);
	set_topaz8_font();

	// init audio must be after init_display()
	// it needs a to know PAL or NTSC from GfxBse
	if(!init_audio()) {
		//printf("cant init_audio\n");
		no_audio = 1;
		game.sound_on = 0;
	}
	else no_audio = 0;
	if(!load_samples()) {
		printf("unable to load samples\n");
		finished = 1;
	}
	
	// clear the screens and place loading message
	SetAPen(&rp_menu, 0);
	BltPattern(&rp_menu, NULL,0, 0, 639, 199, 0);
	SetAPen(&rp_menu, 1);
	Move(&rp_menu, 240, 96);
	Text(&rp_menu, "Loading...", 10);
	
	// load the tiles
	if(!load_tile_bitmaps()) {
		load_tiles_fail = 1;
		finished = 1;
	}
	JoyTest(&jd);

	// load the highscore table
	load_highscores();

	//srand(get_tick_count());

	// main game loop 
	while(!finished) {
		if(game.state == IN_MAPMESSAGE) {
			spanel.update = 1;
			spanel.update_lives = 1;
			spanel.update_bonus = 1;
			spanel.update_room = 1;
			spanel.update_score = 1;
			spanel.update_labels = 1;
			spanel.update_background = 1;
			draw_statuspanel();
			if(map->hard_code) hard_code();
			draw_map_message();
			wait_for_key();
			// clean up the status panel
			spanel.update = 1;
			spanel.update_lives = 1;
			spanel.update_bonus = 1;
			spanel.update_room = 1;
			spanel.update_score = 1;
			spanel.update_labels = 1;
			spanel.update_background = 1;
			game.state = IN_PLAY;
			if(is_spiders) loop_sample(&sample[S_SPIDER1], 3);
		}
		if(game.state == IN_PLAY) {
			if(map->hard_code) hard_code();
			if(map->update) draw_map();
			if(spanel.update) draw_statuspanel();
			if(player.update) draw_player(); // must come after draw_map()
			if(check_spider_move_time()) move_spiders();
			move_traps();
			update_bonus();
			check_play_input();
			if(vbcounter > ambient_time + 150) {
				if(is_water) play_sample(&sample[S_WATER1], 2);
				ambient_time = vbcounter;
			}
		}
		if(game.state == IN_MENU) {
			if(m_screens[game.cur_menu].update_items || m_screens[game.cur_menu].update_selector || m_screens[game.cur_menu].update_background) draw_menu(game.cur_menu);
			check_menu_input();
		}
	}
	
	close_input();
	video_exit();
	exit_audio();
	free_samples();
	if(!load_tiles_fail) unload_tile_bitmaps();
	remove_vbinterrupt();
	FreeMem(map, sizeof(struct map_struct));

	return 0;
}

int check_player_move_time()
{
	if(vbcounter > pl_time + 12) return 1;
	else return 0;
}

void hard_code()
{
	static int x, y;

	// level 16 changes tiles around when a boulder is pushed to a certain square
	if(map->hard_code == 1) {
		switch(map->hce_state) {
		case HCE_START:
			map->hce_state = HCE_WAITING;
			break;
		case HCE_RETURNFROMMENU:
		case HCE_WAITING:
			if(map->t[1][4].type == ROCK) {
				map->t[2][4].type = NOTHING;
				map->t[2][4].update = 1;
				map->t[4][4].type = WALL;
				map->t[4][4].sub_type = BRICK2;
				map->t[4][4].bm = BM_BRICK2;
				map->t[4][4].update = 1;
				map->t[5][4].type = NOTHING;
				map->t[5][4].update = 1;
				map->t[7][4].type = WALL;
				map->t[7][4].sub_type = BRICK2;
				map->t[7][4].bm = BM_BRICK2;
				map->t[7][4].update = 1;
				map->t[8][4].type = NOTHING;
				map->t[8][4].update = 1;
				map->t[10][4].type = WALL;
				map->t[10][4].sub_type = BRICK2;
				map->t[10][4].bm = BM_BRICK2;
				map->t[10][4].update = 1;
				map->t[11][4].type = NOTHING;
				map->t[11][4].update = 1;
				map->t[13][4].type = WALL;
				map->t[13][4].sub_type = BRICK2;
				map->t[13][4].bm = BM_BRICK2;
				map->t[13][4].update = 1;
				map->t[14][4].type = NOTHING;
				map->t[14][4].update = 1;
				map->t[9][1].type = NOTHING;
				map->t[9][1].update = 1;
				map->hce_state = HCE_FINISH;
				map->update = 1;
			}
			break;
		case HCE_FINISH:
			map->hce_state = HCE_FINISH;
			map->hard_code = 0;
			break;
		}
	}
	// level 17 starts off dark until the player walks onto a certain tile
	if(map->hard_code == 2)
	{
		switch(map->hce_state)
		{
		case HCE_START:
			if(game.state == IN_MAPMESSAGE)
			{
				set_to_offscreen();
				for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);// blit_on_sync(&tile_bm[BM_BLANK], &sc_bitmap, 16, 16, x * TILE_W, y * TILE_H);
				draw_statuspanel();
				swap_buffers();
				WaitTOF();
				set_to_offscreen();
				for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);// blit_on_sync(&tile_bm[BM_BLANK], &sc_bitmap, 16, 16, x * TILE_W, y * TILE_H);
				draw_statuspanel();
				map->update = 0;
			}
			if(game.state == IN_PLAY)
			{
				set_to_offscreen();
				for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);// blit_on_sync(&tile_bm[BM_BLANK], &sc_bitmap, 16, 16, x * TILE_W, y * TILE_H);
				swap_buffers();
				WaitTOF();
				set_to_offscreen();
				for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);// blit_on_sync(&tile_bm[BM_BLANK], &sc_bitmap, 16, 16, x * TILE_W, y * TILE_H);
				map->hce_state = HCE_WAITING;
				map->update = 0;
			}
			break;
		case HCE_RETURNFROMMENU:
			set_to_offscreen();
			for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);//blit_on_sync(&tile_bm[BM_BLANK], &sc_bitmap, 16, 16, x * TILE_W, y * TILE_H);
			swap_buffers();
			WaitTOF();
			set_to_offscreen();
			for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);//blit_on_sync(&tile_bm[BM_BLANK], &sc_bitmap, 16, 16, x * TILE_W, y * TILE_H);
			map->hce_state = HCE_WAITING;
			map->update = 0;
			break;
		case HCE_WAITING:
			// when to player gets to (0, 10) we let in the light
			map->update = 0;
			if(plx == 0 && ply == 10) {
				set_to_onscreen();
				SetAPen(rp, 1);
				SetBPen(rp, 9);				
				Move(rp, 5, (0 * 8) + 10);
				Text(rp, "YOU KNOCK THE WALL DOWN AND", 27);
				Move(rp, 5, (1 * 8) + 10);
				Text(rp, "LIGHT SHINES IN            ", 27);
				SetAPen(rp, 0);
				SetBPen(rp, 0);
				for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) map->t[x][y].update = 1;
				map->hce_state = HCE_FINISH;
				map->update = 1;
				wait_for_key();
				spanel.update = 1;
				spanel.update_lives = 1;
				spanel.update_bonus = 1;
				spanel.update_room = 1;
				spanel.update_score = 1;
				spanel.update_labels = 1;
				spanel.update_background = 1;
			}
			break;
		case HCE_FINISH:
			map->hard_code = 0;
			break;
		}
	}
}

void game_won()
{
	int x = 180;
	char str[32];

	LoadView(&view_menu);
	SetAPen(&rp_menu, 0);
	BltPattern(&rp_menu, NULL,0, 0, 639, 199, 0);
	
	SetAPen(&rp_menu, 1);
	Move(&rp_menu, x, 90);
	Text(&rp_menu, "You have won the game!", 22);
	Move(&rp_menu, x, 106);
	sprintf(str, "Your score is %d", player.score);
	Text(&rp_menu, str, strlen(str));

	do_highscore();
	player.level = 1;
	game.state = IN_MENU;
	game.cur_menu = MS_MAIN;
	m_screens[MS_MAIN].update_items = 1;
	m_screens[MS_MAIN].update_selector = 1;
	m_screens[MS_MAIN].update_background = 1;
	m_screens[MS_MAIN].cur_element = 1; // move to start new game
	game.in_progress = 0;
	m_elements[ME_RETURNTOGAME].enabled = 0;
	m_elements[ME_SAVEGAME].enabled = 0;
}

void do_highscore()
{
	char str[32], str2[32], strtemp[32];
	int x = 180, i, spos, hs, hstemp;
	int done = 0;
	UWORD k;
	
	// see if player has made the high score table
	for(hs = hscores[0].points, i = 0; i < 10; i++) if(hscores[i].points < hs) hs = hscores[i].points; // find the lowest entry
	if(player.score > hs) {
		Move(&rp_menu, x, 126);
		Text(&rp_menu, "You have made the high score table", 34);
		Move(&rp_menu, x, 134);
		Text(&rp_menu, "Enter your name", 15);
		// get string from keyboard
		Move(&rp_menu, x, 150);
		for(i = 0; i < 32; i++) str[i] = '\0';
		spos = 0;
		k = ips.key;
		while(!done) {
			if(ips.key != k) {
				k = ips.key;
				// ignore up keys
				if(!(ips.key & 128)) {
					switch(k) {
					case 65:	// backspace
						spos--;
						if(spos < 0) spos = 0;
						str[spos] = ' ';
						for(i = spos+1; i < 32; i++) str[i] = '\0';
						Move(&rp_menu, x, 150);
						Text(&rp_menu, str, strlen(str));
						break;
					case 68:	// return
						while(ips.keys[68]); // wait for key to come up
						done = 1;
						break;
					default:
						if(keycodes[ips.key] != '*') {
							str[spos] = keycodes[ips.key];
							str[spos+1] = '\0';
							spos++;
							if(spos > 20) spos = 20;
							Move(&rp_menu, x, 150);
							Text(&rp_menu, str, strlen(str));
						}
					}
				}
			}
		}
		// add to the high score table
		done = 0;
		for(i = 0, hs = 0; i < 10; i++) {
			if(player.score >= hscores[i].points && done == 0) {
				hs = hscores[i].points;
				sprintf(str2, "%s", hscores[i].pname);
				hscores[i].points = player.score;
				sprintf(hscores[i].pname, "%s", str);
				done = 1;
			}
			if(hs >= hscores[i].points) {
				// move backed up one down
				hstemp = hscores[i].points;
				sprintf(strtemp, "%s", hscores[i].pname);
				hscores[i].points = hs;
				sprintf(hscores[i].pname, "%s", str2);
				hs = hstemp;
				sprintf(str2, "%s", strtemp);
			}
		}
		save_highscores();
	}
	else {
		Move(&rp_menu, x, 126);
		Text(&rp_menu, "You have not made the high score table", 38);
		wait_for_key();
	}
}

void game_over()
{
	int x = 180;
	char str[32];

	stop_loop(3);

	LoadView(&view_menu);
	SetAPen(&rp_menu, 0);
	BltPattern(&rp_menu, NULL,0, 0, 639, 199, 0);

	SetAPen(&rp_menu, 1);
	Move(&rp_menu, x, 90);
	Text(&rp_menu, "You have died your final death.", 31);
	Move(&rp_menu, x, 106);
	sprintf(str, "Your score is %d", player.score);
	Text(&rp_menu, str, strlen(str));

	do_highscore();
	player.level = 1;
	game.state = IN_MENU;
	game.cur_menu = MS_MAIN;
	m_screens[MS_MAIN].update_items = 1;
	m_screens[MS_MAIN].update_selector = 1;
	m_screens[MS_MAIN].update_background = 1;
	m_screens[MS_MAIN].cur_element = 1; // move to start new game
	game.in_progress = 0;
	m_elements[ME_RETURNTOGAME].enabled = 0;
	m_elements[ME_SAVEGAME].enabled = 0;
}

int move_rock(int x, int y, int direction)
{
	int destx = 0, desty = 0, return_value = 0;

	// find the tile we want to move the rock to
	switch(direction) {
	case NORTH:
		destx = x;
		desty = y - 1;
		break;
	case EAST:
		destx = x + 1;
		desty = y;
		break;
	case SOUTH:
		destx = x;
		desty = y + 1;
		break;
	case WEST:
		destx = x - 1;
		desty = y;
		break;
	}
	if(destx < 0 || destx > MAP_W-1 || desty < 0 || desty > MAP_H-1) return 0; // cant move it here!

	if(map->t[destx][desty].type == NOTHING) { // nothing here so move the rock
		map->t[destx][desty].type = ROCK;
		// rock and roll (or flip)
		if(direction == EAST) {
			map->t[destx][desty].bm = map->t[x][y].bm + 1;
			if(map->t[destx][desty].bm > BM_ROCK4) map->t[destx][desty].bm = BM_ROCK1;
		}
		if(direction == WEST) {
			map->t[destx][desty].bm = map->t[x][y].bm - 1;
			if(map->t[destx][desty].bm < BM_ROCK1) map->t[destx][desty].bm = BM_ROCK4;
		}
		if(direction == SOUTH) {
			map->t[destx][desty].bm = map->t[x][y].bm;
			if(map->t[destx][desty].bm == BM_ROCK1 || map->t[destx][desty].bm == BM_ROCK3) {
				if(map->t[destx][desty].bm == BM_ROCK1) map->t[destx][desty].bm = BM_ROCK3;
				else map->t[destx][desty].bm = BM_ROCK1;
			}
		}
		if(direction == NORTH) {
			map->t[destx][desty].bm = map->t[x][y].bm;
			if(map->t[destx][desty].bm == BM_ROCK1 || map->t[destx][desty].bm == BM_ROCK3) {
				if(map->t[destx][desty].bm == BM_ROCK1) map->t[destx][desty].bm = BM_ROCK3;
				else map->t[destx][desty].bm = BM_ROCK1;
			}
		}
		map->t[destx][desty].update = 1;
		map->t[x][y].type = NOTHING;
		map->t[x][y].bm = BM_BLANK;
		map->t[x][y].update = 1;
		map->update = 1;
		return_value = 1;
	}
	if(map->t[destx][desty].type == WATER) {
		// nothing here so lets move this boulder
		if(destx != 0 && desty != 0 && destx != MAP_W-1 && desty != MAP_H-1) map->t[destx][desty].type = NOTHING;
		map->t[destx][desty].update = 1;
		map->t[x][y].type = NOTHING;
		map->t[x][y].update = 1;
		map->update = 1;
		return_value = 1;
	}

	return return_value;
}

int check_move_rock(int x, int y, int direction)
{
	int destx = 0, desty = 0, return_value = 0;

	// find the tile we want to move the rock to
	switch(direction) {
	case NORTH:
		destx = x;
		desty = y - 1;
		break;
	case EAST:
		destx = x + 1;
		desty = y;
		break;
	case SOUTH:
		destx = x;
		desty = y + 1;
		break;
	case WEST:
		destx = x - 1;
		desty = y;
		break;
	}
	if(destx < 0 || destx > MAP_W-1 || desty < 0 || desty > MAP_H-1) return 0; // cant move it here!

	if(map->t[destx][desty].type == NOTHING) {
		return 1;
	}
	if(map->t[destx][desty].type == WATER) {
		// nothing here so lets move this boulder
		return 1;
	}

	return return_value;
}


void update_bonus()
{
	unsigned long t;

	if(player.bonus == 0) return;

	t = vbcounter;
	if(t > player.bonus_time + 50) {
		player.bonus--;
		if(player.bonus < 0) player.bonus = 0;
		player.bonus_time = t;
		spanel.update_bonus = 1;
		spanel.update = 1;
	}
}

// return 1 if death by snake, 0 otherwise
int check_snake_death()
{
	int i;
	int safe = 0;

	// check left to right
	for(i = plx + 1; i < MAP_W; i++) {
		if(map->t[i][ply].type != NOTHING) {
			if(map->t[i][ply].type == SNAKE) {
				if(map->t[i][ply].direction == WEST) map->t[i][ply].bm = BM_SNAKE4;
				if(map->t[i][ply].direction == EAST) map->t[i][ply].bm = BM_SNAKE3;
				map->t[i][ply].update = 1;
				map->update = 1;
				play_sample(&sample[S_SNAKE1], 2);
				return 1;
			}
			else safe = 1;
		}

		if(safe) break;
	}
	// check right to left
	safe = 0;
	for(i = plx - 1; i > 0; i--) {
		if(map->t[i][ply].type != NOTHING) {
			if(map->t[i][ply].type == SNAKE) {
				if(map->t[i][ply].direction == WEST) map->t[i][ply].sub_type = BM_SNAKE4;
				if(map->t[i][ply].direction == EAST) map->t[i][ply].sub_type = BM_SNAKE3;
				map->t[i][ply].update = 1;
				map->update = 1;
				play_sample(&sample[S_SNAKE1], 2);
				return 1;
			}
			else safe = 1;
		}

		if(safe) break;
	}

	return 0;
}

int player_dies()
{
	char level_name[48];

	player.lives--;
	play_sample(&sample[S_DEATH1], player.audio_channel);
	death_animation();
	if(player.lives == 0) {
		game_over();
		return 0;
	}
	sprintf(level_name, "data/map%d.txt", player.level);
	if(!load_map(level_name)) finished = 1;
	player.keys = 0;
	spanel.update = 1;
	spanel.update_lives = 1;
	map->update = 1;
	if(map->hard_code) hard_code();
	player.anim_flag = ANIM_NONE;
	player.update = 1;
	if(is_spiders) loop_sample(&sample[S_SPIDER1], 3);
	wait_for_key();
}

void teleport_player(int x, int y)
{
	int i, a = 0, b = 0;
	int px, py;
	int old_direction;
	ULONG anim_time;

	// find the teleport info
	for(i = 0; i < num_tports; i++) {
		if(tport[i].empty == 0) {
			if(tport[i].x1 == x && tport[i].y1 == y) a = 1;
			if(tport[i].x2 == x && tport[i].y2 == y) b = 1;

			if(a == 1 || b == 1) {
				// move the player
				play_sample(&sample[S_POOF1], player.audio_channel);
				px = plx;
				py = ply;
				map->t[plx][ply].type = NOTHING;
				map->t[plx][ply].update = 1;
				map->update = 1;
				draw_map();
				plx = x;
				ply = y;
				draw_player();
				anim_time = vbcounter;
				
				// do a little  animation (this should be in g_draw.c really)
				set_to_offscreen();
				BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, px * 16, py * 16, 16, 16, 0x0C0);
				set_to_onscreen();
				BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, px * 16, py * 16, 16, 16, 0x0C0);
				BltBitMapRastPort(&tile_bm[BM_POOF2], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
				while(vbcounter < anim_time + 4);
				anim_time = vbcounter;
				BltBitMapRastPort(&tile_bm[BM_POOF1], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
				while(vbcounter < anim_time + 4);
				anim_time = vbcounter;
				BltBitMapRastPort(&tile_bm[BM_POOF2], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
				while(vbcounter < anim_time + 4);
				anim_time = vbcounter;
				BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
				set_to_offscreen();
				BltBitMapRastPort(&tile_bm[BM_BLANK], 0, 0, rp, x * 16, y * 16, 16, 16, 0x0C0);
				while(vbcounter < anim_time + 4);
				anim_time = vbcounter;

				// move the player to new position
				map->t[plx][ply].type = NOTHING;
				map->t[plx][ply].update = 1;
				old_direction = map->t[plx][ply].direction;
				if(a) {
					plx = tport[i].x2;
					ply = tport[i].y2;
				}
				if(b) {
					plx = tport[i].x1;
					ply = tport[i].y1;
				}
				map->t[plx][ply].type = PLAYER;
				map->t[plx][ply].update = 1;
				map->t[plx][ply].direction = old_direction;
				player.anim_flag = ANIM_NONE;
				player.update = 1;
				if(check_snake_death() == 1) player_dies();
				map->update = 1;
				return;
			}
		}
	}
}

void add_points(int amount)
{
	static int reached_5000 = 0;

	player.score += amount;
	player.lives_score += amount;

	if(player.lives_score >= 5000 && reached_5000 == 0) {
		reached_5000 = 1;
		player.lives_score -= 5000;
		player.lives++;
	}
	if(player.lives_score >= 10000) {
		player.lives_score -= 10000;
		player.lives++;
	}

	spanel.update_score = 1;
	spanel.update = 1;
}

void move_player(UWORD direction)
{
	unsigned char old_direction;
	int destx = 0, desty = 0;
	int move_success = 0;
	static char level_name[48];
	int x, y;
	char str[24];

	// find the tile we want to move to
	switch(direction) {
	case NORTH:
		destx = plx;
		desty = ply - 1;
		break;
	case EAST:
		destx = plx + 1;
		desty = ply;
		break;
	case SOUTH:
		destx = plx;
		desty = ply + 1;
		break;
	case WEST:
		destx = plx - 1;
		desty = ply;
		break;
	}

	// make sure its a valid map tile
	if(destx < 0 || destx > MAP_W-1 || desty < 0 || desty > MAP_H-1) return;

	// call a routine appropriate for the tile we are moving to
	switch(map->t[destx][desty].type) {
	case NOTHING:
		move_success = 1;
		pl_time = vbcounter;
		break;
	case WALL:
		if(map->t[destx][desty].direction == COLLAPSETOGEM) {
			pl_time = vbcounter;
			anim_collapse(destx, desty);
			map->t[destx][desty].type = DIAMOND;
			map->t[destx][desty].bm = BM_DIAMOND;
			map->t[destx][desty].update = 1;
			map->update = 1;
		}
		if(map->t[destx][desty].direction == COLLAPSE) {
			pl_time = vbcounter;
			anim_collapse(destx, desty);
			map->t[destx][desty].type = NOTHING;
			map->t[destx][desty].bm = BM_BLANK;
			map->t[destx][desty].update = 1;
			map->update = 1;
		}
		move_success = 0;
		break;
	case PIPE:
		move_success = 0;
		break;
	case SPEARTRAP:
		move_success = 0;
		break;
	case WATER:
		move_success = 0;
		break;
	case DOOR:
		if(player.keys == map->num_keys) {
			pl_time = vbcounter;
			stop_loop(3);
			player.level++;
			if(player.level > NUM_MAPS)	{
				// the game has been won!!
				add_points(1000);
				game_won();
				return;
			}
			add_points(player.bonus);
			// display a transitional screen
			LoadView(&view_menu);
			SetAPen(&rp_menu, 0);
			BltPattern(&rp_menu, NULL, 0, 0, 639, 199, 0);
			SetAPen(&rp_menu, 1);
			Move(&rp_menu, 213, 50);
			sprintf(str, "Now entering room %d", player.level);
			Text(&rp_menu, str, strlen(str));
			Move(&rp_menu, 213, 80);
			sprintf(str, "Bonus: %d", player.bonus);
			Text(&rp_menu, str, strlen(str));
			Move(&rp_menu, 213, 90);
			sprintf(str, "Total score: %d", player.score);
			Text(&rp_menu, str, strlen(str));			
			sprintf(level_name, "data/map%d.txt", player.level);
			if(!load_map(level_name)) finished = 1;
			spanel.update = 1;
			spanel.update_lives = 1;
			spanel.update_labels = 1;
			spanel.update_bonus = 1;
			spanel.update_room = 1;
			spanel.update_score = 1;
			spanel.update_background = 1;
			map->update = 1;
			player.update = 1;
			player.anim_flag = ANIM_NONE;
			add_points(1000);
			Move(&rp_menu, 213, 180);
			Text(&rp_menu, "(click button)", 14);
			SetAPen(&rp_menu, 0);

			// clear play screen
			set_to_offscreen();
			BltPattern(rp, NULL, 0, 0, 319, 199, 0);
			set_to_onscreen();
			BltPattern(rp, NULL, 0, 0, 319, 199, 0);
			wait_for_key();
			
			if(map->num_lines) game.state = IN_MAPMESSAGE;
			else if(is_spiders) loop_sample(&sample[S_SPIDER1], 3);
			if(map->hard_code) hard_code();
		}
		else move_success = 0;
		break;
	case ROCK:
		move_success = check_move_rock(destx, desty, direction);
		if(move_success) {
			pl_time = vbcounter;
			move_rock(destx, desty, direction);
			play_sample(&sample[S_ROCK1], player.audio_channel);
			is_water = 0;
			for(y = 0; y < MAP_H; y++) for(x = 0; x < MAP_W; x++) if(map->t[x][y].type == WATER) is_water = 1;
		}
		break;
	case KEY:
		pl_time = vbcounter;
		map->t[destx][desty].type = NOTHING;
		map->t[destx][desty].bm = BM_BLANK;
		play_sample(&sample[S_KEY1], player.audio_channel);
		move_success = 1;
		player.keys++;
		add_points(10);
		break;
	case DIAMOND:
		pl_time = vbcounter;
		map->t[destx][desty].type = NOTHING;
		map->t[destx][desty].bm = BM_BLANK;
		play_sample(&sample[S_GEM1], player.audio_channel);
		move_success = 1;
		add_points(50);
		break;
	case DIRT:
		// clear the dirt
		pl_time = vbcounter;
		map->t[destx][desty].type = NOTHING;
		map->t[destx][desty].bm = BM_BLANK;
		play_sample(&sample[S_DIRT1], player.audio_channel);
		move_success = 1;
		break;
	}

	// return if not moving
	if(!move_success) return;
	
	player.prev_x = plx;
	player.prev_y = ply;
	player.update = 1;
	if(game.player_anim) player.anim_flag = ANIM_START;
	else player.anim_flag = ANIM_NONE;

	if(player.audio_channel == 0) player.audio_channel = 1;
	else player.audio_channel = 0;
	play_sample(&sample[S_STEP1], player.audio_channel);

	// check teleport
	if(map->t[destx][desty].sub_type == TELEPORT) {
		teleport_player(destx, desty);
		return;
	}

	map->t[plx][ply].type = NOTHING;
	map->t[plx][ply].update = 1;
	old_direction = map->t[plx][ply].direction;
	if(direction == NORTH) {
		ply--;
		if(ply < 0) ply = 0;
		map->t[plx][ply].type = PLAYER;
		map->t[plx][ply].direction = old_direction;
		if(check_snake_death() == 1) player_dies();
		check_traps();
		map->update = 1;
	}
	if(direction == SOUTH) {
		ply++;
		if(ply > MAP_H-1) ply = MAP_H-1;
		map->t[plx][ply].type = PLAYER;
		map->t[plx][ply].direction = old_direction;
		if(check_snake_death() == 1) player_dies();
		check_traps();
		map->update = 1;
	}
	if(direction == EAST) {
		plx++;
		if(plx > MAP_W-1) plx = MAP_W-1;
		map->t[plx][ply].type = PLAYER;
		map->t[plx][ply].direction = EAST;
		if(check_snake_death() == 1)  player_dies();
		check_traps();
		map->update = 1;
	}
	if(direction == WEST) {
		plx--;
		if(plx < 0) plx = 0;
		map->t[plx][ply].type = PLAYER;
		map->t[plx][ply].direction = WEST;
		if(check_snake_death() == 1)  player_dies();
		check_traps();
		map->update = 1;
	}

	// change directions of snakes if needed
	for(y = 0; y < MAP_H; y++) {
		for(x = 0; x < MAP_W; x++) {
			if(map->t[x][y].type == SNAKE) {
				if(plx > x) {
					map->t[x][y].direction = EAST;
					map->t[x][y].bm = BM_SNAKE1;
					map->t[x][y].update = 1;
				}
				if(plx < x) {
					map->t[x][y].direction = WEST;
					map->t[x][y].bm = BM_SNAKE2;
					map->t[x][y].update = 1;
				}
			}
		}
	}
}

void wait_for_key()
{
	UWORD blah;
	int clicked = 0;

	blah = ips.key;
	while(!clicked) {
		if(ips.key != blah) {
			// make sure this is a down key, not just a key coming up
			if(!(ips.key & 128)) {
				// wait for it to come back up
				blah = ips.key;
				while(ips.key == blah);
				clicked = 1;
			}
			else blah = ips.key;
		}
		JoyTest(&jd);
		if(jd.fire == 0) {
			while(jd.fire == 0) JoyTest(&jd);
			clicked = 1;
		}			
	}
}

void check_menu_input()
{
	static ULONG menu_move_time = 0;

	JoyTest(&jd);
	if((jd.up || jd.down) && vbcounter > menu_move_time + 10) {
		if(jd.up) menu_move_up(game.cur_menu);
		if(jd.down) menu_move_down(game.cur_menu);
		menu_move_time = vbcounter;
	}
	if(jd.fire == 0) {
		while(jd.fire == 0) JoyTest(&jd);
		menu_select(m_screens[game.cur_menu].elements[m_screens[game.cur_menu].cur_element]);
	}
	
	if(ips.keys[16]) {		// 'q'
		while(ips.keys[16]);
		finished = 1;
	}
	
	if(ips.keys[68]) {		// return
		while(ips.keys[68]);
		menu_select(m_screens[game.cur_menu].elements[m_screens[game.cur_menu].cur_element]);
	}

	if(ips.keys[77]) {		// down
		while(ips.keys[77]);
		menu_move_down(game.cur_menu);
		menu_move_time = vbcounter;
	}
	
	if(ips.keys[76]) {		// up
		while(ips.keys[76]);
		menu_move_up(game.cur_menu);
		menu_move_time = vbcounter;
	}
}

void check_play_input()
{
	static char level_name[48];

	if(ips.keys[16]) {			// 'q'
		while(ips.keys[16]);
		finished = 1;
		return;
	}
	if(ips.keys[69]) {			// esc
		while(ips.keys[69]);
		stop_loop(3);
		game.state = IN_MENU; // escpae
		game.cur_menu = MS_MAIN;
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		m_screens[MS_MAIN].cur_element = 7; // move to 'return to game'
		LoadView(&view_menu);
		return;
	}

	JoyTest(&jd);
	if(jd.fire == 0) {
		while(jd.fire == 0) JoyTest(&jd);
		stop_loop(3);
		game.state = IN_MENU; // escpae
		game.cur_menu = MS_MAIN;
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		m_screens[MS_MAIN].cur_element = 7; // move to 'return to game'
		LoadView(&view_menu);
		return;
	}

	//if(ips.keys[64]) map->update = 1; // space bar

	if(ips.keys[76]) if(check_player_move_time()) move_player(NORTH);
	if(ips.keys[77]) if(check_player_move_time()) move_player(SOUTH);
	if(ips.keys[78]) if(check_player_move_time()) move_player(EAST);
	if(ips.keys[79]) if(check_player_move_time()) move_player(WEST);

	JoyTest(&jd);
	if(jd.right) if(check_player_move_time()) move_player(EAST);
	if(jd.left) if(check_player_move_time()) move_player(WEST);
	if(jd.up) if(check_player_move_time()) move_player(NORTH);
	if(jd.down) if(check_player_move_time()) move_player(SOUTH);
	
	if(ips.keys[25]) {			// 'p' - pause
		while(ips.keys[25]);
		stop_loop(3);
		wait_for_key();
		if(is_spiders) loop_sample(&sample[S_SPIDER1], 3);
	}
	if(ips.keys[33]) {			// 's' - suicide
		while(ips.keys[33]);
		player_dies();
	}

	if(ips.keys[12]) {			// '+' - extra lives
		while(ips.keys[12]);
		player.lives+= 5;
		spanel.update_lives = 1;
		spanel.update = 1;
	}

	if(ips.keys[26]) {			// '[' - skip to previous level
		while(ips.keys[26]);
		stop_loop(3);
		player.level--;
		if(player.level < 1) player.level = NUM_MAPS;
		sprintf(level_name, "data/map%d.txt", player.level);
		if(!load_map(level_name)) finished = 1;
		player.keys = 0;
		spanel.update_room = 1;
		spanel.update_bonus = 1;
		spanel.update = 1;
		map->update = 1;
		player.prev_x = plx;
		player.prev_y = ply;
		player.update = 1;
		player.anim_flag = ANIM_NONE;
		if(map->num_lines) game.state = IN_MAPMESSAGE;
		if(map->hard_code) hard_code();
		if(is_spiders) loop_sample(&sample[S_SPIDER1], 3);
	}
	if(ips.keys[27]) {			// ']' - skip to next level
		while(ips.keys[27]);
		stop_loop(3);
		player.level++;
		if(player.level > NUM_MAPS) player.level = 1;
		sprintf(level_name, "data/map%d.txt", player.level);
		if(!load_map(level_name)) finished = 1;
		player.keys = 0;
		spanel.update_room = 1;
		spanel.update_bonus = 1;
		spanel.update = 1;
		map->update = 1;
		player.prev_x = plx;
		player.prev_y = ply;
		player.update = 1;
		player.anim_flag = ANIM_NONE;
		if(map->num_lines) game.state = IN_MAPMESSAGE;
		if(map->hard_code) hard_code();
		if(is_spiders) loop_sample(&sample[S_SPIDER1], 3);
	}	
}

void init_keycodes()
{
	int i;

	for(i = 0; i < 128; i++) keycodes[i] = '*';
	keycodes[16] = 'Q';
	keycodes[17] = 'W';
	keycodes[18] = 'E';
	keycodes[19] = 'R';
	keycodes[20] = 'T';
	keycodes[21] = 'Y';
	keycodes[22] = 'U';
	keycodes[23] = 'I';
	keycodes[24] = 'O';
	keycodes[25] = 'P';

	keycodes[32] = 'A';
	keycodes[33] = 'S';
	keycodes[34] = 'D';
	keycodes[35] = 'F';
	keycodes[36] = 'G';
	keycodes[37] = 'H';
	keycodes[38] = 'J';
	keycodes[39] = 'K';
	keycodes[40] = 'L';

	keycodes[49] = 'Z';
	keycodes[50] = 'X';
	keycodes[51] = 'C';
	keycodes[52] = 'V';
	keycodes[53] = 'B';
	keycodes[54] = 'N';
	keycodes[55] = 'M';
	
	keycodes[64] = ' ';
}

int install_vbinterrupt()
{
	if(vbint = AllocMem(sizeof(struct Interrupt), MEMF_PUBLIC|MEMF_CLEAR)) {
		vbint->is_Node.ln_Type = NT_INTERRUPT;
		vbint->is_Node.ln_Pri = -60;
		vbint->is_Node.ln_Name = "VertB-Example";
		vbint->is_Data = (APTR)&vbcounter;
		vbint->is_Code = VertBServer;
		AddIntServer(INTB_VERTB, vbint);
	}
	else {
		printf("can't allocate memory for interrupt node\n");
		return 0;
	}
	return 1;
}

void remove_vbinterrupt()
{
	RemIntServer(INTB_VERTB, vbint);
	FreeMem(vbint, sizeof(struct Interrupt));
}
