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

InitFire(n)
LONG n;
{
LONG x,num;

num = -1;
for(x=0;x<ship[n].fnum;x++)
	if (ship[n].shotI[x].flight == FALSE)
	    {
		num = x;
		break;
	    }

if (num != -1)
    {
	ship[n].shotI[x].range = 24;
	if (n < control.playernum) makesound(0,0);
	else					  makesound(5,0);
	ship[n].shotI[x].xp = ship[n].x+id[ship[n].image+ship[n].pos].wi/2+ship[n].vx/100;
	ship[n].shotI[x].yp = ship[n].y+id[ship[n].image+ship[n].pos].he/2+ship[n].vy/100;
	ship[n].shotI[x].vx = ship[n].fvmax*VxINC[ship[n].pos];
	ship[n].shotI[x].vy = ship[n].fvmax*VyINC[ship[n].pos];
	ship[n].shotI[x].len = ship[n].flen;
	ship[n].shotI[x].pos = ship[n].pos;
	ship[n].shotI[x].dx = (ship[n].shotI[x].len * VxINC[ship[n].shotI[x].pos]) /100;
	ship[n].shotI[x].dy = (ship[n].shotI[x].len * VyINC[ship[n].shotI[x].pos]) /100;
	ship[n].shotI[x].flight = TRUE;
    }
}


Init360Fire(n,pos)
LONG n;
{
LONG x,num;

num = -1;
for(x=0;x<ship[n].fnum;x++)
	if (ship[n].shotI[x].flight == FALSE)
	    {
		num = x;
		break;
	    }

if (num != -1)
    {
	ship[n].shotI[x].range = 24;
	ship[n].shotI[x].xp = ship[n].x+id[ship[n].image+ship[n].pos].wi/2;
	ship[n].shotI[x].yp = ship[n].y+id[ship[n].image+ship[n].pos].he/2;
	ship[n].shotI[x].vx = ship[n].fvmax*VxINC[pos];
	ship[n].shotI[x].vy = ship[n].fvmax*VyINC[pos];
	ship[n].shotI[x].len = ship[n].flen;
	ship[n].shotI[x].pos = pos;
	ship[n].shotI[x].dx = (ship[n].shotI[x].len * VxINC[ship[n].shotI[x].pos]) /100;
	ship[n].shotI[x].dy = (ship[n].shotI[x].len * VyINC[ship[n].shotI[x].pos]) /100;
	ship[n].shotI[x].flight = TRUE;
    }
}


DrawFire(n)
LONG n;
{
LONG x;
LONG xx,yy;
LONG dx,dy;

for(x=0;x<ship[n].fnum;x++)
	if (ship[n].shotI[x].flight == TRUE)
	    {
		ship[n].shotI[x].oxp = ship[n].shotI[x].xp;
		ship[n].shotI[x].oyp = ship[n].shotI[x].yp;
		ship[n].shotI[x].opos = ship[n].shotI[x].pos;

		xx = ship[n].shotI[x].xp += ship[n].shotI[x].vx/100;
		yy = ship[n].shotI[x].yp += ship[n].shotI[x].vy/100;

		dx = ship[n].shotI[x].dx;
		dy = ship[n].shotI[x].dy;

		CollisionFireSaucer(n,x,xx+dx,yy+dy);
		CollisionFireAsteroids(n,x,xx+dx,yy+dy);
		CollisionFireShips(n,x,xx+dx,yy+dy);
		CollisionFireFighters(n,x,xx+dx,yy+dy);

		if (control.firewrap == FALSE)
		    {
			if ( (xx > gi.x2+10) || (xx < gi.x1-10) ||
				(yy > gi.y2+10) || (yy < gi.y1-10))
					ship[n].shotI[x].flight = LAST;
		    }
		else
		    {
			if (--ship[n].shotI[x].range == 0)	ship[n].shotI[x].flight = LAST;
			if (xx > gi.x2) ship[n].shotI[x].xp = gi.x1;
			if (xx < gi.x1) ship[n].shotI[x].xp = gi.x2;
			if (yy > gi.y2) ship[n].shotI[x].yp = gi.y1;
			if (yy < gi.y1) ship[n].shotI[x].yp = gi.y2;
		    }


		if (ship[n].shotI[x].flight == TRUE)
		    {
			SetAPen(rp1[bit],1);
			SetWrMsk(rp1[bit],0xfd);
			Move(rp1[bit],ship[n].shotI[x].xp,ship[n].shotI[x].yp);
			Draw(rp1[bit],ship[n].shotI[x].xp+dx,ship[n].shotI[x].yp+dy);
		    }
	    }
}



