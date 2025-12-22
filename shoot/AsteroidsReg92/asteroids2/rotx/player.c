#include <exec/types.h>
#include <intuition/intuition.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/extern.h>
#include <math.h>
#include <graphics/gfxmacros.h>



LONG Random(bound)   /* Returns 0 to BOUND */
DOUBLE bound;
{
DOUBLE x;
LONG random;

x = lrand48();
random = floor((x/2147483647.0)*(bound+1.0));

return((LONG)random);
}


InitBarrageFire(n)
LONG n;
{
LONG num;
LONG x,y,pos;
LONG xx,yy;

for(y=0;y<3;y++)
{
num=-1;
for(x=0;x<ship[n].pnum;x++)
    {
	if (ship[n].photI[x].flight == FALSE)
	    {
		num = x;
		break;
	    }
    }
if (num != -1)
    {
	pos = ship[n].pos+Random(2.0)-1;
	if (pos > 31) pos = pos-31;
	else
	if (pos < 0) pos = 32+pos;

	xx = ship[n].x+id[ship[n].image+pos].wi/2;
	yy = ship[n].y+id[ship[n].image+pos].he/2;

	makesound(0,0);
	ship[n].photI[x].range = 18;
	ship[n].photI[x].xp = xx;
	ship[n].photI[x].yp = yy;
	ship[n].photI[x].oxp = ship[n].x+id[ship[n].image+ship[n].pos].wi/2;
	ship[n].photI[x].oyp = ship[n].y+id[ship[n].image+ship[n].pos].he/2;
	ship[n].photI[x].pos = pos;
	ship[n].photI[x].vx = ship[n].pvmax+Random(3.0);
	ship[n].photI[x].vy = ship[n].pvmax+Random(3.0);
	ship[n].photI[x].flight = TRUE;
	ship[n].photI[x].type = BARRAGE;
	ship[n].photI[x].wrap = control.firewrap;
	ship[n].photI[x].image = ship[n].image;
    }
}
}

InitHeavyFire(n)
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
	if (n < control.playernum) makesound(0,0);
	else					  makesound(5,0);
	ship[n].photI[x].range = 24;
	ship[n].photI[x].xp = ship[n].x+8;
	ship[n].photI[x].yp = ship[n].y+8;
	ship[n].photI[x].vx = ship[n].pvmax;
	ship[n].photI[x].vy = ship[n].pvmax;
	ship[n].photI[x].pos = ship[n].pos;
	ship[n].photI[x].flight = TRUE;
	ship[n].photI[x].wrap = control.firewrap;
	ship[n].photI[x].type = DIRECT;
	ship[n].photI[x].image = ship[n].image;
    }
}



InitDoubleFire(n)
LONG n;
{
LONG num;
LONG x,y,pos;

for(y=0;y<2;y++)
{
num=-1;
for(x=0;x<ship[n].fnum;x++)
    {
	if (ship[n].shotI[x].flight == FALSE)
	    {
		num = x;
		break;
	    }
    }
if (num != -1)
    {
	pos = ship[n].pos;

	if (n < control.playernum) makesound(0,0);
	else					  makesound(5,0);
	ship[n].shotI[x].range = 24;
	ship[n].shotI[x].xp = ship[n].x+id[ship[n].image+pos].wi/2+((2*y-1)*4*VyINC[pos])/100;
	ship[n].shotI[x].yp = ship[n].y+id[ship[n].image+pos].he/2-((2*y-1)*4*VxINC[pos])/100;
	ship[n].shotI[x].vx = ship[n].fvmax*VxINC[pos];
	ship[n].shotI[x].vy = ship[n].fvmax*VyINC[pos];
	ship[n].shotI[x].len = ship[n].flen;
	ship[n].shotI[x].pos = pos;
	ship[n].shotI[x].dx = (ship[n].shotI[x].len * VxINC[ship[n].shotI[x].pos]) /100;
	ship[n].shotI[x].dy = (ship[n].shotI[x].len * VyINC[ship[n].shotI[x].pos]) /100;
	ship[n].shotI[x].flight = TRUE;
    }
}
}




