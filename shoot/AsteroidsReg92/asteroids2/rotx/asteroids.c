#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <stdio.h>
#include <math.h>
#include <h/rot.h>
#include <h/extern.h>


UpdateAsteroid(n)
LONG n;
{
LONG x;
LONG wi,he;

wi = id[il.asteroid[a[n].size]].wi;
he = id[il.asteroid[a[n].size]].he;

a[n].ox = a[n].x;
a[n].oy = a[n].y;

a[n].x += a[n].vx;
a[n].y += a[n].vy;

if (a[n].flag == LAST) return;

for(x=0;x<control.playernum;x++)
	if (ship[x].pilot != DESTROYED) CollisionAsteroidsShip(n,x,wi,he);

if (saucer.flag == TRUE) CollisionAsteroidsSaucer(n,wi,he);

if (a[n].x+wi/2 > gi.x2) a[n].x = gi.x1-wi/2;
if (a[n].x+wi/2 < gi.x1) a[n].x = gi.x2-wi/2;
if (a[n].y+he/2 > gi.y2) a[n].y = gi.y1-he/2;
if (a[n].y+he/2 < gi.y1) a[n].y = gi.y2-he/2;

a[n].rot += a[n].dir;
if (a[n].size == 2)
    {
	if (a[n].rot > 15) a[n].rot = 0;
	if (a[n].rot < 0)  a[n].rot = 15;
    }
else
if (a[n].size == 1)
    {
	if (a[n].rot > 31) a[n].rot = 0;
	if (a[n].rot < 0)  a[n].rot = 31;
    }
else
if (a[n].size == 0)
    {
	if (a[n].rot > 63) a[n].rot = 0;
	if (a[n].rot < 0)  a[n].rot = 63;
    }

todrawlist(il.asteroid[a[n].size]+a[n].rot,a[n].x,a[n].y,0xfd,1);
}


EraseAsteroids()
{
LONG x;

for (x=0;x<control.asteroidnum;x++)
	if (a[x].flag != FALSE)
	    {
		SetWrMsk(rp1[1-bit],0xfd);
		RectFill(rp1[1-bit],a[x].ox,a[x].oy,a[x].ox+45,a[x].oy+45);
		if (a[x].flag == LAST) a[x].flag = FALSE;
	    }
}


AsteroidExplosion(num,xx,yy)
LONG num,xx,yy;
{
LONG num2=-1,x;

makesound(2,2);
AllocateExplosion(xx,yy,5);

if (++a[num].size > 2)
    {
	a[num].flag = LAST;
    }
else
    {
	for(x=0;x<control.asteroidnum;x++)
		if (a[x].flag == FALSE)
		    {
			num2 = x;
			break;
		    }

	a[num2].x = a[num].x;
	a[num2].y = a[num].y;
	a[num2].size = a[num].size;
	a[num2].flag = TRUE;

	if (Random(100.0) > 50) 	a[num2].dir = 1;
	else					a[num2].dir = -1;

	a[num].vx += Random((DOUBLE)(2*(control.difficulty+2)))-(control.difficulty+2);
	a[num].vy += Random((DOUBLE)(2*(control.difficulty+2)))-(control.difficulty+2);

	while ((a[num].vx == 0) && (a[num].vy == 0))
	    {
		a[num].vx += Random(8.0)-4;
		a[num].vy += Random(8.0)-4;
	    }

	a[num2].vx = -a[num].vx;
	a[num2].vy = -a[num].vy;
    }
}
