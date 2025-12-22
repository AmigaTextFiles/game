#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/extern.h>



AllocateHyper(xx,yy)
LONG xx,yy;
{
LONG x,num,n;

for (n=0;n<8;n++)
    {
	num=-1;
	for(x=0;x<control.hypernum;x++)
		if (h[x].flag == FALSE)
		    {
			num = x;
			break;
		    }

	if (num != -1)
	    {
		h[num].flag = TRUE;
		h[num].x = xx+(200*VxINC[n*4])/100;
		h[num].y = yy+(150*VyINC[n*4])/100;
		h[num].destx = xx;
		h[num].desty = yy;
		h[num].vx = (20*VxINC[n*4])/100;
		h[num].vy = (15*VyINC[n*4])/100;
		h[num].rot = Random(31.0);
		h[num].image = il.triangle;
	    }
    }
}

UpdateHyper()
{
LONG n;
LONG wo,he,wi;
LONG pic;

for(n=0;n<control.hypernum;n++)
{

if (h[n].flag != FALSE)
    {
	h[n].ox = h[n].x;
	h[n].oy = h[n].y;
    }

if (h[n].flag == TRUE)
    {
	h[n].x -= h[n].vx;
	h[n].y -= h[n].vy;

	if (abs(h[n].x-h[n].destx)+abs(h[n].y-h[n].desty) < 20)
	    {
		h[n].flag = LAST;
	    }
	else
	    {
		SetAPen(rp1[bit],1);
		SetWrMsk(rp1[bit],0xfd);
		if (++h[n].rot > 15) h[n].rot = 0;
		pic = h[n].image+h[n].rot;
		wo = 2*id[pic].wo;
		wi = id[pic].wi;
		he = id[pic].he;

		if ((h[n].x > gi.x1) && (h[n].x < gi.x2) &&
		    (h[n].y > gi.y1) && (h[n].y < gi.y2))
			BltTemplate(id[pic].data,0,wo,rp1[bit],h[n].x,h[n].y,wi,he);
	    }
    }
}
}

EraseHyper()
{
LONG x,pic;

for (x=0;x<control.hypernum;x++)
    {
	if (h[x].flag != FALSE)
	    {
		SetWrMsk(rp1[1-bit],0xfd);
		if (h[x].flag == LAST) h[x].flag = FALSE;
		pic = h[x].image+h[x].rot;
		if ((h[x].ox > gi.x1) && (h[x].ox < gi.x2) &&
		    (h[x].oy > gi.y1) && (h[x].oy < gi.y2))
			RectFill(rp1[1-bit],h[x].ox,h[x].oy,h[x].ox+id[pic].wi,h[x].oy+id[pic].he);
	    }
    }
}




UpdateDebris()
{
LONG wo,he,wi;
LONG pic,n;

for (n=0;n<control.debrisnum;n++)
{
if (d[n].length >= 0)
    {
	d[n].ox = d[n].x;
	d[n].oy = d[n].y;
    }

if (d[n].length > 2)
    {
	if (d[n].length %6 == 0)
		if (--d[n].vmax < 3) d[n].vmax = 3;

	d[n].x += (d[n].vmax*VxINC[d[n].pos])/100;
	d[n].y += (d[n].vmax*VyINC[d[n].pos])/100;

	if ((d[n].x > gi.x2) || (d[n].x < gi.x1) ||
	    (d[n].y > gi.y2) || (d[n].y < gi.y1))
	    {
		d[n].length = 1;
	    }
	else
	    {
		SetAPen(rp1[bit],1);
		SetWrMsk(rp1[bit],0xfd);
		if (++d[n].rot > 31) d[n].rot = 0;
		if (d[n].image ==  il.line) pic = d[n].image+d[n].rot/2;
		else					   pic = d[n].image+d[n].rot;
		wo = 2*id[pic].wo;
		wi = id[pic].wi;
		he = id[pic].he;
		BltTemplate(id[pic].data,0,wo,rp1[bit],d[n].x,d[n].y,wi,he);
	    }
    }
}
}


EraseDebris()
{
LONG x,pic;

for (x=0;x<control.debrisnum;x++)
    {
	if (d[x].length != 0)
	    {
		SetWrMsk(rp1[1-bit],0xfd);
		d[x].length--;
		if (d[x].image ==  il.line) pic = d[x].image+d[x].rot/2;
		else					   pic = d[x].image+d[x].rot;
		RectFill(rp1[1-bit],d[x].ox,d[x].oy,d[x].ox+id[pic].wi,d[x].oy+id[pic].he);
	    }
    }
}




AllocateDebris(xx,yy,max)
LONG xx,yy,max;
{
LONG x,num,n;

for (n=0;n<max;n++)
    {
	num=-1;
	for(x=0;x<control.debrisnum;x++)
		if (d[x].length == 0)
		    {
			num = x;
			break;
		    }

	if (num != -1)
	    {
		d[num].x = xx+Random(10.0)-5;
		d[num].y = yy+Random(8.0)-4;
		d[num].pos = Random(31.0);
		d[num].rot = Random(7.0);
		d[num].length = 48;
		if (Random(100.0) < 80)
		    {
			d[num].image = il.line;
			d[num].vmax = Random(9.0)+3;
		    }
		else
		    {
			d[num].image = il.debris;
			d[num].vmax = Random(5.0)+3;
		    }
	    }
    }
}




