/* g_menus.c */
#include <stdio.h>
#include <graphics/gfx.h>
#include <clib/graphics_protos.h>
#include "g_ui.h"
#include "g_headers.h"
#include "g_audio.h"
#include "g_video.h"

struct menu_element_struct m_elements[30];
struct menu_screen_struct m_screens[6];
extern struct View view_menu;
extern struct RastPort *rp;
extern struct player_struct player;
extern struct game_struct game;
extern struct statuspanel_struct spanel;
extern struct map_struct *map;
extern int finished, plx, ply;
extern struct highscores_struct hscores[10];
extern struct UCopList *coplist_menu, *coplist_play;
extern int is_spiders, no_audio;
extern struct sample_struct sample[NUM_SAMPLES];

int save_highscores()
{
	FILE *file = NULL;
	int i;

	file = fopen("data/highscores", "wb");
	if(!file) return -1;

	for(i = 0; i < 10; i++) fwrite(&hscores[i], sizeof(struct highscores_struct), 1, file);

	fclose(file);

	return 1;
}

int load_highscores()
{
	FILE *file = NULL;
	int i;

	file = fopen("data/highscores", "rb");
	if(!file) {
		// does not exists, so make an empty one in memory
		for(i = 0; i < 10; i++) {
			hscores[i].points = 0;
			sprintf(hscores[i].pname, "----------------");
		}
		return -1;
	}

	for(i = 0; i < 10; i++) fread(&hscores[i], sizeof(struct highscores_struct), 1, file);

	fclose(file);

	return 1;
}

