#include <exec/types.h>
#include <h/rot.h>
#include <h/extern.h>

initboxes()
{
LONG x;
for (x=0;x<control.boxnum;x++) b[x].length = 0;
}

inittokenexplosions()
{
LONG x;
for (x=0;x<control.explosionnum;x++) e[x].flag = FALSE;
}


initbattleshipfighter(n)
LONG n;
{
LONG x,num=-1;

for (x=0;x<control.ftrnum;x++)
	if (f[x].flight == FALSE)
	    {
		num = x;
		break;
	    }

if (num!=-1)
    {
	f[num].x = bs[n].x + id[bs[n].image+bs[n].pos].wi/2;
	f[num].y = bs[n].y + id[bs[n].image+bs[n].pos].he/2;
	f[num].ax = Random(60.0)-30;
	f[num].ay = Random(48.0)-24;
	f[num].vmax = 3;
	f[num].pos = Random(31.0);
	f[num].flight = TRUE;

	if ((Random(100.0) > 50) && (control.playernum > 1)) f[num].aim   = 1;
	else										   f[num].aim   = 0;
    }
}


initfighters()
{
LONG xx,yy,x;

for (x=0;x<control.ftrnum;x++)
    {
	xx = gi.x1 + Random((DOUBLE)gi.dx);
	yy = gi.y1 + Random((DOUBLE)gi.dy);

	f[x].x = xx;
	f[x].y = yy;
	f[x].ax = Random(60.0)-30;
	f[x].ay = Random(48.0)-24;
	f[x].vmax = 3;
	f[x].pos = Random(31.0);
	f[x].flight = TRUE;

	if ((Random(100.0) > 50) && (control.playernum > 1)) f[x].aim   = 1;
	else										   f[x].aim   = 0;
    }
}


initsaucer()
{
LONG random;

random = Random(100.0);
if (random > 30)
    {
	saucer.type = 0;
	saucer.image = il.saucer;
    }
else
    {
	saucer.type = 1;
	saucer.image = il.asaucer;
    }

random = Random(100.0);
if (random > 50)
    {
	saucer.x     = gi.x1;
	saucer.y     = gi.y1+Random((DOUBLE)gi.dy);
	saucer.vx    = 4;
    }
else
    {
	saucer.x     = gi.x2;
	saucer.y     = gi.y1+Random((DOUBLE)gi.dy);
	saucer.vx    = -4;
    }

saucer.delay = Random(50.0);
saucer.vy    = 0;
saucer.flag  = TRUE;
saucer.rot = 0;
saucer.fnum = 10;
saucer.haltfire = FALSE;
}

initBattleship(n)
LONG n;
{
LONG x;

bs[n].x     = 300;
bs[n].y     = 200;
bs[n].pos   = 8;

bs[n].fx     = gi.x1 + Random(500.0) + 50;
bs[n].fy     = gi.y1 + Random(240.0) + 30;

bs[n].vx    = 0;
bs[n].vy    = 0;
bs[n].shield=1000;
bs[n].vmax =  1;

bs[n].man  =  3;
bs[n].turn  =  0;

bs[n].fnum = 20;
bs[n].fvmax=  10;
bs[n].fdam =  10;
bs[n].ftype=   0;

bs[n].pnum = 20;
bs[n].pvmax=  10;
bs[n].pdam =  30;
bs[n].prange = 35;
bs[n].pdelay = 300;
bs[n].pman   = 4;

bs[n].dnum = 2;

bs[n].image = il.battleship;
bs[n].flight = TRUE;

bs[n].lbox = TRUE;
bs[n].rbox = TRUE;
bs[n].line = TRUE;

for (x=0;x<bs[n].dnum;x++)
	bs[n].fdelay[x] = -1;
}


initPlayer(n)
LONG n;
{
LONG x;

ship[n].x     = gi.wi/2-10+20*n;
ship[n].y     = gi.he/2-20;
ship[n].modx  = 0;
ship[n].mody  = 0;
ship[n].pos   = 0;
ship[n].vx    = 0;
ship[n].vy    = 0;
ship[n].shield=control.shield[n];
ship[n].vmax =  6;
ship[n].man  =  0;

ship[n].fnum = 20;
ship[n].fvmax=  12;
ship[n].fdam =  20;
ship[n].flen =  10;
ship[n].ftype=   0;

ship[n].pnum = 20;
ship[n].pvmax=  10;
ship[n].pdam =  30;
ship[n].prange = 35;
ship[n].pdelay = 300;
ship[n].pman   = 4;

ship[n].blast = 0;
ship[n].aim   = 1;
ship[n].pilot = HUMAN;
ship[n].pointvalue= 1000;

if (n == 0) ship[n].image  =  il.player;
else		  ship[n].image  =  il.player2;

ship[n].shIno  =  il.shield; /* shield image number */

for (x=0;x<control.thrustlength;x++) 
    {
	ship[n].exhlx[x]=0;
	ship[n].exhly[x]=0;
	ship[n].exhrx[x]=0;
	ship[n].exhry[x]=0;
	ship[n].exhd[x]=-1;
    }

ship[n].shieldstat = NULL;
}

