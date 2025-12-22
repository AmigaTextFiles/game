/* g_input.h */

#ifndef _G_MAIN_H
#define _G_MAIN_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <exec/types.h>
#include <graphics/gfx.h>

#define MAP_W	16
#define MAP_H	12
#define TILE_W	16
#define TILE_H	16
// fire will be zero when pressed, non zero when up
// the rest will be 0 when not presses, non zero when pressed
struct joy_data
{
	UWORD	fire;
	UWORD	up;
	UWORD	down;
	UWORD	left;
	UWORD	right;
};
extern void __asm JoyTest(register __a0 struct joy_data*);

// for player, spider, snake, etc directions
#define NONE	0
#define NORTH	1
#define EAST	2
#define SOUTH	3
#define WEST	4

// defines for game.state
#define IN_PLAY			1
#define IN_MENU			2
#define IN_PAUSE		3
#define IN_MAPMESSAGE	4

struct game_struct
{
	unsigned char	state;
	unsigned char	cur_menu;
	unsigned char	player_anim;
	unsigned char	in_progress;
	unsigned char	sound_on;
	unsigned char	volume;
	unsigned char	menu_copperbars;
	unsigned char	play_copperbars;
};
// status panel
struct statuspanel_struct
{
	unsigned char update;
	unsigned char update_labels;
	unsigned char update_room;
	unsigned char update_score;
	unsigned char update_lives;
	unsigned char update_bonus;
	unsigned char update_background;
};
// defines for player animation
#define ANIM_WAIT	0
#define ANIM_NONE	1
#define ANIM_START	2
// for copper bar effects
#define NOBARS		0
#define REDBARS		1
#define GREENBARS	2
#define BLUEBARS	3
#define XMASBARS	4

struct player_struct
{
	int x, y;
	int prev_x, prev_y;
	int anim_flag;
	unsigned long anim_time;
	int score;
	int keys;
	int level;
	int lives;
	int lives_score;
	int update;
	int bonus;
	unsigned long bonus_time;
	unsigned char audio_channel;
	unsigned char audio_channelB;
};


#define NUM_MAPS 30

struct tile_struct
{
	unsigned char	type;
	unsigned char	sub_type;
	unsigned char	direction;
	unsigned char	bm;
	unsigned char	update;
};

// hard coded event flags
#define HCE_START			1
#define HCE_WAITING			2
#define HCE_FINISH			3
#define HCE_RETURNFROMMENU	4

struct map_struct
{
	struct tile_struct	t[MAP_W][MAP_H];
	int					num_keys;
	int					update;
	char				line[4][42];
	int					num_lines;
	int					hard_code;	// hard code event id, 0 for none
	int					hce_state;	// state of the hard code event
};

// high scores struct
struct highscores_struct
{
	int	points;
	char pname[24];
};

struct tport_struct
{
	int				x1, y1;
	int				x2, y2;
	unsigned char	empty;
};


// tile types
#define NOTHING		0
#define PLAYER		1
#define	ROCK		2
#define DIRT		3
#define WALL		4
#define	KEY			5
#define DIAMOND		6
#define DOOR		7
#define SNAKE		8
#define WATER		9
#define SPIDER		10
#define PIPE		11
#define SPEARTRAP	12
// sub types
#define STONE1		1
#define STONE2		2
#define BRICK1		3
#define BRICK2		4
#define PIPE1		5
#define PIPE2		6
#define PIPE3		7
#define PIPE4		8
#define PIPE5		9
#define PIPE6		10
#define PIPE7		11
#define PIPE8		12
#define PIPE9		13
#define PIPE10		14
#define PIPE11		15
#define PIPE12		16
#define TELEPORT	17
#define SPEAR1		18
#define SPEAR2		19
// these types are used in the direction field
#define NORMAL			0
#define COLLAPSE		1
#define COLLAPSETOGEM	2
// definitions for the various bitmaps used in the games
#define BM_PLAYEAST			0
#define BM_PLAYWEST			1
#define BM_PLAYEAST2		2
#define BM_PLAYWEST2		3
//#define BM_ROCK				4
#define BM_DIRT				5
#define BM_STONE1			6
#define BM_DIAMOND			7
#define BM_BRICK1			8
#define BM_BRICK2			9
#define BM_STONE2			10
#define BM_KEY				11
#define BM_PIPE1			12
#define BM_PIPE2			13
#define BM_PIPE3			14
#define BM_PIPE4			15
#define BM_PIPE5			16
#define BM_PIPE6			17
#define BM_DOOR				18
#define BM_SNAKE1			19
#define BM_SNAKE2			20
#define BM_WATER1			21
#define BM_SPIDER1			22
#define BM_DEATH1			23
#define BM_DEATH2			24
#define BM_DEATH3			25
#define BM_DEATH4			26
#define BM_DEATH5			27
#define BM_DEATH6			28
#define BM_DEATH7			29
#define BM_PIPE7			30
#define BM_PIPE8			31
#define BM_PIPE9			32
#define BM_PIPE10			33
#define BM_PIPE11			34
#define BM_PIPE12			35
#define BM_POOF1			36
#define BM_SPEAR1			37
#define BM_SPEAR2			38
#define BM_BLANK			39
#define BM_POOF2			40
#define BM_COLLAPSE1		41
#define BM_COLLAPSE2		42
#define BM_COLLAPSE3		43
#define BM_SPLODE1			44
#define BM_SPLODE2			45
#define BM_SPIDER2			46
#define BM_SNAKE3			47
#define BM_SNAKE4			48
#define BM_ROCK1			49
#define BM_ROCK2			50
#define BM_ROCK3			51
#define BM_ROCK4			52
#define NUMBER_OF_TILE_BITMAPS	53
// sound samples
#define S_STEP1		0
#define S_DIRT1		1
#define S_GEM1		2
#define S_ROCK1		3
#define S_KEY1		4
#define S_TRAP1		5
#define S_DEATH1	6
#define S_POOF1		7
#define S_WATER1	8
#define S_SPIDER1	9
#define S_EXPLODE1	10
#define S_SNAKE1	11
#define NUM_SAMPLES 12

