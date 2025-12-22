#include <exec/types.h>
#include <intuition/intuition.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/extern.h>


CollisionFireSaucer(n,x,xx,yy)
LONG n,x,xx,yy;
{
LONG wi,he;

if (saucer.flag == TRUE)
{
wi = id[saucer.image+saucer.rot].wi;
he = id[saucer.image+saucer.rot].he;

if ( (xx > saucer.x)    &&
	(xx < saucer.x+wi) &&
	(yy > saucer.y)    &&
	(yy < saucer.y+he))
	    {
		makesound(3,3);
		ship[n].shotI[x].flight = LAST;
		saucer.flag = LAST;
		if (ship[n].pilot == HUMAN)
		    {
			if (saucer.type == 0) IncreaseScore(n,500);
			else				  IncreaseScore(n,1500);
		    }
		AllocateDebris(xx+wi/2,yy+wi/2,control.standarddebris);
		AllocateExplosion(xx+wi/2,yy+he/2,7);
		AllocateBoxes(xx,yy,1);
	    }
}
}


CollisionFireAsteroids(n,x,xx,yy)
LONG n,x,xx,yy;
{
LONG y;
LONG wi,he;

for(y=0;y<control.asteroidnum;y++)
    {
	wi = id[il.asteroid[a[y].size]].wi;
	he = id[il.asteroid[a[y].size]].he;

	if (a[y].flag == TRUE)
	    {
		if (!((xx < a[y].x) || (xx > a[y].x+wi) ||
			 (yy < a[y].y) || (yy > a[y].y+he)))
			    {
				ship[n].shotI[x].flight = LAST;
				if (ship[n].pilot == HUMAN) IncreaseScore(n,50*(a[y].size+1));
				AsteroidExplosion(y,a[y].x+wi/2,a[y].y+he/2);
				break;
			    }
	    }
    }
}



CollisionFireFighters(n,x,xx,yy)
LONG n,x,xx,yy;
{
LONG y;

for(y=0;y<control.ftrnum;y++)
    {
	if (f[y].flight == TRUE)
	    {
		if ((xx > f[y].x) && (xx < f[y].x+id[il.fighter+f[y].pos/4].wi) &&
			(yy > f[y].y) && (yy < f[y].y+id[il.fighter+f[y].pos/4].he))
			    {
				ship[n].shotI[x].flight = LAST;
				if (ship[n].pilot == HUMAN) IncreaseScore(n,50);
				makesound(13,2);
				AllocateExplosion(xx,yy,5);
				f[y].flight = LAST;
				break;
			    }
	    }
    }
}

CollisionPhotonFighters(n,x)
LONG n,x;
{
LONG xx,yy,y;

xx = ship[n].photI[x].xp+2;
yy = ship[n].photI[x].yp+2;

for(y=0;y<control.ftrnum;y++)
    {
	if (f[y].flight == TRUE)
	    {
		if ((xx > f[y].x) && (xx < f[y].x+id[il.fighter+f[y].pos/4].wi) &&
		    (yy > f[y].y) && (yy < f[y].y+id[il.fighter+f[y].pos/4].he))
			    {
				if (ship[n].pilot == HUMAN) IncreaseScore(n,50);
				makesound(13,2);
				AllocateExplosion(xx,yy,5);
				f[y].flight = LAST;
				break;
			    }
	    }
    }
}


CollisionBattleshipFireShips(n,x,xx,yy)
LONG n,x,xx,yy;
{
LONG y,wi,he;

for(y=0;y<control.playernum;y++)
	if (ship[y].pilot != DESTROYED)
	    {
		wi = id[ship[y].image+ship[y].pos].wi;
		he = id[ship[y].image+ship[y].pos].he;
		if ( (xx > ship[y].x) && (xx < ship[y].x+wi) &&
			(yy > ship[y].y) &&	(yy < ship[y].y+he))
			    {
				bs[n].shotI[x].flight = LAST;
				Firehit(y,bs[n].fdam,7);
				break;
			    }
	    }
}