void init_menus()
{
	m_screens[MS_MAIN].update_items = 1;
	m_screens[MS_MAIN].update_selector = 1;
	m_screens[MS_MAIN].update_background = 1;
	m_screens[MS_MAIN].x = 213;
	m_screens[MS_MAIN].y = 96;
	m_screens[MS_MAIN].pixel_height = 10;
	m_screens[MS_MAIN].num_elements = 8;
	m_screens[MS_MAIN].cur_element = 0;
	m_screens[MS_MAIN].elements[0] = ME_STARTNEWGAME;
	m_screens[MS_MAIN].elements[1] = ME_OPTIONS;
	m_screens[MS_MAIN].elements[2] = ME_LOADGAME;
	m_screens[MS_MAIN].elements[3] = ME_SAVEGAME;
	m_screens[MS_MAIN].elements[4] = ME_HIGHSCORES;
	m_screens[MS_MAIN].elements[5] = ME_INSTRUCTIONS;
	m_screens[MS_MAIN].elements[6] = ME_EXIT;
	m_screens[MS_MAIN].elements[7] = ME_RETURNTOGAME;
	sprintf(m_screens[MS_MAIN].title, "Amiganitzu 1.5");
	
	m_screens[MS_OPTIONS].update_items = 1;
	m_screens[MS_OPTIONS].update_selector = 1;
	m_screens[MS_OPTIONS].update_background = 1;
	m_screens[MS_OPTIONS].x = 213;
	m_screens[MS_OPTIONS].y = 96;
	m_screens[MS_OPTIONS].pixel_height = 10;
	m_screens[MS_OPTIONS].num_elements = 5;
	m_screens[MS_OPTIONS].cur_element = 0;
	m_screens[MS_OPTIONS].elements[0] = ME_PLAYERANIM;
	m_screens[MS_OPTIONS].elements[1] = ME_SOUND;
	m_screens[MS_OPTIONS].elements[2] = ME_COPPERBARS;
	m_screens[MS_OPTIONS].elements[3] = ME_COPPERBARSPLAY;
	m_screens[MS_OPTIONS].elements[4] = ME_RETURNTOMAIN;
	sprintf(m_screens[MS_OPTIONS].title, "Options");

	m_screens[MS_SAVE].update_items = 1;
	m_screens[MS_SAVE].update_selector = 1;
	m_screens[MS_SAVE].update_background = 1;
	m_screens[MS_SAVE].x = 213;
	m_screens[MS_SAVE].y = 96;
	m_screens[MS_SAVE].pixel_height = 10;
	m_screens[MS_SAVE].num_elements = 6;
	m_screens[MS_SAVE].cur_element = 0;
	m_screens[MS_SAVE].elements[0] = ME_SAVE1;
	m_screens[MS_SAVE].elements[1] = ME_SAVE2;
	m_screens[MS_SAVE].elements[2] = ME_SAVE3;
	m_screens[MS_SAVE].elements[3] = ME_SAVE4;
	m_screens[MS_SAVE].elements[4] = ME_SAVE5;
	m_screens[MS_SAVE].elements[5] = ME_RETURNTOMAIN;
	sprintf(m_screens[MS_SAVE].title, "Save Game");

	m_screens[MS_LOAD].update_items = 1;
	m_screens[MS_LOAD].update_selector = 1;
	m_screens[MS_LOAD].update_background = 1;
	m_screens[MS_LOAD].x = 213;
	m_screens[MS_LOAD].y = 96;
	m_screens[MS_LOAD].pixel_height = 10;
	m_screens[MS_LOAD].num_elements = 6;
	m_screens[MS_LOAD].cur_element = 0;
	m_screens[MS_LOAD].elements[0] = ME_LOAD1;
	m_screens[MS_LOAD].elements[1] = ME_LOAD2;
	m_screens[MS_LOAD].elements[2] = ME_LOAD3;
	m_screens[MS_LOAD].elements[3] = ME_LOAD4;
	m_screens[MS_LOAD].elements[4] = ME_LOAD5;
	m_screens[MS_LOAD].elements[5] = ME_RETURNTOMAIN;
	sprintf(m_screens[MS_LOAD].title, "Load Game");

	sprintf(m_elements[ME_LOADGAME].str, "Load Game");
	m_elements[ME_LOADGAME].enabled = 1;
	sprintf(m_elements[ME_SAVEGAME].str, "Save Game");
	m_elements[ME_SAVEGAME].enabled = 0;
	sprintf(m_elements[ME_HIGHSCORES].str, "High Scores");
	m_elements[ME_HIGHSCORES].enabled = 1;

	sprintf(m_elements[ME_LOAD1].str, "---------");
	m_elements[ME_LOAD1].enabled = 1;
	sprintf(m_elements[ME_LOAD2].str, "---------");
	m_elements[ME_LOAD2].enabled = 1;
	sprintf(m_elements[ME_LOAD3].str, "---------");
	m_elements[ME_LOAD3].enabled = 1;
	sprintf(m_elements[ME_LOAD4].str, "---------");
	m_elements[ME_LOAD4].enabled = 1;
	sprintf(m_elements[ME_LOAD5].str, "---------");
	m_elements[ME_LOAD5].enabled = 1;

	sprintf(m_elements[ME_SAVE1].str, "---------");
	m_elements[ME_SAVE1].enabled = 1;
	sprintf(m_elements[ME_SAVE2].str, "---------");
	m_elements[ME_SAVE2].enabled = 1;
	sprintf(m_elements[ME_SAVE3].str, "---------");
	m_elements[ME_SAVE3].enabled = 1;
	sprintf(m_elements[ME_SAVE4].str, "---------");
	m_elements[ME_SAVE4].enabled = 1;
	sprintf(m_elements[ME_SAVE5].str, "---------");
	m_elements[ME_SAVE5].enabled = 1;


	sprintf(m_elements[ME_HIGHSCORES].str, "High Scores");
	m_elements[ME_HIGHSCORES].enabled = 1;
	sprintf(m_elements[ME_INSTRUCTIONS].str, "Instructions");
	m_elements[ME_INSTRUCTIONS].enabled = 1;

	switch(game.menu_copperbars) {
	case NOBARS:
		sprintf(m_elements[ME_COPPERBARS].str, "Menu copper bars are off");
		break;
	case REDBARS:
		sprintf(m_elements[ME_COPPERBARS].str, "Menu copper bars are red");
		break;
	case GREENBARS:
		sprintf(m_elements[ME_COPPERBARS].str, "Menu copper bars are green");
		break;
	case BLUEBARS:
		sprintf(m_elements[ME_COPPERBARS].str, "Menu copper bars are blue");
		break;
	}
	m_elements[ME_COPPERBARS].enabled = 1;
	switch(game.play_copperbars) {
	case NOBARS:
		sprintf(m_elements[ME_COPPERBARSPLAY].str, "Play copper bars are off");
		break;
	case REDBARS:
		sprintf(m_elements[ME_COPPERBARSPLAY].str, "Play copper bars are red");
		break;
	case GREENBARS:
		sprintf(m_elements[ME_COPPERBARSPLAY].str, "Play copper bars are green");
		break;
	case BLUEBARS:
		sprintf(m_elements[ME_COPPERBARSPLAY].str, "Play copper bars are blue");
		break;
	}
	m_elements[ME_COPPERBARSPLAY].enabled = 1;


	sprintf(m_elements[ME_EXIT].str, "Exit Game");
	m_elements[ME_EXIT].enabled = 1;

	sprintf(m_elements[ME_OPTIONS].str, "Options");
	m_elements[ME_OPTIONS].enabled = 1;

	if(game.sound_on) sprintf(m_elements[ME_SOUND].str, "Sound is on");
	else sprintf(m_elements[ME_SOUND].str, "Sound is off");
	if(no_audio) m_elements[ME_SOUND].enabled = 0;
	else m_elements[ME_SOUND].enabled = 1;

	sprintf(m_elements[ME_STARTNEWGAME].str, "Start New Game");
	m_elements[ME_STARTNEWGAME].enabled = 1;

	sprintf(m_elements[ME_RETURNTOGAME].str, "Return To Game");
	m_elements[ME_RETURNTOGAME].enabled = 0;

	sprintf(m_elements[ME_RETURNTOMAIN].str, "Return To Main Menu");
	m_elements[ME_RETURNTOMAIN].enabled = 1;

	if(game.player_anim) sprintf(m_elements[ME_PLAYERANIM].str, "Player animation is on");
	else sprintf(m_elements[ME_PLAYERANIM].str, "Player animation is off");
	m_elements[ME_PLAYERANIM].enabled = 1;
}

