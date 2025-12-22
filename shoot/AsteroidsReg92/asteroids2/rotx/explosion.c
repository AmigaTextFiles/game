#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/extern.h>


AllocateExplosion(xx,yy,length)
LONG xx,yy,length;
{
LONG x,num=-1;

for(x=0;x<control.explosionnum;x++)
	if (e[x].flag == FALSE)
	    {
		num = x;
		break;
	    }

if (num != -1)
    {
	e[num].x = xx;
	e[num].y = yy;
	e[num].frame = 0;
	e[num].length  = length;
	e[num].flag = TRUE;
    }
}

DrawTokenExplosions()
{
LONG xx,yy,wo;
LONG n,pic;

for (n=0;n<control.explosionnum;n++)
	if (e[n].flag == TRUE)
	    {
		pic = il.explosion + e[n].frame;
		xx = e[n].x-id[pic].wi/2;
		yy = e[n].y-id[pic].he/2;
		wo = ((id[pic].wi-1)/16)+1;

		SetAPen(rp1[bit],1);
		SetWrMsk(rp1[bit],0xfd);
		BltTemplate(id[pic].data,0,wo*2,rp1[bit],xx,yy,id[pic].wi,id[pic].he);
	    }
}


EraseTokenExplosions()
{
LONG x1,y1,x2,y2;
LONG n,pic;

SetWrMsk(rp1[1-bit],0xfd);
for (n=0;n<control.explosionnum;n++)
	if (e[n].flag != FALSE)
	    {
		if (e[n].frame != 0)
		    {
			pic = il.explosion + e[n].frame - 1;
			x1 = e[n].x-id[pic].wi/2;
			y1 = e[n].y-id[pic].he/2;
			x2 = e[n].x+id[pic].wi/2;
			y2 = e[n].y+id[pic].he/2;
			RectFill(rp1[1-bit],x1,y1,x2,y2);
		    }

		if (e[n].flag == LAST) e[n].flag = FALSE;
		else
		if (++e[n].frame > e[n].length) e[n].flag = LAST;
	    }
}




IncreaseScore(n,inc)
LONG n,inc;
{
LONG x,xx,offset;
BYTE string[10];

if (control.game == 1)
    {
	if ((control.score[n]/30000)<((control.score[n]+inc)/30000))
	    {
		IncreaseLives(n,1);
		makesound(12,2);
	    }

	control.score[n]+=inc;
	sprintf(string,"%d",control.score[n]);
    }
else
    {
	control.score[n]+=inc;
	sprintf(string,"%d",control.score[n]);
    }


offset = 16*(gi.smallfontheight-2);
for (x=0;x<2;x++)
    {
	SetAPen(rp1[x],0);
	SetWrMsk(rp1[x],0xfe);

	if (n == 0) xx = gi.x1;
	else        xx = gi.wi/2;
	RectFill(rp1[x],xx+offset-1,gi.he-2*(gi.smallfontheight+1)-1,
				 xx+offset+8*(gi.smallfontheight-2),gi.he-gi.smallfontheight-2);

	SetAPen(rp1[x],2);
	Move(rp1[x],xx+offset,gi.he-gi.smallfontheight-3);
	Text(rp1[x],string,strlen(string));
    }
}

IncreaseLives(n,inc)
LONG n,inc;
{
LONG x,xx,offset;
BYTE string[10];

control.lives[n]+=inc;
sprintf(string,"%d",control.lives[n]);

offset = 16*(gi.smallfontheight-2);
for (x=0;x<2;x++)
    {
	SetWrMsk(rp1[x],0xfe);
	SetAPen(rp1[x],0);

	if (n == 0) xx = gi.x1;
	else        xx = gi.wi/2;
	RectFill(rp1[x],xx+offset-1,gi.he-gi.smallfontheight-1,
                     xx+offset+3*(gi.smallfontheight-2),gi.he-1);

	SetAPen(rp1[x],2);
	Move(rp1[x],xx+offset,gi.he-1);
	Text(rp1[x],string,strlen(string));
    }
}

IncreaseShields(n,dam)
LONG n,dam;
{
LONG x,xx,offset;
BYTE string[10];

ship[n].shield+=dam;
sprintf(string,"%d",ship[n].shield);


offset = 16*(gi.smallfontheight-2);
for(x=0;x<2;x++)
    {
	SetWrMsk(rp1[x],0xfe);
	SetAPen(rp1[x],0);

	if (n == 0) xx = gi.x1;
	else        xx = gi.wi/2;
	RectFill(rp1[x],xx+offset-1,2,
				 xx+offset+5*(gi.smallfontheight-2),gi.smallfontheight+3);

	SetAPen(rp1[x],2);
	Move(rp1[x],xx+offset,gi.smallfontheight+2);

	if (ship[n].shield < 0)	Text(rp1[x],"DEST",4);
	else					Text(rp1[x],string,strlen(string));
    }
}






AllocateBoxes(xx,yy,max)
LONG xx,yy,max;
{
LONG x,num=-1,random;
LONG n;

if (control.game != 1)
for(n=0;n<max;n++)
{
for(x=0;x<control.boxnum;x++)
	if (b[x].length == 0)
	    {
		num = x;
		break;
	    }

if (num != -1)
    {
	random = Random(100.0);

	if (random > 90) /* extra life */
	    {
		b[num].type = 0;
		b[num].image = il.diamond;
		b[num].rots = 31;
	    }
	else
	if (random > 70)  /* weapon */
	    {
		b[num].type = 1;
		b[num].image = il.box;
		b[num].rots = 15;
	    }
	else
	if (random > 50)  /* autofire */
	    {
		b[num].type = 3;
		b[num].image = il.rectangle;
		b[num].rots = 15;
	    }
	else              /* shield */
 	    {
		b[num].type = 2;
		b[num].image = il.triangle;
		b[num].rots = 15;
	    }

	b[num].length = 100;
	b[num].x = xx + Random(20.0)-10;
	b[num].y = yy + Random(16.0)-8;
    }
}
}


UpdateBoxes()
{
LONG pic;
LONG n;

for(n=0;n<control.boxnum;n++)
    {
	if (b[n].length > 2)
	    {
		CollisionBoxShips(n);

		if (++b[n].pos > b[n].rots) b[n].pos = 0;
		pic = b[n].image+b[n].pos;

		SetAPen(rp1[bit],1);
		SetWrMsk(rp1[bit],0xfd);
		BltTemplate(id[pic].data,0,2*id[pic].wo,rp1[bit],b[n].x,b[n].y,id[pic].wi,id[pic].he);
	    }
    }
}

EraseBoxes()
{
LONG n;

for (n=0;n<control.boxnum;n++)
	if (b[n].length != 0)
	    {
		SetWrMsk(rp1[1-bit],0xfd);
		RectFill(rp1[1-bit],b[n].x,b[n].y,b[n].x+id[b[n].image].wi,b[n].y+id[b[n].image].he);
		b[n].length--;
	    }
}
