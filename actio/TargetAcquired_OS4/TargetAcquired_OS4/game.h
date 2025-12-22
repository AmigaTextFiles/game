/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/

#ifndef __GAME_H__
#define __GAME_H__

#include "modern.h"

#define NUMBLASTS 20
#define NUMEBLASTS 40
#define NUMENEMIES 20
#define NUMEXPLS 40
#define NUMDEBRIS 60
#define NUMSTARS 150

typedef struct spritestruct {
	signed char dx,dy;
	int x,y,pointvalue,firefreq;
	void (*update)(struct spritestruct *);
	void (*fire)(struct spritestruct *);
	void (*destroy)(struct spritestruct *);
	byte active, hitstokill;
	graphic *picture;
} sprite;

typedef struct {
	int length;
	void (*intro)(void);
	void (*update)(void);
} wave;

void setupscreen(void);
void rungame(void);
void blankintro(void);
void wave1intro(void);
void wave2intro(void);
void wave3intro(void);
void runwave(wave *);
void updateeverything(void);
void waveintro(char *, char *, int);
void endingsequence(void);
void updatestarblazer(void);
void updateplasmablast(sprite *);
void updateenemyplasma(sprite *);
void updatesweeper(sprite *);
void updatemissileboss(sprite *);
void updatelaserboss(sprite *);
void updatemassivebattleship(sprite *);
void updatekamikaze(sprite *);
void updatebomb(sprite *);
void updatemissiles(sprite *);
void updatelasers(sprite *);
void initgame(void);
void endgame(void);
void initwave(wave *);
void wave1update(void);
void wave2update(void);
void wave3update(void);
void destroysomething(int);
void killplayer(void);
void smallexpl(sprite *);
void bigexpl(sprite *);
void megaexpl(sprite *);
void ultramegaexpl(sprite *);
void newblast(void);
void shootplasma(sprite *);
void wave1bossupdate(void);
void wave2bossupdate(void);
void wave3bossupdate(void);
void shootmissiles(sprite *);
void shootlasers(sprite *);
void shootmbsmissiles(sprite *);
void shootmbslasers(sprite *);
void shootbolts(sprite *);
void newsweeper(graphic *);
void newkamikaze(graphic *);
void newbomb(graphic *);
void newmissileboss(void);
void newlaserboss(void);
void newmassivebattleship(void);
void newexpl(int, int, int, int);
void newteenyexpl(int, int, int, int);

void loadallsprites(void);
void setupscreen(void);
void rotate(int);
void draweverything(SDL_Surface *);
void collision_check(void);

#endif
