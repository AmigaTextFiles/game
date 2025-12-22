/***********************************************************
* Mirror Magic -- McDuffin's Revenge                       *
*----------------------------------------------------------*
* (c) 1994-2001 Artsoft Entertainment                      *
*               Holger Schemel                             *
*               Detmolder Strasse 189                      *
*               33604 Bielefeld                            *
*               Germany                                    *
*               e-mail: info@artsoft.org                   *
*----------------------------------------------------------*
* main.c                                                   *
***********************************************************/

#include "libgame/libgame.h"

#include "main.h"
#include "init.h"
#include "game.h"
#include "events.h"

GC		tile_clip_gc, line_gc[2];
Bitmap	       *pix[NUM_BITMAPS];
Pixmap		tile_clipmask[NUM_TILES];
DrawBuffer     *fieldbuffer;
DrawBuffer     *drawto_field;

int		game_status = MAINMENU;
boolean		level_editor_test_game = FALSE;
boolean		network_playing = FALSE;

int		key_joystick_mapping = 0;

boolean		redraw[MAX_BUF_XSIZE][MAX_BUF_YSIZE];
int		redraw_x1 = 0, redraw_y1 = 0;

short		Feld[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		Ur[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		Hit[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		Box[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		Angle[MAX_LEV_FIELDX][MAX_LEV_FIELDY];

short		MovPos[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		MovDir[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		MovDelay[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		Store[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		Store2[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		StorePlayer[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		Frame[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
boolean		Stop[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		JustStopped[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		AmoebaNr[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
short		AmoebaCnt[MAX_NUM_AMOEBA], AmoebaCnt2[MAX_NUM_AMOEBA];
unsigned long	Elementeigenschaften[MAX_ELEMENTS];

int		level_nr;
int		lev_fieldx,lev_fieldy, scroll_x,scroll_y;

int		FX = SX, FY = SY, ScrollStepSize;
int		ScreenMovDir = MV_NO_MOVING, ScreenMovPos = 0;
int		ScreenGfxPos = 0;
int		GameFrameDelay = GAME_FRAME_DELAY;
int		FfwdFrameDelay = FFWD_FRAME_DELAY;
int		BX1 = 0, BY1 = 0, BX2 = SCR_FIELDX-1, BY2 = SCR_FIELDY-1;
int		SBX_Left, SBX_Right;
int		SBY_Upper, SBY_Lower;
int		ZX,ZY, ExitX,ExitY;
int		AllPlayersGone;
int		TimeFrames, TimePlayed, TimeLeft;

#if 0
boolean		network_player_action_received = FALSE;
#endif

struct LevelInfo	level;
#if 0
struct PlayerInfo	stored_player[MAX_PLAYERS], *local_player = NULL;
#endif
struct HiScore		highscore[MAX_SCORE_ENTRIES];
struct SetupInfo	setup;
struct GameInfo		game;
struct LaserInfo	laser;
struct EditorInfo	editor;
struct GlobalInfo	global;

short		LX,LY, XS,YS, ELX,ELY;
short		CT,Ct;

Pixel		pen_fg, pen_bg, pen_ray, pen_magicolor[2];
int		color_status;

struct XY	Step[16] =
{
  {  1,  0 },
  {  2, -1 },
  {  1, -1 },
  {  1, -2 },
  {  0, -1 },
  { -1, -2 },
  { -1, -1 },
  { -2, -1 },
  { -1,  0 },
  { -2,  1 },
  { -1,  1 },
  { -1,  2 },
  {  0,  1 },
  {  1,  2 },
  {  1,  1 },
  {  2,  1 }
};

/* "Sign" has the following structure:

   each 4-bit-value represents the values d*8 + c*4 + b*2 + a*1
   at the pixel positions

   a b     1 2
   c d     4 8

   so the value "0xA" (=> (d=1)*8 + (c=0)*4 + (b=1)*2 + (a=0)*1)
   would result in the pixel pattern

   0 1        _ x
   0 1    or  _ x

   x x    x x    x x    x x    x x
   x _    x x    _ _    x x    _ x
      6                      2
   x x     5      4      3     x x
   x x  7                   1  x x

   x _                         _ x
   x _  8                   0  _ x

   x x  9                  15  x x
   x x     11    12     13     x x
      10                     14
   x _    x x    _ _    x x    _ x
   x x    x x    x x    x x    x x

 */

short Sign[16] =
{
  0xA,0xF,0xB,0xF,
  0x3,0xF,0x7,0xF,
  0x5,0xF,0xD,0xF,
  0xC,0xF,0xE,0xF
};


/* data needed for playing sounds */
char *sound_name[NUM_SOUNDS] =
{
  "amoebe.wav",
  "antigrav.wav",
  "autsch.wav",
  "bong.wav",
  "fuel.wav",
  "halloffame.wav",
  "holz.wav",
  "hui.wav",
  "kabumm.wav",
  "kink.wav",
  "kling.wav",
  "laser.wav",
  "oeffnen.wav",
  "quiek.wav",
  "rhythmloop.wav",
  "roaaar.wav",
  "sirr.wav",
  "slurp.wav",
  "warnton.wav",
  "whoosh.wav"
};

/* background music */
int background_loop[] =
{
#if 0
  SND_TYGER,
  SND_VOYAGER,
#endif
};
int num_bg_loops = sizeof(background_loop)/sizeof(int);

char *element_info[] =
{
  "empty space",				/* 0 */
  "mirror (0°)",
  "mirror (11.25°)",
  "mirror (22.5°)",
  "mirror (33.75°)",
  "mirror (45°)",
  "mirror (56.25°)",
  "mirror (67.5°)",
  "mirror (78.75°)",
  "mirror (90°)",
  "mirror (101.25°)",				/* 10 */
  "mirror (112.5°)",
  "mirror (123.75°)",
  "mirror (135°)",
  "mirror (146.25°)",
  "mirror (157.5°)",
  "mirror (168.75°)",
  "fixed steel polarisator (0°)",
  "fixed steel polarisator (90°)",
  "fixed steel polarisator (45°)",
  "fixed steel polarisator (135°)",		/* 20 */
  "Gregor McDuffin (looking right)",
  "Gregor McDuffin (looking up)",
  "Gregor McDuffin (looking left)",
  "Gregor McDuffin (looking down)",
  "closed exit",
  "opening exit",
  "opening exit",
  "open exit",
  "magic kettle",
  "bomb",					/* 30 */
  "prism",
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",					/* 40 */
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",
  "steel wall",
  "wooden wall",
  "wooden wall",
  "wooden wall",				/* 50 */
  "wooden wall",
  "wooden wall",
  "wooden wall",
  "wooden wall",
  "wooden wall",
  "wooden wall",
  "wooden wall",
  "wooden wall",
  "wooden wall",
  "wooden wall",				/* 60 */
  "wooden wall",
  "wooden wall",
  "wooden wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",					/* 70 */
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "ice wall",
  "amoeba wall",				/* 80 */
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",				/* 90 */
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "amoeba wall",
  "wooden block",
  "gray ball",
  "beamer (0°)",
  "beamer (22.5°)",
  "beamer (45°)",				/* 100 */
  "beamer (67.5°)",
  "beamer (90°)",
  "beamer (112.5°)",
  "beamer (135°)",
  "beamer (157.5°)",
  "beamer (180°)",
  "beamer (202.5°)",
  "beamer (225°)",
  "beamer (247.5°)",
  "beamer (270°)",				/* 110 */
  "beamer (292.5°)",
  "beamer (315°)",
  "beamer (337.5°)",
  "fuse",
  "pac man (starts moving right)",
  "pac man (starts moving up)",
  "pac man (starts moving left)",
  "pac man (starts moving down)",
  "polarisator (0°)",
  "polarisator (11.25°)",			/* 120 */
  "polarisator (22.5°)",
  "polarisator (33.75°)",
  "polarisator (45°)",
  "polarisator (56.25°)",
  "polarisator (67.5°)",
  "polarisator (78.75°)",
  "polarisator (90°)",
  "polarisator (101.25°)",
  "polarisator (112.5°)",
  "polarisator (123.75°)",			/* 130 */
  "polarisator (135°)",
  "polarisator (146.25°)",
  "polarisator (157.5°)",
  "polarisator (168.75°)",
  "two-way polarisator (0°)",
  "two-way polarisator (22.5°)",
  "two-way polarisator (45°)",
  "two-way polarisator (67.5°)",
  "fixed mirror (0°)",
  "fixed mirror (45°)",				/* 140 */
  "fixed mirror (90°)",
  "fixed mirror (135°)",
  "reflecting stone lock",
  "key",
  "light bulb (dark)",
  "ligh bulb (glowing)",
  "bonus ball",
  "reflecting stone block",
  "wooden lock",
  "extra energy ball (full)",			/* 150 */
  "fixed wooden polarisator (0°)",
  "fixed wooden polarisator (90°)",
  "fixed wooden polarisator (45°)",
  "fixed wooden polarisator (135°)",
  "extra energy ball (empty)",
  "unused",
  "unused",
  "unused",
  "unused",
  "letter ' '",					/* 160 */
  "letter '!'",
  "letter '\"'",
  "letter '#'",
  "letter '$'",
  "letter '%'",
  "letter '&'",
  "letter '''",
  "letter '('",
  "letter ')'",
  "letter '*'",					/* 170 */
  "letter '+'",
  "letter ','",
  "letter '-'",
  "letter '.'",
  "letter '/'",
  "letter '0'",
  "letter '1'",
  "letter '2'",
  "letter '3'",
  "letter '4'",					/* 180 */
  "letter '5'",
  "letter '6'",
  "letter '7'",
  "letter '8'",
  "letter '9'",
  "letter ':'",
  "letter ';'",
  "letter '<'",
  "letter '='",
  "letter '>'",					/* 190 */
  "letter '?'",
  "letter '@'",
  "letter 'A'",
  "letter 'B'",
  "letter 'C'",
  "letter 'D'",
  "letter 'E'",
  "letter 'F'",
  "letter 'G'",
  "letter 'H'",					/* 200 */
  "letter 'I'",
  "letter 'J'",
  "letter 'K'",
  "letter 'L'",
  "letter 'M'",
  "letter 'N'",
  "letter 'O'",
  "letter 'P'",
  "letter 'Q'",
  "letter 'R'",					/* 210 */
  "letter 'S'",
  "letter 'T'",
  "letter 'U'",
  "letter 'V'",
  "letter 'W'",
  "letter 'X'",
  "letter 'Y'",
  "letter 'Z'",
  "letter 'Ä'",
  "letter 'Ö'",					/* 220 */
  "letter 'Ü'",
  "letter '^'",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",					/* 230 */
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "letter ''",
  "mirror (0°)",				/* 240 */
  "mirror (11.25°)",
  "mirror (22.5°)",
  "mirror (33.75°)",
  "mirror (45°)",
  "mirror (56.25°)",
  "mirror (67.5°)",
  "mirror (78.75°)",
  "mirror (90°)",
  "mirror (101.25°)",
  "mirror (112.5°)",				/* 250 */
  "mirror (123.75°)",
  "mirror (135°)",
  "mirror (146.25°)",
  "mirror (157.5°)",
  "mirror (168.75°)",
  "fixed wooden polarisator (0°)",
  "fixed wooden polarisator (22.5°)",
  "fixed wooden polarisator (45°)",
  "fixed wooden polarisator (67.5°)",
  "fixed wooden polarisator (90°)",		/* 260 */
  "fixed wooden polarisator (112.5°)",
  "fixed wooden polarisator (135°)",
  "fixed wooden polarisator (157.5°)",
  "fixed steel polarisator (0°)",
  "fixed steel polarisator (22.5°)",
  "fixed steel polarisator (45°)",
  "fixed steel polarisator (67.5°)",
  "fixed steel polarisator (90°)",
  "fixed steel polarisator (112.5°)",
  "fixed steel polarisator (135°)",		/* 270 */
  "fixed steel polarisator (157.5°)",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",		/* 280 */
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style wooden wall",
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",			/* 290 */
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",			/* 300 */
  "deflektor style steel wall",
  "deflektor style steel wall",
  "deflektor style steel wall",
  "empty space",
  "cell",
  "mine",
  "refractor",
  "laser cannon (shooting right)",
  "laser cannon (shooting up)",
  "laser cannon (shooting left)",		/* 310 */
  "laser cannon (shooting down)",
  "laser receiver (directed right)",
  "laser receiver (directed up)",
  "laser receiver (directed left)",
  "laser receiver (directed down)",
  "fibre optic (1a)",
  "fibre optic (1b)",
  "fibre optic (2a)",
  "fibre optic (2b)",
  "fibre optic (3a)",				/* 320 */
  "fibre optic (3b)",
  "fibre optic (4a)",
  "fibre optic (4b)",
  "rotating mirror (0°)",
  "rotating mirror (11.25°)",
  "rotating mirror (22.5°)",
  "rotating mirror (33.75°)",
  "rotating mirror (45°)",
  "rotating mirror (56.25°)",
  "rotating mirror (67.5°)",			/* 330 */
  "rotating mirror (78.75°)",
  "rotating mirror (90°)",
  "rotating mirror (101.25°)",
  "rotating mirror (112.5°)",
  "rotating mirror (123.75°)",
  "rotating mirror (135°)",
  "rotating mirror (146.25°)",
  "rotating mirror (157.5°)",
  "rotating mirror (168.75°)",
  "rotating wooden polarisator (0°)",		/* 340 */
  "rotating wooden polarisator (22.5°)",
  "rotating wooden polarisator (45°)",
  "rotating wooden polarisator (67.5°)",
  "rotating wooden polarisator (90°)",
  "rotating wooden polarisator (112.5°)",
  "rotating wooden polarisator (135°)",
  "rotating wooden polarisator (157.5°)",
  "rotating steel polarisator (0°)",
  "rotating steel polarisator (22.5°)",
  "rotating steel polarisator (45°)",		/* 350 */
  "rotating steel polarisator (67.5°)",
  "rotating steel polarisator (90°)",
  "rotating steel polarisator (112.5°)",
  "rotating steel polarisator (135°)",
  "rotating steel polarisator (157.5°)",
  "red beamer (0°)",
  "red beamer (22.5°)",
  "red beamer (45°)",
  "red beamer (67.5°)",
  "red beamer (90°)",				/* 360 */
  "red beamer (112.5°)",
  "red beamer (135°)",
  "red beamer (157.5°)",
  "red beamer (180°)",
  "red beamer (202.5°)",
  "red beamer (225°)",
  "red beamer (247.5°)",
  "red beamer (270°)",
  "red beamer (292.5°)",
  "red beamer (315°)",				/* 370 */
  "red beamer (337.5°)",
  "yellow beamer (0°)",
  "yellow beamer (22.5°)",
  "yellow beamer (45°)",
  "yellow beamer (67.5°)",
  "yellow beamer (90°)",
  "yellow beamer (112.5°)",
  "yellow beamer (135°)",
  "yellow beamer (157.5°)",
  "yellow beamer (180°)",			/* 380 */
  "yellow beamer (202.5°)",
  "yellow beamer (225°)",
  "yellow beamer (247.5°)",
  "yellow beamer (270°)",
  "yellow beamer (292.5°)",
  "yellow beamer (315°)",
  "yellow beamer (337.5°)",
  "green beamer (0°)",
  "green beamer (22.5°)",
  "green beamer (45°)",				/* 390 */
  "green beamer (67.5°)",
  "green beamer (90°)",
  "green beamer (112.5°)",
  "green beamer (135°)",
  "green beamer (157.5°)",
  "green beamer (180°)",
  "green beamer (202.5°)",
  "green beamer (225°)",
  "green beamer (247.5°)",
  "green beamer (270°)",			/* 400 */
  "green beamer (292.5°)",
  "green beamer (315°)",
  "green beamer (337.5°)",
  "blue beamer (0°)",
  "blue beamer (22.5°)",
  "blue beamer (45°)",
  "blue beamer (67.5°)",
  "blue beamer (90°)",
  "blue beamer (112.5°)",
  "blue beamer (135°)",				/* 410 */
  "blue beamer (157.5°)",
  "blue beamer (180°)",
  "blue beamer (202.5°)",
  "blue beamer (225°)",
  "blue beamer (247.5°)",
  "blue beamer (270°)",
  "blue beamer (292.5°)",
  "blue beamer (315°)",
  "blue beamer (337.5°)",
  "unknown",					/* 420 */

  /*
  "-------------------------------",
  */
};
int num_element_info = sizeof(element_info)/sizeof(char *);


/* ========================================================================= */
/* main()                                                                    */
/* ========================================================================= */

int main(int argc, char *argv[])
{
  InitCommandName(argv[0]);
  InitExitFunction(CloseAllAndExit);
  InitPlatformDependantStuff();

  GetOptions(argv);
  OpenAll();

  EventLoop();
  CloseAllAndExit(0);
  exit(0);	/* to keep compilers happy */
}
