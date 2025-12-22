#include <exec/types.h>
#include <intuition/intuition.h>
#include <stdio.h>
#include <math.h>
#include <h/rot.h>
#include <h/extern.h>

/*
#define MWDEBUG 1
#include "sc:extras/memlib/memwatch.h"
*/

InitBattleshipDefenseFire(n,x,y,type)
LONG n,x,y,type;
{
LONG num,t;

num=-1;
for(t=0;t<bs[n].dnum;t++)
    {
	if (bs[n].fdelay[t] == -1)
	    {
		num = t;
		break;
	    }
    }

if (num != -1)
    {
	if (type == 0)
	    {
		bs[n].x2[num] = ship[x].shotI[y].xp;
		bs[n].y2[num] = ship[x].shotI[y].yp;
		ship[x].shotI[y].flight = LAST;
	    }
	else
	    {
		bs[n].x2[num] = ship[x].photI[y].xp;
		bs[n].y2[num] = ship[x].photI[y].yp;
		ship[x].photI[y].flight = LAST;
	    }

	bs[n].fdelay[num] = 6;
	AllocateExplosion(bs[n].x2[num],bs[n].y2[num],6);
    }
}


DrawBattleshipDefenseFire(n)
LONG n;
{
LONG y;

for (y=0;y<bs[n].dnum;y++)
    {
	if (bs[n].fdelay[y] != -1)
	    {
		bs[n].ox1[y] = bs[n].x1[y];
		bs[n].oy1[y] = bs[n].y1[y];
		bs[n].ox2[y] = bs[n].x2[y];
		bs[n].oy2[y] = bs[n].y2[y];
	    }

	if (bs[n].fdelay[y] > 0)
	    {
		bs[n].x1[y] = bs[n].x + id[bs[n].image+bs[n].pos].wi/2-(12*VxINC[bs[n].pos])/100;
		bs[n].y1[y] = bs[n].y + id[bs[n].image+bs[n].pos].he/2-(12*VyINC[bs[n].pos])/100;

		Move(rp1[bit],bs[n].x1[y],bs[n].y1[y]);
		Draw(rp1[bit],bs[n].x2[y],bs[n].y2[y]);
	    }
    }
}


EraseBattleshipDefenseFire(n)
LONG n;
{
LONG y;

for (y=0;y<bs[n].dnum;y++)
    {
	if (bs[n].fdelay[y] != -1)
	    {
		bs[n].fdelay[y]--;
		Move(rp1[1-bit],bs[n].ox1[y],bs[n].oy1[y]);
		Draw(rp1[1-bit],bs[n].ox2[y],bs[n].oy2[y]);
	    }
    }
}

HandleBattleshipFire(n)
LONG n;
{
LONG x,y;
LONG fpos,xx,yy;

for (x=0;x<control.playernum;x++)
    {
	fpos = determineheading(ship[x].x,ship[x].y,bs[n].x,bs[n].y,bs[n].pos) + Random(2.0) - 1;

	if (control.fire[x] < 2)
	    {
		if (bs[n].line == TRUE)
		for (y=0;y<ship[x].fnum;y++)
			if (ship[x].shotI[y].flight == TRUE)
			    {
				xx = bs[n].x+id[bs[n].image+bs[n].pos].wi/2;
				yy = bs[n].y+id[bs[n].image+bs[n].pos].he/2;
				if (abs(xx-ship[x].shotI[y].xp)+abs(yy-ship[x].shotI[y].yp)<80)
					InitBattleshipDefenseFire(n,x,y,0);
			    }
	    }
	else
	    {
		if (bs[n].line == TRUE)
		for (y=0;y<ship[x].pnum;y++)
			if (ship[x].photI[y].flight == TRUE)
			    {
				xx = bs[n].x+id[bs[n].image+bs[n].pos].wi/2;
				yy = bs[n].y+id[bs[n].image+bs[n].pos].he/2;
				if (abs(xx-ship[x].photI[y].xp)+abs(yy-ship[x].photI[y].yp)<60)
					InitBattleshipDefenseFire(n,x,y,1);
			    }
	    }

	if ((Random(100.0) < 20) && (control.endgame == FALSE)) InitBattleshipFire(n,fpos);
    }
}

