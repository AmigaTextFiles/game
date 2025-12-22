#include <exec/types.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <graphics/gels.h>
#include <graphics/gfxbase.h>
#include <graphics/rastport.h>
#include <stdio.h>
#include <h/rot.h>
#include <h/define.h>

struct imagedata id[800];
struct vectordata v[40];
struct imagelocation il;
struct drawlist dl[400];

struct gameinfo gi;
struct control control;
struct gameinput in;

struct ship ship[7];
struct asteroid a[256];
struct explosion e[32];
struct fighter f[200];
struct saucer saucer;
struct box b[40];
struct battleship bs[5];
struct mine m[40];
struct highscorelist hsl[20];
struct saveoptions so;
struct debris d[100];
struct hyper h[100];
struct keys k;

extern struct TextFont *basicfont;
extern struct TextFont *hiresfont;
extern struct TextFont *fixplain7font;
extern struct RastPort *rp1[2];
extern struct Screen *screen;
extern struct Window *masterwindow;

struct NewWindow newpausewindow =
{
270,200,160,50,0,0,RAWKEY,
NOCAREREFRESH | ACTIVATE | BORDERLESS,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
CUSTOMSCREEN
};


BYTE VxINC[32] = { 0,20,38,56,71,83,92,98,100,98,92,83,71,56,38,20,0,-20,-38,-56,-71,-83,-92,-98,-100,-98,-92,-83,-71,-56,-38,-20 };
BYTE VyINC[32] = { -100,-98,-92,-83,-71,-56,-38,-20,0,20,38,56,71,83,92,98,100,98,92,83,71,56,38,20,0,-20,-38,-56,-71,-83,-92,-98 };

UBYTE bit;

main()
{
LONG x;

OpenLibraries();
GetDefaults();
LoadOptions();
SetGameScreen();
SetGameFont();
LoadKeyDefines();
Initialization();

for (;;)
    {
	bit=1;

	for(x=0;x<control.maxplayernum;x++)
	    {
		control.shield[x]=200;
		control.score[x] = 0;
		control.tech[x] = 0;
		control.lives[x] = 3;
		control.weapon[x] = 0;
		control.fire[x] = 0;
		control.hyper[x] = 0;
		control.firecount[x] = 0;
	    }
	control.endgamewait = 0;
	control.endgame = FALSE;
	control.enemynum = 0;
	for (x=0;x<control.playernum;x++)
		control.player[x]=TRUE;

	ClearScreen();
	changeview(0);
	WaitStart();

	ClearScreen();
	DrawGameScreen();
	control.level = control.startlevel;
	StartGame();
    }
}



ReplaceShip(n)
LONG n;
{
LONG x;

if (control.lives[n] == 0)
    {
	if (control.endgame == FALSE)
	    {
		control.player[n] = FALSE;

		control.endgame = TRUE;
		for(x=0;x<control.playernum;x++)
			if (control.player[x] == TRUE)
			    {
				control.endgame = FALSE;
			    }
		if (control.endgame == TRUE) control.endgamewait = 60;
	    }
    }
else
if (--control.wait[n] < 0)
	if ((CheckAsteroidWindow(n) == TRUE) ||
	   ((in.FI[0] == TRUE) && (control.input[n] == 0)) || ((in.FI[1] == TRUE) && (control.input[n] == 1)))
		    {
			initPlayer(n);
			control.wait[n] = 30;
			IncreaseShields(n,0);
			IncreaseLives(n,-1);
			initInput(n);
		    }
}



StartGame()
{
LONG x;

for (;;)				/*  main loop  */
{
if (control.endgame == FALSE)
    {
	makesound(10,3);
	initLEVEL();
	DisplayLevel();
	for(x=0;x<2;x++) initInput(x);
	AsteroidLoop();

	if (control.endgame == FALSE)	control.level++;
    }
else
    {
	for(x=0;x<control.playernum;x++)
		if (control.score[x] > hsl[19].score)
		    {
			ClearScreen();
			changeview(0);
			dohighscorelist(x);
		    }
	return;
    }
}
}