CollisionFireShips(n,x,xx,yy)
LONG n,x,xx,yy;
{
LONG y;
LONG wi,he;

for(y=0;y<control.maxenemynum+control.playernum;y++)
    {
	if ((ship[y].pilot != DESTROYED) && (n != y))
	if ((ship[y].pilot != ship[n].pilot) ||
	   ((control.playmode == 1) && (ship[y].pilot == HUMAN) && (ship[n].pilot == HUMAN)))
	    {
		wi = id[ship[y].image+ship[y].pos].wi;
		he = id[ship[y].image+ship[y].pos].he;
		if ( (xx > ship[y].x) && (xx < ship[y].x+wi) &&
			(yy > ship[y].y) &&	(yy < ship[y].y+he))
			    {
				ship[n].shotI[x].flight = LAST;

				if (ship[n].pilot == HUMAN)
				    {
					IncreaseScore(n,ship[y].pointvalue);
				    }
				Firehit(y,ship[n].fdam,7);
				break;
			    }
	    }
    }
}


CollisionPhotonShips(n,x)
LONG n,x;
{
LONG y;
LONG wi,he;

for(y=0;y<control.maxenemynum+control.playernum;y++)
    {
	if ((y == ship[n].aim) || (ship[n].pilot == HUMAN))
	if ((ship[y].pilot != DESTROYED) && (n != y))
	if ((ship[y].pilot != ship[n].pilot) ||
	   ((control.playmode == 1) && (ship[y].pilot == HUMAN) && (ship[n].pilot == HUMAN)))
	    {
		wi = id[ship[n].photI[x].image].wi;
		he = id[ship[n].photI[x].image].he;

		if ( (ship[n].photI[x].xp     < ship[y].x+id[ship[y].image].wi)  &&
			(ship[n].photI[x].xp+wi  > ship[y].x) 					&&
			(ship[n].photI[x].yp     < ship[y].y+id[ship[y].image].he)  &&
			(ship[n].photI[x].yp+he  > ship[y].y))
			    {
				ship[n].photI[x].flight = LAST;

				if (ship[n].pilot == HUMAN)
				    {
					IncreaseScore(n,ship[y].pointvalue);
				    }
				Firehit(y,ship[n].pdam,7);
				break;
			    }
	    }
    }
}



CollisionPhotonSaucer(n,x)
LONG n,x;
{
LONG xx,yy;
LONG wi,he;

if (saucer.flag == TRUE)
{
xx = ship[n].photI[x].xp;
yy = ship[n].photI[x].yp;
wi = id[ship[n].photI[x].image].wi;
he = id[ship[n].photI[x].image].he;

if ( (xx     < saucer.x+id[saucer.image].wi)  &&
	(xx+wi  > saucer.x)				      &&
	(yy     < saucer.y+id[saucer.image].he)  &&
	(yy+he  > saucer.y))
	    {
		ship[n].photI[x].flight = LAST;
		makesound(3,3);
		if (ship[n].pilot == HUMAN)
		    {
			if (saucer.type == 0) IncreaseScore(n,500);
			else				  IncreaseScore(n,1500);
		    }
		AllocateDebris(xx+wi/2,yy+wi/2,control.standarddebris);
		AllocateExplosion(xx+wi/2,yy+he/2,7);
		AllocateBoxes(xx+wi/2,yy+he/2,1);
		saucer.flag = LAST;
	    }
}
}

CollisionAsteroidsShip(n,x,wi,he)
LONG n,x,wi,he;
{
LONG offx,offy;

offx = wi/4;
offy = wi/4;

if ((a[n].x+wi-offx < ship[x].x) ||
    (a[n].x+offx    > ship[x].x+id[ship[x].image].wi) ||
    (a[n].y+he-offy < ship[x].y) ||
    (a[n].y+offy    > ship[x].y+id[ship[x].image].he))
		return;
else
    {
	DestroyShip(x);
	initInput(x);
    }
}

