#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/extern.h>



AllocateMine(xx,yy)
LONG xx,yy;
{
LONG x,num=-1;

for(x=0;x<control.minenum;x++)
	if (m[x].flight == FALSE)
	    {
		num = x;
		break;
	    }

if (num != -1)
    {
	m[num].x = xx;
	m[num].y = yy;
	m[num].rot = Random(15.0);
	m[num].flight = TRUE;
    }
}


UpdateMines()
{
LONG wo,he,wi;
LONG x,dx,dy;
LONG n;


for (n=0;n<control.minenum;n++)
{
if (m[n].flight == TRUE)
    {
	for (x=0;x<control.playernum;x++)
		if (ship[x].pilot != DESTROYED)
		    {
			dx = abs(m[n].x - ship[x].x);
			dy = abs(m[n].y - ship[x].y);

			if (dx+dy < 40)
			    {
				Firehit(x,50,10);
				AllocateExplosion(m[n].x,m[n].y,6);
				m[n].flight = LAST;
			    }
		    }

	if (m[n].flight == TRUE)
	    {
		SetAPen(rp1[bit],2);
		SetWrMsk(rp1[bit],0xfe);
		if (++m[n].rot > 3) m[n].rot = 0;
		wo = 2*id[il.mine+m[n].rot].wo;
		wi = id[il.mine+m[n].rot].wi;
		he = id[il.mine+m[n].rot].he;
		BltTemplate(id[il.mine+m[n].rot].data,0,wo,rp1[bit],m[n].x,m[n].y,wi,he);
	    }
    }
}
}


EraseMines()
{
LONG x;

for (x=0;x<control.minenum;x++)
    {
	SetWrMsk(rp1[1-bit],0xfe);
	if (m[x].flight != FALSE)
		RectFill(rp1[1-bit],m[x].x,m[x].y,m[x].x+id[il.mine+m[x].rot].wi,m[x].y+id[il.mine+m[x].rot].he);

	if (m[x].flight == LAST) m[x].flight = FALSE;
    }
}


UpdateMineLayer(n)
LONG n;
{
LONG direction;
LONG wi,he,wo;
LONG modpos,pic;
LONG dx,dy;

ship[n].ox = ship[n].x;
ship[n].oy = ship[n].y;

if (ship[n].pilot == COMPUTER)
{

moveenemy(n);

ship[n].vx = ship[n].vmax*VxINC[ship[n].pos];
ship[n].vy = ship[n].vmax*VyINC[ship[n].pos];

if (ship[ship[n].aim].pilot == DESTROYED)
    {
	if (control.playernum > 1) ship[n].aim = abs(1+control.maxplayernum-control.playernum);
    }
else
if (++ship[n].turn > ship[n].man)
    {
	modpos = ship[n].pos+16;
	if (modpos > 31) modpos-=31;

	direction = detcomplexheading(n,ship[ship[n].aim].x,ship[ship[n].aim].y,ship[n].x,ship[n].y,modpos);

	if (--ship[n].pdelay <= 0)
	    {
		if (--ship[n].pnum < 0)
		    {
			ship[n].shield = 0;
			ship[n].pilot=DESTROYED;
			control.enemynum--;
		    }
		else
		    {
			ship[n].pdelay = 20;
			AllocateMine(ship[n].x+id[ship[n].image].wi/2,ship[n].y+id[ship[n].image].he/2);
		    }
	    }

	dx = abs(ship[ship[n].aim].x-ship[n].x);
	dy = abs(ship[ship[n].aim].y-ship[n].y);
	if ((direction != 0) && (dx+dy < 200))
	    {
		direction = sign(direction);
		ship[n].pos+=direction;
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