initAsteroids()
{
LONG x;
LONG vx,vy;

for(x=0;x<256;x++) a[x].flag = FALSE;

for (x=0;x<control.asteroidnum/4;x++)
    {
	a[x].flag = TRUE;
	a[x].size = 0;
    }

for (x=0;x<control.asteroidnum/4;x++)
    {
	a[x].x = 2*gi.x1 + Random((DOUBLE)gi.dx);
	a[x].y = gi.y1   + Random((DOUBLE)gi.dy);
	if (Random(100.0) > 50) 	a[x].dir = 1;
	else					a[x].dir = -1;

	vx = vy = 0;
	while ((vx == 0) && (vy == 0))
	    {
		vx= Random(4.0)-2;
		vy= Random(4.0)-2;
	    }
	a[x].vx = vx;
	a[x].vy = vy;
    }
}


initfirestructures(num)
LONG num;
{
LONG x;

for (x=0;x<40;x++)
	ship[num].shotI[x].flight = FALSE;

for (x=0;x<40;x++)
	ship[num].photI[x].flight = FALSE;
}

initenemy(x)
LONG x;
{
ship[x].x = gi.x1+Random((DOUBLE)gi.dx);
ship[x].y = gi.y1+Random((DOUBLE)gi.dy);
ship[x].pos   = Random(31.0);
ship[x].vx    = 0;
ship[x].vy    = 0;
ship[x].blast = 0;
ship[x].pilot = COMPUTER;
ship[x].shieldstat = NULL;
ship[x].fdelay=   0;
ship[x].pdelay =  0;

if ((Random(100.0) > 50) && (control.playernum > 1)) ship[x].aim   = 1;
else
ship[x].aim   = 0;
}

