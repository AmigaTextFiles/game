#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>
#include <graphics/displayinfo.h>
#include <string.h>
#include <h/rot.h>
#include <h/extern.h>
#include <h/define.h>

DefineKeys(wrp,window)
struct RastPort *wrp;
struct Window *window;
{
struct IntuiMessage *msg;
LONG code=NULL;
LONG x=0,i;
BYTE string[10];
LONG keycode[10];
LONG x0,x1,x2,x3,yy[10],y0;

x0 = gi.wi/2-170;
x1 = x0+12*(gi.smallfontheight-2);
x2 = gi.wi/2+10;
x3 = x2+12*(gi.smallfontheight-2);

y0 = gi.he/2-60;
for(i=0;i<6;i++)
	yy[i] = y0 + (gi.smallfontheight+2)*i;


SetFont(wrp,basicfont);
Move(wrp,gi.wi/2-135,110);
Text(wrp,"DEFINE KEYS",11);


SetFont(wrp,fixplain7font);
Move(wrp,gi.wi/2-210,gi.he/2-80);
Text(wrp,"CURRENT KEY DEFINITIONS",23);

SetFont(wrp,hiresfont);
Move(wrp,x0,yy[0]);
Text(wrp,"ROTATE LEFT",11);
Move(wrp,x0,yy[1]);
Text(wrp,"ROTATE RIGHT",12);
Move(wrp,x0,yy[2]);
Text(wrp,"FIRE",4);
Move(wrp,x0,yy[3]);
Text(wrp,"THRUST",6);
Move(wrp,x0,yy[4]);
Text(wrp,"HYPERSPACE",10);
Move(wrp,x0,yy[5]);
Text(wrp,"PAUSE",5);

sprintf(string,"$%x",k.left);
Move(wrp,x1,yy[0]);
Text(wrp,string,strlen(string));
sprintf(string,"$%x",k.right);
Move(wrp,x1,yy[1]);
Text(wrp,string,strlen(string));
sprintf(string,"$%x",k.fire);
Move(wrp,x1,yy[2]);
Text(wrp,string,strlen(string));
sprintf(string,"$%x",k.thrust);
Move(wrp,x1,yy[3]);
Text(wrp,string,strlen(string));
sprintf(string,"$%x",k.hyperspace);
Move(wrp,x1,yy[4]);
Text(wrp,string,strlen(string));
sprintf(string,"$%x",k.pause);
Move(wrp,x1,yy[5]);
Text(wrp,string,strlen(string));

SetFont(wrp,fixplain7font);
Move(wrp,gi.wi/2+5,gi.he/2-80);
Text(wrp,"NEW KEY DEFINITIONS",19);

SetFont(wrp,hiresfont);
Move(wrp,x2,yy[0]);
Text(wrp,"ROTATE LEFT",11);

while ((code != F1) && (code != ESC))
{
WaitPort(window->UserPort);
while (msg = (struct IntuiMessage *)GetMsg(window->UserPort))
    {
	code = msg->Code;
	ReplyMsg((struct Message *)msg);
	
	if (code < 0x64)
	    {
		x++;

		Move(wrp,x2,yy[x]);
		if (x == 1)
		    {
			Text(wrp,"ROTATE RIGHT",12);
			keycode[0] = code;
		    }
		else
		if (x == 2)
		    {
			Text(wrp,"FIRE",4);
			keycode[1] = code;
		    }
		else
		if (x == 3)
		    {
			Text(wrp,"THRUST",6);
			keycode[2] = code;
		    }
		else
		if (x == 4)
		    {
			Text(wrp,"HYPERSPACE",10);
			keycode[3] = code;
		    }
		else
		if (x == 5)
		    {
			Text(wrp,"PAUSE",5);
			keycode[4] = code;
		    }
		if (x == 6)
		    {
			Move(wrp,gi.wi/2-110,gi.he/2+150);
			Text(wrp,"PRESS < S >  TO SAVE DEFINITIONS",31);
			Move(wrp,gi.wi/2-90,gi.he/2+150+gi.smallfontheight+2);
			Text(wrp,"PRESS < F1 > TO RETURN",22);
			keycode[5] = code;
		    }
		if (x < 7)
		    {
			Move(wrp,x3,yy[x-1]);
			sprintf(string,"$%x",code);
			Text(wrp,string,strlen(string));
		    }
		else if (code == 0x21)
			    {
				k.left = keycode[0]; 
				k.right = keycode[1]; 
				k.fire = keycode[2]; 
				k.thrust = keycode[3]; 
				k.hyperspace = keycode[4]; 
				k.pause = keycode[5]; 
				SaveKeyDefines();
				code = ESC;
			    }
	    }
    }
}
}



