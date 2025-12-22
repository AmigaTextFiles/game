/************************************************************************/
/************************************************************************/
/*																		*/
/*							Dungeon Drawing Code						*/
/*																		*/
/************************************************************************/
/************************************************************************/

#include "aklabeth.h"

static void _DDRAWCalcRect(RECT *,double);

/************************************************************************/
/*																		*/
/*							Draw the dungeon							*/
/*																		*/
/************************************************************************/

void DDRAWDraw(PLAYER *p,DUNGEONMAP *d)
{
	double Level = 0;
	int xWidth = 1279;
	int yWidth = 1023;
	RECT rOut,rIn;
	COORD Dir,Pos,Next;
	int Monster,Front,Left,Right;
	DRAWSetRect(&rOut,0,1023,1260,10);
	_DDRAWCalcRect(&rOut,0);
	Pos = p->Dungeon;						/* Get position */
	do
	{
		Level++;							/* Next level */
		_DDRAWCalcRect(&rIn,Level);
		Next.x = Pos.x + p->DungDir.x;		/* Next position */
		Next.y = Pos.y + p->DungDir.y;

		Dir = p->DungDir;MOVERotLeft(&Dir);	/* To the left */
		Left = d->Map[Pos.x+Dir.x][Pos.y+Dir.y];
		MOVERotLeft(&Dir);MOVERotLeft(&Dir);/* To the right */
		Right = d->Map[Pos.x+Dir.x][Pos.y+Dir.y];
		Front = d->Map[Next.x][Next.y];		/* What's in front ? */

		Monster = DDRAWFindMonster(d,&Pos);	/* Find ID of monster here */
		if (Monster >= 0)					/* Find Type if Found */
			{
			Monster = d->Monster[Monster].Type;
			}
		DRAWDungeon(&rOut,&rIn,				/* Draw the dungeon */
					Left,Front,Right,
					d->Map[Pos.x][Pos.y],Monster);

		Pos = Next;							/* Next position down */
		rOut = rIn;							/* Last in is new out */
	}
	while (Level < MAX_VIEW_DEPTH && ISDRAWOPEN(Front));
}

/************************************************************************/
/*																		*/
/*					Calculate display rectangle							*/
/*																		*/
/************************************************************************/

static void _DDRAWCalcRect(RECT *r,double Level)
{
	int xWidth,yWidth;
	xWidth = (int)						/* Calculate frame size */
					(atan(1.0/(Level+1))/atan(1.0)*1279+0.5);
	xWidth = 1279/(Level+1);
	yWidth = xWidth * 10/13;
	r->left = 640-xWidth/2;			/* Calculate drawing rectangle */
	r->right = 640+xWidth/2;
	r->top = 512+yWidth/2;
	r->bottom = 512-yWidth/2;
}

/************************************************************************/
/*																		*/
/*					Find Monster ID at given location					*/
/*																		*/
/************************************************************************/

int DDRAWFindMonster(DUNGEONMAP *d,COORD *c)
{
	int i,n = -1;
	for (i = 0;i < d->MonstCount;i++)
			if (c->x == d->Monster[i].Loc.x &&
				c->y == d->Monster[i].Loc.y &&
				d->Monster[i].Alive != 0) n = i;
	return n;
}
