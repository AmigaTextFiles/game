///////////////////////////////////////////////
// 
//  Snipe2d ludum dare 48h compo entry
//
//  Jari Komppa aka Sol 
//  http://iki.fi/sol
// 
///////////////////////////////////////////////
// License
///////////////////////////////////////////////
// 
//     This software is provided 'as-is', without any express or implied
//     warranty.    In no event will the authors be held liable for any damages
//     arising from the use of this software.
// 
//     Permission is granted to anyone to use this software for any purpose,
//     including commercial applications, and to alter it and redistribute it
//     freely, subject to the following restrictions:
// 
//     1. The origin of this software must not be misrepresented; you must not
//        claim that you wrote the original software. If you use this software
//        in a product, an acknowledgment in the product documentation would be
//        appreciated but is not required.
//     2. Altered source versions must be plainly marked as such, and must not be
//        misrepresented as being the original software.
//     3. This notice may not be removed or altered from any source distribution.
// 
// (eg. same as ZLIB license)
//
///////////////////////////////////////////////
//
// Houses are taken from a satellite picture of glasgow.
//
// The sources are a mess, as I didn't even try to do anything
// really organized here.. and hey, it's a 48h compo =)
//
//#include <windows.h>
#include <iostream>
#ifdef __amigaos__
#include <limits.h>
#else
#include <linux/limits.h>
#endif
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <libgen.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_mixer.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "petopt.h"

#ifdef __amigaos4__
#define VERSTAG    "\0$VER: OES 1.29 - AmigaOS4.0 Port 1.0 (06.01.2005)\n"
CONST STRPTR __attribute__((used)) VerStr = VERSTAG;
CONST STRPTR __attribute__((used)) Stack  = "$STACK:131072\n";
#endif

// When trying to debug a segfault, you REALLY, REALLY need to be able to
// switch windows.  :(
#ifdef DEBUG_MODE
#undef SDL_GRAB_ON
#define SDL_GRAB_ON SDL_GRAB_OFF
#endif
// Config:

#define SHIFT_AMOUNT 12
#define CAMERA_STEPS
#define UNREAL_DITHER
#define WOBBLE 2
#define DISPLAY_LOGO_SCREEN
#define DISPLAY_GAMEOVER_SCREEN
//#define CAMERA_RECOIL
//#define RECYCLE_PEDESTRIANS
#define PLAY_AUDIO

enum COLORSET {
    COLOR_BLACK = 0,
    COLOR_WHITE,
    COLOR_GREEN,
    COLOR_YELLOW,
    COLOR_RED
};

enum CHARTYPES
{
    CHAR_BADGUY = 0,
    CHAR_VIP = 1,
    CHAR_PEDESTRIAN = 2
};

enum SOUNDCHAN {
  SOUNDCHAN_EFFECT = 0,
  SOUNDCHAN_MUSIC = 1,
};


/* Reason for game over */
typedef enum OES_ENDREASON {
  OESREASON_NONE = 0,  /* game in progress */
  OESREASON_NEGLIGENT,  /* let a VIP die. */
  OESREASON_AWOL,       /* left post (voluntary game end). */
  OESREASON_FRAG,       /* hit VIP. */
  OESREASON_QUIT,       /* forceful quit. */
} OES_ENDREASON;


/* Game states */
typedef enum OES_GAMESTATE {
  OESGAME_CHAOS = 0,  /* uninitialized. */
  OESGAME_PLAY,       /* initialized and in play. */
  OESGAME_PAUSED,     /* paused. */
  OESGAME_UNPAUSED,   /* un-paused, reinitalize system resources (devices). */
} OES_GAMESTATE;


/* data types go here. */

typedef struct character_
{
    float mX, mY; // position
    float mXi, mYi; // direction
    float mSpeed;   // speed of this AI
    int mType;   // AI type
    int mTTL;    // time to live, for normal pedestrians
    int mTarget; // target exit point or target character
    int mNextWaypoint;   // waypoint towards which this AI is walking
    int mLastWaypoints[7];   // last 7 waypoints to kill loops
    int mLastWaypoint;  // counter for above array
} CHARACTER;

typedef struct waypointstruc
{
    int mX,mY;
    int *mConnection;
    int mConnections;
} WAYPOINT;

typedef struct spawnpointstruc
{
    int mX, mY;
    int mClosestWaypoint;
    int mType;
} SPAWNPOINT;

