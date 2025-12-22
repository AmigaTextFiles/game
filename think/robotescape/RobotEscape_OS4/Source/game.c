#include "robot.h"
#include <string.h>

#define TIMELIMIT  60
#define MAXROBOTS 255
#define MAXDISCUS 255
#define MOVEFACTOR  2           /* must be an integer factor of TILE_SIZE */
#define DISCUSMOVE  4
#define HALFTILE (TILE_SIZE/2)

enum
{
	D_UP,
	D_LEFT,
	D_DOWN,
	D_RIGHT
};

static char gamefield[HEIGHT][WIDTH];
static char needsredrawing[HEIGHT][WIDTH];

typedef struct
{
	int tilex;
	int tiley;
	int realx;
	int realy;
	int direction;
	int valid;
} robot_t;

typedef robot_t ball_t;
typedef robot_t discus_t;

static ball_t   ball;
static robot_t  robots[MAXROBOTS];
static discus_t discus[MAXDISCUS];
static int      playerprefdirs[4] = {0, 1, 2, 3};
static int      playerdirchanged = 0;

static int numrobots = 0;
static int numdiscus = 0;

static int r2t(int r)
{
	return (r-HALFTILE)/TILE_SIZE;
}


static void object_invalidate(robot_t *obj)
{
	int l, r, t, b;

	l = obj->realx - HALFTILE;
	r = l + TILE_SIZE - 1;
	t = obj->realy - HALFTILE;
	b = t + TILE_SIZE - 1;

	/* invalidate the tiles under this object */
	needsredrawing[t/TILE_SIZE][l/TILE_SIZE] = 1;
	needsredrawing[t/TILE_SIZE][r/TILE_SIZE] = 1;
	needsredrawing[b/TILE_SIZE][l/TILE_SIZE] = 1;
	needsredrawing[b/TILE_SIZE][r/TILE_SIZE] = 1;
	/* this is more generic than it needs to be */
}

static void updatedisplay(void)
{
	int i, j;

	for (i = 0; i < WIDTH;  i++)
	for (j = 0; j < HEIGHT; j++)
	{
		if (needsredrawing[j][i])
		{
			puttile(i*TILE_SIZE, j*TILE_SIZE, gamefield[j][i]);
			needsredrawing[j][i] = 0;
		}
	}

	for (i = 0; i < numrobots; i++)
		if (robots[i].valid)
			puttile(
				robots[i].realx-HALFTILE,
				robots[i].realy-HALFTILE,
				T_ROBOT
			);

	for (i = 0; i < numdiscus; i++)
	{
		if (!discus[i].valid)
			continue;

		if (discus[i].direction == D_UP
			|| discus[i].direction == D_DOWN)
		{
			puttile(
				discus[i].realx-HALFTILE,
				discus[i].realy-HALFTILE,
				T_DISCUS_V
			);
		}
		else
		{
			puttile(
				discus[i].realx-HALFTILE,
				discus[i].realy-HALFTILE,
				T_DISCUS_H
			);
		}
	}

	if (ball.valid)
		puttile(
			ball.realx-HALFTILE,
			ball.realy-HALFTILE,
			T_BALL
		);
	updatescreen();
}

static void dirpref_movetotop(int pref)
{
	int occurrence;
	int i;

	/* find where the new preference was in the list */
	for (occurrence = 0; occurrence < 3; occurrence++)
		if (playerprefdirs[occurrence] == pref)
			break;

	/* move the unpreferred directions down */
	for (i = occurrence; i > 0; i--)
		playerprefdirs[i] = playerprefdirs[i-1];

	playerprefdirs[0] = pref;
}

static void robot_add(int tilex, int tiley)
{
	if (numrobots == MAXROBOTS)
		error("Too many robots");

	robots[numrobots].tilex = tilex;
	robots[numrobots].tiley = tiley;
	robots[numrobots].realx = tilex*TILE_SIZE + HALFTILE;
	robots[numrobots].realy = tiley*TILE_SIZE + HALFTILE;
	robots[numrobots].direction = 0;
	robots[numrobots].valid = 1;
	numrobots++;
}

static void robot_destroy(int robotnum)
{
	object_invalidate(&robots[robotnum]);
	robots[robotnum].valid = 0;
	if (robotnum == numrobots-1)
		while (numrobots > 0 && !robots[numrobots-1].valid)
			numrobots--;
	playsfx(SFX_ROBOT);
}

