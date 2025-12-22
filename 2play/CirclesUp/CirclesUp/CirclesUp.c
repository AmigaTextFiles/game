
#include <intuition/intuition.h>
#include <graphics/sprite.h>
#include <math.h>
#include "easysound.c"
#include "easysound.h"
#include "spriteDATA.c"
#include "askc"
#include "titlec"
#include "stripc"
#include "mainaskc"
#include "infoc"
#include "rightc"
#include "leftc"
#include "letsgoc"

#define HEIGHT 200
#define WIDTH 320
#define DEPTH 5

struct Window *win;
struct Screen *scr;
struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct ViewPort *vp;
struct RastPort *rp;
struct IntuiMessage *message;

USHORT class;
USHORT code;

struct NewScreen ns =
{ 0,0,WIDTH,HEIGHT,5,0,1,NULL,  /* View modes */
  CUSTOMSCREEN,  /* Screen type */
  NULL,          /* Font */
  NULL,NULL,NULL          /* CustomBitmap */  };

struct NewWindow nw =
{ 0,0,WIDTH,HEIGHT,0,1,MOUSEBUTTONS+RAWKEY,  /* IDCMP flags */
  ACTIVATE|BORDERLESS|RMBTRAP, /* Flags */
  NULL,NULL,NULL,  /* Gadget,Checkmark,Name */
  NULL,NULL,  /* Screen,BitMap */
  WIDTH,HEIGHT,100,100,  /* Max Width,Height, Min Width,Height */
  CUSTOMSCREEN  };

int loc[40][12],blue_ball;

struct SimpleSprite left_arrow = {
left_arrow_data,15,15,200,3 };

struct SimpleSprite right_arrow = {
right_arrow_data,15,15,200,3 };

int connect;  /*  This is a variable of how many circles the user wishes to 
                  connect so they win the game */
CPTR boing;

UWORD chip dummydata[] = { 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000 };

void _main()
{
int dum;

Open_Stuff();

if((GetSprite(&left_arrow,2))!=2)  die("   I CAN GET SPRITE #2, SO I AM EXITING.");
if((GetSprite(&right_arrow,3))!=3) die("   I CAN GET SPRITE #3, SO I AM EXITING.");

MoveSprite(0,&left_arrow,8,184);   
MoveSprite(0,&right_arrow,286,184); /* These are the arrows */

Init_Screen();

while(1)
 {
 ClearRASTPORT();
 ClearLOCS();
 DrawImage(rp,&mainask,76,81);
 dum=1;
   while(dum)
   {  
   while((connect=idcmpch())==0);
   if(connect==0x19)
   { dum=0; CirclesUp(); }
      else if(connect==0x10) die("");
         else if(connect==0x17) { dum=0; DisplayINFO(); }
   }
}
die("");
}

DisplayINFO()
{
DrawImage(rp,&info,37,62);
while(idcmpch()!=0x45);
return(1);
}

WriteNumber()
{
char dum2[20];
SetAPen(rp,29);
sprintf(dum2,"%d",connect);
Move(rp,215,50);
Text(rp,dum2,strlen(dum2));
return(1);
}

CirclesUp()
{
int xpos,incr,dummy=1,input,player,player2,c=0,v,r;
int xpos2;

ClearRASTPORT();
ClearLOCS();
DrawImage(rp,&ask_image,52,106);  
while(dummy)
   {
   while((connect=idcmpch())==0);
   if(connect<=7&&connect>=3) dummy=0; 
   }
WriteNumber();
ClearRASTPORT();

DrawImage(rp,&letsgo,105,120);
Delay(75);
ClearRASTPORT();

while(1)
   {
      v=rand()%777;  
      if(v%2==1)  /*  This is the side which the circle flys in */
      { xpos=0; incr=6; } 
      else { xpos=288; incr=-6; }
      if(++c%2==0)   
        { player=0x64; player2=-1; ball2.PlanePick=4; }
        else { player=0x65; player2=0x68; ball2.PlanePick=8; }
dummy=1;
      if(rand()%25==0) 
        { blue_ball=1;  ball2.PlanePick=16; }
        else blue_ball=0;
        while(dummy)
        {
        xpos+=incr;
        xpos2=xpos;
        if(xpos2%12!=0) xpos2+=incr;  
        DrawImage(rp,&ball2,xpos,186);
        input=idcmpch();
        if(input==player||input==player2)
        if(blue_ball==1)
                {
                if(xpos%12==0) { up2(xpos); dummy=0; }
                else { xpos+=incr; DrawImage(rp,&ball2,xpos,186); up2(xpos); dummy=0; }
                }
                else
                if(loc[(xpos2-12)/12][9]==0)   
                {
                if(xpos%12==0) { r=up(xpos2,c%2+1); dummy=0; }
                else { xpos+=incr; DrawImage(rp,&ball2,xpos2,186); r=up(xpos2,c%2+1); dummy=0; }
                }
        if(r==5||input==0x45) return(1);
        if(xpos<=16&&incr==-6) dummy=0;
           else if(xpos>=272&&incr==6) dummy=0;
        WaitTOF();
        }
   ball2.PlanePick=0x00;
   DrawImage(rp,&ball2,xpos,186);
   }
return(1);
}

