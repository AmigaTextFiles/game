#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/extern.h>


InitExpander(n)
LONG n;
{
LONG x,num;

num = -1;
for(x=0;x<2;x++)
	if (ship[n].photI[x].flight == FALSE)
		    {
			num = x;
			break;
		    }

if (num != -1)
    {
	ship[n].photI[x].xp = ship[n].x+id[ship[n].image].wi/2+((2*num-1)*6*VyINC[ship[n].pos])/100;
	ship[n].photI[x].yp = ship[n].y+id[ship[n].image].he/2-((2*num-1)*6*VxINC[ship[n].pos])/100;
	ship[n].photI[x].vx = ship[n].pvmax;
	ship[n].photI[x].vy = ship[n].pvmax;
	ship[n].photI[x].pos = ship[n].pos;
	ship[n].photI[x].range = ship[n].prange;
	ship[n].photI[x].flight = TRUE;
	ship[n].photI[x].image = ship[n].pimage;
    }
}


DrawExpander(n)
LONG n;
{
LONG x;
LONG pic;

for(x=0;x<ship[n].pnum;x++)
    {
	if (ship[n].photI[x].flight != FALSE)
	    {
		ship[n].photI[x].oxp = ship[n].photI[x].xp;
		ship[n].photI[x].oyp = ship[n].photI[x].yp;

		CollisionPhotonShips(n,x);
		CollisionPhotonAsteroids(n,x);
		if (saucer.flag == TRUE) CollisionPhotonSaucer(n,x);

		if (x < 2) 
		    {
			CheckPhotonWrap(n,x);
			if (--ship[n].photI[x].range == 0) ExplodeExpander(n,x);
			pic = il.expander;
		    }
		else
		    {
			if ((ship[n].photI[x].xp > gi.x2+10) ||
			    (ship[n].photI[x].xp < gi.x1-10) ||
			    (ship[n].photI[x].yp > gi.y2+10) ||
			    (ship[n].photI[x].yp < gi.y1-10))
					ship[n].photI[x].flight = LAST;
			else pic = il.photon+1;
		    }
	    }

	if (ship[n].photI[x].flight == TRUE)
	    {
		ship[n].photI[x].xp += ship[n].photI[x].vx*VxINC[ship[n].photI[x].pos]/100;
		ship[n].photI[x].yp += ship[n].photI[x].vy*VyINC[ship[n].photI[x].pos]/100;

		SetAPen(rp1[bit],1);
		SetWrMsk(rp1[bit],0xfd);
		BltTemplate(id[pic].data,0,2,rp1[bit],ship[n].photI[x].xp,ship[n].photI[x].yp,id[pic].wi,id[pic].he);
	    }
    }
}


ExplodeExpander(n,x)
LONG n,x;
{
LONG y,z;
LONG xx,yy;

xx = ship[n].photI[x].xp;
yy = ship[n].photI[x].yp;
ship[n].photI[x].flight = LAST;

for(y=0;y<6;y++)
    {
	z = x*6+2+y;
	if (ship[n].photI[z].flight == FALSE)
	    {
		ship[n].photI[z].xp = xx;
		ship[n].photI[z].yp = yy;
		ship[n].photI[z].vx = ship[n].pvmax;
		ship[n].photI[z].vy = ship[n].pvmax;
		ship[n].photI[z].pos = y*5;
		ship[n].photI[z].flight = TRUE;
		ship[n].photI[z].image = il.photon+1;
	    }
    }
}


InitDisplacer(n)
LONG n;
{
if (ship[n].photI[18].flight == FALSE)
    {
	ship[n].photI[18].xp = ship[n].x+id[ship[n].image].wi/2;
	ship[n].photI[18].yp = ship[n].y+id[ship[n].image].he/2;
	ship[n].photI[18].vx = ship[n].pvmax;
	ship[n].photI[18].vy = ship[n].pvmax;
	ship[n].photI[18].pos = ship[n].pos;
	ship[n].photI[18].rot = 0;
	ship[n].photI[18].turn= ship[n].pman;
	ship[n].photI[18].range = ship[n].prange;
	ship[n].photI[18].flight = TRUE;
    }
}


