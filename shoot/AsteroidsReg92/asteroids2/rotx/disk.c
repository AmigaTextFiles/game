#include <exec/types.h>
#include <exec/memory.h>
#include <exec/interrupts.h>
#include <devices/input.h>
#include <devices/inputevent.h>
#include <devices/timer.h>
#include <libraries/dos.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <graphics/gfxbase.h>
#include <graphics/rastport.h>
#include <graphics/view.h>
#include <hardware/custom.h>
#include <string.h>
#include <h/rot.h>
#include <h/extern.h>


SaveKeyDefines()
{
LONG file;

file = Open ("keydefinitions",MODE_OLDFILE);
if (file == NULL)
    {
	file = Open ("keydefinitions",MODE_NEWFILE);
	if (file == NULL)
	    {
		printf("Options file creation error\n");
		return;
	    }
    }

Write(file,&k,sizeof(k));
Close(file);
}


LoadKeyDefines()
{
LONG file;
struct keys temp;

file = Open ("keydefinitions",MODE_OLDFILE);
if (file != NULL)
    {
	Read(file,&temp,sizeof(temp));

	k.left       = temp.left;
	k.right      = temp.right;
	k.fire       = temp.fire;
	k.thrust     = temp.thrust;
	k.hyperspace = temp.hyperspace;
	k.pause      = temp.pause;

	Close(file);
    }
}



LoadOptions()
{
LONG file,x;

file = Open ("options",MODE_OLDFILE);
if (file != NULL)
    {
	Read(file,&so,sizeof(so));

	control.playernum =      so.playernum;
	control.input[0] =       so.input[0];
	control.input[1] =       so.input[1];
	control.enemyonscreen =  so.enemyonscreen;
	control.ftrnum =         so.ftrnum;
	control.delay =          so.delay;
	control.playmode =       so.playmode;
	control.game =           so.game;
	control.startlevel =     so.startlevel;
	control.difficulty =     so.difficulty;
	control.autofire =	     so.autofire;
	control.firewrap =       so.firewrap;
	control.standarddebris = so.standarddebris;
	control.screentype =     so.screentype;
	control.fontsize =       so.fontsize;

	for(x=0;x<control.playernum;x++)
		control.player[x] = TRUE;

	for(x=control.playernum;x<control.maxplayernum;x++)
		control.player[x] = FALSE;

	if (control.game == 1)
	    {
		control.ftrnum = 0;
		control.enemyonscreen=0;
	    }

	Close(file);
    }
}


SaveOptions()
{
LONG file;

file = Open ("options",MODE_OLDFILE);
if (file == NULL)
    {
	file = Open ("options",MODE_NEWFILE);
	if (file == NULL)
	    {
		printf("Options file creation error\n");
		return;
	    }
    }

so.playernum = control.playernum;
so.input[0] = control.input[0];
so.input[1] = control.input[1];
so.enemyonscreen = control.enemyonscreen;
so.ftrnum = control.ftrnum;
so.delay = control.delay;
so.playmode = control.playmode;
so.game = control.game;
so.startlevel = control.startlevel;
so.difficulty = control.difficulty;
so.autofire = control.autofire;
so.firewrap = control.firewrap;
so.standarddebris = control.standarddebris;
so.screentype = control.screentype;
so.fontsize = control.fontsize;

Write(file,&so,sizeof(so));
Close(file);
}


LoadHighScores()
{
LONG file;

file = Open ("highscores",MODE_OLDFILE);
if (file == NULL)
    {
	file = Open ("highscores",MODE_NEWFILE);
	if (file == NULL)
	    {
		printf("High score file creation error\n");
		exit(FALSE);
	    }
	else
	    {
		Write(file,hsl,sizeof(hsl));
		Close(file);
	    }
    }
else
    {
	Read(file,hsl,sizeof(hsl));
	Close(file);
    }
}