CollisionPhotonAsteroids(n,x)
LONG n,x;
{
LONG y;
LONG wi,he;
LONG wi2,he2;
LONG xx,yy;

xx = ship[n].photI[x].xp;
yy = ship[n].photI[x].yp;

for(y=0;y<control.asteroidnum;y++)
    {
	if (a[y].flag == TRUE)
	    {
		wi = id[ship[n].photI[x].image].wi;
		he = id[ship[n].photI[x].image].he;

		wi2 = id[il.asteroid[a[y].size]].wi;
		he2 = id[il.asteroid[a[y].size]].he;

		if ( (xx     < a[y].x+2*wi2/3) &&
			(xx+wi  > a[y].x+wi2/3)	 &&
			(yy     < a[y].y+2*he2/3) &&
			(yy+he  > a[y].y+he2/3))
			    {
				ship[n].photI[x].flight = LAST;
				if (ship[n].pilot == HUMAN) IncreaseScore(n,50*(a[y].size+1));
				AsteroidExplosion(y,a[y].x+id[il.asteroid[a[y].size]].wi/2,
								a[y].y+id[il.asteroid[a[y].size]].he/2);
				break;
			    }
	    }
    }
}





CollisionAsteroidsSaucer(n,wi,he)
LONG n,wi,he;
{
if ((a[n].x < saucer.x + wi -2) &&
    (a[n].x + id[il.asteroid[a[n].size]].wi > saucer.x +2) &&
    (a[n].y < saucer.y + he -2) &&
    (a[n].y + id[il.asteroid[a[n].size]].he > saucer.y +2))
	    {
		makesound(3,3);
		AllocateDebris(saucer.x+wi/2,saucer.y+he/2,control.standarddebris);
		AllocateExplosion(saucer.x+wi/2,saucer.y+he/2,7);
		saucer.flag = LAST;
	    }
}



Firehit(n,dam,len)
LONG n,dam,len;
{

if (n < control.playernum) IncreaseShields(n,-dam);
else ship[n].shield-=dam;

if (ship[n].shield < 0) DestroyShip(n);
else	makesound(8,0);

ship[n].shieldstat=len;
}


DestroyShip(n)
LONG n;
{
LONG xx,yy;

xx = ship[n].x+id[ship[n].image+ship[n].pos].wi/2;
yy = ship[n].y+id[ship[n].image+ship[n].pos].he/2;

AllocateExplosion(xx,yy,7);
AllocateDebris(xx,yy,control.standarddebris);
if ((control.asize > 4) && (ship[n].pilot!=HUMAN))
    {
	if (ship[n].image == il.minelayer) AllocateBoxes(xx,yy,1);
	else
	if (ship[n].image == il.elight) 	AllocateBoxes(xx,yy,2);
	else							AllocateBoxes(xx,yy,3);
    }

makesound(3,3);
ship[n].wait = 30;
ship[n].pilot=DESTROYED;

if (n < control.playernum)
    {
	if (--control.fire[n] < control.weapon[n]) control.fire[n] = control.weapon[n];
	if (++control.firedelay[n] > 4) control.firedelay[n] = 4;
    }
else 
    {
	control.enemynum--;
    }
}


CollisionBoxShips(n)
LONG n;
{
LONG y;
LONG xx,yy;
LONG wi,he;

xx = b[n].x+id[il.box+b[n].pos].wi/2;
yy = b[n].y+id[il.box+b[n].pos].he/2;

for(y=0;y<control.playernum;y++)
    {
	wi = id[ship[y].image+ship[y].pos].wi;
	he = id[ship[y].image+ship[y].pos].he;
	
	if ( (xx > ship[y].x) && (xx < ship[y].x+wi) &&
		(yy > ship[y].y) &&	(yy < ship[y].y+he))
		    {
			if (b[n].type == 2)
			    {
				makesound(11,2);
				IncreaseShields(y,50);
			    }
			else
			if (b[n].type == 1)
			    {
				makesound(9,2);
				++control.fire[y];
			    }
			else
			if (b[n].type == 3)
			    {
				makesound(9,2);
				if (--control.firedelay[y] < 0) control.firedelay[y] = 0;
			    }
			else
			if (b[n].type == 0)
			    {
				makesound(12,2);
				IncreaseLives(y,1);
			    }

			b[n].length = 2;
			break;
		    }
    }
}