InitSuperFire(n)
LONG n;
{
LONG x,y,num;
LONG wi,he;

for(y=0;y<2;y++)
{
num=-1;
for(x=0;x<ship[n].pnum;x++)
	if (ship[n].photI[x].flight == FALSE)
		if (ship[n].photI[x].delay == 0)
		    {
			num = x;
			break;
		    }

if (num != -1)
    {
	if (n < control.playernum) makesound(0,0);
	else					  makesound(5,0);

	wi = id[ship[n].image+ship[n].pos].wi;
	he = id[ship[n].image+ship[n].pos].he;
	ship[n].photI[x].range = 24;
	ship[n].photI[x].xp = ship[n].x+wi/2+((2*y-1)*4*VyINC[ship[n].pos])/100;
	ship[n].photI[x].yp = ship[n].y+he/2-((2*y-1)*4*VxINC[ship[n].pos])/100;
	ship[n].photI[x].vx = ship[n].pvmax;
	ship[n].photI[x].vy = ship[n].pvmax;
	ship[n].photI[x].pos = ship[n].pos;
	ship[n].photI[x].flight = TRUE;
	ship[n].photI[x].type = DIRECT;
	ship[n].photI[x].image = ship[n].image;
    }
}
}


DrawShield(n)
LONG n;
{
LONG xx,yy,pic;

if ((ship[n].shieldstat > 2) && (ship[n].pilot!=DESTROYED))
    {
	pic= ship[n].shIno;
	xx = ship[n].x+id[ship[n].image+ship[n].pos].wi/2-id[pic].wi/2-1;
	yy = ship[n].y+id[ship[n].image+ship[n].pos].he/2-id[pic].he/2-1;

	SetAPen(rp1[bit],1);
	SetWrMsk(rp1[bit],0xfd);
	BltTemplate(id[pic].data,0,2*id[pic].wo,rp1[bit],xx,yy,id[pic].wi,id[pic].he);
    }
}

EraseShield(n)
LONG n;
{
LONG xx,yy,pic;

if (ship[n].shieldstat != 0)
    {
	--ship[n].shieldstat;

	pic= ship[n].shIno;
	xx = ship[n].ox+id[ship[n].image+ship[n].pos].wi/2-id[pic].wi/2;
	yy = ship[n].oy+id[ship[n].image+ship[n].pos].he/2-id[pic].he/2;

	SetWrMsk(rp1[1-bit],0xfd);
	RectFill(rp1[1-bit],xx-4,yy-4,xx+id[pic].wi+4,yy+id[pic].he+4);
    }
}


Hyperspace(n)
LONG n;
{
LONG dx,dy;

makesound(7,2);

SetAPen(rp1[1-bit],0);
RectFill(rp1[1-bit],ship[n].x,ship[n].y,ship[n].x+id[ship[n].image+ship[n].pos].wi,ship[n].y+id[ship[n].image+ship[n].pos].he);

if (ship[n].shieldstat != 0)
RectFill(rp1[1-bit],ship[n].x-1,ship[n].y-1,ship[n].x+id[il.shield].wi,ship[n].y+id[il.shield].he);

dx = Random((DOUBLE)gi.dx);
dy = Random((DOUBLE)gi.dy);

ship[n].ox = ship[n].x;
ship[n].oy = ship[n].y;

ship[n].x = gi.x1 + dx;
ship[n].y = gi.y1 + dy;

AllocateHyper(ship[n].x,ship[n].y);
control.hyper[n] = 10;
ship[n].pilot = DESTROYED;
}


DrawThrust()
{
LONG x,n;

SetAPen(rp1[bit],1);
SetWrMsk(rp1[bit],0xfd);
SetWrMsk(rp1[1-bit],0xfd);

for (n=0;n<control.playernum;n++)
{
for (x=0;x<control.thrustlength;x++)
    {
	if (ship[n].exhd[x] > 0)
	    {
		ship[n].exhd[x]--;
		WritePixel(rp1[bit],ship[n].exhlx[x],ship[n].exhly[x]);
		WritePixel(rp1[bit],ship[n].exhrx[x],ship[n].exhry[x]);
	    }
	else if (ship[n].exhd[x] == 0)
	    {
		ship[n].exhd[x] = -1;
		SetAPen(rp1[bit],0);
		SetAPen(rp1[1-bit],0);

		WritePixel(rp1[bit],ship[n].exhlx[x],ship[n].exhly[x]);
		WritePixel(rp1[1-bit],ship[n].exhlx[x],ship[n].exhly[x]);

		WritePixel(rp1[bit],ship[n].exhrx[x],ship[n].exhry[x]);
		WritePixel(rp1[1-bit],ship[n].exhrx[x],ship[n].exhry[x]);

		SetAPen(rp1[bit],1);
	    }
    }
}
}