static int robot_canmove(int robotnum, int dir)
{
	int rx, ry;
	int tx, ty;
	int i;

	rx = robots[robotnum].realx;
	ry = robots[robotnum].realy;

	/* can't move one way when between two tiles the other */
	if ((dir == D_DOWN || dir == D_UP)
		&& rx % TILE_SIZE != HALFTILE)
	{
		return 0;
	}
	if ((dir == D_RIGHT || dir == D_LEFT)
		&& ry % TILE_SIZE != HALFTILE)
	{
		return 0;
	}

	if (dir == D_DOWN)
		ry += MOVEFACTOR;
	else if (dir == D_UP)
		ry -= MOVEFACTOR;
	else if (dir == D_RIGHT)
		rx += MOVEFACTOR;
	else if (dir == D_LEFT)
		rx -= MOVEFACTOR;

	/* is it off the map? if so, that's no good */
	if (rx < HALFTILE || ry < HALFTILE
		|| rx >= TILE_SIZE*WIDTH  - HALFTILE
		|| ry >= TILE_SIZE*HEIGHT - HALFTILE)
	{
		return 0;
	}

	/* what tile does this put the robot in? is that tile floor? */
	if (dir == D_RIGHT)
		tx = r2t(rx+TILE_SIZE-1);
	else
		tx = r2t(rx);
	if (dir == D_DOWN)
		ty = r2t(ry+TILE_SIZE-1);
	else
		ty = r2t(ry);
	if (gamefield[ty][tx] != T_FLOOR)
		return 0; /* if it's a wall, you cannot move into it */

	/* check for collisions with other robots */
	for (i = 0; i < numrobots; i++)
	{
		if (!robots[i].valid || i == robotnum)
			continue;
		if (robots[i].realy+HALFTILE < ry-HALFTILE)
			continue;
		if (robots[i].realx+HALFTILE < rx-HALFTILE)
			continue;
		if (ry+HALFTILE < robots[i].realy-HALFTILE)
			continue;
		if (rx+HALFTILE < robots[i].realx-HALFTILE)
			continue;
		return 0; /* collision; move is no good */
	}

	return 1;
}

static void robot_updatedirection(int robotnum)
{
	int curdir;
	int opdir;
	int dirs[4];
	int i;

	curdir = robots[robotnum].direction; /* current direction */
	opdir = (curdir+2)%4;                /* opposite direction */

	dirs[3] = opdir;
	dirs[2] = (opdir+1)%4;
	dirs[1] = curdir;
	dirs[0] = (curdir+1)%4;

	for (i = 0; i < 2; i++)
	{
		int tmp, swap;
		swap = rnd(3-i) + i;
		tmp = dirs[swap];
		dirs[swap] = dirs[i];
		dirs[i] = tmp;
	}

	for (i = 0; i < 4; i++)
	{
		if (robot_canmove(robotnum, dirs[i]))
		{
			robots[robotnum].direction = dirs[i];
			return;
		}
	}
}

static void robot_move(int robotnum)
{
	int rx, ry;
	int tx, ty;
	int dir;

	if (!robot_canmove(robotnum, robots[robotnum].direction))
		return;

	rx  = robots[robotnum].realx;
	ry  = robots[robotnum].realy;
	dir = robots[robotnum].direction;

	object_invalidate(&robots[robotnum]);

	if (dir == D_DOWN)
		ry += MOVEFACTOR;
	else if (dir == D_UP)
		ry -= MOVEFACTOR;
	else if (dir == D_RIGHT)
		rx += MOVEFACTOR;
	else if (dir == D_LEFT)
		rx -= MOVEFACTOR;

	tx = r2t(rx);
	ty = r2t(ry);

	robots[robotnum].realx = rx;
	robots[robotnum].realy = ry;
	robots[robotnum].tilex = tx;
	robots[robotnum].tiley = ty;

	object_invalidate(&robots[robotnum]);
}

static void discus_add(int realx, int realy, int direction)
{
	if (numdiscus == MAXDISCUS)
		error("Too many discuses");

	discus[numdiscus].tilex = r2t(realx);
	discus[numdiscus].tiley = r2t(realy);
	discus[numdiscus].realx = realx;
	discus[numdiscus].realy = realy;
	discus[numdiscus].direction = direction;
	discus[numdiscus].valid = 1;

	object_invalidate((robot_t*) &discus[numdiscus]);
	numdiscus++;
}