UpdateBattleship(n)
LONG n;
{
LONG wi,he,wo;
LONG dir;
LONG xx,yy;
LONG pic,bspic;
LONG rx,ry,x;

bs[n].ox = bs[n].x;
bs[n].oy = bs[n].y;


if (bs[n].flight == TRUE)
{
HandleBattleshipFire(n);

if (bs[n].shield < 0)
    {
	for (x=0;x<10;x++)
	    {
		rx = Random((DOUBLE)(id[bs[n].image+bs[n].pos].wi-40));
		ry = Random((DOUBLE)(id[bs[n].image+bs[n].pos].he-40));
		AllocateExplosion(bs[n].x+20+rx,bs[n].y+20+ry,6);
		AllocateBoxes(bs[n].x+20+rx,bs[n].y+20+ry,1);
		AllocateDebris(bs[n].x+20+rx,bs[n].y+20+ry,2);
	    }
	makesound(3,3);
	bs[n].flight = FALSE;
	for(x=0;x<control.playernum;x++)
	    {
		control.shield[x]+=100;
		if (++control.weapon[x] > 4) control.weapon[x] = 4;
	    }
    }
else
if (Random(500.0) > bs[n].shield*2)
    {
	rx = Random((DOUBLE)(id[bs[n].image+bs[n].pos].wi-40));
	ry = Random((DOUBLE)(id[bs[n].image+bs[n].pos].he-40));
	AllocateExplosion(bs[n].x+20+rx,bs[n].y+20+ry,6);
	makesound(2,2);
    }
}


if (bs[n].shield > 200)
    {
	if (++bs[n].turn == bs[n].man)
	    {
		bs[n].turn = 0;
		dir = determineheading(bs[n].fx,bs[n].fy,bs[n].x,bs[n].y,bs[n].pos);
		if (abs(dir) > 1)
		    {
			bs[n].pos+=sign(dir);
			if (bs[n].pos > 31) bs[n].pos=0;
			if (bs[n].pos <  0) bs[n].pos=31;
		    }
	    }

	bs[n].x += 2*VxINC[bs[n].pos]/100;
	bs[n].y += 2*VyINC[bs[n].pos]/100;
	if (abs(bs[n].x - bs[n].fx) + abs(bs[n].y - bs[n].fy) < 10)
	    {
		bs[n].fx     = gi.x1 + Random(450.0) + 50;
		bs[n].fy     = gi.y1 + Random(210.0) + 30;
	    }
    }


bspic = bs[n].image+bs[n].pos;

if (bs[n].flight == TRUE)
    {
	wi = id[bspic].wi;
	he = id[bspic].he;
	wo = 2*id[bspic].wo;
	BltTemplate(id[bspic].data,0,wo,rp1[bit],bs[n].x,bs[n].y,wi,he);

	if (bs[n].lbox == TRUE)
	    {
		if (--bs[n].lrot < 15) bs[n].lrot=3;
		pic = il.box+bs[n].lrot;
		wi = id[pic].wi;
		he = id[pic].he;
		wo = 2*id[pic].wo;
		xx = bs[n].x+id[bspic].wi/2-(12*VyINC[bs[n].pos])/100-(8*VxINC[bs[n].pos])/100;
		yy = bs[n].y+id[bspic].he/2+(12*VxINC[bs[n].pos])/100-(8*VyINC[bs[n].pos])/100;
		BltTemplate(id[pic].data,0,wo,rp1[bit],xx-wi/2,yy-he/2,wi,he);
	    }

	if (bs[n].rbox == TRUE)
	    {
		if (++bs[n].rrot > 15) bs[n].rrot=0;
		pic = il.box+bs[n].rrot;
		wi = id[pic].wi;
		he = id[pic].he;
		wo = 2*id[pic].wo;
		xx = bs[n].x+id[bspic].wi/2+(12*VyINC[bs[n].pos])/100-(8*VxINC[bs[n].pos])/100;
		yy = bs[n].y+id[bspic].he/2-(12*VxINC[bs[n].pos])/100-(8*VyINC[bs[n].pos])/100;
		BltTemplate(id[pic].data,0,wo,rp1[bit],xx-wi/2,yy-he/2,wi,he);
	    }

	if (bs[n].line == TRUE)
	    {
		if (++bs[n].lirot > 15) bs[n].lirot=0;
		pic = il.line+bs[n].lirot;
		wi = id[pic].wi;
		he = id[pic].he;
		wo = 2*id[pic].wo;
		xx = bs[n].x+id[bspic].wi/2-(12*VxINC[bs[n].pos])/100;
		yy = bs[n].y+id[bspic].he/2-(12*VyINC[bs[n].pos])/100;
		BltTemplate(id[pic].data,0,wo,rp1[bit],xx-wi/2,yy-he/2,wi,he);
	    }
    }

}