setenemy(x,type)
LONG x,type;
{

initenemy(x);

if (type == 1) /* light cruiser */
    {
	ship[x].vmax =   3;
	ship[x].man  =   1;
	ship[x].fnum =   3;
	ship[x].fvmax=   8;
	ship[x].fdam =  20;
	ship[x].flen =   5;
	ship[x].ftype=   0;
	ship[x].frate=   8;
	ship[x].pnum =   1;
	ship[x].pvmax=   8;
	ship[x].pdam =  30;
	ship[x].prange =  150;
	ship[x].pdelay =  400;
	ship[x].pman   =  5;
	ship[x].pimage =  il.photon+1;
	ship[x].image  =  il.elight;
	ship[x].shIno  =  il.shield;
	ship[x].shield=100;
	ship[x].pointvalue= 1000;
    }
else
if (type == 2) /* heavy cruiser */
    {
	ship[x].vmax =   4; /* maximum velocity */
	ship[x].man  =   3; /* maneuverability */
	ship[x].fnum =   5; /* fire number */
	ship[x].fvmax=   8; /* fire velocity */
	ship[x].fdam =  20; /* fire damage */
	ship[x].flen =   8; /* fire length */
	ship[x].ftype=   2; /* fire type   0=fwd  1=360  2=360+side */
	ship[x].frate=   4;
	ship[x].pnum =   2; /* seeking number */
	ship[x].pvmax=   8; /* seeking velocity */
	ship[x].pdam =  30; /* seeking damage */
	ship[x].prange =  150; /* seeking range */
	ship[x].pdelay =  400; /* seeking delay */
	ship[x].pman   =  5; /* seeking maneuverabilty */
	ship[x].pimage =  il.photon+1;
	ship[x].image  =  il.eheavy; /* ship image number */
	ship[x].shIno  =  il.shield; /* shield image number */
	ship[x].shield=200;
	ship[x].pointvalue= 2000;
    }
else
if (type == 3)		/* x-cruiser */
    {
	ship[x].vmax =   5;
	ship[x].man  =   1;
	ship[x].fnum =  10;
	ship[x].fvmax=   8;
	ship[x].fdam =  20;
	ship[x].flen =   8;
	ship[x].ftype=   0;
	ship[x].frate=   4;
	ship[x].pnum =   3;
	ship[x].pvmax=  12;
	ship[x].pdam =  30;
	ship[x].prange = 30;
	ship[x].prate =  32;
	ship[x].pman   =  4;
	ship[x].pimage =  il.photon+1;
	ship[x].image  =  il.xcruiser;
	ship[x].shIno  =  il.shield;
	ship[x].shield =150;
	ship[x].pointvalue= 3500;
    }
else
if (type == 4)		/* MINELAYER */
    {
	ship[x].vmax =   3; /* maximum velocity */
	ship[x].man  =   2; /* maneuverability */
	ship[x].fnum =   1; /* fire number */
	ship[x].fvmax=   8; /* fire velocity */
	ship[x].fdam =  10; /* fire damage */
	ship[x].flen =   8; /* fire length */
	ship[x].ftype=   0; /* fire type   0=fwd  1=360 */
	ship[x].pnum =   10; /* seeking number */
	ship[x].pimage =  il.photon+1;
	ship[x].image  =  il.minelayer; /* ship image number */
	ship[x].shIno  =  il.shield; /* shield image number */
	ship[x].shield = 50;
	ship[x].pointvalue= 500;
    }
else
if (type == 5)		/* dreadnought */
    {
	ship[x].vmax =   5; /* maximum velocity */
	ship[x].man  =   3; /* maneuverability */
	ship[x].fnum =   0; /* fire number */
	ship[x].fvmax=   8; /* fire velocity */
	ship[x].fdam =  20; /* fire damage */
	ship[x].flen =   8; /* fire length */
	ship[x].ftype=   0; /* fire type   0=fwd  1=360 */
	ship[x].frate=   10;
	ship[x].pnum =   14;
	ship[x].pvmax=  10;
	ship[x].pdam =  30;
	ship[x].prange =  30; /* seeking range */
	ship[x].pdelay =  400; /* seeking delay */
	ship[x].pman   =  4; /* seeking maneuverabilty */
	ship[x].pimage =  il.expander;
	ship[x].image  =  il.dreadnought; /* ship image number */
	ship[x].shIno  =  il.dreadshield; /* shield image number */
	ship[x].shield =250;
	ship[x].pointvalue= 4000;
    }
else
if (type == 6)		/* m-cruiser */
    {
	ship[x].vmax =   4; /* maximum velocity */
	ship[x].man  =   2; /* maneuverability */
	ship[x].fnum =   4; /* fire number */
	ship[x].fvmax=   8; /* fire velocity */
	ship[x].fdam =  20; /* fire damage */
	ship[x].flen =   8; /* fire length */
	ship[x].ftype=   0; /* fire type   0=fwd  1=360 */
	ship[x].frate=   3;
	ship[x].pnum =   2; /* seeking number */
	ship[x].pvmax=  10; /* seeking velocity */
	ship[x].pdam =  30; /* seeking damage */
	ship[x].prange =  150; /* seeking range */
	ship[x].pdelay =  400; /* seeking delay */
	ship[x].pman   =  4; /* seeking maneuverabilty */
	ship[x].pimage =  il.photon+1;
	ship[x].image  =  il.magnetic; /* ship image number */
	ship[x].shIno  =  il.shield; /* shield image number */
	ship[x].shield =100;
	ship[x].pointvalue= 2000;
    }


}

addenemy()
{
LONG x,xx,num=-1;
LONG r1,r2,type;


for(x=0;x<control.maxenemynum;x++)
    {
	xx = control.playernum+x;
	if ((ship[xx].pilot == DESTROYED) && (ship[xx].wait == 0))
	    {
		num = xx;
		break;
	    }
    }

if (num != -1)
    {
	makesound(7,3);

	r1 = Random(100.0);
	r2 = Random(100.0);

	if (r1 < 100-4*control.level)
	    {
		if (r2 < 40-control.level) type = 1; /* light cruiser */
		else
		if (r2 < 80-control.level) type = 4; /* minelayer */
		else					  type = 2; /* heavy cruiser */
	    }
	else
	    {
		if (r2 < 40) type = 3; /* x-cruiser */
		else
		if (r2 < 70) type = 5; /* dreadnought */
		else		   type = 6; /* m-cruiser */
	    }
	control.enemynum++;
	setenemy(num,type);
    }
}