HandleOptions(wrp,window)
struct RastPort *wrp;
struct Window *window;
{
struct IntuiMessage *msg;
LONG code=NULL,class;
LONG x;
BYTE string[10];
LONG y1,yy[20],x0,x1,x2,x3;
LONG screentype;

x0 = gi.wi/2 - 22*(gi.smallfontheight-2);
x1 = x0 + 5*(gi.mediumfontheight-2);
x2 = x1 + 22*(gi.smallfontheight-2);
x3 = x2 + 25*(gi.smallfontheight-2);

y1 = 100;
for(x=0;x<20;x++) 
	yy[x] = y1+40+(gi.mediumfontheight+3)*x;


SetFont(wrp,basicfont);
Move(wrp,gi.wi/2-90,y1);
Text(wrp,"OPTIONS",7);


SetFont(wrp,fixplain7font);


Move(wrp,x0,yy[0]);
Text(wrp,"<F1>",4);
Move(wrp,x0,yy[1]);
Text(wrp,"<F2>",4);
Move(wrp,x0,yy[2]);
Text(wrp,"<F3>",4);
Move(wrp,x0,yy[3]);
Text(wrp,"<F4>",4);
Move(wrp,x0,yy[4]);
Text(wrp,"<F5>",4);
Move(wrp,x0,yy[5]);
Text(wrp,"<F6>",4);
Move(wrp,x0,yy[6]);
Text(wrp,"<F7>",4);
Move(wrp,x0,yy[7]);
Text(wrp,"<F8>",4);
Move(wrp,x0,yy[8]);
Text(wrp,"<F9>",4);
Move(wrp,x0,yy[9]);
Text(wrp,"<F10>",5);

Move(wrp,x0,yy[11]);
Text(wrp,"<L>",3);
Move(wrp,x0,yy[12]);
Text(wrp,"<D>",3);
Move(wrp,x0,yy[13]);
Text(wrp,"<G>",3);
Move(wrp,x0,yy[14]);
Text(wrp,"<T>",3);
Move(wrp,x0,yy[15]);
Text(wrp,"<F>",3);
Move(wrp,x0,yy[17]);
Text(wrp,"<S>",3);

Move(wrp,x1,yy[0]);
Text(wrp,"TO RETURN",9);



SetFont(wrp,hiresfont);
Move(wrp,x1,yy[1]-1);
Text(wrp,"NUMBER OF PLAYERS--",19);
Move(wrp,x2,yy[1]-1);
sprintf(string,"%d",control.playernum);
Text(wrp,string,strlen(string));


SetFont(wrp,hiresfont);
Move(wrp,x1,yy[2]-1);
Text(wrp,"PLAYER ONE CONTROL--",20);
Move(wrp,x2,yy[2]-1);
if (control.input[0] == 0) Text(wrp,"HUMAN (KEYBOARD)",16);
else
if (control.input[0] == 1) Text(wrp,"HUMAN (JOYSTICK)",16);


Move(wrp,x1,yy[3]-1);
Text(wrp,"PLAYER TWO CONTROL--",20);
Move(wrp,x2,yy[3]-1);
if (control.input[1] == 0) Text(wrp,"HUMAN (KEYBOARD)",16);
else
if (control.input[1] == 1) Text(wrp,"HUMAN (JOYSTICK)",16);


Move(wrp,x1,yy[4]-1);
Text(wrp,"MAXIMUM ENEMY SHIPS--",21);
Move(wrp,x2,yy[4]-1);
sprintf(string,"%d",control.enemyonscreen);
Text(wrp,string,strlen(string));

Move(wrp,x1,yy[5]-1);
Text(wrp,"FIGHTERS IN SQUADRON--",22);
Move(wrp,x2,yy[5]-1);
sprintf(string,"%d",control.ftrnum);
Text(wrp,string,strlen(string));

Move(wrp,x1,yy[6]-1);
Text(wrp,"BASE GAME DELAY--",17);
Move(wrp,x2,yy[6]-1);
sprintf(string,"%d",control.delay);
Text(wrp,string,strlen(string));

Move(wrp,x1,yy[7]-1);
Text(wrp,"TEAM PLAY MODE--",16);
Move(wrp,x2,yy[7]-1);
if (control.playmode == 0) Text(wrp,"COOPERATIVE",11);
else
if (control.playmode == 1) Text(wrp,"COMPETITIVE",11);

Move(wrp,x1,yy[8]-1);
Text(wrp,"AMOUNT OF DEBRIS--",18);
Move(wrp,x2,yy[8]-1);
sprintf(string,"%d",control.standarddebris);
Text(wrp,string,strlen(string));

Move(wrp,x1,yy[9]-1);
Text(wrp,"FIRE WRAP --",12);
Move(wrp,x2,yy[9]-1);
if (control.firewrap == FALSE) Text(wrp,"OFF",3);
else						 Text(wrp,"ON",2);



Move(wrp,x1,yy[11]-1);
Text(wrp,"START LEVEL-",12);
Move(wrp,x2,yy[11]-1);
sprintf(string,"%d",control.startlevel);
Text(wrp,string,strlen(string));

Move(wrp,x1,yy[12]-1);
Text(wrp,"DIFFICULTY--",12);
Move(wrp,x2,yy[12]-1);
if (control.difficulty == 0) Text(wrp,"SIMPLE",6);
else
if (control.difficulty == 1) Text(wrp,"PRACTICE",8);
else
if (control.difficulty == 2) Text(wrp,"NORMAL",6);

Move(wrp,x1,yy[13]-1);
Text(wrp,"GAME --",7);
Move(wrp,x2,yy[13]-1);


#if REGISTERED == TRUE
if (control.game == 0) Text(wrp,"ASTERIODS II",12);
#else
if (control.game == 0) Text(wrp,"LIMITED ASTERIODS II",20);
#endif
else				   Text(wrp,"BASIC ASTEROIDS",15);


screentype = control.screentype;
Move(wrp,x1,yy[14]-1);
Text(wrp,"SCREEN TYPE--",12);
Move(wrp,x2,yy[14]-1);
if (control.screentype == 0) Text(wrp,"WORKBENCH CLONE",15);
else
if (control.screentype == 1) Text(wrp,"HIRES NTSC",10);
else
if (control.screentype == 2) Text(wrp,"HIRES PAL",9);
else
if (control.screentype == 3) Text(wrp,"SUPERHIRES NTSC",15);
else
if (control.screentype == 4) Text(wrp,"SUPERHIRES PAL",14);


Move(wrp,x1,yy[15]-1);
Text(wrp,"FONT SIZE--",11);
Move(wrp,x2,yy[15]-1);
if (control.fontsize == 0) Text(wrp,"SMALL",5);
else
if (control.fontsize == 1) Text(wrp,"LARGE",5);


Move(wrp,x1,yy[17]-1);
Text(wrp,"SAVE OPTIONS TO DISK",20);
Move(wrp,x2,yy[17]-1);


while ((code != F1) && (code != ESC))
{
WaitPort(window->UserPort);
while (msg = (struct IntuiMessage *)GetMsg(window->UserPort))
    {
	class = msg->Class;
	code = msg->Code;
	ReplyMsg((struct Message *)msg);

	if (class == RAWKEY)
	{

	if (code == F2)
	    {
 		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[1]-(gi.smallfontheight+1),x3,yy[1]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[1]-1);
 		if (++control.playernum > control.maxplayernum) control.playernum = 1;
		sprintf(string,"%d",control.playernum);
		Text(wrp,string,strlen(string));

		Delay(10);
	    }
	else
	if (code == F3)
	    {
 		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[2]-(gi.smallfontheight+1),x3,yy[2]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[2]-1);

 		if (++control.input[0] > 1) control.input[0] = 0;

 		if (control.input[0] == 0) Text(wrp,"HUMAN (KEYBOARD)",16);
		else
		if (control.input[0] == 1) Text(wrp,"HUMAN (JOYSTICK)",16);
		Delay(10);
	    }
	else
	if (code == F4)
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[3]-(gi.smallfontheight+1),x3,yy[3]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[3]-1);

