/* The Blob V1.1 by Guido Wegener of CLUSTER */
/* this program is Freeware, look at Blob.doc to get more information */
/* or look at any mirror to get a good laugh */
#include "math.h"
#include "exec/types.h"
#include "functions.h"
#include "intuition/intuition.h"
#include "graphics/gfxbase.h"
#include "graphics/gfx.h"
#include "graphics/sprite.h"
#include "hardware/custom.h"
#include "hardware/dmabits.h"
#include "stdio.h"
#include "exec/memory.h"
#define ABS(a) ((a<0) ? -a : a)
#define DROPMAXANZ 50     /* I don't think that I'm going to tell you what this means, go away !
                             By the way, WHO reads source-files ??? No REMs this time, sorry. */

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct Screen wbs;
struct ViewPort *vpo;
struct NewWindow MyNewWindow=
 {
  0,0,404,10,
  -1,-1,
  CLOSEWINDOW,
  WINDOWCLOSE | WINDOWDRAG | WINDOWDEPTH | SMART_REFRESH | NOCAREREFRESH,
  NULL,NULL,
  (UBYTE *)"The BLOB by Guido Wegener of CLUSTER",
  NULL,NULL,
  0,0,0,0,
  WBENCHSCREEN
 };
#define TANZ 56
char *texts[]=
 { 
  "The late night movie starts ...",
  "Is it BLOOD ???",
  "No, it's the slime of BLOB...",
  "Blob, the alien Amiga-eating monster !",
  "Welcome",
  "I don't think.",
  "Do not be alarmed.",
  "Be very, very frightened, user.",
  "Since I've got no license for using",
  "the name Blob, I will have to mention",
  "the movie (I know of two Blob-movies).",
  "Both are a little bit slimy !",
  "You can run more than one Blob at a time",
  "by typing 'run Blob' more than once.",
  "Don't forget pressing return, lamer.",
  "Well, let's mention me !",
  "I'm Guido Wegener of CLUSTER !",
  "In other words ...",
  "the mega-man of the 10^6-group !",
  "Will I ever stop typing ???",
  "     NO !     ",
  "Greetings and thanx to :",
  "André, Martin, Philipp, Martin,",
  "Stefan, Martin, Addison Wesley",
  "(you know, the reference manuals),",
  "Scientific American and ...",
  "my beloved Amiga 500 with 1MByte and",
  "2nd drive and Kick 1.2 !",
  "Ok, André ! Daddy's beloved Amiga.",
  "Look out for other CLUSTER proggies !",
  "This one was written on Feb.,2,1990.",
  "Maybe I will produce other movies later.",
  "What about Rocky Horror Picture Show",
  "(Kiss me Amiga) or Little Shop of",
  "Horrors (the all-eating mouse-pointer).",
  "You can exit this proggy by kilcking..",
  "<=- here !",
  "Nice of you not doing it !",
  "This is line 39 (just for counting 'em)",
  "Hey guy, there's slime on ya screen !",
  "This program is freeware !",
  "For copy-conditions read Blob.Doc !",
  "Just for information :",
  "The cheaper one of the two Blob movies",
  "is the better one !",
  "Let's panic !",
  "Love is hate !",
  "Freedom is slavery !",
  "Ignorance is strength !",
  "I think I'll stop here ...",
  "but I don't !",
  "OK, I will !",
  "Soon ...",
  "This is the end ...",
  "Over and out ...",
  "RESTART"
 };
  
struct Window *MyWindow;
UWORD *sprite_data;
UBYTE drop[10][25]=  /* the shape of the drops ... */
 {
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,6,6,7,7,6,6,5,4,3,2,1,
  1,1,2,2,3,4,5,5,4,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  1,1,1,1,2,2,2,3,3,4,4,3,2,0,0,0,0,0,0,0,0,0,0,0,0,
  1,1,2,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  1,1,1,1,1,2,2,2,2,3,3,3,4,4,4,5,5,3,2,0,0,0,0,0,0,
  1,1,1,2,2,3,4,5,5,4,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  1,1,1,2,2,2,3,3,3,4,4,5,5,4,2,0,0,0,0,0,0,0,0,0,0,
  1,1,1,1,2,2,3,4,4,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  1,1,1,1,1,2,2,2,3,3,3,4,4,5,5,6,6,4,2,0,0,0,0,0,0,
  1,1,1,2,2,3,3,4,4,5,6,7,7,6,4,2,0,0,0,0,0,0,0,0,0
 };
float dropy[DROPMAXANZ],drops[DROPMAXANZ],dropp[DROPMAXANZ];
int x[350];
long int warsch=100;
 
