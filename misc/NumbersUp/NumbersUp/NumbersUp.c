
#include <intuition/intuition.h>
#include <stdio.h>
#include "includesound.h"
#include "imagec"
#include "infoc"
#include "titlec"
#include "questionc"
#include "gameoverc"
#include "sound"

#define HEIGHT 203
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
{ 0,0,WIDTH,HEIGHT,DEPTH,0,1,NULL,  /* View modes */
  CUSTOMSCREEN,  /* Screen type */
  NULL,          /* Font */
  NULL,NULL,NULL          /* CustomBitmap */  };

struct NewWindow nw =
{ 0,0,WIDTH,HEIGHT,0,1,MOUSEBUTTONS+VANILLAKEY,  /* IDCMP flags */
  ACTIVATE|BORDERLESS|RMBTRAP, /* Flags */
  NULL,NULL,NULL,  /* Gadget,Checkmark,Name */
  NULL,NULL,  /* Screen,BitMap */
  WIDTH,HEIGHT,100,100,  /* Max Width,Height, Min Width,Height */
  CUSTOMSCREEN  };

char names[12][80];
int scores[12];

int save_to_disk=1;

char dis[15];
int loc[50][50];
int number,dummy,xi,xpos,score=0;
int rawkey=1;

UWORD pointer_data[] = { 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000 };

main()
{
int input;
FILE *testing123;

Open_Stuff();
SetPointer(win,&pointer_data,1,1,0,0);

SetRGB4(vp,1,10,3,8);
SetRGB4(vp,2,15,0,0);
SetRGB4(vp,3,0,15,0);
SetRGB4(vp,4,0,0,15);
SetRGB4(vp,5,7,7,7);
SetRGB4(vp,6,15,0,15);
SetRGB4(vp,7,0,15,15);
SetRGB4(vp,8,15,15,0);
SetRGB4(vp,9,0,15,7);
SetRGB4(vp,10,15,9,9);
SetRGB4(vp,11,15,15,15);
SetRGB4(vp,20,15,15,0);
SetRGB4(vp,22,15,0,0);
SetRGB4(vp,25,9,9,9);
SetRGB4(vp,29,15,15,0);

Move(rp,120,100);
Text(rp,"Loading...",10);

Save_to_disk();

SetAPen(rp,1);

DrawImage(rp,&title,0,0);

InitRandom();
InitLoc();
InitScreen();
ClearSelected();
InitHighScores();
while(1)
    {
    DrawImage(rp,&image,52,67);
    while((input=idcmpch())==0);
      if(input==1) NumbersUp();
        else if(input==81) die("");
           else if(input==2) ViewHighScores();
              else if(input==73) ViewInstructions();
   }
}


Save_to_disk()
{
int i;
DrawImage(rp,&saved,71,40);
while(1)
   {
   while((i=idcmpch())==0);
   if(i==1) { save_to_disk=1; ClearAll(); return(); }
   else if(i==2) { save_to_disk=0; ClearAll(); return(); }
   }
}

ViewInstructions()
{
DrawImage(rp,&info,50,65);  /* This simply draws the info to the window */
while(idcmpch()!=1);
return();
}

ViewHighScores()
{
int m,color=1;
char numy[100];

ClearSelected();
SetAPen(rp,20);
for(m=0;m<10;m++)
   {
   Move(rp,100,90+m*10);
   Text(rp,names[m],strlen(names[m]));
   Move(rp,193,90+m*10);
   sprintf(numy,"%d",scores[m]);
   Text(rp,numy,strlen(numy));
   SetAPen(rp,color++);
   }
SetAPen(rp,22);
Move(rp,113,75); Text(rp,"HIGH SCORES",11);
Move(rp,75,200); Text(rp,"Press LMB to continue",21);
while(idcmpch()!=1);
ClearSelected();
}

ClearSelected()
{
struct Image i ={
0,0,288,137,1,NULL,0,0,NULL };
DrawImage(rp,&i,16,65);
}

ClearAll()
{
struct Image i={
0,0,320,203,1,NULL,0,0,NULL };
DrawImage(rp,&i,0,0);
}