 		if (++control.input[1] > 1) control.input[1] = 0;
 		if (control.input[1] == 0) Text(wrp,"HUMAN (KEYBOARD)",16);
		else
 		if (control.input[1] == 1) Text(wrp,"HUMAN (JOYSTICK)",16);
		Delay(10);
	    }
	else
	if (code == F5)
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[4]-(gi.smallfontheight+1),x3,yy[4]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[4]-1);
		
 		if (++control.enemyonscreen > 3) control.enemyonscreen = 0;
		sprintf(string,"%d",control.enemyonscreen);
		Text(wrp,string,strlen(string));
		Delay(10);
	    }
	else
	if (code == F6)
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[5]-(gi.smallfontheight+1),x3,yy[5]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[5]-1);
		
 		if (++control.ftrnum > 24) control.ftrnum = 0;
		sprintf(string,"%d",control.ftrnum);
		Text(wrp,string,strlen(string));
		Delay(5);
	    }
	else
	if (code == F7)
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[6]-(gi.smallfontheight+1),x3,yy[6]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[6]-1);
		
		control.delay+=1000;
 		if (++control.delay > 60000) control.delay = 0;
		sprintf(string,"%d",control.delay);
		Text(wrp,string,strlen(string));
		Delay(1);
	    }
	else
	if (code == F8)
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[7]-(gi.smallfontheight+1),x3,yy[7]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[7]-1);

 		if (++control.playmode > 1) control.playmode = 0;
 		if (control.playmode == 0) Text(wrp,"COOPERATIVE",11);
		else
 		if (control.playmode == 1) Text(wrp,"COMPETITIVE",11);
		Delay(10);
	    }
	else
	if (code == F9)
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[8]-(gi.smallfontheight+1),x3,yy[8]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[8]-1);

		if (++control.standarddebris > 24) control.standarddebris = 4;
		sprintf(string,"%d",control.standarddebris);
		Text(wrp,string,strlen(string));
		Delay(2);
	    }
	else
	if (code == F10)
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[9]-(gi.smallfontheight+1),x3,yy[9]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[9]-1);

		if (++control.firewrap > 1) control.firewrap=0;
		if (control.firewrap == FALSE) Text(wrp,"OFF",3);
		else						 Text(wrp,"ON",2);
		Delay(5);
	    }


	if (code == 0x28) /* L */
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[11]-(gi.smallfontheight+1),x3,yy[11]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[11]-1);

		if (++control.startlevel > 30) control.startlevel=1;
		sprintf(string,"%d",control.startlevel);
		Text(wrp,string,strlen(string));
		Delay(2);
	    }

	if (code == 0x22) /* D */
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[12]-(gi.smallfontheight+1),x3,yy[12]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[12]-1);

		if (++control.difficulty > 2) control.difficulty=0;
		if (control.difficulty == 0) Text(wrp,"SIMPLE",6);
		else
		if (control.difficulty == 1) Text(wrp,"PRACTICE",8);
		else
		if (control.difficulty == 2) Text(wrp,"NORMAL",6);
	    }

	if (code == 0x24) /* G */
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[13]-(gi.smallfontheight+1),x3,yy[13]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[13]-1);
		
 		if (++control.game > 1) control.game = 0;