main()
 {
  BOOL succ;
  long int spriten;
  struct SimpleSprite sprite;
  long int colr,count=0;
  int i,closed=0,ctext=0;
  int rndrnd;
  VOID *mess; 

  IntuitionBase=(struct IntuitionBase *)OpenLibrary("intuition.library",0L);
  if(!IntuitionBase)
   {
    puts("Intu");
    exit(20);
   }
  GfxBase=(struct GfxBase *)OpenLibrary("graphics.library",0L);
  if(!GfxBase)
   {
    puts("Gfx");
    CloseLibrary(IntuitionBase);
    exit(20);
   }

  sprite_data=AllocMem(32*255L,MEMF_CHIP | MEMF_CLEAR);
  if(!sprite_data)
   {
    puts("No Mem !");
    CloseLibrary(GfxBase);
    CloseLibrary(IntuitionBase);
    exit(20);
   }
    
  rndrnd=VBeamPos();
  for(i=0;i<rndrnd;i++)RangeRand(5L);
  succ=GetScreenData((CPTR)&wbs,(long int)sizeof(struct Screen),WBENCHSCREEN,NULL);  
  if(!succ)
   {
    puts("Not found !");
    FreeMem(sprite_data,32*255L);
    CloseLibrary(GfxBase);
    CloseLibrary(IntuitionBase);
    exit(20);
   }
  vpo=&(wbs.ViewPort);
  for(i=0;i<DROPMAXANZ;i++)
   {
    dropy[i]=0;
    drops[i]=0;
    dropp[i]=0;
   }
  newdrop();   
  
  spriten=GetSprite(&sprite,-1L);
  if(spriten==-1)
   {
    puts("No free sprite !");
    FreeMem(sprite_data,32*255L);
    CloseLibrary(GfxBase);
    CloseLibrary(IntuitionBase);
    exit(20);
   }
  MyNewWindow.TopEdge=spriten*10;
  MyWindow=OpenWindow(&MyNewWindow);
  if(!MyWindow)
   {
    puts("Can't open Window !");
    FreeSprite(spriten);
    FreeMem(sprite_data,32*255L);
    CloseLibrary(GfxBase);
    CloseLibrary(IntuitionBase);
    exit();
   }

  colr=16+((spriten&0x06)<<1);
  SetRGB4(vpo,colr+1,11L,0L,0L);
  SetRGB4(vpo,colr+2,10L,5L,5L);
  SetRGB4(vpo,colr+3,15L,1L,1L);
  sprite.x=10+RangeRand(200L);
  sprite.y=0;
  sprite.height=255;
  ChangeSprite(NULL,&sprite,sprite_data);
  while(!closed)
   {
    mess=GetMsg(MyWindow->UserPort);
    if(mess)
     {
      closed=1;
      ReplyMsg(mess);
     }
    WaitTOF();
    if(!RangeRand(warsch))newdrop();
    movedrops();
    drawdrops();
    ChangeSprite(NULL,&sprite,sprite_data);
    count++;
    if((count%65)==0)
     {
      SetWindowTitles(MyWindow,texts[ctext],-1L);
      ctext=(ctext+1)%TANZ;
     }
    if(!RangeRand(40L)&&warsch>25)
     {
      warsch--;
     }
   }

  CloseWindow(MyWindow);
  FreeSprite(spriten);
  FreeMem(sprite_data,32*255L);
  CloseLibrary(GfxBase);
  CloseLibrary(IntuitionBase);
 }

newdrop()
 {
  int i;
  
  for(i=0;i<DROPMAXANZ;i++)
   {
    if(drops[i]==0)
      {
       dropy[i]=0;
       dropp[i]=RangeRand(10L);
       drops[i]=(float)RangeRand(17L)/15;
       i=DROPMAXANZ;
      }
    }
 }
 
movedrops()
 {
  register int i;
  
  for(i=0;i<DROPMAXANZ;i++)
   {
    dropy[i]+=drops[i];
    if(dropy[i]>300)drops[i]=0;
   }
 }
 
drawdrops()
 {
  register int i,j;
  register int *po;
  
  po=x;
  for(i=0;i<350;i++)
   {
    *(po++)=0;
   }
  for(i=0;i<DROPMAXANZ;i++)
   {
    if(drops[i])
     {
      for(j=0;j<25;j++)
       {
        x[j+(int)dropy[i]]+=(int)drop[(int)dropp[i]][j];
       }
     }
   }
  
  for(i=0;i<255;i++)
   {
    if(x[i+50]>15)
     {
      sprite_data[i*2+2]=0xffff;
      sprite_data[i*2+3]=0x7ffe;
     }
    else
     {
      sprite_data[i*2+2]= ((1 << x[i+50])-1) << (7-x[i+50]/2); /* <=- It's so simple, it just doesn't need any REMarks, does it ?  */
      if(x[i+50]<2)x[i+50]=2;
      sprite_data[i*2+3]= ((1 << (x[i+50]-2))-1) << (8-x[i+50]/2); /* I told you to go away ! */
     }
   }
 }
 