static void discus_throw(void)
{
	int rx, ry;
	int tx, ty;
	int dir;
	int i;

	rx  = ball.realx;
	ry  = ball.realy;
	dir = ball.direction;

	if (dir == D_DOWN)
		ry += TILE_SIZE;
	else if (dir == D_UP)
		ry -= TILE_SIZE;
	else if (dir == D_RIGHT)
		rx += TILE_SIZE;
	else if (dir == D_LEFT)
		rx -= TILE_SIZE;

	/* is it off the map? if so, that's no good */
	if (rx < HALFTILE || ry < HALFTILE
		|| rx >= TILE_SIZE*WIDTH  - HALFTILE
		|| ry >= TILE_SIZE*HEIGHT - HALFTILE)
	{
		return;
	}

	/* what tile does this put the discus in? is that tile floor? */
	if (dir == D_RIGHT)
		tx = r2t(rx+TILE_SIZE-1);
	else
		tx = r2t(rx);
	if (dir == D_DOWN)
		ty = r2t(ry+TILE_SIZE-1);
	else
		ty = r2t(ry);
	if (gamefield[ty][tx] != T_FLOOR)
		return; /* if it's a wall, you cannot move into it */

	for (i = 0; i < numrobots; i++)
	{
		if (!robots[i].valid)
			continue;
		if (robots[i].realy+HALFTILE < ry-HALFTILE)
			continue;
		if (robots[i].realx+HALFTILE < rx-HALFTILE)
			continue;
		if (ry+HALFTILE < robots[i].realy-HALFTILE)
			continue;
		if (rx+HALFTILE < robots[i].realx-HALFTILE)
			continue;
		robot_destroy(i);
		return;
	}

	discus_add(rx, ry, dir);
	playsfx(SFX_DISCUS);
}

static void discus_destroy(int discusnum)
{
	object_invalidate((robot_t*) &discus[discusnum]);
	discus[discusnum].valid = 0;
	if (discusnum == numdiscus-1)
		while (numdiscus > 0 && !discus[numdiscus-1].valid)
			numdiscus--;
}

static int discus_trymove(int discusnum, int dir)
{
	int rx, ry;
	int tx, ty;
	int i;

	rx = discus[discusnum].realx;
	ry = discus[discusnum].realy;

	if (dir == D_DOWN)
		ry += DISCUSMOVE;
	else if (dir == D_UP)
		ry -= DISCUSMOVE;
	else if (dir == D_RIGHT)
		rx += DISCUSMOVE;
	else if (dir == D_LEFT)
		rx -= DISCUSMOVE;

	/* is it off the map? if so, that's no good */
	if (rx < HALFTILE || ry < HALFTILE
		|| rx >= TILE_SIZE*WIDTH  - HALFTILE
		|| ry >= TILE_SIZE*HEIGHT - HALFTILE)
	{
		return 0;
	}

	/* what tile does this put the discus in? is that tile floor? */
	if (dir == D_RIGHT)
		tx = r2t(rx+TILE_SIZE-1);
	else
		tx = r2t(rx);
	if (dir == D_DOWN)
		ty = r2t(ry+TILE_SIZE-1);
	else
		ty = r2t(ry);
	if (gamefield[ty][tx] != T_FLOOR)
		return 0; /* if it's a wall, you cannot move into it */

	/* check for collisions with robots */
	for (i = 0; i < numrobots; i++)
	{
		if (!robots[i].valid)
			continue;
		if (robots[i].realy+HALFTILE < ry-HALFTILE)
			continue;
		if (robots[i].realx+HALFTILE < rx-HALFTILE)
			continue;
		if (ry+HALFTILE < robots[i].realy-HALFTILE)
			continue;
		if (rx+HALFTILE < robots[i].realx-HALFTILE)
			continue;
		robot_destroy(i); /* die, stupid bitch */
		return 0;         /* but now I have to die too :( */
	}

	return 1;
}

static void discus_moveordie(int discusnum)
{
	int rx, ry;
	int tx, ty;
	int dir;

	if (!discus_trymove(discusnum, discus[discusnum].direction))
	{
		discus_destroy(discusnum);
		return;
	}

	rx  = discus[discusnum].realx;
	ry  = discus[discusnum].realy;
	dir = discus[discusnum].direction;

	object_invalidate((robot_t*) &discus[discusnum]);

	if (dir == D_DOWN)
		ry += DISCUSMOVE;
	else if (dir == D_UP)
		ry -= DISCUSMOVE;
	else if (dir == D_RIGHT)
		rx += DISCUSMOVE;
	else if (dir == D_LEFT)
		rx -= DISCUSMOVE;

	tx = r2t(rx);
	ty = r2t(ry);

	discus[discusnum].realx = rx;
	discus[discusnum].realy = ry;
	discus[discusnum].tilex = tx;
	discus[discusnum].tiley = ty;

	object_invalidate((robot_t*) &discus[discusnum]);
}