#if REGISTERED == TRUE
		if (control.game == 0) Text(wrp,"ASTERIODS II",12);
#else
		if (control.game == 0) Text(wrp,"LIMITED ASTERIODS II",20);
#endif
		else				   Text(wrp,"BASIC ASTEROIDS",15);

		Delay(10);
	    }

	if (code == 0x14) /* T */
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[14]-(gi.smallfontheight+1),x3,yy[14]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[14]-1);
		
 		if (++control.screentype > 4) control.screentype = 0;

		if (control.screentype == 0) Text(wrp,"WORKBENCH CLONE",15);
		else
		if (control.screentype == 1) Text(wrp,"HIRES NTSC",10);
		else
		if (control.screentype == 2) Text(wrp,"HIRES PAL",9);
		else
		if (control.screentype == 3) Text(wrp,"SUPERHIRES NTSC",15);
		else
		if (control.screentype == 4) Text(wrp,"SUPERHIRES PAL",14);
	    }

	if (code == 0x23) /* F */
	    {
		SetAPen(wrp,0);
 		RectFill(wrp,x2-1,yy[15]-(gi.smallfontheight+1),x3,yy[15]);
		SetAPen(wrp,1);
		Move(wrp,x2,yy[15]-1);
		
 		if (++control.fontsize > 1) control.fontsize = 0;

		if (control.fontsize == 0) Text(wrp,"SMALL",5);
		else
		if (control.fontsize == 1) Text(wrp,"LARGE",5);
	    }


	if (code == 0x21) /* S */
	    {
		SaveOptions();
	    }
	}
    }
}