DisplayHighScores(wrp)
struct RastPort *wrp;
{
LONG x;
UBYTE string[20];
LONG yy[24],y0,y1;
LONG x0,x1,x2;

y0= gi.he/2-100;
y1= gi.he/2-120;
for(x=0;x<22;x++)
	yy[x] = y0 + x*(gi.smallfontheight+2);

x0 = gi.wi/2-22*(gi.smallfontheight-2);
x1 = x0+25*(gi.smallfontheight-2);
x2 = x1+13*(gi.smallfontheight-2);


SetAPen(wrp,1);
SetFont(wrp,basicfont);
Move(wrp,gi.wi/2-120,70);
Text(wrp,"HIGH SCORES",11);

SetFont(wrp,fixplain7font);
Move(wrp,x0,y1);
Text(wrp,"NAME",4);
Move(wrp,x1,y1);
Text(wrp,"SCORE",5);
Move(wrp,x2,y1);
Text(wrp,"LEVEL",5);


SetFont(wrp,hiresfont);
for (x=0;x<20;x++)
    {
	Move(wrp,x0,yy[x]);
	Text(wrp,hsl[x].name,strlen(hsl[x].name));

	Move(wrp,x1,yy[x]);
	sprintf(string,"%8d  ",hsl[x].score);
	Text(wrp,string,strlen(string));

	Move(wrp,x2,yy[x]);
	sprintf(string,"%3d",hsl[x].level);
	Text(wrp,string,strlen(string));
    }

Move(wrp,gi.wi/2-10*(gi.smallfontheight-2),gi.he-60);
Text(wrp,"PRESS <F1> TO CONTINUE",22);
}


dohighscorelist(n)
LONG n;
{
UBYTE string[20];
UBYTE temp[40];
UBYTE not[3] = " ";
LONG x,place,file;
LONG len=0;
static UBYTE ascii[] = " 1234567890-+\   QWERTYUIOP[]    ASDFGHJKL;'      ZXCVBNM,./      ";
struct IntuiMessage *msg;
LONG code=NULL,class;
LONG x0,x1,y0,yy[24];

while (msg = (struct IntuiMessage *)GetMsg(masterwindow->UserPort)) ReplyMsg((struct Message *)msg);


x0 = gi.wi/2-22*(gi.smallfontheight-2);
x1 = x0+25*(gi.smallfontheight-2);
y0= gi.he/2-100;
for(x=0;x<22;x++)
	yy[x] = y0 + x*(gi.smallfontheight+2);


for(x=0;x<20;x++)
	if (control.score[n] > hsl[x].score)
	    {
		place = x;
		break;
	    }

for(x=19;x>place-1;x--)
    {
	strcpy(hsl[x].name,hsl[x-1].name);
	hsl[x].score = hsl[x-1].score;
	hsl[x].level = hsl[x-1].level;
    }

strcpy(hsl[place].name,not);			/* just to blank the name for screen */
hsl[place].score = control.score[n];
hsl[place].level = control.level;

DisplayHighScores(mwrp);

Move(mwrp,x0-11*(gi.smallfontheight-2),yy[place]);
sprintf(string,"PLAYER %d--",n+1);
Text(mwrp,string,strlen(string));

Move(mwrp,x0,yy[place]);

while ((code != F1) && (code != RET) && (code != ESC))
{
WaitPort(masterwindow->UserPort);
while (msg = (struct IntuiMessage *)GetMsg(masterwindow->UserPort))
    {
	class = msg->Class;
	code = msg->Code;
	ReplyMsg((struct Message *)msg);

	if (class == RAWKEY)
	    {
		if ((code > 0) && (code < 0x41) && (len < 30))
		    {
			Text(mwrp,&ascii[code],1);
			hsl[place].name[len] = ascii[code];
			len++;
		    }
		else
		if ((code == 0x46) || (code == 0x41))
		    {
			len--;
			SetAPen(mwrp,0);
			RectFill(mwrp,x0-1,yy[place]-gi.smallfontheight,x1-1,yy[place]+1);
			SetAPen(mwrp,1);
			stccpy(temp,hsl[place].name,len+1);
			stccpy(hsl[place].name,temp,len+1);
			Move(mwrp,x0,yy[place]);
			Text(mwrp,hsl[place].name,strlen(hsl[place].name));
		    }
		Delay(1);
	    }
    }
}

stccpy(temp,hsl[place].name,len+1);
stccpy(hsl[place].name,temp,len+1);

file = Open ("highscores",MODE_OLDFILE);
if (file == NULL)
    {
	printf ("*** undetermined file error");
    }
else
    {
	Write(file,hsl,sizeof(hsl));
	Close(file);
    }
}