static int ball_canmove(int dir)
{
	int rx, ry;
	int tx, ty;
	int i;

	if (!ball.valid)
		return 0;

	rx = ball.realx;
	ry = ball.realy;

	/* can't move one way when between two tiles the other */
	if ((dir == D_DOWN || dir == D_UP)
		&& rx % TILE_SIZE != HALFTILE)
	{
		return 0;
	}
	if ((dir == D_RIGHT || dir == D_LEFT)
		&& ry % TILE_SIZE != HALFTILE)
	{
		return 0;
	}

	if (dir == D_DOWN)
		ry += MOVEFACTOR;
	else if (dir == D_UP)
		ry -= MOVEFACTOR;
	else if (dir == D_RIGHT)
		rx += MOVEFACTOR;
	else if (dir == D_LEFT)
		rx -= MOVEFACTOR;

	/* is it off the map? if so, that's no good */
	if (rx < HALFTILE || ry < HALFTILE
		|| rx >= TILE_SIZE*WIDTH  - HALFTILE
		|| ry >= TILE_SIZE*HEIGHT - HALFTILE)
	{
		return 0;
	}

	/* what tile does this put the ball in? is that tile floor? */
	if (dir == D_RIGHT)
		tx = r2t(rx+TILE_SIZE-1);
	else
		tx = r2t(rx);
	if (dir == D_DOWN)
		ty = r2t(ry+TILE_SIZE-1);
	else
		ty = r2t(ry);
	if (gamefield[ty][tx] != T_FLOOR)
		return 0; /* if it's a wall, you cannot move into it */

	for (i = 0; i < numrobots; i++)
	{
		if (!robots[i].valid)
			continue;
		if (robots[i].realy+HALFTILE < ry-HALFTILE)
			continue;
		if (robots[i].realx+HALFTILE < rx-HALFTILE)
			continue;
		if (ry+HALFTILE < robots[i].realy-HALFTILE)
			continue;
		if (rx+HALFTILE < robots[i].realx-HALFTILE)
			continue;
		object_invalidate((robot_t*) &ball);
		ball.valid = 0;
		return 0;
	}

	return 1;
}

static void ball_updatedirection(void)
{
	int i;
	int opdir;
	int prefdirs[4];

	/* copy the prefdirs so as to work on them */
	for (i = 0; i < 4; i++)
		prefdirs[i] = playerprefdirs[i];

	/* only move in the opposite direction as a last resort */
	opdir = (ball.direction+2)%4;
	if (prefdirs[0] == opdir)
	{
		prefdirs[0] = prefdirs[1];
		prefdirs[1] = opdir;
	}
	if (prefdirs[1] == opdir)
	{
		prefdirs[1] = prefdirs[2];
		prefdirs[2] = opdir;
	}
	if (prefdirs[2] == opdir)
	{
		prefdirs[2] = prefdirs[3];
		prefdirs[3] = opdir;
	}

	for (i = 0; i < 4; i++)
	{
		if (ball_canmove(prefdirs[i]))
		{
			if (prefdirs[i] != ball.direction)
				playerdirchanged = 1;
			ball.direction = prefdirs[i];
			return;
		}
	}
}

static void ball_move(void)
{
	int rx, ry;
	int tx, ty;
	int dir;

	if (!ball_canmove(ball.direction))
	{
		playerdirchanged = 0;
		return;
	}

	rx = ball.realx;
	ry = ball.realy;
	dir = ball.direction;

	object_invalidate((robot_t*) &ball); /* old location */

	if (dir == D_DOWN)
		ry += MOVEFACTOR;
	else if (dir == D_UP)
		ry -= MOVEFACTOR;
	else if (dir == D_RIGHT)
		rx += MOVEFACTOR;
	else if (dir == D_LEFT)
		rx -= MOVEFACTOR;

	tx = r2t(rx);
	ty = r2t(ry);

	ball.realx = rx;
	ball.realy = ry;
	ball.tilex = tx;
	ball.tiley = ty;

	object_invalidate((robot_t*) &ball); /* new location */

	if (playerdirchanged)
	{
		playerdirchanged = 0;
		dirpref_movetotop(dir);
		discus_throw();
	}
}

