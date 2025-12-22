
#include <intuition/intuition.h>
#include <graphics/sprite.h>
#include "crc"
#include "includesound.h"

#define HEIGHT 200
#define WIDTH 640
#define DEPTH 4

extern struct Image title;
extern struct Image ask;
extern struct Image rooms;
extern struct Image question;

extern struct Image square1;
extern struct Image square2;
extern struct Image square3;

extern struct Image start;

extern char Room1[34][70];
extern char Room5[21][70];
extern char Room6[40][57];
extern char Room2[24][72];
extern char Room3[22][70];
extern char Room7[26][70];
extern char Room4[26][70];
extern char Room8[34][70];
extern char Room9[35][70];

extern char LASTROOM[21][100];
extern char LastROOM[5][100];

extern struct SoundInfo lefty;
extern struct SoundInfo bad;
extern struct SoundInfo good;

extern struct Image tri1;
extern struct Image tri2;
extern struct Image tri3;

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
{ 0,0,WIDTH,HEIGHT,4,0,1,HIRES,  /* View modes */
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

char children[7][10]={"KIM","ROSEMARIE","ROBERT","SANDRA","SIMON","TERRY","MELINDA" };

char r1[100],r2[100],r3[100],r4[100],users_input[20],correct_answer[20];
char r5[100],r6[100];
int d,e;

UWORD DUMMY_SPRITE_DATA[]={ 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000 };

main(int argc, char *argv[])
{
int input=1;

Open_Stuff();
GetSprite(&cross,2);
SetPointer(win,DUMMY_SPRITE_DATA,1,1,0,0);

InitScreenI();
DrawImage(rp,&start,51,51);

Delay(25);

StopSound(RIGHT1);
PlaySound(&lefty,MAXVOLUME,RIGHT1,NORMALRATE,1,0,0);

while(input)
      {
      while((d=idcmpch())==0);
      if(d==-1) input=0; 
      }

SetAPen(rp,0);
RectFill(rp,1,38,638,198);

InitScreenII();

while(1)
   {
   DrawImage(rp,&ask,100,92);
   while((input=idcmpch())==0);
   if(input==0x19) { MathsAdventure(); ClearAll(); }
      else if(input==0x10) die("");
   ClearBORDER();
   MoveBorder(1);
   }


die("");

}

DisplayEnd(){}

ClearBORDER()
{
ChangeSprite(vp,&cross,dummy_data);
}

RenewBORDER()
{
ChangeSprite(vp,&cross,sprite_data);
}


/***************************************************************************/
/***************************************************************************/

MathsAdventure()
{
int room=1,result;


ClearAll();
MoveBorder(room);
RenewBORDER();
MoveBorder(room);
result=EnterRoom(room);
if(!result) { DisplayEnd();  return(0); }

while(1)
   {
   ClearAll();
   room=GetRoom(room);
   MoveBorder(room);
   result=EnterRoom(room);
   if(!result) { DisplayEnd(); return(0); }
   }
}

/***************************************************************************/
/***************************************************************************/

RETURN()
{
int i;

SetAPen(rp,3);
WRITEIN("[RETURN]",385,170);

while(1)
   {
   while((i=idcmpch())==0);
   if(i==0x44||i==0x43) return(0);
   }
}

/***************************************************************************/
/***************************************************************************/

EnterRoom1()
{
int x,q;
char buf1[60],answer[10],input[15];
q=rand()%3+1;

if(q==1)
   {
   strcpy(buf1,"product of 9 and 12.");
   strcpy(answer,"");
   }
else if(q==2)
   {
   strcpy(buf1,"sum of 14,15 and 16.");
   strcpy(answer,"");
   }
else 
   {
   strcpy(buf1,"difference between 99 and 1001.");
   strcpy(answer,"");
   }

ClearBox1();
SetAPen(rp,8);
for(x=0;x<8;x++)
WRITEIN(Room1[x],14,100+(10*x));

RETURN();

ClearBox1();
SetAPen(rp,8);
for(x=8;x<15;x++)
WRITEIN(Room1[x],14,100+(10*(x-8)));

RETURN();

ClearBox1();
SetAPen(rp,8);
for(x=15;x<22;x++)
WRITEIN(Room1[x],14,100+(10*(x-15)));
WRITEIN(buf1,14,170);

GetAnswer(input);
ClearBox1();
SetAPen(rp,8);
if(strcmp(input,answer)==0) 
   {
   IsCorrect(1);
   for(x=22;x<26;x++)
   WRITEIN(Room1[x],14,120+(10*(x-22)));
   RETURN();
   return(1);
   }
   else
   {
   IsCorrect(0);
   for(x=26;x<34;x++)
   WRITEIN(Room1[x],14,100+(10*(x-26)));
   RETURN();
   return(0);
   }
}

/***************************************************************************/
/***************************************************************************/


EnterRoom2()
{

ClearAll();

strcpy(r2,"have? '");

d=rand()%3+1;

if(d==1)
   {
   strcpy(r1,"problem goes like this, how many sides does a pentagon");
   strcpy(correct_answer,"");
   }
else if(d==2)
   {
   strcpy(r1,"problem goes like this, how many sides does a  hexagon");
   strcpy(correct_answer,"");
   }
else
   {
   strcpy(r1,"problem goes like this, how many edges does a cube ");
   strcpy(correct_answer,"");
   }

SetAPen(rp,8);
for(d=0;d<7;d++)
   WRITEIN(Room2[d],14,100+(d*10));
RETURN();

ClearBox1();
SetAPen(rp,8);
for(d=7;d<12;d++)
   WRITEIN(Room2[d],14,((d-7)*10)+105);
WRITEIN(r1,14,155);
WRITEIN(r2,14,165); 

GetAnswer(users_input);
if(strcmp(users_input,correct_answer)==0)
   {
   ClearBox1();
   IsCorrect(1);
   for(d=12;d<16;d++)
      WRITEIN(Room2[d],14,((d-11)*10)+115);
   RETURN();
   return(1);
   }
   else
   {
   ClearBox1();
   IsCorrect(0);
   for(d=17;d<24;d++)
      WRITEIN(Room2[d],14,((d-17)*10)+100);
   RETURN();
   return(0);
   }

}

/*************************************************************************/
/*************************************************************************/
/*************************************************************************/
/*************************************************************************/

EnterRoom3()
{

ClearAll();

d=rand()%3+1;

if(d==1)
   {
   strcpy(r1,"between the hands of a clock at 3:00pm ?'");
   strcpy(correct_answer,"");
   }
else if(d==2)
   {
   strcpy(r1,"between the hands of a clock at 7:00pm ?'");
   strcpy(correct_answer,"");
   }
else
   {
   strcpy(r1,"between the hands of a clock at 8:00pm ?'");
   strcpy(correct_answer,"");
   }

SetAPen(rp,8);
for(d=0;d<8;d++)
   WRITEIN(Room3[d],14,100+(d*10));
RETURN();

ClearBox1();
SetAPen(rp,8);
for(d=8;d<13;d++)
   WRITEIN(Room3[d],14,((d-7)*10)+105);
WRITEIN(r1,14,165);

GetAnswer(users_input);
if(strcmp(users_input,correct_answer)==0)
   {
   ClearBox1();
   IsCorrect(1);
   for(d=13;d<17;d++)
      WRITEIN(Room3[d],14,((d-12)*10)+115);
   RETURN();
   return(1);
   }
   else
   {
   ClearBox1();
   IsCorrect(0);
   for(d=17;d<22;d++)
      WRITEIN(Room3[d],14,((d-16)*10)+115);
   RETURN();
   return(0);
   }

}

/***************************************************************************/
/***************************************************************************/


EnterRoom4()
{

ClearAll();

d=rand()%3+1;

if(d==1)
   strcpy(correct_answer,"");
else if(d==2)
   strcpy(correct_answer,"");
else
   strcpy(correct_answer,"");

e=d;

SetAPen(rp,8);
for(d=0;d<8;d++)
   WRITEIN(Room4[d],14,100+(d*10));
RETURN();

ClearBox1();
SetAPen(rp,8);
for(d=8;d<11;d++)
   WRITEIN(Room4[d],14,((d-8)*10)+140);

if(e==1)
   DrawImage(rp,&square1,205,95);
else if(e==2)
   DrawImage(rp,&square2,203,95);
else DrawImage(rp,&square3,181,95);

GetAnswer(users_input);
if(strcmp(users_input,correct_answer)==0)
   {
   ClearBox1();
   IsCorrect(1);
   for(d=11;d<19;d++)
      WRITEIN(Room4[d],14,((d-11)*10)+100);
   RETURN();
   return(1);
   }
   else
   {
   ClearBox1();
   IsCorrect(0);
   for(d=19;d<26;d++)
      WRITEIN(Room4[d],14,((d-19)*10)+100);
   RETURN();
   return(0);
   }

}


/***************************************************************************/
/***************************************************************************/

EnterRoom5()
{

ClearAll();

d=rand()%3+1;

if(d==1)
   {
   strcpy(r1,"deal with this room. Ok. I'm thinking  of a  number. If");
   strcpy(r2,"you  double  it, add 5, subtract 6, divide  by  5  then");
   strcpy(r3,"finally add the number I'm thinking of, you'll get  18.");
   strcpy(r4,"What number am I thinking of ?'");
   strcpy(correct_answer,"");
   }
else if(d==2)
   {
   strcpy(r1,"deal with this room. Ok. I'm thinking  of two  numbers."); 
   strcpy(r2,"Their sum is 28 more than their difference. What is the");
   strcpy(r3,"smaller number?'");
   strcpy(r4,"");
   strcpy(correct_answer,"");
   }
else
   {
   strcpy(r1,"deal with this room. Ok. I'm thinking of  two  numbers.");
   strcpy(r2,"Their average  is 40 greater than  the  smallest number");
   strcpy(r3,"and their sum is 280. What is the larger number?'");
   strcpy(r4,"");
   strcpy(correct_answer,"");
   }

SetAPen(rp,8);
for(d=0;d<8;d++)
   WRITEIN(Room5[d],14,100+(d*10));
RETURN();

ClearBox1();
SetAPen(rp,8);
for(d=8;d<10;d++)
   WRITEIN(Room5[d],14,((d-8)*10)+105);
WRITEIN(r1,14,125); 
WRITEIN(r2,14,135); 
WRITEIN(r3,14,145); 
WRITEIN(r4,14,155); 

GetAnswer(users_input);
if(strcmp(users_input,correct_answer)==0)
   {
   ClearBox1();
   IsCorrect(1);
   for(d=15;d<21;d++)
      WRITEIN(Room5[d],14,((d-16)*10)+115);
   RETURN();
   return(1);
   }
   else
   {
   ClearBox1();
   IsCorrect(0);
   for(d=10;d<15;d++)
      WRITEIN(Room5[d],14,((d-10)*10)+110);
   RETURN();
   return(0);
   }

}


/***************************************************************************/
/***************************************************************************/

EnterRoom6()
{

d=rand()%3+1;
if(d==1)
   {
   strcpy(r1,"    At a party 66 handshakes were exchanged. If each");
   strcpy(r2,"person shook hands with each other exactly once, how");
   strcpy(r3,"many people were present at the party?");
   strcpy(correct_answer,"");
   }
   else if(d==2)
   {
   strcpy(r1,"    How many solid cubes of side length 2cm can be made"); 
   strcpy(r2,"from a solid block of wood measuring 4cm by 8cm by 2cm?");
   strcpy(r3,"");
   strcpy(correct_answer,"");
   }
   else 
   {
   strcpy(r1,"   A cube of  side length 8cm is  made up of individual");
   strcpy(r2,"1cm cubes. How many of these 1cm cubes are face-to-face");
   strcpy(r3,"with exactly four other 1cm cubes?");
   strcpy(correct_answer,"");
   }

for(d=0;d<3;d++)
   {
   ClearBox1();
   SetAPen(rp,8);
   for(e=d*8;e<(d*8+8);e++)
      WRITEIN(Room6[e],14,((e-(d*8))*10)+100);
   RETURN();   
   }

ClearBox1();
SetAPen(rp,8);
WRITEIN(Room6[24],14,125);
WRITEIN(r1,14,135);
WRITEIN(r2,14,145);
WRITEIN(r3,14,155);

GetAnswer(users_input);
if(strcmp(users_input,correct_answer)==0)
   {
   ClearBox1();
   IsCorrect(1);
   for(d=25;d<33;d++)
      WRITEIN(Room6[d],14,((d-25)*10)+100);
   RETURN();
   return(1);
   }
   else
   {
   ClearBox1();
   IsCorrect(0);
   for(d=33;d<40;d++)
      WRITEIN(Room6[d],14,((d-33)*10)+100);
   RETURN();
   return(0);
   }

}

/***************************************************************************/
/***************************************************************************/

EnterRoom7()
{

ClearAll();

d=rand()%3+1;

if(d==1)
   {
   strcpy(correct_answer,"");
   }
else if(d==2)
   {
   strcpy(correct_answer,"");
   }
else
   {
   strcpy(correct_answer,"");
   }

e=d;

SetAPen(rp,8);
for(d=0;d<8;d++)
   WRITEIN(Room7[d],14,100+(d*10));
RETURN();

ClearBox1();

if(e==1) DrawImage(rp,&tri1,176,95);
else if(e==2) DrawImage(rp,&tri2,156,95);
else DrawImage(rp,&tri3,158,95);

SetAPen(rp,8);
for(d=8;d<11;d++)
   WRITEIN(Room7[d],14,140+((d-8)*10));

GetAnswer(users_input);
if(strcmp(users_input,correct_answer)==0)
   {
   ClearBox1();
   IsCorrect(1);
   for(d=11;d<18;d++)
      WRITEIN(Room7[d],14,((d-11)*10)+100);
   RETURN();
   return(1);
   }
   else
   {
   ClearBox1();
   IsCorrect(0);
   for(d=18;d<26;d++)
      WRITEIN(Room7[d],14,((d-18)*10)+100);
   RETURN();
   return(0);
   }

}

/***************************************************************************/
/***************************************************************************/

EnterRoom8()
{

ClearAll();

strcpy(correct_answer,"");


SetAPen(rp,8);
for(d=0;d<8;d++)
   WRITEIN(Room8[d],14,100+(d*10));
RETURN();

ClearBox1();
SetAPen(rp,8);
for(d=8;d<14;d++)
   WRITEIN(Room8[d],14,100+((d-7)*10));
RETURN();

ClearBox1();
SetAPen(rp,8);
for(d=14;d<22;d++)
   WRITEIN(Room8[d],14,100+((d-14)*10));

GetAnswer(users_input);
if(strcmp(users_input,correct_answer)==0)
   {
   ClearBox1();
   IsCorrect(1);
   for(d=22;d<28;d++)
      WRITEIN(Room8[d],14,((d-22)*10)+105);
   RETURN();
   return(1);
   }
   else
   {
   ClearBox1();
   IsCorrect(0);
   for(d=28;d<34;d++)
      WRITEIN(Room8[d],14,((d-28)*10)+105);
   RETURN();
   return(0);
   }

}

/***************************************************************************/
/***************************************************************************/

EnterRoom9()
{

ClearAll();

d=rand()%3+1;

if(d==1)
   strcpy(correct_answer,"");
else 
   strcpy(correct_answer,"");

e=d;

SetAPen(rp,8);
for(d=0;d<8;d++)
   WRITEIN(Room9[d],14,100+(d*10));
RETURN();

ClearBox1();
SetAPen(rp,8);
for(d=8;d<16;d++)
   WRITEIN(Room9[d],14,((d-8)*10)+100);
RETURN();

ClearBox1();
SetAPen(rp,8);
if(e==1)
   for(d=16;d<20;d++)
      WRITEIN(Room9[d],14,((d-15)*10)+100);
else
   for(d=20;d<27;d++)
      WRITEIN(Room9[d],14,((d-19)*10)+100);

GetAnswer(users_input);
if(strcmp(users_input,correct_answer)==0)
   {
   ClearBox1();
   IsCorrect(1);
   for(d=30;d<34;d++)
      WRITEIN(Room9[d],14,((d-29)*10)+100);
   RETURN();
   return(1);
   }
   else
   {
   ClearBox1();
   IsCorrect(0);
   for(d=27;d<30;d++)
      WRITEIN(Room9[d],14,((d-25)*10)+100);
   RETURN();
   return(0);
   }

}

/***************************************************************************/
/***************************************************************************/

LastRoom()
{
char buf[100];
int across,dummy=1,x,dummy2=1,a[10];

ClearBORDER();
MakeWay();
SetAPen(rp,8);

for(x=0;x<5;x++)
   WRITEIN(LastROOM[x],20,50+(10*x));

WRITEIN("JUST PRESS 'Y' or 'N' for your answer. (No need to press RETURN).",58,105);

while(dummy)
   {
      for(x=0;x<7;x++)
      {
      sprintf(buf,"Does %s catch the train?",children[x]);
      across=350-(strlen(buf)*8);
      SetAPen(rp,11);
      WRITEIN(buf,across,120+(10*x));

      dummy2=1;
      while(dummy2)
         {
         across=idcmpch();
         if(across==0x15) { a[x]=1; strcpy(buf,"Yes"); dummy2=0; SetAPen(rp,3); }
            else if(across==0x36) { a[x]=0; strcpy(buf,"No"); dummy2=0; SetAPen(rp,9);}
         }
      WRITEIN(buf,360,120+(10*x));
      }

   SetAPen(rp,8);
   WRITEIN("Is this correct??? (Y/N)",220,190);
   dummy2=1;
      while(dummy2)
      {
      across=idcmpch();
      if(across==0x15) { dummy=0; dummy2=0; } 
         else if(across==0x36) 
            {
            dummy2=0;
            SetAPen(rp,0);
            RectFill(rp,20,110,630,190);
            }
      }
   }

ClearBig();
if(MONKEYS LIKE BANANAS)
   {
   SetAPen(rp,8);
   for(d=0;d<15;d++)
      WRITEIN(LASTROOM[d],35,50+(10*d));

      SetAPen(rp,3);
      WRITEIN("[RETURN]",500,170);
      while(1)
      {
      while((d=idcmpch())==0);
      if(d==0x44||d==0x43) { ClearBig(); InitScreenI(); InitScreenII(); return(0); }
      }
   }
   else
   {
   SetAPen(rp,9);
   for(d=15;d<21;d++)
      WRITEIN(LASTROOM[d],20,70+(10*(d-15)));

      SetAPen(rp,3);
      WRITEIN("[RETURN]",500,140);
      while(1)
      {
      while((d=idcmpch())==0);
      if(d==0x44||d==0x43) { ClearBig(); InitScreenI(); InitScreenII(); return(0); }
      }
   }

}

/***************************************************************************/
/***************************************************************************/

InitScreenI()
{
int s,m;

CurrentTime(&s,&m);
srand(999*s+9*m+9);

SetRGB4(vp,1,0xB,0xB,0xB);
SetRGB4(vp,2,0x0,0x0,0xF);
SetRGB4(vp,3,0x0,0xF,0x0);
SetRGB4(vp,4,0x0,0x0,0xF);
SetRGB4(vp,5,0x5,0x5,0x5);
SetRGB4(vp,6,0x8,0x8,0x8);
SetRGB4(vp,7,0xC,0xC,0xC);
SetRGB4(vp,8,0x8,0xC,0xF);
SetRGB4(vp,9,0xF,0x0,0x0);
SetRGB4(vp,10,0xF,0x0,0x0);
SetRGB4(vp,11,0x3,0x3,0xF);

SetRGB4(vp,21,0x0,0x0,0xF);

SetAPen(rp,0);
RectFill(rp,8,40,638,195);

SetAPen(rp,2);

Move(rp,0,0);
Draw(rp,639,0);
Draw(rp,639,199);
Draw(rp,0,199);
Draw(rp,0,0);

DrawImage(rp,&title,28,1);
}

InitScreenII()
{
SetAPen(rp,2);

Move(rp,8,90);
Draw(rp,458,90);
Draw(rp,458,176);
Draw(rp,8,176);
Draw(rp,8,90);

Move(rp,465,90);
Draw(rp,631,90);
Draw(rp,631,195);
Draw(rp,465,195);
Draw(rp,465,90);

Move(rp,8,179);
Draw(rp,458,179);
Draw(rp,458,195);
Draw(rp,8,195);
Draw(rp,8,179);

Move(rp,78,40);
Draw(rp,562,40);
Draw(rp,562,86);
Draw(rp,78,86);
Draw(rp,78,40);

DrawImage(rp,&rooms,118,44);
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
                   return(-1);
                   }
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
   die("   Can't open intuition.library");

if(!(GfxBase=(struct GfxBase *)OpenLibrary("graphics.library",0)))
   die("   Can't open graphics library");


if((scr=OpenScreen(&ns))==NULL)
die("   NOT ENOUGH MEMORY!!!");

nw.Screen=scr;

if(!(win=(struct Window *)OpenWindow(&nw)))
   die("   NOT ENOUGH MEMORY!!!");

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

if(cross.num!=-1) FreeSprite(2); 

StopSound(RIGHT1);
StopSound(LEFT0);

if(win) CloseWindow(win);
if(scr) CloseScreen(scr);
if(GfxBase) CloseLibrary(GfxBase);
if(IntuitionBase) CloseLibrary(IntuitionBase);
exit();
return(TRUE);
}