EraseFire(n)
LONG n;
{
LONG x,xx,yy;
LONG dx,dy;

for(x=0;x<ship[n].fnum;x++)
{
if (ship[n].shotI[x].flight != FALSE)
    {
	xx = ship[n].shotI[x].oxp;
	yy = ship[n].shotI[x].oyp;

	dx = (ship[n].shotI[x].len * VxINC[ship[n].shotI[x].opos])/100;
	dy = (ship[n].shotI[x].len * VyINC[ship[n].shotI[x].opos])/100;

	SetWrMsk(rp1[1-bit],0xfd);
	Move(rp1[1-bit],xx,yy);
	Draw(rp1[1-bit],xx+dx,yy+dy);

	if (ship[n].shotI[x].flight == LAST) ship[n].shotI[x].flight = FALSE;
    }
}    
}


InitPlasmaBall(n)
{
LONG x,num;

num = -1;
for(x=0;x<ship[n].pnum;x++)
	if (ship[n].photI[x].flight == FALSE)
		if (ship[n].photI[x].delay == 0)
		    {
			num = x;
			break;
		    }

if (num != -1)
    {
	ship[n].photI[x].xp = ship[n].x+id[ship[n].image].wi/2;
	ship[n].photI[x].yp = ship[n].y+id[ship[n].image].he/2;
	ship[n].photI[x].vx = ship[n].pvmax;
	ship[n].photI[x].vy = ship[n].pvmax;
	ship[n].photI[x].pos = ship[n].pos;
	ship[n].photI[x].turn = 0;
	ship[n].photI[x].range = ship[n].prange;
	ship[n].photI[x].flight = TRUE;
	ship[n].photI[x].delay = ship[n].pdelay;
	ship[n].photI[x].type = SEEKING;
	ship[n].photI[x].wrap = TRUE;
	ship[n].photI[x].image = ship[n].pimage;
    }
}


InitSidePlasmaBall(n)
{
LONG x,num,y;
LONG wi,he;

num = -1;
for(x=0;x<ship[n].pnum;x++)
	if (ship[n].photI[x].flight == FALSE)
		if (ship[n].photI[x].delay == 0)
		    {
			num = x;
			break;
		    }

if ((num != -1) && (ship[ship[n].aim].pilot != DESTROYED))
    {
	wi = id[ship[n].image+ship[n].pos].wi;
	he = id[ship[n].image+ship[n].pos].he;

	if (Random(100.0) < 50) y = wi/4;
	else				    y =-wi/4;

	ship[n].photI[x].xp = ship[n].x+wi/2+(y*VyINC[ship[n].pos])/100;
	ship[n].photI[x].yp = ship[n].y+he/2-(y*VxINC[ship[n].pos])/100;
	ship[n].photI[x].vx = ship[n].pvmax;
	ship[n].photI[x].vy = ship[n].pvmax;
	ship[n].photI[x].pos = ship[n].pos;
	ship[n].photI[x].turn = 0;
	ship[n].photI[x].range = ship[n].prange;
	ship[n].photI[x].flight = TRUE;
	ship[n].photI[x].delay = ship[n].pdelay;
	ship[n].photI[x].wrap = TRUE;
	ship[n].photI[x].type = SEEKING;
	ship[n].photI[x].image = ship[n].pimage;
    }
}