for(x=0;x<control.playernum;x++)
	control.player[x] = TRUE;

for(x=control.playernum;x<control.maxplayernum;x++)
	control.player[x] = FALSE;

if (control.game == 1)
    {
	control.ftrnum = 0;
	control.enemyonscreen=0;
    }

if (screentype != control.screentype)
	SwapScreen(control.screentype);
SetGameFont();
}



DrawTitleScreen(wrp)
struct RastPort *wrp;
{
BYTE string[40];
LONG yy = 200,x1,x2,x3;

SetAPen(wrp,1);
SetFont(wrp,basicfont);			/* title screen */
Move(wrp,gi.wi/2-140,100);
Text(wrp,"ASTERIODS II",12);

SetFont(wrp,hiresfont);			/* title screen */


x1 = gi.wi/2-5*(gi.smallfontheight);
x2 = x1-6*(gi.smallfontheight);
x3 = x1-(gi.smallfontheight-2);

sprintf(string,"VERSION %s",VERSION);
Move(wrp,x1,130);
Text(wrp,string,strlen(string));

Move(wrp,x3,145);
Text(wrp,"by mike seifert",15);

Move(wrp,x2,yy+1*gi.smallfontheight);
Text(wrp,"PRESS  <F1>  TO START",21); 

Move(wrp,x2,yy+2*gi.smallfontheight);
Text(wrp,"PRESS  <F2>  TO CHANGE OPTIONS",30);

Move(wrp,x2,yy+3*gi.smallfontheight);
Text(wrp,"PRESS  <F3>  TO VIEW HIGH SCORES",32);

Move(wrp,x2,yy+4*gi.smallfontheight);
Text(wrp,"PRESS  <F4>  TO GET INFORMATION",31);

Move(wrp,x2,yy+5*gi.smallfontheight);
Text(wrp,"PRESS  <F5>  TO DEFINE KEYS",27);

Move(wrp,x2,yy+6*gi.smallfontheight);
Text(wrp,"PRESS  <ESC>  TO EXIT",21);
}