GetAnswer(char answer[])
{
int dummy=1,maindummy=1,i=0,w=0,decimal=0,start,end;
char input[20],final[20];

memset((void *)final,0,sizeof(final));

DrawImage(rp,&question,466,91);

SetAPen(rp,8);
while(maindummy)
{
memset((void *)input,0,sizeof(input));
w=0;
decimal=0;
dummy=1;

Move(rp,508,179);
Text(rp,"           ",10);
Move(rp,473,190);
Text(rp,"                    ",19);

while(dummy)
   {
   while((i=idcmpch())==0);
      if(w<10)
      {
      if( i>=0x01  &&  i<=0x0A )
         if(i==0x0A) input[w++]='0'; else input[w++]=48+i;
      if( i>=0x1D  &&  i<=0x1F )
         input[w++]=i-0x1D+49;
      else if( i>=0x2D  &&  i<=0x2F )
         input[w++]=i-0x2D+52;
      else if( i>=0x3D  &&  i<=0x3F )
         input[w++]=i-0x3D+55;
      else if( i==0x0F ) input[w++]='0';
      } 

      if(!decimal)
      if( i==0x3C  ||  i==0x39)
         {
         input[w++]='.'; 
         decimal=1;
         }
      Move(rp,508,179);
      Text(rp,input,strlen(input));

      if(i==0x41  &&  w>0)
         {
         if(input[w-1]=='.') decimal=0;
         Move(rp,8*w+500,179);  
         Text(rp," ",1);
         input[--w]='\0';
         }
         
      if(i==0x44||i==0x43) dummy=0;
   
   }
dummy=1;
Move(rp,473,190);
Text(rp,"Are you sure? (Y/N)",19);
while(dummy)
   {
   while((i=idcmpch())==0);
   if(i==0x15) { dummy=0; maindummy=0; }
      else if(i==0x36) dummy=0;
   }
}
start=0;
while(input[start++]=='0');
if(decimal)
   {
   end=strlen(input)-1;
   if(input[end]=='0')
   while(input[end--]=='0');
   } else end=strlen(input)-1;
--start;
for(i=start,w=0;i<=end;i++,w++)
   final[w]=input[i];
if(final[strlen(final)-1]=='.') final[strlen(final)-1]='\0';

strcpy(answer,final);
}
 


     
GetRoom(int ro)
{
int i,dummy=1,maindummy=1,w=0,correct1,correct2;
char r[10];

ClearBox1();

if(ro==1) { correct1=2; correct2=3; }
   else if(ro==2||ro==3) { correct1=4; correct2=4; }
      else if(ro==4) { correct1=5; correct2=6; }
         else if(ro==5||ro==6) { correct1=7; correct2=7; }
            else if(ro==7) { correct1=8; correct2=8; }
               else if(ro==8) { correct1=9; correct2=9; }
                  else if(ro==9) { correct1=10; correct2=10; }

SetAPen(rp,8);
Move(rp,105,120);
Text(rp,"Which room shall you enter next.",32);

while(maindummy)
{
Move(rp,224,130); Text(rp,"        ",5);
Move(rp,145,140); Text(rp,"                          ",23);
w=0; 
memset((void *)r,0,sizeof(r));
dummy=1;

SetAPen(rp,9); 
while(dummy)
   {
   while((i=idcmpch())==0);
   if(w<2)
   if(i>=0x00 && i<=0x0A)
         {
         if(i==0x0A) 
            {
            if(r[0]=='1') r[w++]='0';
            }  
         else if(w==0) r[w++]=i+48;
         }
   else if(w==0)
         {
         if( i>=0x1D && i<=0x1F ) r[w++]=i-0x1E+50;
            else if(i>=0x2D&&i<=0x2F) r[w++]=i-0x2D+52;
               else if(i>=0x3D&&i<=0x3F) r[w++]=i-0x3D+55;
         }
         else if(r[0]=='1'&&i==0x0F) r[w++]='0';

   if(i==0x41&&w>0) 
      if(w==2) 
      {
      w=1;
      r[1]='\0';
      Move(rp,232,130); Text(rp,"  ",2);
      } 
      else
      {
      w=0;
      r[0]='\0';
      Move(rp,224,130); Text(rp,"  ",2);
      }
   
   if(i==0x44||i==0x43) if(w>0) dummy=0;
   Move(rp,224,130); Text(rp,r,strlen(r));
   }

SetAPen(rp,8);
Move(rp,145,140);
Text(rp,"Is this correct? (Y/N)",22);

dummy=1;
while(dummy)
   {
   while((i=idcmpch())==0);
   if(i==0x15) { maindummy=0; dummy=0; }
      else if(i==0x36) dummy=0;
   }

if(r[0]=='0') { r[0]=r[1]; r[1]='\0'; } 
dummy=atoi(r);
if(dummy!=correct1&&dummy!=correct2)
   if(maindummy==0)
      {
      Move(rp,93,150);
      Text(rp,"You can't enter that room! [RETURN]",35);
      while(1)
         {
         dummy=idcmpch();
         if(dummy==0x43||dummy==0x44) break; 
         }
      maindummy=1;
      Move(rp,93,150);
      Text(rp,"                                      ",35);
      }

}

ClearBox1();

return(atoi(r));     
 
}