typedef struct prefs_
{
    char *homedir;
    char *datadir;
    char *cfgpath;
    char *scorepath;
    char *bindpath;
    char *keyspath;
    FILE *f;
    char verbose;
    char fullscreen;
    char audio;
    char difficulty;
    char joystick;
    char *wwwbrowser;
} PREFS;

typedef struct scores_
{
    char easy_n[10][9];
    int easy_s[10];
    char medium_n[10][9];
    int medium_s[10];
    char hard_n[10][9];
    int hard_s[10];
} SCORES;

typedef struct BUTTONS {
    SDL_Surface *startgame;
    SDL_Surface *startgameh;
    SDL_Surface *fullscreen;
    SDL_Surface *fullscreenh;
    SDL_Surface *window;
    SDL_Surface *windowh;
    SDL_Surface *audioon;
    SDL_Surface *audiooff;
    SDL_Surface *audioonh;
    SDL_Surface *audiooffh;
    SDL_Surface *easy;
    SDL_Surface *easyh;
    SDL_Surface *medium;
    SDL_Surface *mediumh;
    SDL_Surface *hard;
    SDL_Surface *hardh;
    SDL_Surface *hiscores;
    SDL_Surface *hiscoresh;
    SDL_Surface *prefs;
    SDL_Surface *prefsh;
    SDL_Surface *quit;
    SDL_Surface *quith;
    SDL_Surface *resume;
    SDL_Surface *resumeh;
} BUTTONS;

#if 0
class SniperBGM {
    Mix_Music *BGM;
    int playp;
    int pausep;
    int startTime, stopTime;
    float bookmark;
    static const int FadeInTime = 3000;
    static const int FadeOutTime = 1000;
    static const float RepeatJumpPos = 0.0;
  public:
    SniperBGM();
    SniperBGM(Mix_Music *m);
    ~SniperBGM();
    const SniperBGM & operator=(Mix_Music *m);
    operator Mix_Music*() const;
    void use(Mix_Music *m);
    void start();
    void stimulate();
    void depress();
    void stop();
    void pause();
    void pause(int newstate);
    void jumpto(float pos);
    void rewind();
    void loop();
    void release();
    void grab();
};
#endif /* 0 */

/* Phasing out class SniperBGM */
typedef struct sniperbgm_t {
  Mix_Music *BGM;
  int playp;
  int pausep;
  int time_start;
  int time_stop;
  float bookmark;
} sniperbgm_t;

#define sniperbgm_FadeInTime 3000
#define sniperbgm_FadeOutTime 1000
#define sniperbgm_RepeatJumpPos 0.0

sniperbgm_t * sniperbgm_init (sniperbgm_t *);
sniperbgm_t * sniperbgm_init_music (sniperbgm_t *, Mix_Music *);
sniperbgm_t * sniperbgm_destroy (sniperbgm_t *);
void sniperbgm_delete (sniperbgm_t *);
Mix_Music * sniperbgm_music (sniperbgm_t *);
void sniperbgm_use (sniperbgm_t *, Mix_Music *);
void sniperbgm_start (sniperbgm_t *);
void sniperbgm_stimulate (sniperbgm_t *);
void sniperbgm_depress (sniperbgm_t *);
void sniperbgm_stop (sniperbgm_t *);
void sniperbgm_pause (sniperbgm_t *, int);
void sniperbgm_jumpto (sniperbgm_t *, float);
void sniperbgm_rewind (sniperbgm_t *);
void sniperbgm_loop (sniperbgm_t *);
void sniperbgm_release (sniperbgm_t *);
void sniperbgm_grab (sniperbgm_t *);



/* character counter/generator state */
typedef struct charcount_t {
  int spawn;      /* SpawnCount */
  int count;      /* Count */
  int dead;       /* Killed */
  int goal;       /* GottenToSafety */
  float time;     /* SpawnTime */
  float period;   /* SpawnTimePeriod */
} charcount_t;

#if 0
typedef struct soundeffect_t {
  Mix_Chunk *data;
  int len;
  int ofs;
} soundeffect_t;
#endif /* 0 */