static void loadlevel(int levelnum)
{
	int i, j;
	int meta;

	levelnum--;
	meta      = levelnum / numlevels;
	levelnum %= numlevels;

	numrobots         = 0;
	numdiscus         = 0;
	playerdirchanged  = 0;
	playerprefdirs[0] = 0;
	playerprefdirs[1] = 1;
	playerprefdirs[2] = 2;
	playerprefdirs[3] = 3;

	for (i = 0; i < WIDTH;  i++)
	for (j = 0; j < HEIGHT; j++)
	{
		int tiletype;

		tiletype = gamemap[levelnum][j][i];

		if (strchr(".#$*12345", tiletype) == NULL)
			error("Table is inconsistent");

		if (tiletype == '*') /* ball */
		{
			ball.tilex = i;
			ball.tiley = j;
			ball.realx = i*TILE_SIZE + HALFTILE;
			ball.realy = j*TILE_SIZE + HALFTILE;
			ball.direction = 0;
			ball.valid = 1;
			tiletype = T_FLOOR;
		}
		else if (tiletype == '$' /* robot */

			/* or a robot on a harder metalevel */
			|| (tiletype >= '1' && tiletype <= '5'
			&& meta >= tiletype - '0'))
		{
			robot_add(i, j);
			tiletype = T_FLOOR;
		}
		else if (tiletype == '#') /* wall */
			tiletype = T_WALL;
		else
			tiletype = T_FLOOR;

		gamefield[j][i] = (char) tiletype;
		needsredrawing[j][i] = 1;
	}
}

static void discusiterate(void (*func)(int))
{
	int i;
	for (i = 0; i < numdiscus; i++)
		if (discus[i].valid)
			func(i);
}

static void robotiterate(void (*func)(int))
{
	int i;
	for (i = 0; i < numrobots; i++)
		if (robots[i].valid)
			func(i);
}

int playgame(void)
{
	Uint32 starttime;
	int timer;
	int frameskip = 0;
	static int lev = 1;
	static int lives = STARTLIVES;

	loadlevel(lev);

	clearscreen();
	panel_displaytext(0, "LEVEL %d", lev);
	panel_displaylives(lives);
	updatedisplay();

	timer_start();
	resetinput();
	starttime = SDL_GetTicks();
	timer = 1000;

	while (ball.valid && numrobots > 0 && timer > 0)
	{
		int keys;
		int newtimer;

		/* getinput() can pause, so don't run the timer for it */
		newtimer = SDL_GetTicks();
		keys = getinput();
		starttime += SDL_GetTicks() - newtimer;

#ifdef CHEAT
		if (keys == 10000)
		{
			keys = 0;
			if (numrobots)
				robot_destroy(numrobots - 1);
		}
#endif

		/* if player pressed escape, return to title */
		if (keys < 0)
		{
			lev = 1;
			lives = STARTLIVES;
			return -1;
		}

		if (keys & KEY_UP)
			dirpref_movetotop(D_UP);
		if (keys & KEY_DOWN)
			dirpref_movetotop(D_DOWN);
		if (keys & KEY_LEFT)
			dirpref_movetotop(D_LEFT);
		if (keys & KEY_RIGHT)
			dirpref_movetotop(D_RIGHT);

		ball_updatedirection();
		robotiterate(robot_updatedirection);

		ball_move();
		robotiterate(robot_move);
		discusiterate(discus_moveordie);

		newtimer = (int) (TIMELIMIT - (SDL_GetTicks()-starttime)/1000);
		if (newtimer != timer)
		{
			panel_displaytext(1, "%d", newtimer);
			timer = newtimer;
			if (timer <= 10 && timer > 0)
				playsfx(SFX_TICK);
		}

		if (frameskip)
			frameskip--;
		else
		{
			updatedisplay();
			frameskip = time_wait();
		}
	}

	if (timer == 0)
	{
		playsfx(SFX_TIMEUP);
		lives--;
		if (lives == 0)
		{
			lev = 1;
			lives = STARTLIVES;
			return -1;
		}
		return 0;
	}

	if (!ball.valid)
	{
		playsfx(SFX_BALL);
		lives--;
		if (lives == 0)
		{
			lev = 1;
			lives = STARTLIVES;
			return -1;
		}
		return 0;
	}

	lev++;
	lives += factors(lev) - 1;
	if (lives > 45)
		lives = 45;
	return timer;
}