MoveBorder(int r)
{
  if(r==2) MoveSprite(0,&cross,83,44);
   else if(r==3) MoveSprite(0,&cross,83,65);
    else if(r==4) MoveSprite(0,&cross,108,54);
     else if(r==5) MoveSprite(0,&cross,133,44);
      else if(r==6) MoveSprite(0,&cross,133,65);
       else if(r==7) MoveSprite(0,&cross,158,54);
        else if(r==8) MoveSprite(0,&cross,183,54);
         else if(r==9) MoveSprite(0,&cross,208,54);
          else if(r==10) MoveSprite(0,&cross,238,54);
           else MoveSprite(0,&cross,58,54);
}


ClearBox1()
{
SetAPen(rp,0);
RectFill(rp,9,91,457,175);
}

ClearBox2()
{
SetAPen(rp,0);
RectFill(rp,9,180,457,194);
}

ClearBox3()
{
SetAPen(rp,0);
RectFill(rp,466,91,630,194);
}

ClearAll()
{
ClearBox1();
ClearBox2();
ClearBox3();
}

WRITEIN(char s[],int x,int y)
{
Move(rp,x,y);
Text(rp,s,strlen(s));
}





MakeWay()
{
SetAPen(rp,0);

Move(rp,0,0);
Draw(rp,639,0);
Draw(rp,639,199);
Draw(rp,0,199);
Draw(rp,0,0);

Move(rp,8,90);
Draw(rp,458,90);
Draw(rp,458,176);
Draw(rp,8,176);
Draw(rp,8,90);

Move(rp,465,90);
Draw(rp,631,90);
Draw(rp,631,195); 
Draw(rp,465,195);
Draw(rp,465,90);

Move(rp,8,179);
Draw(rp,458,179);
Draw(rp,458,195);
Draw(rp,8,195);
Draw(rp,8,179);

Move(rp,78,40);
Draw(rp,562,40);
Draw(rp,562,86);
Draw(rp,78,86);
Draw(rp,78,40);


SetAPen(rp,0);
RectFill(rp,9,41,623,145);

SetAPen(rp,2);
Move(rp,8,40);
Draw(rp,631,40);
Draw(rp,631,195);
Draw(rp,8,195);
Draw(rp,8,40);
}