IncVelocity(n)
LONG n;
{
LONG x,num=-1;
LONG wi,he;

makesound(1,1);

for (x=0;x<control.thrustlength;x++)
if (ship[n].exhd[x] == -1)
    {
	num = x;
	break;
    }

if (num != -1)
    {
	wi = id[ship[n].image+ship[n].pos].wi;
	he = id[ship[n].image+ship[n].pos].he;

	ship[n].exhlx[num] = ship[n].x+wi/2- (4*VyINC[ship[n].pos])/100;
	ship[n].exhly[num] = ship[n].y+he/2+ (4*VxINC[ship[n].pos])/100;
	ship[n].exhrx[num] = ship[n].x+wi/2+ (4*VyINC[ship[n].pos])/100;
	ship[n].exhry[num] = ship[n].y+he/2- (4*VxINC[ship[n].pos])/100;
	ship[n].exhd[num] = control.thrustlength;
    }

ship[n].vx+=1*VxINC[ship[n].pos]; 
ship[n].vy+=1*VyINC[ship[n].pos];

if (ship[n].vx > ship[n].vmax*100) ship[n].vx = ship[n].vmax*100;
if (ship[n].vx <-ship[n].vmax*100) ship[n].vx =-ship[n].vmax*100;
if (ship[n].vy > ship[n].vmax*100) ship[n].vy = ship[n].vmax*100;
if (ship[n].vy <-ship[n].vmax*100) ship[n].vy =-ship[n].vmax*100;
}


UpdatePlayer(n)
LONG n;
{
LONG wi,he;

ship[n].ox = ship[n].x;
ship[n].oy = ship[n].y;

if (ship[n].pilot == HUMAN)
    {
	if (abs(ship[n].vx) > 0) ship[n].vx-=(abs(ship[n].vx)/40+1)*sign(ship[n].vx); /* damping */
	if (abs(ship[n].vy) > 0) ship[n].vy-=(abs(ship[n].vy)/40+1)*sign(ship[n].vy);

	ship[n].modx += ship[n].vx%100;
	ship[n].mody += ship[n].vy%100;
	
	ship[n].x += (ship[n].vx+ship[n].modx)/100;
	ship[n].y += (ship[n].vy+ship[n].mody)/100;
	
	ship[n].modx -= (ship[n].modx/100)*100;
	ship[n].mody -= (ship[n].mody/100)*100;

	wi = id[ship[n].image].wi/2;
	he = id[ship[n].image].he/2;

	if (ship[n].x+wi > gi.x2) ship[n].x = gi.x1-wi;
	if (ship[n].x+wi < gi.x1) ship[n].x = gi.x2-wi;
	if (ship[n].y+he > gi.y2) ship[n].y = gi.y1-he;
	if (ship[n].y+he < gi.y1) ship[n].y = gi.y2-he;

	todrawlist(ship[n].image+ship[n].pos,ship[n].x,ship[n].y,0xfd,1);
    }
}


EraseAll()
{
LONG x,wi,he;

for (x=0;x<control.playernum;x++)
	    {
		wi = id[ship[x].image+ship[x].pos].wi;
		he = id[ship[x].image+ship[x].pos].he;
		SetWrMsk(rp1[1-bit],0xfd);
		RectFill(rp1[1-bit],ship[x].ox,ship[x].oy,ship[x].ox+wi,ship[x].oy+he);
		WaitBlit();
	    }

for (x=control.playernum;x<control.playernum+control.maxenemynum;x++)
    {
	wi = id[ship[x].image+ship[x].pos].wi;
	he = id[ship[x].image+ship[x].pos].he;
	SetWrMsk(rp1[1-bit],0xfe);
	RectFill(rp1[1-bit],ship[x].ox,ship[x].oy,ship[x].ox+wi,ship[x].oy+he);
    }
}
