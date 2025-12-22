#ifndef MISSCMD_H
#define MISSCMD_H 1

#include "gfx_clear.h"
#include "gfx_ui.h"
#include "gfx_ui_hiscore.h"

#define MENU_MICROS 2*20*1000

#define MICROS 2*20*1000
#define FREQ 25
#define COUNTDOWN FREQ*1

typedef union {
	int32 f;
	struct { int16 i, f; } p;
} fixed;

typedef struct hiscore {
	char name[12];
	int32 score;
} hiscore;

typedef struct {
	struct DiskObject	*icon;
	timer	*timer;
	entropy	*entropy;
	display	*disp;

	LIST	dmglist;
	gfx		*bkg;
	pointer	*ptr;
	sound	**sounds;
	gfx		**citygfx;

	int 	status;
	uint32	flags;

	Menu		*mainmenu;
	HiscoreView	*hiscoreview;
	hiscore		hiscores[10];

	LIST	city;
	int32	skyline;
	LIST	missiles;
	LIST	antimissiles;

	int		wave;
	int32 	score;

	int		mlaunched, mtotal;
	int32	delay;
	int32	accuracy, speed;
	int		build_left;
} globals;

extern globals *global;

#define GFLG_NEWWAVE 1
#define GFLG_GAMEOVER 2
#define GFLG_NEWHISCORE 4

/* coll.c */
int LineGfxColl (int32 x1, int32 y1, int32 x2, int32 y2, int32 gfx_x1, int32 gfx_y1, gfx *gfx);

typedef struct {
	NODE node;

	int status, special;
	int32 x, y;
	gfx *gfx;
	int16 points;

	struct {
		int32 x, y, r, dr, max_r;
	} exp;
} Building;

typedef struct {
	Building node;
	int reload;
} Cannon;

/* buildings.c */
int GenerateCity (int32 num);
void RenderBuilding (NODE *node, int dontmove);
int32 RandomTarget ();
NODE *IsHit (int32 x1, int32 y1, int32 x2, int32 y2);
void Explode (NODE *node);
int32 CalcScore (LIST *city);

typedef struct {
	NODE node;

	int status;
	int32 dx, dy;
	fixed x1, y1, x2, y2;
	int dir;
} Missile;

typedef struct {
	NODE node;

	int status;
	int32 dx, dy;
	fixed x1, y1, x2, y2;
	int32 r, dr, r_sqr;
} AntiMissile;

/* missiles.c */
void NextWave ();
int LaunchMissile ();
void RenderMissile (NODE *node, int dontmove);
int LaunchAntiMissile (int32 x, int32 y);
void RenderAntiMissile (NODE *node, int dontmove);
void FreeMissiles();

#endif
