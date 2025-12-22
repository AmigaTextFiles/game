#ifndef DYNAMITE_H
#define DYNAMITE_H
/*
**	$VER: dynamite.h 40.0 (3.6.2001)
**
*/

#ifndef EXEC_NODES_H
#include <exec/nodes.h>
#endif /* EXEC_NODES_H */

#ifndef EXEC_LISTS_H
#include <exec/lists.h>
#endif /* EXEC_LISTS_H */

#ifndef EXEC_SEMAPHORES_H
#include <exec/semaphores.h>
#endif /* EXEC_SEMAPHORES_H */


/* player->status */
#define PA_NONE 0      /* no player */
#define PA_VISI 1      /* visitor */
#define PA_LOGGEDIN 2  /* just logged in/after a game */
#define PA_PLAYING 3   /* is in game (no matter if he's dead) */
#define PA_COUNTDOWN 4 /* this is of no use. players only have this status if they logged in. */
#define PA_DEAD 5      /* this is of no use, it's not meant to see if a player is */
		       /* actually dead.  use player.dead instead.  it's only set */
		       /* after a successfull login for the other players */
#define PA_WON 6       /* a player has this status if he won the last round */

/* dynasema->gamerunning */
#define	GAME_NOTCONNECTED 0 /* game is not connected (startscreen) */
#define GAME_CLOSEGAME 1    /* transitional state to GAME_MENU after connection got closed */
#define GAME_MENU 2        /* game is in menu eg: login screen */
#define GAME_ENDGAME 3     /* transitional state to GAME_MENU after effect has been drawn */
#define GAME_EFFECT 4      /* game draws effect after a match */
#define GAME_COUNTDOWN 5   /* game is doing the countdown */
#define GAME_GAME 6        /* game is running */
#define GAME_HURRYUP 7     /* game is running and is in hurry up mode */

#define DIR_NONE	-1
#define DIR_DOWN	0
#define DIR_RIGHT	1
#define DIR_LEFT	2
#define DIR_UP		3

#define SPEED_NORMAL	4
#define SPEED_SLOW	3
#define SPEED_FAST	6

#define BLOCK_FAKEBLOCK		-1	/* used for remote/kick bombs which are placed into the map */
#define BLOCK_NOBLOCK		0	/* empty field */
#define BLOCK_HARDBLOCK		1	/* non-destroyable block */
#define BLOCK_DESTROYABLE	2	/* destroyable block */
#define BLOCK_BOMB		3	/* normal bomb */
#define BLOCK_BORDERWALL1	4	/* borderblocks are equal to hardblock */
#define BLOCK_BORDERWALL2	5
#define BLOCK_BORDERWALL3	6
#define BLOCK_BORDERWALL4	7
#define BLOCK_BORDERWALL5	8
#define BLOCK_BORDERWALL6	10
#define BLOCK_BORDERWALL7	11
#define BLOCK_BORDERWALL8	12
#define BLOCK_BORDERWALL9	13
#define BLOCK_BORDERWALL10	14
#define BLOCK_BORDERWALL11	15
#define BLOCK_BORDERWALL12	16

#define BLOCK_ADDBOMB	19	/* block which contains a bomb */

#define BO_EXPANDFLAME	1	/* types for bonusgrid */
#define BO_ADDBOMB	2
#define BO_FLAMEMAX	3
#define BO_BOMBMAX	4
#define BO_RANDOMWALL	5
#define BO_BOMBS2BLOCKS	6
#define BO_DROPALL	7
#define BO_EXPLALL	8
#define BO_FASTER	9
#define BO_SLOWER	10
#define BO_SHORTERFUSE	11
#define BO_LONGERFUSE	12
#define BO_SHORTERFLAME	13
#define BO_SWAPCONTROLSRL	14
#define BO_FEWERBOMBS	15
#define BO_NODROP	16
#define BO_SHIELD	17
#define BO_STANDSTILL	18
#define BO_TELEPORT	19
#define BO_REMOTEBOMB	20
#define BO_BACK2BASIC	21
#define BO_KICKBOMB	22
#define BO_SABER	23
#define BO_SWAPCONTROLSUD	24
#define BO_MAGNET	25
#define BO_PHOENIX	26
#define BO_DOHURRYUP	27
#define BO_INVISIBLE	28
#define BO_DUELL	29
#define BO_AFTERBURNER	30
#define BO_FLAG			31
#define BO_TELEPORTALL		32
#define BO_MAPJUMP		33
#define BO_RESTARTMAP		34
#define BO_SWAPPOSITIONS	35
#define BO_MAX			36

#define BOMB_NORMAL	0	/* normal bomb */
#define BOMB_GEN		1	/* predefinend bomb */
#define BOMB_REMOTE	2	/* remote bomb */
#define BOMB_KICK		3	/* kick bomb */

struct serverdata {
  char servername[34]; /* name of the server */
  char sysopname[18];  /* name of the sysop */
  WORD maxslots;       /* how many players allows this server */
  WORD maxobservers;   /* how many observers allows this server */
};

