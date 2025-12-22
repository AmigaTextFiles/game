#include <stdio.h>
#include <stdlib.h>
#include "SDL.h"

#ifdef __WIN32
#define SHAREPATH ""
#else
#define SHAREPATH ""
#endif

#define TICK_INTERVAL 16
#define TILE_SIZE     24
#define STARTLIVES     9

/* size of the game board in tiles */
#define WIDTH         19
#define HEIGHT        19

#define KEY_LEFT  (1<<0)
#define KEY_RIGHT (1<<1)
#define KEY_UP    (1<<2)
#define KEY_DOWN  (1<<3)

enum
{
	T_FLOOR,
	T_WALL,
	T_ROBOT,
	T_BALL,
	T_DISCUS_H,
	T_DISCUS_V,
	T_COUNT
};

enum
{
	SFX_BALL,
	SFX_DISCUS,
	SFX_ROBOT,
	SFX_TICK,
	SFX_TIMEUP
};

/* error stuff */
void error(const char *msg, ...);

/* game stuff */
int playgame(void);

/* input stuff */
int getinput(void);
void resetinput(void);

/* level stuff */
extern char gamemap[][HEIGHT][WIDTH];
extern int numlevels;

/* menu stuff */
void setupfonts(void);
int showmenu(const int score);
void showpausedtext(void);
void panel_displaytext(int right, const char *text, ...);

/* number stuff */
int factors(int n);

/* random stuff */
void random_seed(void);
int rnd(int range);

/* sound stuff */
void startaudio(void);
void playsfx(int sfx);
void pausemusic(void);
void unpausemusic(void);

/* time stuff */
int time_wait(void);
void timer_start(void);

/* video stuff */
void setupvideo(void);
Uint32 getcolor(int r, int g, int b);
void puttile(int realx, int realy, int tileindex);
void updatescreen(void);
void reblitscreen(void);
SDL_Surface *getscreen(void);
SDL_Surface *getfakescreen(void);
void restorescreen(void);
void clearscreen(void);
void clearregion(int x, int y, int w, int h);
void screen_save(void);
void panel_displaylives(int lives);
