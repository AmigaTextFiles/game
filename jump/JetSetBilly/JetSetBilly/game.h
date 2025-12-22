#ifndef _GAME_H
#define _GAME_H

#define TOP_EDGE		13

#define NO_OF_PLAYERS		 2
#define NO_OF_BOBS		18

/* Changing these might trash old map, itm or hi files */
/*=========================================*/
#define ROOM_YSIZE		11
#define ROOM_XSIZE		20
#define MAP_YSIZE		16
#define MAP_XSIZE		16
#define NO_OF_MONSTERS		(NO_OF_BOBS - 2)
#define NO_OF_ITEMS		2000
#define NO_OF_HISCORES		20
/*=========================================*/

struct JSBPlayer
{
	unsigned int	score;
	short		lives;
	unsigned short	items;
	unsigned short	jump, fall, slide, climb, swim;
	UBYTE		items_found[NO_OF_ITEMS];
};

struct HiScore
{
	char		name[26];
	unsigned int	score;
	short		lives;
	unsigned short	items;
	unsigned long	timeval;
};

struct Mobile
{
	unsigned short	shape;
	BYTE		PlanePick;
	BYTE		PlaneOnOff;
	BOOL		on;
	short		anim;
	short		x, y;
	short		xd, yd;
	short		xs, ys, xe, ye;
	short		delay;
	short		dead;
};

struct Item
	{
	unsigned short	shape;		/* Shape 0: unused item */
	unsigned short	rno;		/* Room */
	UBYTE		x, y;		/* Block */
	UBYTE		type, data;	/* Key/door/special datas */
};

/* Each room takes 274 bytes plus monster data (416), total 690 */
struct Room
{
	unsigned short	n;
	char		name[40];
	unsigned short	charset;
	unsigned short	flags;
	unsigned char	block[ROOM_YSIZE][ROOM_XSIZE];
	unsigned short	exits[4];
	struct Mobile	monsters[NO_OF_MONSTERS];
};

#define ITEM_TREASURE	(1)
#define ITEM_KEY	(1<<1)
#define ITEM_LOCK	(1<<2)

/* filerequest mode */
#define FR_SAVE		0x01
#define FR_LOAD		0x02

#endif /* _GAME_H */
