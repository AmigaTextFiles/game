#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/extern.h>


initInput(x)
LONG x;
{
LONG n;

n = control.input[x];

in.FI[n] = FALSE;
in.FIUP[n] = TRUE;
in.HY[n] = FALSE;
in.TH[n] = FALSE;

in.PAUSE = FALSE;
in.EXIT = FALSE;
in.NEXT = FALSE;
}

initLEVEL()
{
LONG x,y;

for (x=control.playernum;x<control.playernum+control.maxenemynum;x++)
    {
	ship[x].pilot = DESTROYED;
	for (y=0;y<ship[x].fnum;y++) ship[x].shotI[y].flight = FALSE;
    }

saucer.flag = FALSE;
if (control.game == 1) control.asteroidnum = 8+control.level*8;
else				   control.asteroidnum = 12+control.level*4;
control.asize = 0;

ClearScreen();
DrawGameScreen();
initAsteroids();

for(x=0;x<control.ftrnum;x++)
	f[x].flight = FALSE;

for (x=0;x<control.playernum;x++)
    {
	control.hyper[x] = 0;
	if (control.player[x] == TRUE)
		initPlayer(x);
	initfirestructures(x);
    }

for(x=0;x<control.maxenemynum+control.playernum;x++)
    {
	initfirestructures(x);
	ship[x].ox = 200;
	ship[x].oy = 200;
    }
for (x=0;x<saucer.fnum;x++) saucer.photI[x].flight = FALSE;

control.enemynum=0;

inittokenexplosions();
initboxes();

for(x=0;x<control.battleshipnum;x++)
	bs[x].flight=FALSE;

for(x=0;x<control.debrisnum;x++)
	d[x].length=0;

for(x=0;x<control.minenum;x++)
	m[x].flight = FALSE;

for(x=0;x<control.hypernum;x++)
	h[x].flag = FALSE;

/*if (control.game != 1) initMines(Random(3.0));*/

for(x=0;x<2;x++) initInput(x);
}


DisplayLevel()
{
LONG x,y=0;
BYTE string[20];
BOOL getout = FALSE;

for (x=0;x<control.playernum;x++)
		ship[x].pilot = DESTROYED;

timedelay(2000);  /* prime the pump */

while (getout == FALSE)
{
getjoystickinput();
 
bit^=1;

SetAPen(rp1[bit],2);
SetWrMsk(rp1[bit],0xfe);
SetFont(rp1[bit],basicfont);
sprintf(string,"LEVEL %d",control.level);
Move(rp1[bit],gi.wi/2-100,gi.he/2-20);
Text(rp1[bit],string,strlen(string));

for (x=0;x<control.asteroidnum;x++)
	if (a[x].flag != FALSE) UpdateAsteroid(x);

dodrawlist();

waitfortimer();
timedelay(control.delay);
WaitBlit();
changeview(bit);

SetAPen(rp1[1-bit],0);

EraseAsteroids();

if (++y > 50)
    {
	if ((CheckAsteroidWindow(0) == TRUE) && (CheckAsteroidWindow(1) == TRUE))
		getout = TRUE;

	if ((in.FI[0] == TRUE) || (in.FI[1] == TRUE)) getout = TRUE;
    }
else
    {
	if (in.EXIT == TRUE) getout = TRUE;
	else in.FI[0] = in.FI[1] = FALSE;
    }
}

for (x=0;x<2;x++) SetFont(rp1[x],hiresfont);

for (x=0;x<control.playernum;x++)
	if (control.player[x] == TRUE) ship[x].pilot = HUMAN;

for (y=0;y<2;y++) 
    {
	SetAPen(rp1[y],0);
	SetWrMsk(rp1[y],0xfe);
	RectFill(rp1[y],gi.wi/2-101,gi.he/2-20-gi.largefontheight-3,gi.wi/2+150,gi.he/2-19);
    }
}


CheckAsteroidWindow(n)
LONG n;
{
BOOL out;
LONG x,p;

out = TRUE;
for (x=0;x<control.asteroidnum;x++)
	if (a[x].flag != FALSE)
		for(p=0;p<control.playernum;p++)
		    {
			if ((control.player[p] == TRUE) && (n == p))
				if ((abs(a[x].x - gi.wi/2) < 70+abs(a[x].vx*10)) && (abs(a[x].y - (gi.he/2-20)) < 50+abs(a[x].vy*10)))
				    {
					out = FALSE;
					break;
				    }
		    }

if (saucer.flag == TRUE)
	if ((abs(saucer.x - 310) < 75) && (abs(saucer.y - 200) < 50)) 
		out = FALSE;

return(out);
}