EraseDisplacer(n)
{
if (ship[n].photI[18].flight != FALSE)
    {
	SetWrMsk(rp1[1-bit],0xfd);
	RectFill(rp1[1-bit],ship[n].photI[18].oxp,ship[n].photI[18].oyp,
 		    ship[n].photI[18].oxp+id[il.displacer].wi,ship[n].photI[18].oyp+id[il.displacer].he);

	if (ship[n].photI[18].flight == LAST) ship[n].photI[18].flight = FALSE;
    }
}



UpdateDisplacer(n)
{
if (ship[n].photI[18].flight != FALSE)
    {
	ship[n].photI[18].oxp = ship[n].photI[18].xp;
	ship[n].photI[18].oyp = ship[n].photI[18].yp;

	if (--ship[n].photI[18].range == 0) ship[n].photI[18].flight = LAST;
	else
	    {
		CollisionDisplacerShips(n,18);
		CheckPhotonWrap(n,18);
		HandleSeeking(n,18);
	    }
    }

if (ship[n].photI[18].flight == TRUE)
    {
	if (++ship[n].photI[18].rot > 15) ship[n].photI[18].rot= 0;

	ship[n].photI[18].xp += ship[n].photI[18].vx*VxINC[ship[n].photI[18].pos]/100;
	ship[n].photI[18].yp += ship[n].photI[18].vy*VyINC[ship[n].photI[18].pos]/100;

	SetAPen(rp1[bit],1);
	SetWrMsk(rp1[bit],0xfd);
	BltTemplate(id[il.displacer+ship[n].photI[18].rot].data,0,2,rp1[bit],
			  ship[n].photI[18].xp,ship[n].photI[18].yp,id[il.displacer].wi,id[il.displacer].he);
    }
}


CollisionDisplacerShips(n,x)
LONG n,x;
{
LONG y;
LONG wi,he;

for(y=0;y<control.playernum;y++)
    {
	if (ship[y].pilot == HUMAN)
	    {
		wi = id[il.displacer].wi;
		he = id[il.displacer].he;

		if ( (ship[n].photI[x].xp     < ship[y].x+id[ship[y].image].wi)  &&
			(ship[n].photI[x].xp+wi  > ship[y].x) 					&&
			(ship[n].photI[x].yp     < ship[y].y+id[ship[y].image].he)  &&
			(ship[n].photI[x].yp+he  > ship[y].y))
			    {
				in.HY[y] = TRUE;
				ship[n].photI[x].flight = LAST;
			    }
	    }
    }
}




UpdateDreadnought(n)
LONG n;
{
LONG direction;
LONG wi,he,wo;
LONG pic;
LONG dx,dy;

UpdateDisplacer(n);

ship[n].ox = ship[n].x;
ship[n].oy = ship[n].y;

if (ship[n].pilot == COMPUTER)
{
ship[n].vx = ship[n].vmax*VxINC[ship[n].pos];
ship[n].vy = ship[n].vmax*VyINC[ship[n].pos];

moveenemy(n);

if (ship[ship[n].aim].pilot == DESTROYED)
    {
	if (++ship[n].aim >= control.playernum) ship[n].aim = 0;
    }
else
if (++ship[n].turn > ship[n].man)
    {
	direction = detcomplexheading(n,ship[ship[n].aim].x,ship[ship[n].aim].y,ship[n].x,ship[n].y,ship[n].pos);
	dx = abs(ship[ship[n].aim].x-ship[n].x);
	dy = abs(ship[ship[n].aim].y-ship[n].y);


	if (++ship[n].fdelay > ship[n].frate)
	    {
		ship[n].fdelay = 0;
		InitExpander(n);
	    }

	if (direction == 0)	InitDisplacer(n);
	else
	if (dx+dy > 50)
	    {
		ship[n].pos+=sign(direction);
		if (ship[n].pos > 31)  ship[n].pos= 0;
		if (ship[n].pos <  0)  ship[n].pos=31;
	    }
	ship[n].turn = 0;
    }


SetAPen(rp1[bit],2);
SetWrMsk(rp1[bit],0xfe);
pic = ship[n].image+ship[n].pos;
wi = id[pic].wi;
he = id[pic].he;
wo = 2*id[pic].wo;
BltTemplate(id[pic].data,0,wo,rp1[bit],ship[n].x,ship[n].y,wi,he);
}
}