EraseBattleship(x)
LONG x;
{
LONG wi,he;

wi = id[bs[x].image+bs[x].pos].wi;
he = id[bs[x].image+bs[x].pos].he;
RectFill(rp1[1-bit],bs[x].ox-2,bs[x].oy-2,bs[x].ox+wi+2,bs[x].oy+he+2);
}


InitBattleshipFire(n,fpos)
LONG n,fpos;
{
LONG num;
LONG x,y,pos;

pos = bs[n].pos;
fpos+=pos;
if (fpos < 0) fpos+=32;
else
if (fpos > 31) fpos-=32;

for(y=0;y<2;y++)
{
num=-1;
for(x=0;x<bs[n].fnum;x++)
    {
	if (bs[n].shotI[x].flight == FALSE)
	    {
		num = x;
		break;
	    }
    }

if (num != -1)
if (((y==0)&&(bs[n].lbox == TRUE)) || ((y==1)&&(bs[n].rbox == TRUE)))
    {
	makesound(5,0);

	bs[n].shotI[x].xp = bs[n].x+id[bs[n].image+pos].wi/2+(2*y-1)*(12*VyINC[pos])/100-(8*VxINC[pos])/100;
	bs[n].shotI[x].yp = bs[n].y+id[bs[n].image+pos].he/2-(2*y-1)*(12*VxINC[pos])/100-(8*VyINC[pos])/100;
	bs[n].shotI[x].vx = bs[n].fvmax*VxINC[fpos];
	bs[n].shotI[x].vy = bs[n].fvmax*VyINC[fpos];

	bs[n].shotI[x].len = 10;
	bs[n].shotI[x].pos = fpos;
	bs[n].shotI[x].flight = TRUE;
    }
}
}


DrawBattleshipFire(n)
LONG n;
{
LONG x;
LONG xx,yy;
LONG dx,dy;

for(x=0;x<bs[n].fnum;x++)
	if (bs[n].shotI[x].flight == TRUE)
	    {
		bs[n].shotI[x].oxp = bs[n].shotI[x].xp;
		bs[n].shotI[x].oyp = bs[n].shotI[x].yp;
		bs[n].shotI[x].opos= bs[n].shotI[x].pos;

		bs[n].shotI[x].xp += bs[n].shotI[x].vx/100;
		bs[n].shotI[x].yp += bs[n].shotI[x].vy/100;

		dx = (bs[n].shotI[x].len * VxINC[bs[n].shotI[x].pos]) /100;
		dy = (bs[n].shotI[x].len * VyINC[bs[n].shotI[x].pos]) /100;
		xx = bs[n].shotI[x].xp + dx;
		yy = bs[n].shotI[x].yp + dy;

		CollisionBattleshipFireShips(n,x,xx,yy);

		if ( (bs[n].shotI[x].xp > gi.x2+10) ||
			(bs[n].shotI[x].xp < gi.x1-10) ||
			(bs[n].shotI[x].yp > gi.y2+10) ||
			(bs[n].shotI[x].yp < gi.y1-10))
				bs[n].shotI[x].flight = LAST;

		if (bs[n].shotI[x].flight == TRUE)
		    {
			Move(rp1[bit],xx-dx,yy-dy);
			Draw(rp1[bit],xx,yy);
		    }
	    }
}