NumbersUp()
{

int dummy2,gameover=1,nopress=1;
int input;
score=0;
SetAPen(rp,1);
DisplayScore();
InitRandom();
InitLoc();
InitScreen();
ClearSelected();
while(gameover)
  {
  if(!nopress)
     {
     score-=100;
     if(score<0) score=0;
     DisplayScore();
     }

  number=rand()%2;
  if(number==1)
     {
     number=rand()%9+1;
     sprintf(dis," %c",number+48);
     xi=4;
     xpos=0;
     }
     else
     {
     number=rand()%9+1;
     sprintf(dis,"%c ",number+48);
     xpos=304;
     xi=-4;
     }

  SetAPen(rp,number+1);
  dummy=1;
  while(dummy)
     {
     xpos+=xi;
     Move(rp,xpos,200);
     Text(rp,dis,2);
     dummy2=xpos;
     if(xi==4)
        {
        if(xpos%8!=0) dummy2=xpos+12;
          else dummy2=xpos+8;
        }
        else
        if(xpos%8!=0) dummy2=xpos-4;

     nopress=1;
     input=idcmpch();

     if(input==1||input==-2)
      {
      if(loc[(dummy2-16)/8+1][14]==0)
        {
        dummy=0;
        if(up()==9) gameover=0;
        }
      WaitTOF();
      }
        else
        {
        WaitTOF();
        if(xi==4&&xpos==288)
           {
           dummy=0;
           Move(rp,xpos,200);
           Text(rp,"  ",2);
           nopress=0;
           }
           else
           if(xi==-4&&xpos==16)
           {
           dummy=0;
           Move(rp,xpos,200);
           Text(rp,"  ",2);
           nopress=0;
           }
        }
     }
  }
if((CheckHighScores())==0) displayend();
}

displayend()
{
SetAPen(rp,2);
DrawImage(rp,&gameover,93,158);
Move(rp,75,180); Text(rp,"Press LMB to continue",21);
while(idcmpch()!=1);
return();
}

CheckHighScores()
{
int m,place,dy,input,w=0;
char temp[100],blanks[100];

if(score<=scores[9]) return(0);  /* The user hasn't got a high score! */

memset((void *)temp,0,sizeof(temp));

for(m=0;m<10;m++)
  if(score>scores[m])
     {
     place=m;
     m=10;
     }
dy=1;
DrawImage(rp,&gameover,93,158);
SetAPen(rp,20);
Move(rp,75,180);
Text(rp,"You got a high score",20);
Move(rp,67,190);
Text(rp,"Please enter your name",22);
Move(rp,90,200);
Text(rp,"NAME:",5);
while(dy)
   {
   while((input=idcmpch())==0);
   if(input==13) dy=0;
     else if(input<=97&&input>=65&&w<=10)
     {
     temp[w++]=input;
     Move(rp,140,200);
     Text(rp,temp,strlen(temp));
     }
     else if(input==8&&w>0)
     {
     temp[--w]='\0';
     Move(rp,140,200);
     sprintf(blanks,"%s                         ",temp);
     Text(rp,blanks,24);
     }
   }

if(place==9) { scores[place]=score; strcpy(names[place],temp); }
else
{
for(m=8;m>=place;m--)
   {
   scores[m+1]=scores[m];
   strcpy(names[m+1],names[m]);
   }
scores[place]=score;
strcpy(names[place],temp);
}

ClearSelected();
if(save_to_disk) CreateNew();
ViewHighScores();   /* Show the user the high scores when he/she gets one */
return(1);
}

InitHighScores()
{
FILE *high;
if((high=fopen("highs","r"))==NULL)
  {
  CreateBrandNew();
  }
  else
  {
  fclose(high);
  LoadHighScores();
  }
}

LoadHighScores()
{
char temp[10],c;
FILE *high;
int m,o;

high=fopen("highs","r");
rewind(high);

for(m=0;m<10;m++)
  {
  o=0;
    while((c=getc(high))!=12)
    names[m][o++]=c;

    memset((void *)temp,0,sizeof(temp));
  o=0;
    while((c=getc(high))!=12)
    temp[o++]=c+34;
  scores[m]=atoi(temp);
  }
fclose(high);
return();
}

CreateBrandNew()   /* If there is no high score file I create one */
{                  /* Delete the file "highs" and see what happens */
FILE *high;
char temp[1000],dum[100];
int m;
memset((void *)temp,0,sizeof(temp));
for(m=0;m<10;m++)
 {
 sprintf(dum,"Jason%c%c%c%c%c%c%c",12,14,14,15,14,14,12);
 strcpy(names[m],"Jas");
 scores[m]=100;
 strcat(temp,dum);
 }

if(save_to_disk)
if((high=fopen("highs","w"))==NULL)
  die("   I NEED YOUR DISK TO BE WRITE ENABLED SO I CAN CREATE A HIGHSCORES TABLE!!!");
  else
  {
  fwrite(temp,1,strlen(temp),high);
  fclose(high);
  }
}