void menu_move_down(int ms)
{
	int i, success = 0;

	i = m_screens[ms].cur_element;
	while(!success) {
		i++;
		if(i >= m_screens[ms].num_elements) i = 0;

		if(m_elements[m_screens[ms].elements[i]].enabled) {
			m_screens[ms].cur_element = i;
			m_screens[ms].update_selector = 1;
			success = 1;
		}
	}
}

void menu_move_up(int ms)
{
	int i, success = 0;

	i = m_screens[ms].cur_element;
	while(!success) {
		i--;
		if(i < 0 ) i = m_screens[ms].num_elements - 1;

		if(m_elements[m_screens[ms].elements[i]].enabled) {
			m_screens[ms].cur_element = i;
			m_screens[ms].update_selector = 1;
			success = 1;
		}
	}
}

void sense_saved_games()
{
	int i;
	FILE *file;
	char fname[24];

	for(i = 1; i < 6; i++) {
		sprintf(fname, "data/save%i", i);
		file = NULL;
		file = fopen(fname, "rb");
		if(!file) {
			switch(i) {
			case 1:
				sprintf(m_elements[ME_LOAD1].str, "------");
				sprintf(m_elements[ME_SAVE1].str, "------");
				break;
			case 2:
				sprintf(m_elements[ME_LOAD2].str, "------");
				sprintf(m_elements[ME_SAVE2].str, "------");
				break;
			case 3:
				sprintf(m_elements[ME_LOAD3].str, "------");
				sprintf(m_elements[ME_SAVE3].str, "------");
				break;
			case 4:
				sprintf(m_elements[ME_LOAD4].str, "------");
				sprintf(m_elements[ME_SAVE4].str, "------");
				break;
			case 5:
				sprintf(m_elements[ME_LOAD5].str, "------");
				sprintf(m_elements[ME_SAVE5].str, "------");
				break;
			}
		}
		else {
			switch(i) {
			case 1:
				sprintf(m_elements[ME_LOAD1].str, "Game 1");
				sprintf(m_elements[ME_SAVE1].str, "Game 1");
				break;
			case 2:
				sprintf(m_elements[ME_LOAD2].str, "Game 2");
				sprintf(m_elements[ME_SAVE2].str, "Game 2");
				break;
			case 3:
				sprintf(m_elements[ME_LOAD3].str, "Game 3");
				sprintf(m_elements[ME_SAVE3].str, "Game 3");
				break;
			case 4:
				sprintf(m_elements[ME_LOAD4].str, "Game 4");
				sprintf(m_elements[ME_SAVE4].str, "Game 4");
				break;
			case 5:
				sprintf(m_elements[ME_LOAD5].str, "Game 5");
				sprintf(m_elements[ME_SAVE5].str, "Game 5");
				break;
			}
			fclose(file);
		}
	}
}