EraseBattleshipFire(n)
LONG n;
{
LONG x,xx,yy;
LONG dx,dy;

for(x=0;x<bs[n].fnum;x++)
{
if (bs[n].shotI[x].flight != FALSE)
    {
	xx = bs[n].shotI[x].oxp;
	yy = bs[n].shotI[x].oyp;

	dx = (bs[n].shotI[x].len * VxINC[bs[n].shotI[x].opos]) /100;
	dy = (bs[n].shotI[x].len * VyINC[bs[n].shotI[x].opos]) /100;

	Move(rp1[1-bit],xx,yy);
	Draw(rp1[1-bit],xx+dx,yy+dy);

	if (bs[n].shotI[x].flight == LAST) bs[n].shotI[x].flight = FALSE;
    }
}    
}

CollisionFireBattleship(n,x,xx,yy)
LONG n,x,xx,yy;
{
LONG y,bspic;
WORD lbx,lby;
WORD rbx,rby;
WORD lx,ly;

for(y=0;y<control.battleshipnum;y++)
    {
	if (bs[y].flight == TRUE)
	    {
		bspic = bs[y].image+bs[y].pos;

		if (bs[y].line == FALSE)
		    {
			if ( (xx > bs[y].x+15) &&
				(xx < bs[y].x+id[bspic].wi-15) &&
				(yy > bs[y].y+15) &&
				(yy < bs[y].y+id[bspic].he-15))
				    {
					makesound(2,2);
					ship[n].shotI[x].flight = LAST;
					AllocateExplosion(xx,yy,6);
					bs[y].shield-=ship[n].fdam;
				    }

			lbx = bs[y].x+id[bspic].wi/2-(12*VyINC[bs[y].pos])/100-(8*VxINC[bs[y].pos])/100;
			lby = bs[y].y+id[bspic].he/2+(12*VxINC[bs[y].pos])/100-(8*VyINC[bs[y].pos])/100;
			if (bs[y].lbox == TRUE)
			if ( (xx > lbx) &&
				(xx < lbx+id[il.box+bs[y].lrot].wi) &&
				(yy > lby) &&
				(yy < lby+id[il.box+bs[y].lrot].he))
				    {
					control.asize = 0;
					makesound(3,3);
					ship[n].shotI[x].flight = LAST;
					AllocateExplosion(xx,yy,6);
					AllocateDebris(xx,yy,control.standarddebris);
					bs[y].lbox = FALSE;
				    }

			rbx = bs[y].x+id[bspic].wi/2+(12*VyINC[bs[y].pos])/100-(8*VxINC[bs[y].pos])/100;
			rby = bs[y].y+id[bspic].he/2-(12*VxINC[bs[y].pos])/100-(8*VyINC[bs[y].pos])/100;
			if (bs[y].rbox == TRUE)
			if ( (xx > rbx) &&
				(xx < rbx+id[il.box+bs[y].rrot].wi) &&
				(yy > rby) &&
				(yy < rby+id[il.box+bs[y].rrot].he))
				    {
					control.asize = 0;
					makesound(3,3);
					ship[n].shotI[x].flight = LAST;
					AllocateDebris(xx,yy,control.standarddebris);
					AllocateExplosion(xx,yy,6);
					bs[y].rbox = FALSE;
				    }
		    }
		else
		    {

			lx = bs[y].x+id[bspic].wi/2-(12*VxINC[bs[y].pos])/100;
			ly = bs[y].y+id[bspic].he/2-(12*VyINC[bs[y].pos])/100;
			if (bs[y].line == TRUE)
			if ( (xx > lx) &&
				(xx < lx+id[il.line+bs[y].lirot].wi) &&
				(yy > ly) &&
				(yy < ly+id[il.line+bs[y].lirot].he))
				    {
					makesound(3,3);
					ship[n].shotI[x].flight = LAST;
					AllocateExplosion(xx,yy,8);
					AllocateDebris(xx,yy,control.standarddebris);
					bs[y].line = FALSE;
			    }
		    }
	    }
    }
}