CreateNew()
{
int n,n1,n2,m,length,when=0;
char tem[1000],tem2[10];
FILE *file;
memset((void *)tem,0,sizeof(tem));
memset((void *)tem2,0,sizeof(tem2));

if((file=fopen("highs","w"))==NULL)
   when=TRUE;

for(m=0;m<10;m++)
 {
 strcat(tem,names[m]);
 tem[strlen(tem)]=12;
 n=scores[m];
 length=0;
  for(n1=4;n1>=0;n1--)
     {
     n2=n%10;
     n=(n-n2)/10;
     tem2[length++]=n2+14;
     }
 length=strlen(tem);
  for(n1=4;n1>=0;n1--)
  tem[length++]=tem2[n1];
  tem[strlen(tem)]=12;
  }

if(when==TRUE) return();

  fwrite(tem,1,strlen(tem),file);
  fclose(file);
return();
}


InitRandom()
{
ULONG sec,micros;
CurrentTime(&sec,&micros);
srand(sec*99+micros);
return();
}

up()
{
register int y,where,ttt,stop;
int num1,num2,num3,num;
char buf2[80];

if(xpos%8!=0)
  {
  xpos+=xi;
  Move(rp,xpos,200); Text(rp,dis,2);
  }

if(xi==4) xpos+=8;
sprintf(dis,"%c",number+48);

where=(xpos-16)/8;
where++;

for(ttt=0;ttt<50;ttt++)
 if(loc[where][ttt+1]==0)
    {
    loc[where][ttt+1]=number;
    stop=ttt;
    ttt=50;
    }

num=loc[where][stop+1];

num1=loc[where][stop];
num2=loc[where+1][stop+1];
num3=loc[where-1][stop+1];

ttt=stop*9+73;

Move(rp,xpos,200); Text(rp," ",1);

for(y=200;y>=ttt;y--)
 {
 Move(rp,xpos,y);
 Text(rp,dis,1);
 }


if(num1==num||num2==num||num3==num)
  {
  StopSound(LEFT0);
  PlaySound(&boing,MAXVOLUME,LEFT0,NORMALRATE,1,0,0);
  return(9);
  }
else
  {
  StopSound(LEFT0);
  PlaySound(&boing,MAXVOLUME,LEFT0,NORMALRATE,1,0,0);
  score+=((num1+num2+num3)*num);
  DisplayScore();
  return(8);
  }
}

DisplayScore()
{
char bufferIII[30];
SetAPen(rp,29);
sprintf(bufferIII,"%5d",score);
Move(rp,166,51);
Text(rp,bufferIII,strlen(bufferIII));
return();
}

InitScreen()
{

register int y;

SetAPen(rp,1);

for(y=191;y>=65;y-=9)
 {
 Move(rp,8,y); Text(rp,"*",1);
 Move(rp,304,y); Text(rp,"*",1);
 }

for(y=8;y<304;y+=8)
 {
 Move(rp,y,65); Text(rp,"*",1);
 }
DisplayScore();
return();
}


InitLoc()
{
register int a,b;
for(a=0;a<50;a++)
 for(b=0;b<50;b++)
  loc[a][b]=0;
return();
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
                   switch(code)
                   {
                   case SELECTDOWN:
                   return(1);
                   case MENUDOWN:
                   return(2);
                   }
              case VANILLAKEY:
              if(code<=122&&code>=97) { code-=32;
              return(code); }
              if(code==32) return(-2); else return(code);
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
   die("   ERROR IN STARTING UP");

if(!(GfxBase=(struct GfxBase *)OpenLibrary("graphics.library",0)))
   die("   ERROR IN STARTING UP");


if((scr=OpenScreen(&ns))==NULL)
   die("   ERROR IN STARTING UP");

nw.Screen=scr;

if(!(win=(struct Window *)OpenWindow(&nw)))
   die("   ERROR IN STARTING UP");

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

StopSound(LEFT0);

if(win) CloseWindow(win);
if(scr) CloseScreen(scr);
if(GfxBase) CloseLibrary(GfxBase);
if(IntuitionBase) CloseLibrary(IntuitionBase);
exit();
return(TRUE);
}