WaitStart()
{
struct IntuiMessage *msg;
LONG code=NULL,class;

while(msg = (struct IntuiMessage *)GetMsg(masterwindow->UserPort)) ReplyMsg((struct Message *)msg);

DrawTitleScreen(mwrp);

while (code != F1)
{
WaitPort(masterwindow->UserPort);
while (msg = (struct IntuiMessage *)GetMsg(masterwindow->UserPort))
    {
	class = msg->Class; 
	code = msg->Code;
	ReplyMsg((struct Message *)msg);

	if (class == RAWKEY)
	    {
		if (code == F2) 
		    {
			SetRast(mwrp,0);
			HandleOptions(mwrp,masterwindow);
			while(msg = (struct IntuiMessage *)GetMsg(masterwindow->UserPort)) ReplyMsg((struct Message *)msg);
			SetRast(mwrp,0);
			DrawTitleScreen(mwrp);
		    }
		else
		if (code == F3) 
		    {
			SetRast(mwrp,0);
			DisplayHighScores(mwrp);

			while ((code != F1) && (code != ESC))
			    {
				WaitPort(masterwindow->UserPort);
				while (msg = (struct IntuiMessage *)GetMsg(masterwindow->UserPort))
				    {
					code = msg->Code;
					ReplyMsg((struct Message *)msg);
				    }
			    }
			code = NULL;
			SetRast(mwrp,0);
			DrawTitleScreen(mwrp);
			while(msg = (struct IntuiMessage *)GetMsg(masterwindow->UserPort)) ReplyMsg((struct Message *)msg);
		    }
		else
		if (code == F4) 
		    {
			ClearScreen();
			Information();
			ClearScreen();
			DrawTitleScreen(mwrp);
			while(msg = (struct IntuiMessage *)GetMsg(masterwindow->UserPort)) ReplyMsg((struct Message *)msg);
		    }
		else
		if (code == F5) 
		    {
			SetRast(mwrp,0);
			DefineKeys(mwrp,masterwindow);
			SetRast(mwrp,0);
			DrawTitleScreen(mwrp);
			while(msg = (struct IntuiMessage *)GetMsg(masterwindow->UserPort)) ReplyMsg((struct Message *)msg);
		    }
		else
		if (code == ESC)
		    {
			Cleanup();
		    }
	    }
    }
}
}

DrawGameScreen()
{
LONG x;


for(x=0;x<2;x++)
    {
	SetWrMsk(rp1[x],0xfe);
	SetFont(rp1[x],hiresfont);
	SetAPen(rp1[x],2);

	Move(rp1[x],gi.wi/2,gi.smallfontheight+2);
	Text(rp1[x],"PLAYER 2 SHIELDS",16);
	Move(rp1[x],gi.wi/2,gi.he-gi.smallfontheight-3);
	Text(rp1[x],"PLAYER 2 SCORE",14);
	Move(rp1[x],gi.wi/2,gi.he-1);
	Text(rp1[x],"SHIPS REMAINING",15);

	Move(rp1[x],+gi.x1,gi.smallfontheight+2);
	Text(rp1[x],"PLAYER 1 SHIELDS",16);
	Move(rp1[x],+gi.x1,gi.he-gi.smallfontheight-3);
	Text(rp1[x],"PLAYER 1 SCORE",14);
	Move(rp1[x],+gi.x1,gi.he-1);
	Text(rp1[x],"SHIPS REMAINING",15);

	IncreaseScore(x,0);
	IncreaseLives(x,0);
 	IncreaseShields(x,0);

/*	Move(rp1[x],gi.x1,gi.y1);
	Draw(rp1[x],gi.x2,gi.y1);
	Draw(rp1[x],gi.x2,gi.y2);
	Draw(rp1[x],gi.x1,gi.y2);
	Draw(rp1[x],gi.x1,gi.y1);*/
    }
}


ClearScreen()
{
LONG x;

for(x=0;x<2;x++)
    {
	SetWrMsk(rp1[x],0xff);
	SetRast(rp1[x],0);
    }
}