void menu_select(int m)
{
	char level_name[48];
	int x, y;
	
	switch(m) {
	case ME_PLAYERANIM:
		if(game.player_anim) {
			game.player_anim = 0;
			sprintf(m_elements[ME_PLAYERANIM].str, "Player animation is off");
		}
		else {
			game.player_anim = 1;
			sprintf(m_elements[ME_PLAYERANIM].str, "Player animation is on");
		}
		m_screens[MS_OPTIONS].update_background = 1;
		m_screens[MS_OPTIONS].update_items = 1;
		m_screens[MS_OPTIONS].update_selector = 1;
		break;
	case ME_RETURNTOGAME:
		game.state = IN_PLAY;
		for(y = 0; y < 12; y++) for(x = 0; x < 16; x++) map->t[x][y].update = 1;
		player.update = 1;
		map->update = 1;
		if(map->hard_code) map->hce_state = HCE_RETURNFROMMENU;
		spanel.update = 1;
		spanel.update_labels = 1;
		spanel.update_room = 1;
		spanel.update_score = 1;
		spanel.update_lives = 1;
		spanel.update_bonus = 1;
		spanel.update_background = 1;

		// clear play screen
		set_to_offscreen();
		SetAPen(rp, 0);
		BltPattern(rp, NULL, 0, 0, 319, 199, 0);
		set_to_onscreen();
		SetAPen(rp, 0);
		BltPattern(rp, NULL, 0, 0, 319, 199, 0);
		set_to_playscreen();
	
		if(is_spiders) loop_sample(&sample[S_SPIDER1], 3);
		break;
	case ME_STARTNEWGAME:
		player.score = 0;
		player.level = 1;
		player.lives = 4;
		player.lives_score = 0;
		player.anim_time = 0;
		player.update = 1;
		sprintf(level_name, "data/map%d.txt", player.level);
		if(!load_map(level_name)) {
			printf("cant load map->\n");
			finished = 1;
		}
		game.state = IN_PLAY;
		game.in_progress = 1;
		map->update = 1;
		spanel.update = 1;
		spanel.update_labels = 1;
		spanel.update_room = 1;
		spanel.update_score = 1;
		spanel.update_lives = 1;
		spanel.update_bonus = 1;
		spanel.update_background = 1;
		m_elements[ME_RETURNTOGAME].enabled = 1;
		m_elements[ME_SAVEGAME].enabled = 1;
		if(map->num_lines) game.state = IN_MAPMESSAGE;
		
		// clear play screen
		set_to_offscreen();
		SetAPen(rp, 0);
		BltPattern(rp, NULL, 0, 0, 319, 199, 0);
		set_to_onscreen();
		SetAPen(rp, 0);
		BltPattern(rp, NULL, 0, 0, 319, 199, 0);
		set_to_playscreen();
		
		break;
	case ME_EXIT:
		finished = 1;
		break;
	case ME_INSTRUCTIONS:
		draw_instructions();
		wait_for_key();
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		break;
	case ME_HIGHSCORES:
		draw_highscores();
		wait_for_key();
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		break;
	case ME_RETURNTOMAIN:
		game.state = IN_MENU;
		game.cur_menu = MS_MAIN;
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		break;
	case ME_SAVE1:
		save_game(1);
		game.state = IN_MENU;
		game.cur_menu = MS_MAIN;
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		m_screens[MS_MAIN].cur_element = 7;
		break;
	case ME_SAVE2:
		save_game(2);
		game.state = IN_MENU;
		game.cur_menu = MS_MAIN;
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		m_screens[MS_MAIN].cur_element = 7;
		break;
	case ME_SAVE3:
		save_game(3);
		game.state = IN_MENU;
		game.cur_menu = MS_MAIN;
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		m_screens[MS_MAIN].cur_element = 7;
		break;
	case ME_SAVE4:
		save_game(4);
		game.state = IN_MENU;
		game.cur_menu = MS_MAIN;
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		m_screens[MS_MAIN].cur_element = 7;
		break;
	case ME_SAVE5:
		save_game(5);
		game.state = IN_MENU;
		game.cur_menu = MS_MAIN;
		m_screens[MS_MAIN].update_items = 1;
		m_screens[MS_MAIN].update_selector = 1;
		m_screens[MS_MAIN].update_background = 1;
		m_screens[MS_MAIN].cur_element = 7;
		break;
	case ME_LOAD1:
		if(load_game(1)) {
			m_elements[ME_RETURNTOGAME].enabled = 1;
			m_elements[ME_SAVEGAME].enabled = 1;
			game.state = IN_MENU;
			game.cur_menu = MS_MAIN;
			m_screens[MS_MAIN].update_items = 1;
			m_screens[MS_MAIN].update_selector = 1;
			m_screens[MS_MAIN].update_background = 1;
			m_screens[MS_MAIN].cur_element = 7;
		}
		break;
	case ME_LOAD2:
		if(load_game(2)) {
			m_elements[ME_RETURNTOGAME].enabled = 1;
			m_elements[ME_SAVEGAME].enabled = 1;
			game.state = IN_MENU;
			game.cur_menu = MS_MAIN;
			m_screens[MS_MAIN].update_items = 1;
			m_screens[MS_MAIN].update_selector = 1;
			m_screens[MS_MAIN].update_background = 1;
			m_screens[MS_MAIN].cur_element = 7;
		}
		break;
	case ME_LOAD3:
		if(load_game(3)) {
			m_elements[ME_RETURNTOGAME].enabled = 1;
			m_elements[ME_SAVEGAME].enabled = 1;
			game.state = IN_MENU;
			game.cur_menu = MS_MAIN;
			m_screens[MS_MAIN].update_items = 1;
			m_screens[MS_MAIN].update_selector = 1;
			m_screens[MS_MAIN].update_background = 1;
			m_screens[MS_MAIN].cur_element = 7;
		}
		break;
	case ME_LOAD4:
		if(load_game(4)) {
			m_elements[ME_RETURNTOGAME].enabled = 1;
			m_elements[ME_SAVEGAME].enabled = 1;
			game.state = IN_MENU;
			game.cur_menu = MS_MAIN;
			m_screens[MS_MAIN].update_items = 1;
			m_screens[MS_MAIN].update_selector = 1;
			m_screens[MS_MAIN].update_background = 1;
			m_screens[MS_MAIN].cur_element = 7;
		}
		break;
	case ME_LOAD5:
		if(load_game(5)) {
			m_elements[ME_RETURNTOGAME].enabled = 1;
			m_elements[ME_SAVEGAME].enabled = 1;
			game.state = IN_MENU;
			game.cur_menu = MS_MAIN;
			m_screens[MS_MAIN].update_items = 1;
			m_screens[MS_MAIN].update_selector = 1;
			m_screens[MS_MAIN].update_background = 1;
			m_screens[MS_MAIN].cur_element = 7;
		}
		break;
	case ME_LOADGAME:
		game.cur_menu = MS_LOAD;
		m_screens[MS_LOAD].update_items = 1;
		m_screens[MS_LOAD].update_selector = 1;
		m_screens[MS_LOAD].update_background = 1;
		sense_saved_games();
		break;
	case ME_SAVEGAME:
		game.cur_menu = MS_SAVE;
		m_screens[MS_SAVE].update_items = 1;
		m_screens[MS_SAVE].update_selector = 1;
		m_screens[MS_SAVE].update_background = 1;
		sense_saved_games();
		break;
	case ME_COPPERBARSPLAY:
		game.play_copperbars++;
		if(game.play_copperbars == 4) game.play_copperbars = 0;
		switch(game.play_copperbars) {
		case NOBARS:
			sprintf(m_elements[ME_COPPERBARSPLAY].str, "Play copper bars are off");
			break;
		case REDBARS:
			sprintf(m_elements[ME_COPPERBARSPLAY].str, "Play copper bars are red");
			break;
		case GREENBARS:
			sprintf(m_elements[ME_COPPERBARSPLAY].str, "Play copper bars are green");
			break;
		case BLUEBARS:
			sprintf(m_elements[ME_COPPERBARSPLAY].str, "Play copper bars are blue");
			break;
		}
		m_screens[MS_OPTIONS].update_background = 1;
		m_screens[MS_OPTIONS].update_items = 1;
		m_screens[MS_OPTIONS].update_selector = 1;
		make_copperlist(coplist_play, game.play_copperbars, 0);
		break;
	case ME_COPPERBARS:
		game.menu_copperbars++;
		if(game.menu_copperbars == 4) game.menu_copperbars = 0;
		switch(game.menu_copperbars) {
		case NOBARS:
			sprintf(m_elements[ME_COPPERBARS].str, "Menu copper bars are off");
			break;
		case REDBARS:
			sprintf(m_elements[ME_COPPERBARS].str, "Menu copper bars are red");
			break;
		case GREENBARS:
			sprintf(m_elements[ME_COPPERBARS].str, "Menu copper bars are green");
			break;
		case BLUEBARS:
			sprintf(m_elements[ME_COPPERBARS].str, "Menu copper bars are blue");
			break;
		}
		m_screens[MS_OPTIONS].update_background = 1;
		m_screens[MS_OPTIONS].update_items = 1;
		m_screens[MS_OPTIONS].update_selector = 1;
		make_copperlist(coplist_menu, game.menu_copperbars, 1);
		LoadView(&view_menu);
		break;
	case ME_OPTIONS:
		game.cur_menu = MS_OPTIONS;
		m_screens[MS_OPTIONS].update_items = 1;
		m_screens[MS_OPTIONS].update_selector = 1;
		m_screens[MS_OPTIONS].update_background = 1;
		sense_saved_games();
		break;
	case ME_SOUND:
		if(game.sound_on == 0) {
			sprintf(m_elements[ME_SOUND].str, "Sound is on");
			game.sound_on = 1;
			m_screens[MS_OPTIONS].update_items = 1;
			m_screens[MS_OPTIONS].update_selector = 1;
			m_screens[MS_OPTIONS].update_background = 1;
		}
		else {
			sprintf(m_elements[ME_SOUND].str, "Sound is off");
			game.sound_on = 0;
			m_screens[MS_OPTIONS].update_items = 1;
			m_screens[MS_OPTIONS].update_selector = 1;
			m_screens[MS_OPTIONS].update_background = 1;
		}
		break;
	default:
		break;
	}
}