UpdateFighters()
{
LONG wo,he,wi;
LONG xx,yy;
LONG shpic;
LONG pic;
LONG n;


for(n=0;n<control.ftrnum;n++)
{
if (f[n].flight != FALSE)
    {
	f[n].ox = f[n].x;
	f[n].oy = f[n].y;
    }

if (f[n].flight == TRUE)
    {
	if (ship[f[n].aim].pilot == DESTROYED)
	    {
		if (control.playernum > 1) f[n].aim = abs(/*maxplayernum*/2-control.playernum);
	    }
	else
	    {
		shpic = ship[f[n].aim].image+ship[f[n].aim].pos;
		xx = ship[f[n].aim].x + id[shpic].wi/2 + f[n].ax;
		yy = ship[f[n].aim].y + id[shpic].he/2 + f[n].ay;
		
		f[n].pos += detcomplexheading(0,xx,yy,f[n].x,f[n].y,f[n].pos);
		if (f[n].pos > 31) f[n].pos = 0;
		else
		if (f[n].pos < 0) f[n].pos = 31;

		if ((xx = f[n].x) && (yy == f[n].y))
		    {
			f[n].ax = Random(60.0)-30;
			f[n].ay = Random(48.0)-24;
		    }
	    }

	f[n].x += (f[n].vmax*VxINC[f[n].pos])/100; + Random(1.0);
	f[n].y += (f[n].vmax*VyINC[f[n].pos])/100; + Random(1.0);

	SetAPen(rp1[bit],2);
	SetWrMsk(rp1[bit],0xfe);
	pic = il.fighter+f[n].pos/2;
	wo = 2*id[pic].wo;
	wi = id[pic].wi;
	he = id[pic].he;

	if (f[n].x+wi+1 >= gi.x2) f[n].x = gi.x1+1;
	if (f[n].x      <= gi.x1) f[n].x = gi.x2-wi-1;
	if (f[n].y+he+1 >= gi.y2) f[n].y = gi.y1+1;
	if (f[n].y      <= gi.y1) f[n].y = gi.y2-he-1;

	BltTemplate(id[pic].data,0,wo,rp1[bit],f[n].x,f[n].y,wi,he);
    }
}
}


EraseFighters()
{
LONG x;

control.fighter = FALSE;
for (x=0;x<control.ftrnum;x++)
	if (f[x].flight == TRUE)
	    {
		control.fighter = TRUE;
		break;
	    }

for (x=0;x<control.ftrnum;x++)
    {
	SetWrMsk(rp1[1-bit],0xfe);
	if (f[x].flight != FALSE)
		RectFill(rp1[1-bit],f[x].ox,f[x].oy,f[x].ox+id[il.fighter+f[x].pos/2].wi,f[x].oy+id[il.fighter+f[x].pos/2].he);

	if (f[x].flight == LAST) f[x].flight = FALSE;
    }
}




DrawFighterFire()
{
LONG dx,dy;
LONG n;

for(n=0;n<control.ftrnum;n++)
{
if (f[n].flight == TRUE) 
{
if ((f[n].fire == FALSE) && (ship[f[n].aim].pilot != DESTROYED))
    {
	dx = abs(f[n].x - ship[f[n].aim].x);
	dy = abs(f[n].y - ship[f[n].aim].y);
	if (((dx+dy) < 60) && (--f[n].delay <= 0))
	    {
		Firehit(f[n].aim,1,2);
		f[n].fdelay = 5;
		f[n].delay = 30;
		f[n].fire = TRUE;
	    }
    }
else
    {
	f[n].ox1 = f[n].x1;
	f[n].oy1 = f[n].y1;
	f[n].ox2 = f[n].x2;
	f[n].oy2 = f[n].y2;
    }

if (f[n].fire == TRUE)
    {
	f[n].x1 = f[n].x + id[il.fighter+f[n].pos/2].wi/2;
	f[n].y1 = f[n].y + id[il.fighter+f[n].pos/2].he/2;
	f[n].x2 = ship[f[n].aim].x + id[ship[f[n].aim].image+ship[f[n].aim].pos].wi/2;
	f[n].y2 = ship[f[n].aim].y + id[ship[f[n].aim].image+ship[f[n].aim].pos].he/2;

	SetAPen(rp1[bit],1);
	SetWrMsk(rp1[bit],0xfd);
	Move(rp1[bit],f[n].x1,f[n].y1);
	Draw(rp1[bit],f[n].x2,f[n].y2);
    }
}
}
}

EraseFighterFire()
{
LONG n;

for(n=0;n<control.ftrnum;n++)
{
if (f[n].fire != FALSE)
    {
	if (f[n].fire == LAST) f[n].fire = FALSE;
	else
	if (--f[n].fdelay == 0) f[n].fire = LAST;
	
	SetWrMsk(rp1[1-bit],0xfd);
	Move(rp1[1-bit],f[n].ox1,f[n].oy1);
	Draw(rp1[1-bit],f[n].ox2,f[n].oy2);
    }
}
}