// menu screens
#define MS_MAIN			1
#define MS_OPTIONS		2
#define MS_LOAD			3
#define MS_SAVE			4
#define MS_HIGHSCORES	5
#define MS_INSTRUCTIONS	6
// menu elements
#define ME_EXIT				1
#define ME_OPTIONS			2
#define ME_PLAYERANIM		3
#define ME_RETURNTOGAME		4
#define ME_RETURNTOMAIN		5
#define ME_STARTNEWGAME		6
#define ME_SOUND			7
#define ME_LOAD1			8
#define ME_LOAD2			9
#define ME_LOAD3			10
#define ME_LOAD4			11
#define ME_LOAD5			12
#define ME_SAVE1			13
#define ME_SAVE2			14
#define ME_SAVE3			15
#define ME_SAVE4			16
#define ME_SAVE5			17
#define ME_LOADGAME			18
#define ME_SAVEGAME			19
#define ME_HIGHSCORES		20
#define ME_COPPERBARS		21
#define ME_COPPERBARSPLAY	22
#define ME_INSTRUCTIONS		23

// for the spider move logic
#define NW		0
#define WST		1
#define SW		2
#define STH		3
#define SE		4
#define EST		5
#define NE		6
#define NTH		7
// clockwise and counter clockwise
#define CW		0
#define CCW		1

struct spiders_struct
{
	int x, y;
	int empty;
	int lx, ly;
	unsigned char latched_edge;
	unsigned char direction;
	unsigned char orientation;
};
// spider check struct
struct check_struct
{
	int lx, ly;
	int dx, dy;
	int place;
};

#define TRAP_SET		1
#define TRAP_SPRUNG		2
#define TRAP_DISABLED	3
struct traps_struct
{
	int				orig_x, orig_y;
	int				x, y;
	int				flag;
	unsigned long	time_stamp;
	int				empty;
};

// from g_traps.c
void check_traps(void);
void move_traps(void);

// from g_spiders.c
void move_spiders(void);
int check_spider_move_time(void);

// from g_sounds.c
void free_samples(void);
int load_samples(void);

// from g_menus.c
void menu_move_down(int);
void menu_move_up(int);
void init_menus(void);
void menu_select(int);
void sense_saved_games(void);
int load_highscores(void);
int save_highscores(void);

// from g_map.c
int load_map(char*);
void init_map(void);
void unload_tile_bitmaps(void);
int load_tile_bitmaps(void);
int save_game(int);
int load_game(int);

// from g_draw.c
void draw_map_message(void);
void draw_player(void);
void draw_statuspanel(void);
void update_statuspanel(void);
void draw_map_updates(void);
void draw_map(void);
void death_animation(void);
void set_topaz8_font(void);
void draw_highscores(void);
void draw_instructions(void);
void anim_collapse(int, int);

// from g_main.c
void game_over(void);
void do_highscore(void);
int check_player_move_time(void);
int install_vbinterrupt(void);
void remove_vbinterrupt(void);
void game_won(void);
void move_player(UWORD);
void hard_code(void);
void update_bonus(void);
void wait_for_key(void);
void add_points(int);
int player_dies(void);
int check_snake_death(void);
void set_player_move_time(void);
void set_tile(int, int, int);
void set_sobj(int, int, int);
void check_play_input(void);
void check_menu_input(void);
void init_keycodes(void);
int check_move_rock(int, int, int);

#endif