DrawPhoton(n)
LONG n;
{
LONG x;

for(x=0;x<ship[n].pnum;x++)
    {
	if (--ship[n].photI[x].delay < 0) ship[n].photI[x].delay=0;

	if (ship[n].photI[x].flight != FALSE)
	    {
		ship[n].photI[x].oxp = ship[n].photI[x].xp;
		ship[n].photI[x].oyp = ship[n].photI[x].yp;

		CollisionPhotonShips(n,x);
		if (n < control.playernum)
		    {
			CollisionPhotonFighters(n,x);
			CollisionPhotonAsteroids(n,x);
			CollisionPhotonSaucer(n,x);
			CollisionPhotonBattleship(n,x);
		    }

		if (ship[n].photI[x].type == SEEKING) HandleSeeking(n,x);
		if (ship[n].photI[x].wrap == TRUE)
			CheckPhotonWrap(n,x);
		else	CheckPhotonEnd(n,x);
		
		CheckRange(n,x);

		if (ship[n].photI[x].flight == TRUE)
		    {
			SetAPen(rp1[bit],1);
			SetWrMsk(rp1[bit],0xfd);
			ship[n].photI[x].xp += ship[n].photI[x].vx*VxINC[ship[n].photI[x].pos]/100;
			ship[n].photI[x].yp += ship[n].photI[x].vy*VyINC[ship[n].photI[x].pos]/100;
			if (n < control.playernum)
				BltTemplate(id[il.photon].data,0,2,rp1[bit],ship[n].photI[x].xp,ship[n].photI[x].yp,id[il.photon].wi,id[il.photon].he);
			else
				BltTemplate(id[il.photon+1].data,0,2,rp1[bit],ship[n].photI[x].xp,ship[n].photI[x].yp,id[il.photon+1].wi,id[il.photon+1].he);
		    }
	     }
    }
}


CheckPhotonWrap(n,x)
LONG n,x;
{
if (ship[n].photI[x].xp > gi.x2+10) ship[n].photI[x].xp = gi.x1-10;
else
if (ship[n].photI[x].xp < gi.x1-10) ship[n].photI[x].xp = gi.x2+10;
if (ship[n].photI[x].yp > gi.y2+10) ship[n].photI[x].yp = gi.y1-10;
else
if (ship[n].photI[x].yp < gi.y1-10) ship[n].photI[x].yp = gi.y2+10;
}

CheckRange(n,x)
LONG n,x;
{
if (--ship[n].photI[x].range == 0)	ship[n].photI[x].flight = LAST;
}


CheckPhotonEnd(n,x)
LONG n,x;
{
if ((ship[n].photI[x].xp > gi.x2+10) ||
    (ship[n].photI[x].xp < gi.x1-10) ||
    (ship[n].photI[x].yp > gi.y2+10) ||
    (ship[n].photI[x].yp < gi.y1-10))
		ship[n].photI[x].flight = LAST;
}

ErasePhoton(n)
LONG n;
{
LONG x;

SetWrMsk(rp1[1-bit],0xfd);
for(x=0;x<ship[n].pnum;x++)
{
if (ship[n].photI[x].flight != FALSE)
    {
	RectFill(rp1[1-bit],ship[n].photI[x].oxp,ship[n].photI[x].oyp,
 		    ship[n].photI[x].oxp+id[ship[n].photI[x].image].wi,ship[n].photI[x].oyp+id[ship[n].photI[x].image].he);

	if (ship[n].photI[x].flight == LAST) ship[n].photI[x].flight = FALSE;
    }
}    
}


HandleSeeking(n,x)
LONG n,x;
{
LONG direction;

if (++ship[n].photI[x].turn >= ship[n].pman)
    {
	ship[n].photI[x].turn = 0;
	direction = detcomplexheading(n,ship[ship[n].aim].x,ship[ship[n].aim].y,ship[n].photI[x].xp,ship[n].photI[x].yp,ship[n].photI[x].pos);
	if (direction != 0) ship[n].photI[x].pos+=sign(direction);

	if (ship[n].photI[x].pos > 31)  ship[n].photI[x].pos= 0;
	if (ship[n].photI[x].pos <  0)  ship[n].photI[x].pos=31;
    }
}