EnterRoom(int r)
{
if(r==1) return(EnterRoom1());
   else if(r==2) return(EnterRoom2());
      else if(r==3) return(EnterRoom3());
         else if(r==4) return(EnterRoom4());
            else if(r==5) return(EnterRoom5());
               else if(r==6) return(EnterRoom6());
                  else if(r==7) return(EnterRoom7());
                     else if(r==8) return(EnterRoom8());
                        else if(r==9) return(EnterRoom9());
                           else LastRoom();
}

IsCorrect(int r)
{
int i=1,dummy=1;
char correct[20];

if(r==1) strcpy(correct,"CORRECTLY"); else strcpy(correct,"INCORRECTLY");

SetAPen(rp,8);
Move(rp,72,190);
Text(rp,"You answered that question",26);

if(r==1) SetAPen(rp,3); else SetAPen(rp,9);
Move(rp,297,190);
Delay(75);
Text(rp,correct,strlen(correct));

if(r==1) PlayGOOD(); else PlayBAD();
Delay(25);
}

ClearBig()
{
SetAPen(rp,0);
RectFill(rp,9,41,630,194);
}

PlayGOOD()
{
StopSound(LEFT0);
PlaySound(&good,MAXVOLUME,RIGHT1,NORMALRATE,1,0,0);
}

PlayBAD()
{
StopSound(LEFT0);
PlaySound(&bad,MAXVOLUME,RIGHT1,NORMALRATE,1,0,0);
}