printendgame()
{
SetAPen(rp1[bit],2);
SetWrMsk(rp1[bit],0xfe);
SetFont(rp1[bit],basicfont);

Move(rp1[bit],gi.wi/2-100,gi.he/2-20);
Text(rp1[bit],"GAME OVER",9);

SetFont(rp1[bit],hiresfont);
}


Information()
{
LONG x;
LONG wi,he,wo;
LONG sax,say,sapos;
LONG sattx,satty,sattpos;
LONG ax[3],ay[3],ap[3];
LONG bx[4],by[4],bp[4];
LONG off;
LONG spos[10];
LONG sxx[10],syy[10];
LONG simage[10];

off = gi.wi/2-320;

for (x=0;x<2;x++)
    {
	SetAPen(rp1[x],2);
	SetWrMsk(rp1[x],0xfe);
	SetFont(rp1[x],basicfont);
	Move(rp1[x],off+220,40);
	Text(rp1[x],"ASTERIODS II",12);

	SetFont(rp1[x],sfont);
	Move(rp1[x],off+350,260);
	Text(rp1[x],"KEYBOARD COMMANDS",17);
	Move(rp1[x],off+360,280);
	Text(rp1[x],"Z,X  ROTATE",11);
	Move(rp1[x],off+360,290);
	Text(rp1[x],"<,>  THRUST",11);
	Move(rp1[x],off+360,300);
	Text(rp1[x],"<.>  FIRE",9);
	Move(rp1[x],off+360,310);
	Text(rp1[x],"</>  HYPERSPACE",15);
	Move(rp1[x],off+360,320);
	Text(rp1[x],"<SPACE>  PAUSE",14);

	Move(rp1[x],off+483,260);
	Text(rp1[x],"JOYSTICK COMMANDS",17);
	Move(rp1[x],off+480,280);
	Text(rp1[x],"LEFT/RIGHT  ROTATE",18);
	Move(rp1[x],off+480,290);
	Text(rp1[x],"UP          THRUST",18);
	Move(rp1[x],off+480,300);
	Text(rp1[x],"BUTTON      FIRE",16);
	Move(rp1[x],off+480,310);
	Text(rp1[x],"BACK        HYPERSPACE",22);

	Move(rp1[x],off+400,340);
	Text(rp1[x],"FOR GAME REGISTRATION,",22);
	Move(rp1[x],off+400,350);
	Text(rp1[x],"BUG REPORTS, OR",15);
	Move(rp1[x],off+400,360);
	Text(rp1[x],"SOURCE INFORMATION, SEND",24);
	Move(rp1[x],off+400,370);
	Text(rp1[x],"INTERNET MAIL TO:",17);
	Move(rp1[x],off+400,380);
	Text(rp1[x],"seifert@gn.ecn.purdue.edu",25);
	Move(rp1[x],off+400,390);
	Text(rp1[x],"OR CALL (317)743-5999",21);


	Move(rp1[x],off+255,60);
	Text(rp1[x],"DESIGNED AND CODED BY MIKE SEIFERT",34);

	Move(rp1[x],off+0,130);
	Text(rp1[x],"PLAYER 1 CRUISER",16);

	Move(rp1[x],off+125,130);
	Text(rp1[x],"PLAYER 2 CRUISER",16);

	Move(rp1[x],off+250,130);
	Text(rp1[x],"ENEMY LIGHT CRUISER",19);
	Move(rp1[x],off+266,140);
	Text(rp1[x],"1000 POINTS",11);

	Move(rp1[x],off+375,130);
	Text(rp1[x],"ENEMY HEAVY CRUISER",19);
	Move(rp1[x],off+391,140);
	Text(rp1[x],"3000 POINTS",11);

	Move(rp1[x],off+505,130);
	Text(rp1[x],"ENEMY CARRIER",13);
	Move(rp1[x],off+510,140);
	Text(rp1[x],"5000 POINTS",11);



	Move(rp1[x],off+0,200);
	Text(rp1[x],"ENEMY X CRUISER",15);
	Move(rp1[x],off+8,210);
	Text(rp1[x],"3500 POINTS",11);

	Move(rp1[x],off+125,200);
	Text(rp1[x],"ENEMY MINELAYER",15);
	Move(rp1[x],off+135,210);
	Text(rp1[x],"500 POINTS",10);

	Move(rp1[x],off+250,200);
	Text(rp1[x],"ENEMY DREADNOUGHT",17);
	Move(rp1[x],off+262,210);
	Text(rp1[x],"4000 POINTS",11);

	Move(rp1[x],off+375,200);
	Text(rp1[x],"ENEMY M-CRUISER",15);
	Move(rp1[x],off+383,210);
	Text(rp1[x],"2000 POINTS",11);

	Move(rp1[x],off+500,200);
	Text(rp1[x],"ENEMY FIGHTERS",14);
	Move(rp1[x],off+510,210);
	Text(rp1[x],"50 POINTS",9);


	Move(rp1[x],off+250,275);
	Text(rp1[x],"SCOUT SAUCER",12);
	Move(rp1[x],off+254,285);
	Text(rp1[x],"500 POINTS",10);

	Move(rp1[x],off+250,330);
	Text(rp1[x],"ATTACK SAUCER",13);
	Move(rp1[x],off+254,340);
	Text(rp1[x],"1500 POINTS",11);

	Move(rp1[x],off+255,390);
	Text(rp1[x],"MINEFIELD",9);



	Move(rp1[x],off+125,260);
	Text(rp1[x],"LARGE ASTEROID",14);
	Move(rp1[x],off+125,270);
	Text(rp1[x],"50 POINTS",9);

	Move(rp1[x],off+125,300);
	Text(rp1[x],"MEDIUM ASTEROID",15);
	Move(rp1[x],off+125,310);
	Text(rp1[x],"100 POINTS",10);

	Move(rp1[x],off+125,330);
	Text(rp1[x],"SMALL ASTEROID",14);
	Move(rp1[x],off+125,340);
	Text(rp1[x],"150 POINTS",10);

	Move(rp1[x],off+125,369);
	Text(rp1[x],"WEAPON FLOTSAM",14);

	Move(rp1[x],off+125,384);
	Text(rp1[x],"LIFE FLOTSAM",12);

	Move(rp1[x],off+125,399);
	Text(rp1[x],"SHIELD FLOTSAM",14);

	Move(rp1[x],off+125,414);
	Text(rp1[x],"AUTOFIRE FLOTSAM",16);
    }

ax[0] = off+75;
ay[0] = 245;
ap[0] = 0;

ax[1] = off+80;
ay[1] = 290;
ap[1] = 0;

ax[2] = off+85;
ay[2] = 325;
ap[2] = 0;

bx[0] = off+90;
by[0] = 360;
bp[0] = 0;

bx[1] = off+90;
by[1] = 375;
bp[1] = 1;

bx[2] = off+90;
by[2] = 390;
bp[2] = 2;

bx[3] = off+90;
by[3] = 405;
bp[3] = 3;


for(x=0;x<5;x++)
    {
	spos[x] = 0;
	sxx[x] = off+40+125*x;
	syy[x] = 100;
    }

for(x=0;x<4;x++)
    {
	spos[5+x] = 0;
	sxx[5+x] = off+40+125*x;
	syy[5+x] = 170;
    }

simage[0] = il.player;
simage[1] = il.player2;
simage[2] = il.elight;
simage[3] = il.eheavy;
simage[4] = il.carrier;
simage[5] = il.xcruiser;
simage[6] = il.minelayer;
simage[7] = il.dreadnought;
simage[8] = il.magnetic;

sapos = 0;
sax = off+265;
say = 250;

sattpos = 2;
sattx = off+265;
satty = 305;


for (x=0;x<8;x++)
    {
	f[x].x = off+525+Random(24.0)-12;
	f[x].y = 170+Random(14.0)-7;
	f[x].pos = Random(31.0);
    }

for (x=0;x<4;x++)
    {
	m[x].x = off+265+Random(24.0)-12;
	m[x].y = 365+Random(14.0)-7;
	m[x].rot = Random(3.0);
    }


in.KEY = NULL;


timedelay(2000);  /* prime the pump */

while (in.KEY == NULL)
{
bit^=1;
SetAPen(rp1[bit],1);
SetWrMsk(rp1[x],0xfd);

for (x=0;x<9;x++)
    {
	if (++spos[x] > 31) spos[x] = 0;
	wi = id[simage[x]].wi;
	he = id[simage[x]].he;
	wo = 2*id[simage[x]].wo;
	BltTemplate(id[simage[x]+spos[x]].data,0,wo,rp1[bit],sxx[x]-wi/2,syy[x]-he/2,wi,he);
    }


for (x=0;x<8;x++)
    {
	f[x].pos+=2;
	if (f[x].pos > 31) f[x].pos -= 32;
	wo =2*id[il.fighter+f[x].pos/2].wo;
	wi =  id[il.fighter+f[x].pos/2].wi;
	he =  id[il.fighter+f[x].pos/2].he;
	BltTemplate(id[il.fighter+f[x].pos/2].data,0,wo,rp1[bit],f[x].x,f[x].y,wi,he);
    }


for (x=0;x<4;x++)
    {
	if (++m[x].rot > 3) m[x].rot = 0;
	wo =2*id[il.mine+m[x].rot].wo;
	wi =  id[il.mine+m[x].rot].wi;
	he =  id[il.mine+m[x].rot].he;
	BltTemplate(id[il.mine+m[x].rot].data,0,wo,rp1[bit],m[x].x,m[x].y,wi,he);
    }

if (++sapos > 4) sapos = 0;
wi = id[il.saucer+sapos].wi;
he = id[il.saucer+sapos].he;
wo = 2*id[il.saucer+sapos].wo;
BltTemplate(id[il.saucer+sapos].data,0,wo,rp1[bit],sax,say,wi,he);

if (++sattpos > 4) sattpos = 0;
wi = id[il.asaucer+sattpos].wi;
he = id[il.asaucer+sattpos].he;
wo = 2*id[il.asaucer+sattpos].wo;
BltTemplate(id[il.asaucer+sattpos].data,0,wo,rp1[bit],sattx,satty,wi,he);

for (x=0;x<3;x++)
    {
	if (x == 0) if (++ap[x] > 63) ap[x] = 0;
	if (x == 1) if (++ap[x] > 31) ap[x] = 0;
	if (x == 2) if (++ap[x] > 15) ap[x] = 0;

	wi = id[il.asteroid[x]].wi;
	he = id[il.asteroid[x]].he;
	wo = 2*id[il.asteroid[x]].wo;
	BltTemplate(id[il.asteroid[x]+ap[x]].data,0,wo,rp1[bit],ax[x],ay[x],wi,he);
    }

if (++bp[0] > 15) bp[0] = 0;
if (++bp[1] > 31) bp[1] = 0;
if (++bp[2] > 15) bp[2] = 0;
if (++bp[3] > 15) bp[3] = 0;

wi = id[il.box+bp[0]].wi;
he = id[il.box+bp[0]].he;
wo = 2*id[il.box+bp[0]].wo;
BltTemplate(id[il.box+bp[0]].data,0,wo,rp1[bit],bx[0],by[0],wi,he);

wi = id[il.diamond+bp[1]].wi;
he = id[il.diamond+bp[1]].he;
wo = 2*id[il.diamond+bp[1]].wo;
BltTemplate(id[il.diamond+bp[1]].data,0,wo,rp1[bit],bx[1],by[1],wi,he);

wi = id[il.triangle+bp[2]].wi;
he = id[il.triangle+bp[2]].he;
wo = 2*id[il.triangle+bp[2]].wo;
BltTemplate(id[il.triangle+bp[2]].data,0,wo,rp1[bit],bx[2],by[2],wi,he);

wi = id[il.rectangle+bp[3]].wi;
he = id[il.rectangle+bp[3]].he;
wo = 2*id[il.rectangle+bp[3]].wo;
BltTemplate(id[il.rectangle+bp[3]].data,0,wo,rp1[bit],bx[3],by[3],wi,he);


waitfortimer();
WaitBlit();
changeview(bit);
timedelay(control.delay);

SetWrMsk(rp1[1-bit],0xfd);
SetRast(rp1[1-bit],0);
}


in.KEY=NULL;
SetAPen(rp1[0],1);
changeview(0);
}