/* game state */
typedef struct orbitalsniper_t {
  SDL_Surface *Screen;
  SDL_Surface *Map;
  SDL_Surface *AIMap;
  SDL_Surface *Font[5];
  SDL_Surface *CharSprite;

  int ControlState;
  float MouseX;
  float MouseY;
  float MouseZ;
  float CoordScale;

  int WobbleIndex;
  float WobbleX;
  float WobbleY;
  float CenterX;
  float CenterY;

  int verbosity;
  int Reloading;
  int ReloadTime;
  int StartTick;
  int GameStartTick;
  int GameOverTicks;
  OES_ENDREASON GameOverReason;
  int FrameCount;
  int LastTick;
  int Score;
  float ScoreMod;  /* score modifier. */

  charcount_t vip;    /* keep alive at all costs. */
  charcount_t baddy;    /* BadGuys */
  charcount_t pedestrian;  /* collateral damage. */

  int num_characters;
  CHARACTER *characters;  /* List of all characters in game */
  int num_spawnpoints;
  SPAWNPOINT *spawnpoints;  /* List of spawnpoints */
  int num_waypoints;
  WAYPOINT *waypoints;      /* List of waypoints */
  CHARACTER * SightedCharacter;
  SCORES HiScore;  /* high scores list */

//  soundeffect_t AudioZoomSample;
//  soundeffect_t AudioFireSample;
  Mix_Chunk *AudioZoomOut;
  Mix_Chunk *AudioZoomIn;
  Mix_Chunk *AudioFire;

  int GameState;
  SDL_AudioSpec *sdlaudio;
//  SniperBGM BGM;
  sniperbgm_t *BGM;
  int GrabP;  /* mouse grab */
  int BeforePauseTick;  /* keep spawn-timing across pauses. */
  int AfterPauseTick;
  int SemiPause;  /* double-click timer. */

  char *mediaPath;
//  int unreal_dither[];
} ORBITALSNIPER;


/* globals. */

extern BUTTONS gButton;
extern int unreal_dither[];
extern char *mediaPath;

extern ORBITALSNIPER Game;


/* function prototypes. */
extern float distance(float aX1, float aY1, float aX2, float aY2);
extern float distance_wp(int aWaypoint, float aX, float aY);
extern float distance_wpwp(int aWaypoint1, int aWaypoint2);
extern void handle_ai(CHARACTER &c);
extern int spawn_ai(int aType);

extern void print(int aXofs, int aYofs, int aColor, const char *aString, ...);
extern void printShadow(int aXofs, int aYofs, const char *aString, ...);
extern void zoom(SDL_Surface * src, float ofsx, float ofsy, float scale);
extern void zoom_unreal(SDL_Surface * src, float ofsx, float ofsy, float scale);
extern void drawLine(SDL_Surface * aTarget, int x1,int y1,int x2, int y2, int clr);
extern void target();
extern void init();
extern void init_logoscreen();
extern void logoscreen();
extern void precalc_ai();
extern void shoot();
extern void gameoverscreen(int aReason);

extern void drawCharacter(CHARACTER &c);

extern void configure_difficulty();

/* setup and teardown */
int oes_setup ();
void oes_teardown ();
int oes_suspend();
int oes_resume();

/* Preferences */
PREFS *prefs_init (PREFS *);
PREFS *prefs_destroy (PREFS *);
void prefs_delete (PREFS *);
PREFS *prefs_load (PREFS *);
PREFS *prefs_save (PREFS *);
PREFS *prefs_create (PREFS *);

extern void show_hiscores();
extern void init_hiscores();
extern void process_hiscore();
extern void save_hiscores();

extern void prefs();


void draw_button (SDL_Surface *b, int x, int y);

// FIXME:  everybody should use this.
SDL_Surface *oes_load_img (const char *path);

bool hovering (int x, int y, int w, int h);


/* drawing */
void oes_fillrect (SDL_Surface *, int x0, int y0, int x1, int y1, int color);

int draw_gameover (SDL_Surface *, const SDL_Rect *);
int draw_hiscores (SDL_Surface *, const SDL_Rect *);


/* S-Expressions (libsexpr) */

#define PAIRP(se) ((se)->ty == SEXP_LIST)
#define ATOMP(se) ((se)->ty == SEXP_VALUE)
#define CAR(se) (ATOMP(se) ? se : hd_sexp(se))
#define CDR(se) (ATOMP(se) ? next_sexp(se) : tl_sexp(se))

int prefs_load ();
int prefs_save ();
int prefs_init ();


int oes_game ();  /* main game loop */

#include "ui.h"



