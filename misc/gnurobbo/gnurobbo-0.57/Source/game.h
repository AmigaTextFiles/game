#include "config.h"

#include <SDL/SDL.h>
#include <SDL/SDL_endian.h>
#include <stdio.h> 
#include <SDL/SDL_ttf.h>

#define SPEED 4				// the less the fast...
#define FIELD_SIZE 32			// size of one field
#define ROBBO_LIVES_START 5		// how many lifes Robbo should have at start
#define ROBBO_LEVEL_START 1		// begining level for Robbo
#define TICK_INTERVAL 10			// Delay for SDL library
#define DELAY_BIRD 4 * SPEED		// Delays for objects
#define DELAY_BOOM 1 * SPEED
#define DELAY_BEAR 4 * SPEED
#define DELAY_BUTTERFLY 4 * SPEED
#define DELAY_BIGBOOM 3 * SPEED
#define DELAY_ROBBO  4 * SPEED
#define DELAY_TELEPORT 15 * SPEED
#define DELAY_LASER 4 * SPEED
#define DELAY_CAPSULE 10 * SPEED
#define DELAY_GUN 8 * SPEED
#define DELAY_ROTATION 20 * SPEED
#define DELAY_BLASTER 4 * SPEED
#define DELAY_PUSHBOX 4 * SPEED
#define DELAY_BARRIER 4 * SPEED
#define SCROLL_RATE 32			// Scrolling rate

#define LAST_LEVEL 52

/* object ids */
#define EMPTY_FIELD 0
#define ROBBO 1
#define WALL 2
#define WALL_RED 3
#define SCREW 4
#define BULLET 5
#define BOX 6
#define KEY 7
#define BOMB 8
#define DOOR 9
#define QUESTIONMARK 10
#define BEAR 11
#define BIRD 13
#define CAPSULE 15
#define LIVE 20
#define LITTLE_BOOM 21
#define GROUND 24
#define WALL_GREEN 25
#define BEAR_B 26
#define BUTTERFLY 28
#define LASER_L 30
#define LASER_D 32
#define TELEPORT 40
#define BIG_BOOM 42
#define GUN 50
#define MAGNET 54
#define BLASTER 58
#define BLACK_WALL 59
#define PUSH_BOX 60
#define BARRIER 61

/* game limitations */
#define MAX_X 200		// max x size of the board
#define MAX_Y 200		// max y size of the board
#define MAX_TELEPORT_IDS 10	// max number of teleports of one kind at level
#define DELAY_BLINKSCREEN 2	// how long screen should blink after exit opening
#define CODE_LENGTH 5

/* paths to additional files */
#ifdef PACKAGE_DATA_DIR
#define BMP_ICONS (PACKAGE_DATA_DIR "pixmaps/icons.bmp")
#define BMP_CIPHERS (PACKAGE_DATA_DIR "pixmaps/ciphers.bmp")
#define BMP_BACKGROUND (PACKAGE_DATA_DIR "pixmaps/background.bmp")
#define ROBBO_FONT (PACKAGE_DATA_DIR "robbo.ttf")
#define ROBBO_LEVELS (PACKAGE_DATA_DIR "levels.dat")
#else
#define BMP_ICONS "pixmaps/icons.bmp"
#define BMP_CIPHERS "pixmaps/ciphers.bmp"
#define ROBBO_FONT "robbo.ttf"
#define ROBBO_LEVELS "levels.dat"
#endif

#define FONTSIZE 15
#ifdef __AMIGA__
#define RESOURCE_FILE "gnurobborc"
#else
#define RESOURCE_FILE "/.gnurobborc"
#endif

char *user_home_dir;
char path_resource_file[100];

static Uint32 next_time;
Uint32 rmask, gmask, bmask,amask;  /* variables for creating surfaces */
int KeyPressed;			   /* Structure with information about pressed keys */
				   /* Bits:  RDLUS	R - rigth ... etc... S - shift */
int KeyLastPressed;

TTF_Font* font;

SDL_Surface* screen;
SDL_Surface* robbo_img[8];
SDL_Surface* score_img[10];
SDL_Surface* score_screw;
SDL_Surface* score_key;
SDL_Surface* score_bullet;
SDL_Surface* score_level;
SDL_Surface* score_robbo;
SDL_Surface* icons;
SDL_Surface* ciphers;
SDL_Surface* image;
SDL_Surface* image_startscreen;
SDL_Surface* icon;


static char* Text[] = {"Robbo has been lost on unfriendly planet. Help him to get out ",
			"of there, but remember, you have only limited number of lives...",
			"This job is not so easy, there're many levels, killing animals, ",
			"shooting guns and other kind things...",
			"          Game page: http://gnurobbo.sourceforge.net",
			" ",
			" ",
			" ",
			"              Keys:",
			"        ARROWS                 Moving",
			"        SHIFT+ARROW   Shooting",
			"        ESC                          Suicide",
			"        F9                        End game",
			" ",
			" ",
			" ",
			" ",
			" " };
