/************************************************************************/
/************************************************************************/
/*																		*/
/*					  Dungeon Create and Draw Code						*/
/*																		*/
/************************************************************************/
/************************************************************************/

#include "aklabeth.h"

static int _DUNGEONContents(int);
static void _DUNGEONAddMonster(DUNGEONMAP *,PLAYER *,int);

/************************************************************************/
/*																		*/
/*							Create Dungeon Level						*/
/*																		*/
/************************************************************************/

void DUNGEONCreate(PLAYER *p,DUNGEONMAP *d)
{
	int i,n,x,y,Size;

	srand(p->LuckyNumber - p->World.x*40 -	/* Seed the random number */
									p->World.y * 1000 - p->Level);
	Size=MAINSuper()?DUNGEON_MAP_SIZE-1:10;	/* Calculate map size */
	d->MapSize = Size;						/* Save the map size */

	for (x = 0;x < Size;x++)        		/* Clear the dungeon */
		for (y = 0;y < Size;y++)
			d->Map[x][y] = DT_SPACE;

	for (x = 0;x <= Size;x++)				/* Draw the boundaries */
	{
		d->Map[Size][x] = DT_SOLID;
		d->Map[0][x] = DT_SOLID;
		d->Map[x][Size] = DT_SOLID;
		d->Map[x][0] = DT_SOLID;
	}
	for (x = 2;x < Size;x = x+2)			/* Fill with checkerboard */
		for (y = 1;y < Size;y++)
		{
		d->Map[x][y] = DT_SOLID;
		d->Map[y][x] = DT_SOLID;
		}
	for (x = 2;x < Size;x = x+2)			/* Fill with stuff */
		for (y = 1;y < Size;y = y+2)
		{
			d->Map[x][y] = _DUNGEONContents(d->Map[x][y]);
			d->Map[y][x] = _DUNGEONContents(d->Map[y][x]);
		}

		d->Map[2][1] = DT_SPACE;			/* Put stairs in */
		if (p->Level % 2 == 0)				/* Different ends each level */
		{
			d->Map[Size-3][3] = DT_LADDERDN;
			d->Map[3][Size-3] = DT_LADDERUP;
		}
		else
		{
			d->Map[Size-3][3] = DT_LADDERUP;
			d->Map[3][Size-3] = DT_LADDERDN;
		}

		if (p->Level == 1)					/* On first floor */
		{
			d->Map[1][1] = DT_LADDERUP;		/* Ladder at top left */
			d->Map[Size-3][3] = DT_SPACE;	/* No other ladder up */
		}

		d->MonstCount = 0;					/* No monsters */
		n = MAINSuper() ? MAX_MONSTERS:10;	/* How many might there be ? */
		for (i = 1;i <= n;i++)				/* Go through the monsters */
				_DUNGEONAddMonster(d,p,i);	/* Maybe adding them as you go */
}

/************************************************************************/
/*																		*/
/*							Generate some contents						*/
/*																		*/
/************************************************************************/

static int _DUNGEONContents(int c)
{
	if (RND() > .95) 	c= DT_TRAP;
	if (RND() > .6) 	c= DT_HIDDENDOOR;
	if (RND() > .6) 	c= DT_DOOR;
	if (RND() > .97) 	c= DT_PIT;
	if (RND() > .94) 	c= DT_GOLD;
	return c;
}

/************************************************************************/
/*																		*/
/*					Maybe add a monster of the given type				*/
/*																		*/
/************************************************************************/

static void _DUNGEONAddMonster(DUNGEONMAP *d,PLAYER *p,int Type)
{
	MONSTER *m;
	int x,y;
	int Level = GLOMonsterLevel(Type);		/* Read the level */

	if (Level - 2 > p->Level) return;		/* Limit monsters to levels */
	if (RND() > 0.4) return;				/* Not always there anyway */

	m = &(d->Monster[(d->MonstCount)++]);	/* Get monster record */

	m->Type = Type;							/* Fill in details */
	m->Strength = Level + 3 + p->Level;
	m->Alive = 1;

	do  									/* Find a place for it */
	{
		x = rand() % d->MapSize;
		y = rand() % d->MapSize;
	} while (d->Map[x][y] != DT_SPACE ||   	/* Must be empty, not player */
			 (x == p->Dungeon.x && y == p->Dungeon.y));

	m->Loc.x = x;m->Loc.y = y;				/* Record position */
}