int up(int where,int who) /* This function sends an ordinary ball up */
{
int y,w,stop,up,across,max;
int gameover;

for(w=0;w<12;w++)
   if(loc[(where-12)/12][w]==0)
   {
   stop=w;
   loc[(where-12)/12][w]=who;
   w=13;
   }

across=(where-12)/12;
up=stop;

w=60+(stop*12);

where+=7;

ball.PlanePick=ball2.PlanePick;

for(y=186;y>w;y--)
   DrawImage(rp,&ball,where,y);

StopSound(RIGHT0);
if(boing) PlaySound(boing,MAXVOLUME,RIGHT0,NORMALRATE,1);

max=how_many(across,up,who);
if(max>=connect) { gameover=1; AWinner(who); } else gameover=0;

if(gameover) return(5); else return(2);
}



AWinner(int w)
{
if(w==1) DrawImage(rp,&left,65,156);
   else DrawImage(rp,&right,65,156);
while(idcmpch()!=0x45);
return(1);
}

int how_many(int across,int up,int person)
{    /* This function returns the maximum number of circles of the colour
        just shot up either diagonally,horizontally or vertically. */
int n1,n2,n3,n4;
int dummy,c1,c2,max;
int a,u;

a=across; u=up; dummy=1; c1=0;

while(dummy)
   {
      if(a==0) dummy=0;
      else {
      --a;
      if(loc[a][u]==person) c1++;
      else dummy=0;
      }
   }

a=across; u=up; dummy=1; c2=0;

while(dummy)
   {
      if(a==39) dummy=0;
      else {
      ++a;
      if(loc[a][u]==person) c2++;
      else dummy=0;
      }
   }

n1=c1+1+c2;

a=across; u=up; dummy=1; c1=0;

while(dummy)
   {
      if(u==0) dummy=0;
      else {
      --u;
      if(loc[a][u]==person) c1++;
      else dummy=0;
      }
   }

a=across; u=up; dummy=1; c2=0;

while(dummy)
   {
      if(u==11) dummy=0;
      else {
      ++u;
      if(loc[a][u]==person) c2++;
      else dummy=0;
      }
   }

n2=c1+1+c2;

a=across; u=up; dummy=1; c1=0;

while(dummy)
   {
      if(u==0||a==0) dummy=0;
      else {
      --u; --a;
      if(loc[a][u]==person) c1++;
      else dummy=0;
      }
   }

a=across; u=up; dummy=1; c2=0;

while(dummy)
   {
      if(u==39||a==11) dummy=0;
      else {
      ++u; ++a;
      if(loc[a][u]==person) c2++;
      else dummy=0;
      }
   }

n3=1+c1+c2;

a=across; u=up; dummy=1; c1=0;

while(dummy)
   {
      if(a==39||u==0) dummy=0;
      else {
      a++; --u;
      if(loc[a][u]==person) c1++;
      else dummy=0;
      }
   }

a=across; u=up; dummy=1; c2=0;

while(dummy)
   {
      if(a==39||u==11) dummy=0;
      else {
      --a; ++u;
      if(loc[a][u]==person) c2++;
      else dummy=0;
      }
   }

n4=c1+1+c2;

if(n1>n2) max=n1; else max=n2;
if(max<n3) max=n3;
if(max<n4) max=n4;  

/*  n1 is the value of how many circles where found horizontally from the
    circle that was just sent up.
    n2 is the value of how many circles where found vertically 
    n3 & n4 is the value of how many circles where found diagonally 
    AND finally max contains the largest of these 4 values */

return(max);
}