CollisionPhotonBattleship(n,x)
LONG n,x;
{
LONG xx,yy;
LONG y,bspic;
WORD lbx,lby;
WORD rbx,rby;
WORD lx,ly;

xx = ship[n].photI[x].xp+2;
yy = ship[n].photI[x].yp+2;

for(y=0;y<control.battleshipnum;y++)
    {
	if (bs[y].flight == TRUE)
	    {
		bspic = bs[y].image+bs[y].pos;

		if (bs[y].line == FALSE)
		    {
			if ( (xx > bs[y].x+15) &&
				(xx < bs[y].x+id[bspic].wi-15) &&
				(yy > bs[y].y+15) &&
				(yy < bs[y].y+id[bspic].he-15))
				    {
					makesound(2,2);
					IncreaseScore(n,500);
					ship[n].photI[x].flight = LAST;
					AllocateExplosion(xx,yy,6);
					bs[y].shield-=ship[n].fdam;
				    }

			lbx = bs[y].x+id[bspic].wi/2-(12*VyINC[bs[y].pos])/100-(8*VxINC[bs[y].pos])/100;
			lby = bs[y].y+id[bspic].he/2+(12*VxINC[bs[y].pos])/100-(8*VyINC[bs[y].pos])/100;
			if (bs[y].lbox == TRUE)
			if ( (xx > lbx) &&
				(xx < lbx+id[il.box+bs[y].lrot].wi) &&
				(yy > lby) &&
				(yy < lby+id[il.box+bs[y].lrot].he))
				    {
					control.asize = 0;
					makesound(3,3);
					ship[n].photI[x].flight = LAST;
					AllocateExplosion(xx,yy,6);
					AllocateDebris(xx,yy,control.standarddebris);
					bs[y].lbox = FALSE;
				    }

			rbx = bs[y].x+id[bspic].wi/2+(12*VyINC[bs[y].pos])/100-(8*VxINC[bs[y].pos])/100;
			rby = bs[y].y+id[bspic].he/2-(12*VxINC[bs[y].pos])/100-(8*VyINC[bs[y].pos])/100;
			if (bs[y].rbox == TRUE)
			if ( (xx > rbx) &&
				(xx < rbx+id[il.box+bs[y].rrot].wi) &&
				(yy > rby) &&
				(yy < rby+id[il.box+bs[y].rrot].he))
				    {
					control.asize = 0;
					makesound(3,3);
					ship[n].photI[x].flight = LAST;
					AllocateDebris(xx,yy,control.standarddebris);
					AllocateExplosion(xx,yy,6);
					bs[y].rbox = FALSE;
				    }
		    }
		else
		    {

			lx = bs[y].x+id[bspic].wi/2-(12*VxINC[bs[y].pos])/100;
			ly = bs[y].y+id[bspic].he/2-(12*VyINC[bs[y].pos])/100;
			if (bs[y].line == TRUE)
			if ( (xx > lx) &&
				(xx < lx+id[il.line+bs[y].lirot].wi) &&
				(yy > ly) &&
				(yy < ly+id[il.line+bs[y].lirot].he))
				    {
					makesound(3,3);
					ship[n].photI[x].flight = LAST;
					AllocateDebris(xx,yy,control.standarddebris);
					AllocateExplosion(xx,yy,6);
					bs[y].line = FALSE;
			    }
		    }
	    }
    }
}