struct tempbomb {
	struct	MinNode ln;
	WORD	x;		/* x blockpos */
	WORD	y;		/* y blockpos */
	WORD	x1;		/* x pos (pixel) */
	WORD	y1;		/* y pos (pixel) */
	WORD	fuse;		/* >0 bomb is still ticking, =0 bomb is going to explode */
	LONG	range;		/* flamlength */
	WORD	dir;		/* in case of kick/remote bomb holds the direction */
	WORD	originx;	/* holds the x/y pos (block) where the bomb was placed */
	WORD	originy;	/* (useful to find kick/remotebombs) */
	WORD	type;		/* is set to one of BOMB_#? */
};

struct player {
	WORD	num;
	LONG	status;
	WORD	dead;
	WORD	x;			/* xpos (pixel) + border (24 pixel) */
	WORD	y;			/* ypos (pixel) + border (16 pixel) */
	WORD	px;			/* xpos (block number) */
	WORD	py;			/* ypos (block number) */

	WORD	bombc;			/* how many bombs this player has currently ticking */
	WORD	maxkickbombs;		/* how many kickbombs this player has */
	struct	tempbomb *remotebomb;	/* pointer to a bomb of bomblist which is his remotebomb else 0 */

	WORD	maxrange;	/* flamelen of player ranging from 2 to 15 */
	WORD	maxbombs;	/* how many bombs this player can drop */
	WORD	fuselen;	/* fuselength of bombs the player can drop */
	WORD	speed;		/* player speed; SPEED_NORMAL=4, SPEED_SLOW=3, SPEED_FAST=6 */
	WORD	speedc;		/* >0 = player has other speed (SPEED_SLOW, SPEED_FAST) */

	WORD	swaprlc;	/* >0 = swaped horizontal controls */
	WORD	swapudc;	/* >0 = swaped vertical controls */
	WORD	nodropc;	/* >0 = player can't drop bombs */

	WORD	shieldc;	/* >0 = player has shield */

	WORD	standstillc;	/* >0 = player can't move */

	WORD	invisiblec;	/* >0 = player is invisible */

	WORD	afterburnerc;	/* >0 = player has afterburner */

	WORD	b2bc;

	WORD	flamethrowerc;	/* >0 = player has lightsabre */
	WORD	flamethrowerdir;	/* direction of lightsabre */
	WORD	flamethrowerr;	/* range of light sabre */

	WORD	magnetc;	/* >0 = this player has magnet enabled */
	WORD	magnetdir;	/* direction of magnet */

	char	name[34];	/* players name */
	char	system[64];	/* players systemstring */

  WORD  dir; /* players direction */

  WORD tag; /* this player has tag */
  WORD tagc; /* remaining time until he dies if he has tag */
};

struct dynamitesemaphore {
	struct	SignalSemaphore sema;	/* embedded signalsemaphore */
	LONG	opencnt;	/* you must increase this by 1 if you are going to use the */
				/* semaphore the first time. decrease it by 1 if you are done */

	LONG	quit;		/* dynamite will set this to 1 if it wants to quit.  Check this */
				/* from time to time and end your program if quit gets set to 1 */

	LONG	gamerunning; /* is set to one of GAME_#? */

	LONG	frames;		/* once a game is running this long will be increased by 1 */
				/* every frame. */

	LONG	walk;		/* set to one of DIR_ to make the player move or stop */
	LONG	drop;		/* set to 1 to drop a bomb */
	LONG	dropkick;	/* set to 1 to drop a kickbomb */

	LONG	thisplayer;	/* number of this player in playerarray (>7 = observer) */
	struct	player *players[16];		/* array ptr of players (15 entries max; >7 = observer) */

	LONG	mapwidth;	/* holds the width of the map in blocks */
	LONG	mapheight;	/* holds the height of the map in blocks */

	APTR	grid;		/* array ptr to the actual map (29 entries max). each entry contains 1 line of the map without powerups */
	APTR	bonusgrid;	/* array ptr to the bonus map (29 entries max). each entry contains 1 line of the bonusmap */

	char	*addbubble; /* setting this pointer to a string will make dynamite */
		  /* show the string given here as bubble.  dynamite will */
		  /* reset this pointer to 0 after successfull creation of */
		  /* the bubble */

	struct serverdata *serverdata; /* see serverdata for details */

	APTR explosiongrid; /* array ptr to the explosion map (29 entries max). each entry contains 1 line of the explosion map */
		     /* this map reflects where currently explosions are (explosion=1) */
		     /* each element of line is CHAR sized */

	LONG version; /* holds the version of dynamite (e.g. 45) */

	APTR botinfo: /* pointer to an array of 255 (so 255 bots are supported
	       /* with this array) long pointers to hold a string */
	       /* (versioninfo, description) of your bot.  You should set */
	       /* the entry for your bot after opencnt has been increased */
	       /* by your bot and set it back to NULL if your bot is about */
	       /* to decrease the opencnt again on quit. */

	       /* entry for your bot in this array is opencnt after */
	       /* increasing (on botstartup, see example) */

	struct	MinList *bomblist;	/* doubly linked list of bombs belonging to this player */
};
#endif
