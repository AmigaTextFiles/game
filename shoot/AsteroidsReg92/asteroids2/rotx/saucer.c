#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/extern.h>

/*
#define MWDEBUG 1
#include "sc:extras/memlib/memwatch.h"
*/

InitSmartSaucerFire()
{
LONG x,num=-1;
LONG random,aim;
DOUBLE aimfp;

for(x=0;x<saucer.fnum;x++)
	if (saucer.photI[x].flight == FALSE)
	    {
		num = x;
		break;
	    }

if (num != -1)
    {
	aimfp = control.playernum+control.enemynum;
	aim = Random(aimfp);

	random = determineheading(ship[aim].x,ship[aim].y,saucer.x,saucer.y,0);
	if (random < 0) random+=32;

	makesound(4,0);
	saucer.photI[x].xp = saucer.x+id[saucer.image+saucer.rot].wi/2;
	saucer.photI[x].yp = saucer.y+id[saucer.image+saucer.rot].he/2;
	saucer.photI[x].vx = 12*VxINC[random];
	saucer.photI[x].vy = 12*VyINC[random];
	saucer.photI[x].rot = 0;
	saucer.photI[x].flight = TRUE;
    }
}


InitSaucerFire()
{
LONG x,num=-1;
LONG random;

for(x=0;x<saucer.fnum;x++)
	if (saucer.photI[x].flight == FALSE)
	    {
		num = x;
		break;
	    }

if (num != -1)
    {
	random = Random(31.0);
	makesound(4,0);
	saucer.photI[x].xp = saucer.x+id[saucer.image+saucer.rot].wi/2;
	saucer.photI[x].yp = saucer.y+id[saucer.image+saucer.rot].he/2;
	saucer.photI[x].vx = 12*VxINC[random];
	saucer.photI[x].vy = 12*VyINC[random];
	saucer.photI[x].rot = 0;
	saucer.photI[x].flight = TRUE;
    }
}



DrawSaucerFire()
{
LONG x,y;

for(x=0;x<saucer.fnum;x++)
    {
	if (saucer.photI[x].flight != FALSE)
	    {
		for(y=0;y<control.playernum+control.enemynum;y++)
		    {
			if (ship[y].pilot != DESTROYED)
			if ( (saucer.photI[x].xp + 2 > ship[y].x)    &&
				(saucer.photI[x].xp + 2 < ship[y].x+id[ship[y].image+ship[y].pos].wi) &&
				(saucer.photI[x].yp + 2 > ship[y].y)    &&
				(saucer.photI[x].yp + 2 < ship[y].y+id[ship[y].image+ship[y].pos].he))
				    {
					if (ship[y].pilot == HUMAN) saucer.haltfire = TRUE;
					saucer.photI[x].flight = LAST;
					Firehit(y,300,8);
					break;
				    }
		    }

		for(y=0;y<control.asteroidnum;y++)
		    {
			if (a[y].flag == TRUE)
			    {
				if ( (saucer.photI[x].xp + 2 > a[y].x)    &&
					(saucer.photI[x].xp + 2 < a[y].x+id[il.asteroid[a[y].size]].wi) &&
					(saucer.photI[x].yp + 2 > a[y].y)    &&
					(saucer.photI[x].yp + 2 < a[y].y+id[il.asteroid[a[y].size]].he))
					    {
						saucer.photI[x].flight = LAST;
						AsteroidExplosion(y,saucer.photI[x].xp,saucer.photI[x].yp);
						break;
					    }
			    }
		    }

		saucer.photI[x].oxp = saucer.photI[x].xp;
		saucer.photI[x].oyp = saucer.photI[x].yp;

		if ( (saucer.photI[x].xp > gi.x2+10) ||
			(saucer.photI[x].xp < gi.x1-10) || 
			(saucer.photI[x].yp > gi.y2+10) || 
			(saucer.photI[x].yp < gi.y1-10))
				saucer.photI[x].flight = LAST;


		if (saucer.photI[x].flight == TRUE)
		    {
			if (++saucer.photI[x].rot > 15) saucer.photI[x].rot = 0;
			saucer.photI[x].xp += saucer.photI[x].vx/100;
			saucer.photI[x].yp += saucer.photI[x].vy/100;

			SetAPen(rp1[bit],1);
			SetWrMsk(rp1[bit],0xfd);
			BltTemplate(id[il.sauphot+saucer.photI[x].rot].data,0,2,rp1[bit],
                              saucer.photI[x].xp,saucer.photI[x].yp,id[il.sauphot].he,id[il.sauphot].wi);
		    }
	     }
    }
}



EraseSaucerFire()
{
LONG x;

for(x=0;x<saucer.fnum;x++)
{
if (saucer.photI[x].flight != FALSE)
    {
	SetWrMsk(rp1[1-bit],0xfd);
	RectFill(rp1[1-bit],saucer.photI[x].oxp,saucer.photI[x].oyp,
		    saucer.photI[x].oxp+id[il.sauphot].wi,saucer.photI[x].oyp+id[il.sauphot].he);

	if (saucer.photI[x].flight == LAST) saucer.photI[x].flight = FALSE;
    }
}
}


UpdateSaucer()
{
LONG x,wo,he,wi;
LONG sapic;

if (saucer.flag != FALSE)
    {
	saucer.ox = saucer.x;
	saucer.oy = saucer.y;
    }

if (saucer.flag == TRUE)
    {
	sapic = saucer.image+saucer.rot;
	wi = id[sapic].wi;
	he = id[sapic].he;

	saucer.x += saucer.vx;
	saucer.y += saucer.vy;

	for(x=0;x<control.playernum;x++)
		if (ship[x].pilot != DESTROYED)
			if ((saucer.x      < ship[x].x + wi -4) &&
			    (saucer.x + wi > ship[x].x +4) &&
			    (saucer.y      < ship[x].y + he -4) &&
			    (saucer.y + he > ship[x].y +4))
				    {
					DestroyShip(x);
				    	initInput(x);
				    }

	if ((saucer.x+wi/2 > gi.x2) || (saucer.x+wi/2 < gi.x1)) saucer.flag = LAST;

	if (saucer.y+he/2 > gi.y2) saucer.y = gi.y1-he/2;
	if (saucer.y+he/2 < gi.y1) saucer.y = gi.y2-he/2;

	if (saucer.delay%3 == 0)
		if (++saucer.rot > 4) saucer.rot = 0;


	if (saucer.flag == TRUE)
	    {
		SetAPen(rp1[bit],1);
		SetWrMsk(rp1[bit],0xfd);
		wo = 2*id[sapic].wo;
		BltTemplate(id[sapic].data,0,wo,rp1[bit],saucer.x,saucer.y,wi,he);
	    }
    }
}


ChangeSaucerCourse()
{
LONG random;

random = Random(300.0);
if (random > 200) saucer.vy =-3;
else
if (random > 100) saucer.vy = 3;
else			   saucer.vy = 0;

saucer.delay = Random(50.0-control.level);
}


EraseSaucer()
{
if (saucer.flag != FALSE)
    {
	SetWrMsk(rp1[1-bit],0xfd);
	if (saucer.flag == LAST) saucer.flag = FALSE;
	RectFill(rp1[1-bit],saucer.ox,saucer.oy,saucer.ox+id[saucer.image+saucer.rot].wi,saucer.oy+id[saucer.image+saucer.rot].he);
    }
}
