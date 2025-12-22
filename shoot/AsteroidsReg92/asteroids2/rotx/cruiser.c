#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/extern.h>



UpdateMCruiser(n)
LONG n;
{
LONG direction;
LONG relpos;
LONG dx,dy;

ship[n].ox = ship[n].x;
ship[n].oy = ship[n].y;

if (ship[n].pilot == COMPUTER)
{
ship[n].x += (ship[n].vmax*VxINC[ship[n].pos])/100;
ship[n].y += (ship[n].vmax*VyINC[ship[n].pos])/100;

if (ship[n].x > gi.x2)	 ship[n].x = gi.x1;
if (ship[n].x < gi.x1)	 ship[n].x = gi.x2;
if (ship[n].y > gi.y2-10) ship[n].y = gi.y1;
if (ship[n].y < gi.y1)	 ship[n].y = gi.y2-10;

if (ship[ship[n].aim].pilot == DESTROYED)
    {
	if (++ship[n].aim >= control.playernum) ship[n].aim = 0;
    }
else
    {
	direction = detcomplexheading(n,ship[ship[n].aim].x,ship[ship[n].aim].y,ship[n].x,ship[n].y,ship[n].pos);

	dx = abs(ship[n].x - ship[ship[n].aim].x);
	dy = abs(ship[n].y - ship[ship[n].aim].y);
	if (dx+dy < 100)
	    {
		relpos = ship[n].pos + direction;
		ship[ship[n].aim].vx+=VxINC[relpos]; 
		ship[ship[n].aim].vy+=VyINC[relpos];
	    }
	else
	if (dx+dy < 50)
	    {
		relpos = ship[n].pos + direction;
		ship[ship[n].aim].vx+=2*VxINC[relpos]; 
		ship[ship[n].aim].vy+=2*VyINC[relpos];
	    }

	if (++ship[n].turn > ship[n].man)
	    {
		ship[n].pos+=sign(direction);
		if (ship[n].pos > 31)  ship[n].pos= 0;
		if (ship[n].pos <  0)  ship[n].pos=31;
		ship[n].turn = 0;
	    }
    }


todrawlist(ship[n].image+ship[n].pos,ship[n].x,ship[n].y,0xfe,2);
}
}




UpdateXCruiser(n)
LONG n;
{
LONG direction;

ship[n].ox = ship[n].x;
ship[n].oy = ship[n].y;

if (ship[n].pilot == COMPUTER)
{
ship[n].x += (ship[n].vmax*VxINC[ship[n].pos])/100;
ship[n].y += (ship[n].vmax*VyINC[ship[n].pos])/100;

if (ship[n].x > gi.x2)	 ship[n].x = gi.x1;
if (ship[n].x < gi.x1)	 ship[n].x = gi.x2;
if (ship[n].y > gi.y2-10) ship[n].y = gi.y1;
if (ship[n].y < gi.y1)	 ship[n].y = gi.y2-10;

if (ship[ship[n].aim].pilot == DESTROYED)
    {
	if (++ship[n].aim >= control.playernum) ship[n].aim = 0;
    }
else
    {
	direction = detcomplexheading(n,ship[ship[n].aim].x,ship[ship[n].aim].y,ship[n].x,ship[n].y,ship[n].pos);
	if (direction == 0)
	    {
		if (++ship[n].fdelay > ship[n].frate)
		    {
			InitDoubleFire(n);
			ship[n].fdelay = 0;
		    }
	    }
	else
	if (++ship[n].turn > ship[n].man)
	    {
		ship[n].pos+=sign(direction);
		if (ship[n].pos > 31)  ship[n].pos= 0;
		if (ship[n].pos <  0)  ship[n].pos=31;
		ship[n].turn = 0;
	    }

	if ((abs(direction)<6) && (++ship[n].pdelay > ship[n].prate))
	    {
		InitPlasmaShotgun(n);
		ship[n].pdelay = 0;
	    }
    }

todrawlist(ship[n].image+ship[n].pos,ship[n].x,ship[n].y,0xfe,2);
}
}