up2(int where)   /*  This function sends a blue ball up! */
{
int y;
where+=7;

for(y=1;y<12;y++)
   loc[(where-12)/12][y]=0;
loc[(where-12)/12][0]=5;

ball.PlanePick=ball2.PlanePick;

for(y=186;y>60;y--)
   DrawImage(rp,&ball,where,y);

StopSound(RIGHT0);
if(boing) PlaySound(boing,MAXVOLUME,RIGHT0,NORMALRATE,1);

return(TRUE);
}

ClearRASTPORT()
{
struct Image i = {
0,0,277,150,0,NULL,0,0,NULL };
DrawImage(rp,&i,18,61);
return(8);
}      

Init_Screen()
{
int sec,micros;

ClearRASTPORT();
CurrentTime(&sec,&micros);
srand(sec*9999+micros);

SetRGB4(vp,1,0xD,0xD,0);
SetRGB4(vp,2,0xB,0,0);
SetRGB4(vp,3,0,0xB,0);
SetRGB4(vp,4,15,0,0);
SetRGB4(vp,5,4,4,4);
SetRGB4(vp,6,8,8,8);
SetRGB4(vp,7,0xC,0xC,0xC);

SetRGB4(vp,8,0,15,0);
SetRGB4(vp,16,0,0,15);
SetRGB4(vp,29,13,13,13);
SetRGB4(vp,30,13,13,4);

DrawImage(rp,&title,0,0);
DrawImage(rp,&strip,4,61);
DrawImage(rp,&strip,295,61);     

boing=PrepareSound("boing");

SetPointer(win,dummydata,1,1,0,0);

return(TRUE);
}

ClearLOCS()
{
int a,b;
for(a=0;a<40;a++)
 for(b=0;b<12;b++)
   loc[a][b]=0;
return(1);
}     


/*************************************************************************/
/*************************************************************************/
/*************************************************************************/
/***************************                      ************************/
/***************************    Functions....     ************************/
/***************************                      ************************/
/*************************************************************************/
/*************************************************************************/
/*************************************************************************/

int idcmpch()
{
        if(win->UserPort->mp_SigBit)
        if(message=(struct IntuiMessage *)GetMsg(win->UserPort))
        {
        class=message->Class;
        code=message->Code;
        ReplyMsg((struct IntuiMessage *)message);
           switch(class)
              {
              case MOUSEBUTTONS:
                   return((int)0x68);
              case RAWKEY:
                   return((int)code);
              }
        }
return(0);  /* Nothing interesting! */
}



Open_Stuff()
{

void *OpenLibrary();
struct Window *OpenWindow();
struct Screen *OpenScreen();

if(!(IntuitionBase=(struct IntuitionBase *)OpenLibrary("intuition.library",0)))
   die("Can't open intuition.library");

if(!(GfxBase=(struct GfxBase *)OpenLibrary("graphics.library",0)))
   die("Can't open graphics library");


if((scr=OpenScreen(&ns))==NULL)
die("");

nw.Screen=scr;

if(!(win=(struct Window *)OpenWindow(&nw)))
   die("");

rp=win->RPort;
vp=&scr->ViewPort;

SetRGB4(vp,0,0,0,0);

return(TRUE);

}


die(s)
char *s[];
{
char Alert[300];
register int loop;

if(strlen(s)!=0) /* Display alert if s isn't NULL */
   {
   memset((void *)Alert,0,sizeof(Alert));
   strcat(Alert,s);
   strcat(Alert,"       Press either mouse button to continue.");
   loop=strlen(s);
   Alert[0]=0; Alert[1]=32; Alert[2]=16;
   Alert[loop+2]='\0'; Alert[loop+3]=TRUE;
   Alert[loop+4]=0; Alert[loop+5]=32; Alert[loop+6]=32;
   Alert[loop+45]='\0'; Alert[loop+46]=FALSE;
   DisplayAlert(RECOVERY_ALERT,Alert,48);
   }

if((left_arrow.num)!=-1) FreeSprite(left_arrow.num);
if((right_arrow.num)!=-1) FreeSprite(right_arrow.num);

StopSound(RIGHT0);
if(boing) RemoveSound(boing);

if(win) CloseWindow(win);
if(scr) CloseScreen(scr);
if(GfxBase) CloseLibrary(GfxBase);
if(IntuitionBase) CloseLibrary(IntuitionBase);
exit();
return(TRUE);
}