AsteroidLoop()
{
LONG x,anum=1;
LONG random;


#if REGISTERED == FALSE
if ((control.game == 0) && (control.level > 1+1+1+1+1))
    {
	control.endgame = TRUE;
	for(x=0;x<control.playernum;x++)
	    {
		control.lives[x] = 0;
		ship[x].pilot = DESTROYED;
	    }
    }
#endif


while(anum > 0)
{
bit^=1;

getjoystickinput();

random = Random(1000.0);
if ((random > 996-control.level) && (saucer.flag == FALSE)) initsaucer();

if (control.game != 1)
    {
	if (control.fighter == FALSE)
		for(x=0;x<control.playernum;x++)
			if ((ship[x].shield < 50) && (ship[x].pilot != DESTROYED))
			    {
				initfighters();
				break;
			    }

	random = Random(1000.0);
	if ((random > (997-control.level)) && (control.enemynum < control.enemyonscreen))
		addenemy();
    }


for(x=0;x<control.playernum;x++)
	if ((ship[x].pilot == DESTROYED) && (control.player[x] == TRUE) && (control.hyper[x] == 0))
		ReplaceShip(x);


if (control.endgame == TRUE)
    {
	printendgame();
	control.endgamewait--;
	if ((control.endgamewait <= 0) && 
	   ((control.score[0] > hsl[19].score) || (control.score[1] > hsl[19].score)))
		return;
    }


for(x=0;x<control.playernum;x++)
    {
	if ((ship[x].pilot != DESTROYED) && (control.player[x] == TRUE))
		HandleInput(x,control.input[x]);
    }

if (in.FI[0] == TRUE) in.FI[0] = FALSE;
if (in.FI[1] == TRUE) in.FI[1] = FALSE;

if (in.EXIT == TRUE)
    {
	control.endgame = TRUE;
	return;
    }
if ((in.PAUSE == TRUE) && (bit == 1)) handlePause();


for (x=0;x<control.playernum;x++)
    {
	if (control.hyper[x] > 0)
	    {
		if (--control.hyper[x] == 0) ship[x].pilot = HUMAN;
	    }
	else UpdatePlayer(x);
    }

for (x=control.playernum;x<control.playernum+control.maxenemynum;x++)
    {
	if (--ship[x].wait < 0) ship[x].wait = 0;

	if (ship[x].image == il.minelayer) UpdateMineLayer(x);
	else
	if (ship[x].image == il.magnetic) UpdateMCruiser(x);
	else
	if (ship[x].image == il.xcruiser) UpdateXCruiser(x);
	else
	if (ship[x].image == il.dreadnought) UpdateDreadnought(x);
	else							  UpdateCruiser(x);
    }

for (x=0;x<control.maxenemynum+control.playernum;x++)
    {
	DrawFire(x);
	DrawShield(x);
	if (ship[x].image != il.dreadnought) DrawPhoton(x);
	else							  DrawExpander(x);
    }
DrawSaucerFire();

if (saucer.flag != FALSE)
    {
	UpdateSaucer();
	if (saucer.type == 1)
	    {
		if ((Random(1000.0) > 960-20*control.level) && (saucer.haltfire == FALSE))
			InitSmartSaucerFire();
	    }
	else
	if ((Random(1000.0) > 900-20*control.level) && (saucer.haltfire == FALSE))
		InitSaucerFire();

	if (--saucer.delay == 0) ChangeSaucerCourse();
    }


DrawThrust();
UpdateFighters(x);
DrawFighterFire(x);
DrawTokenExplosions();
UpdateBoxes();
UpdateMines();
UpdateDebris();
UpdateHyper();

control.asize=anum = 0;
for (x=0;x<control.asteroidnum;x++)
	if (a[x].flag != FALSE)
	    {
		anum++;
		control.asize+=(3-a[x].size);
		UpdateAsteroid(x);
	    }


dodrawlist();


waitfortimer();
timedelay(control.delay);
WaitBlit();
changeview(bit);



SetAPen(rp1[1-bit],0);

EraseAll();
EraseSaucer();
EraseFighterFire();
EraseFighters();
EraseMines();
EraseDebris();
EraseHyper();
EraseAsteroids();
EraseTokenExplosions();
EraseBoxes();
EraseSaucerFire();
for (x=0;x<control.maxenemynum+control.playernum;x++)
    {
	EraseFire(x);
	EraseShield(x);
	ErasePhoton(x);
	if (ship[x].image == il.dreadnought) EraseDisplacer(x);
    }
RectFill(rp1[1-bit],579,2,620,11);
}
}



todrawlist(pic,xx,yy,mask,color)
WORD pic,xx,yy;
UWORD mask;
BYTE color;
{

dl[control.dlpos].x = xx;
dl[control.dlpos].y = yy;
dl[control.dlpos].pic = pic;
dl[control.dlpos].color = color;
dl[control.dlpos].mask = mask;
control.dlpos++;
}


dodrawlist()
{
LONG x;


SetAPen(rp1[bit],3);
for(x=0;x<control.dlpos;x++)
    {
	SetWrMsk(rp1[bit],dl[x].mask);
	BltTemplate(id[dl[x].pic].data,0,2*id[dl[x].pic].wo,rp1[bit],
			  dl[x].x,dl[x].y,id[dl[x].pic].wi,id[dl[x].pic].he);
    }

control.dlpos = 0;
}



handlePause()
{
struct RastPort *wrp;
struct Window *window;
struct IntuiMessage *message;
ULONG pwinsig,mwinsig,signal;

newpausewindow.LeftEdge = gi.wi/2-90;
newpausewindow.TopEdge = gi.he/2-20;
newpausewindow.Screen = screen;
window = (struct Window *)OpenWindow(&newpausewindow);
if (window == NULL) printf("open window error\n");

wrp = window->RPort;

SetAPen(wrp,1);
SetFont(wrp,fixplain7font);

Move(wrp,13,30);
Text(wrp,"GAME PAUSED",11);

pwinsig = 1L << window->UserPort->mp_SigBit;
mwinsig = 1L << masterwindow->UserPort->mp_SigBit;

while(message = (struct IntuiMessage *)GetMsg(window->UserPort)) ReplyMsg((struct Message *)message);
while(message = (struct IntuiMessage *)GetMsg(masterwindow->UserPort)) ReplyMsg((struct Message *)message);

for(;;)
{
signal = Wait(pwinsig | mwinsig);

if (signal & pwinsig)
    {
	while (message = (struct IntuiMessage *)GetMsg(window->UserPort))
	    {
		ReplyMsg((struct Message *)message);

		if (message->Code < 0x64)
		    {
			CloseWindow(window);
			in.PAUSE = FALSE;
			return;
		    }
	    }
    }
else
if (signal & mwinsig)
    {
	while (message = (struct IntuiMessage *)GetMsg(masterwindow->UserPort))
	    {
		ReplyMsg((struct Message *)message);

		if (message->Code < 0x64)
		    {
			CloseWindow(window);
			in.PAUSE = FALSE;
			return;
		    }
	    }
    }

}
}