InitPlasmaShotgun(n)
LONG n;
{
LONG x,pos;

for(x=0;x<3;x++)
    {
	pos = ship[n].pos+Random(2.0)-1;
	if (pos > 31) pos = pos-31;
	else
	if (pos < 0)  pos = pos+32;

	ship[n].photI[x].xp = ship[n].x+id[ship[n].image].wi/2;
	ship[n].photI[x].yp = ship[n].y+id[ship[n].image].he/2;
	ship[n].photI[x].vx = ship[n].pvmax+Random(6.0)-3;
	ship[n].photI[x].vy = ship[n].pvmax+Random(6.0)-3;
	ship[n].photI[x].pos = pos;
	ship[n].photI[x].range = ship[n].prange;
	ship[n].photI[x].image = ship[n].pimage;
	ship[n].photI[x].type = DIRECT;
	ship[n].photI[x].wrap = TRUE;
	ship[n].photI[x].flight = TRUE;
    }
}



UpdateCruiser(n)
LONG n;
{
LONG direction;

ship[n].ox = ship[n].x;
ship[n].oy = ship[n].y;

if (ship[n].pilot == COMPUTER)
    {
	moveenemy(n);

	if (ship[ship[n].aim].pilot == DESTROYED)
	    {
		if (++ship[n].aim >= control.playernum) ship[n].aim = 0;
	    }
	else
	if (++ship[n].turn > ship[n].man)
	    {
		direction = detcomplexheading(n,ship[ship[n].aim].x,ship[ship[n].aim].y,ship[n].x,ship[n].y,ship[n].pos);

		if (ship[n].ftype > 0) Init360Fire(n,ship[n].pos+direction);

		if (direction == 0)
		    {
			if (ship[n].ftype == 0)
				if (++ship[n].fdelay > ship[n].frate) InitFire(n);
		    }
		else
		    {

			if ( abs(direction) < 6)
				if (ship[n].ftype != 2) InitPlasmaBall(n);
				else				    InitSidePlasmaBall(n);

			direction = sign(direction);
			ship[n].pos+=direction;

			if (ship[n].pos > 31)  ship[n].pos= 0;
			if (ship[n].pos <  0)  ship[n].pos=31;
		    }

		ship[n].turn = 0;
	    }
	enemythrust(n);


	todrawlist(ship[n].image+ship[n].pos,ship[n].x,ship[n].y,0xfe,2);
    }
}

enemythrust(n)
LONG n;
{
LONG dist,dx,dy;

dx = abs(ship[ship[n].aim].x-ship[n].x);
dy = abs(ship[ship[n].aim].y-ship[n].y);

dist = dx+dy;

if (dist > 350)
    {
	ship[n].vx+=2*VxINC[ship[n].pos];
	ship[n].vy+=2*VyINC[ship[n].pos];
    }
else
if (dist > 50)
    {
	ship[n].vx+=VxINC[ship[n].pos];
	ship[n].vy+=VyINC[ship[n].pos];
    }

if (ship[n].vx> ship[n].vmax*100) ship[n].vx= ship[n].vmax*100;
if (ship[n].vx<-ship[n].vmax*100) ship[n].vx=-ship[n].vmax*100;
if (ship[n].vy > ship[n].vmax*100) ship[n].vy = ship[n].vmax*100;
if (ship[n].vy <-ship[n].vmax*100) ship[n].vy =-ship[n].vmax*100;
}




moveenemy(n)
LONG n;
{
LONG wi,he;

ship[n].x += ship[n].vx/100;
ship[n].y += ship[n].vy/100;

wi = id[ship[n].image].wi+1;
he = id[ship[n].image].he+1;

if (ship[n].x+wi >= gi.x2) ship[n].x = gi.x1+1;
else
if (ship[n].x    <= gi.x1) ship[n].x = gi.x2-wi;
if (ship[n].y+he >= gi.y2) ship[n].y = gi.y1+1;
else
if (ship[n].y    <= gi.y1) ship[n].y = gi.y2-he;
}