static char* MenuText[] = {	"Start game",
				"Change level",
				"Quit game"};


static char* EndScreen[] = {"Congtatulations you have completed all levels.",
			  "Robbo can safely go home now....",
			  " ",
			  "Press RETURN to start from the begining."};
int MenuPosition;
SDL_Color bgcolor;
SDL_Color fgcolor;

struct Coords{
  int x;
  int y;
};

int game_is_started;
int offset_description;

struct object{
  int type;
  int state;
  int direction;     /* 0r 1d 2l 3u */
  int destroyable;   /* can be destroyed */
  int blowable;      /* can be blowed up */
  int killing;       /* is object dangerous for robbo */
  int moved;         /* When last object was moved (all movable) */
  int blowed;        /* Should object be blowed up? */
  int shooted;	     /* When lately object shooted (guns) */
  int rotated;       /* When object lately was rotated (guns) */
  int solidlaser;    /* Does gun shoots solid or normal laser */
  int rotable;	     /* If object can be rotated ? (guns) */
  int randomrotated; /* When object has undetermining rotation */
  int teleportnumber; /* Number of teleport (kind of theleport) */
  int teleportnumber2; /* ID of teleport (for teleports with the same number */
  int id_questionmark; /* What object is covered under questionmark */
  int direction2;      /* direction of moveing (for guns) (if direction2 for birds != (direction+-1) bird shoots */
  int movable;	       /* Is object moving (only for guns all animals do) */
  int returnlaser;	/* only for solid lasers... */
  int shooting;		/* if birds can shoot */
  struct Coords icon[5];   /* Coords of left-up point of icons drawed on bitmap */
};

  SDL_Event event;
  struct object board[MAX_X][MAX_Y];
  struct object board_copy[MAX_X][MAX_Y];	// the copy of board - it protects from reading
  int board_changed[MAX_X][MAX_Y];		// 1 if board needs update, 0 another case 
  						// data each time we need the same level
  int old_level;				// what was last level?
  int score_was_changed;			// score was changed ...
  int typing_code;				// typing the code
  char TextBuffer[100];				// text buffer
  char TypeBuffer[CODE_LENGTH+1];
  char TextRGBColor[7];				// Buffer for hex RGB representation
 

struct{
  int x;		// actual x position
  int y;		// actual y position
  int init_x;		// init x position
  int init_y;		// init y position
  int alive;		// if Robbo is alive
  int state;		// Robbo's state (0 or 1 for exchange 2 icons for each direction) 
  int direction;	// Robbo's direction 0,2,4,6  + state => icon
  int score;		// Robbo's score
  int screws;		// Screws to collect
  int lives;		// Lives remaining
  int keys;		// Keys
  int bullets;
  int level;
  int moved;
  int shooted;
  int exitopened;
  int stepdirection;	// 0 - direction of stepping
  int mapoffsetx;
  int mapoffsety;
  int blocked;			/* robbo cannot move - possible magnet moving */
  int blocked_direction;	/* where robbo should be moved after blocking */
} robbo;

struct{
  int x;
  int y;
  int number;
  int screws;
  int init_screws;		// initial number of screws to collect
  char code[CODE_LENGTH+1];
  int bullets;
  char author[50];
  int now_is_blinking;
  int now_is_scrolling_h;	// horizontal scrolling
  int now_is_scrolling_v;	// vertical scrolling
  Uint32 color;			// color of the level
} level;

unsigned int next_rand;		// seed for random function

/******************************************/
/*********** All game functions ***********/
/******************************************/

void init_robbo(void);
SDL_Rect set_rect(int x, int y, int w, int h);
Uint32 getpixel(SDL_Surface *surface, int x, int y);
void load_bitmaps(void);
void draw_score(void);
void show_gamearea();
void move_robbo(int x,int y);
void shoot_robbo(int x,int y);
void update_game();
int update_coords(struct Coords *coords, int direction);
void prepare_objects();
void set_images(int type,int x, int y);
void kill_robbo();
int read_from_file(int level_number);
void create_object(int x,int y,int type);
void clear_field(struct object *obj);
int transform_char(char c);
int level_init(int level, int force_fileread);
void set_coords(struct Coords *coords,int x, int y);
void set_mapoffset();
int can_move(struct Coords coords, int direction);
int next_laserfield(struct Coords coords, int direction);
void move_object(int x, int y, struct Coords coords);
void shoot_object(int x, int y, int direction);
void blow_bomb(int x, int y);
int coords_out_of_range(struct Coords coords);
void show_startscreen();
void show_endscreen();
void open_exit();
void refresh_field(int x, int y);
void clear_screen();
int my_rand();
int my_srand(unsigned int seed);
void init_questionmarks();
void read_resource_file();
void save_resurce_file();
int test_resource_file();

