/* FlashbackNG v1.12 - Copyright © 2000-2001 Nogfx - NicoEFE@ifrance.com

   This is Distributed under the GPL: check file 'licence.txt' for more info.

   Small History: 02.12.00 - Added Timer.device functions
                  09.12.00 - Added Mouse Support (works better than expected ;))
                             Now Blits the background in a Temp Bitmap so that
                             it can be restored
                  12.01.01 - Added FillScreen function: clear the Screen with specified color
                  20.01.01 - Ported the Initscore and LevelSUPP Unit to C lib
                  23.01.01 - Ported the Whole Game engine to C language
                  24.01.01 - Arranged the source Code
                  25.01.01 - Added LevelSUPP functions, Added DisplayScore() and DisplayLevel()
                  27.01.01 - GtLayout GUI
                  28.01.01 - Prefs are now loaded and save correctly
                  25.03.01 - ooooh... loads of funky changes! :) by Giles Burdett
                  04.04.01 - FIXED some bugs, Added ScoreTable,...
*/

// Uncomment this to debug
//#define DEBUG

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <exec/types.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <graphics/displayinfo.h>
#include <dos/dos.h>
#include <graphics/gfx.h>

#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/graphics_protos.h>
#include <clib/alib_protos.h>
#include <clib/dos_protos.h>
#include <clib/lowlevel_protos.h>
#include <clib/timer_protos.h>
#include <clib/lucyplay_protos.h>

#include "version.h"
#include "timer.h"
#include "game.h"
#include "load.h"
#include "gui.h"
#include "icon.h"

char flashngversion[]="$VER: "FLASHNGVERSION;

// KEYS used in Flashback
#define ENTER 0x44
#define ESC   0x45
#define PAUSE 0x19
#define RIGHT 0x4E
#define LEFT  0x4F

#define LEFTMOUSEBUTTON 38

// In-game menu constants
#define PLAYGAME 0
#define QUITS    0
#define SCORE    0


struct Library *LucyPlayBase=NULL;
struct Library *GTLayoutBase=NULL;
struct Library *IconBase=NULL;


struct Window *win;
struct Screen *scr;

char *logo;      // Flahsback Logo
char *sprites;   // Sprites Bank
UWORD *BLANKPointer;
ULONG palette1[770]; // Trust LogoPalette
ULONG palette2[770]; // Blank Palette
ULONG palette3[770]; // Flash Logo Palette
ULONG palette4[770]; // Sprites palette
int etoiles[117][2];
int etoile,etoile2;
struct RastPort *rast;
struct BitMap *bitmap2;
struct BitMap *bitmap3;
struct timerequest *T;
struct Prefs userprefs;

BOOL dejablitte, dejablitteball;  // some more globals! ;)

BOOL active; // pause related...
int speed, bug, bug2; // gees! these /are/ global! ;)

int menu(void);
void flashngmain(void);

void LineH(long x,long y,long x2)
{
   SetAPen(win->RPort,0);
   Move(win->RPort,x,y);
   Draw(win->RPort,x2,y);
}


 
BOOL InitIntuition(void)
{
    char *Mode=InitToolTypes();

    if (Mode)
    {
        ULONG ModeID;

        ModeID=strtoul(Mode,NULL,16);
        #ifdef DEBUG
        printf("tooltype...%s => %d\n",Mode,ModeID);
        #endif
        scr = OpenScreenTags(NULL, SA_Depth,8,
                             SA_DisplayID,ModeID,
                             SA_Type,CUSTOMSCREEN,
                             TAG_END);
    }
    else scr = OpenScreenTags(NULL, SA_Depth,8,
                              SA_DisplayID,lucBestModeID(320,200,8),
                              SA_Type,CUSTOMSCREEN,
                              TAG_END);

    if (scr)
    {
        win = OpenWindowTags(NULL,
                             WA_Flags, WFLG_BORDERLESS|WFLG_ACTIVATE|WFLG_RMBTRAP,
                             WA_IDCMP, IDCMP_MOUSEMOVE|IDCMP_DELTAMOVE|IDCMP_MOUSEBUTTONS|IDCMP_ACTIVEWINDOW|IDCMP_INACTIVEWINDOW,
                             WA_CustomScreen, scr,
                             TAG_END);

        if (win)
            return TRUE;

        CloseScreen(scr);
    }
    return FALSE;
}

void CleanupIntuition (void)
{
    CloseWindow(win);
    CloseScreen(scr);
}

BOOL AllocFlash(void)
{
    if (logo=(char *)malloc(64000))
    {
        if (sprites=(char *)malloc(64000))
        {
            if (rast=(struct RastPort *)AllocVec(64000,0))
            {
                if (bitmap2=AllocBitMap(320,200,8,BMF_DISPLAYABLE | BMF_MINPLANES,win->RPort->BitMap))
                {
                    if (bitmap3=AllocBitMap(GetBitMapAttr(bitmap2, BMA_WIDTH), GetBitMapAttr(bitmap2, BMA_HEIGHT), GetBitMapAttr(bitmap2, BMA_DEPTH),BMF_DISPLAYABLE | BMF_MINPLANES,win->RPort->BitMap))
                    {
                        InitRastPort(rast);
                        rast->BitMap=bitmap2;

                        /* Small tip to hide Mouse pointer */
                        if (BLANKPointer=AllocVec(100,MEMF_CHIP|MEMF_CLEAR))
                        {
                            SetPointer(win,BLANKPointer,0,0,0,0);

                            /* init of Timer.device */
                            if (T=CreateTimer(UNIT_VBLANK))
                                return TRUE;

                            FreeVec(BLANKPointer);
                        }
                        FreeBitMap(bitmap3);
                    }
                    FreeBitMap(bitmap2);
                }
                FreeVec(rast);
            }
            free(sprites);
        }
        free(logo);
    }
    return FALSE;
}

void CleanupFlash (void)
{
    #ifdef DEBUG
    puts("Freeing Resources..");
    #endif
    DeleteTimer(T);
    FreeVec(BLANKPointer);
    FreeBitMap(bitmap3);
    FreeBitMap(bitmap2);
    FreeVec(rast);
    free(sprites);
    free(logo);
}

void UsePalette(ULONG *palette)
{
    LoadRGB32(&scr->ViewPort, palette);
}


void Chunky2Bitmap(char *buffer)
{
    WritePixelArray8((struct RastPort *)rast,0,0,319,199,buffer,NULL);
}


void FillScreen(short x,short y,short width, short height, UBYTE color)
{
    short y1;
    SetAPen(win->RPort,color);
    for (y1=y;y1<y+height;y1++)
    {
        Move(win->RPort,x,y1);
        Draw(win->RPort,x+width,y1);
    }
}

void MoveShape(LONG srcx, long srcy, long width, long height, long destx, long desty)
{
    BltBitMap(bitmap2, srcx, srcy, win->RPort->BitMap, destx, desty, width, height, 0xC0, 0xFF, NULL);    //0x20 0xE0 (au premier)
}

void Rectangle(ULONG x1, ULONG y1, ULONG x2, ULONG y2, ULONG color)
{
    SetAPen(win->RPort,color);
    RectFill(win->RPort,x1,y1,x2,y2);
}

void pause(BOOL begin)
{
    if (begin)
        MoveShape(45,140,88,37,100,102);
    else
        Rectangle(100,102,188,137,0);
}

void MoveRect(LONG x, long y, long width, long height, long destx, long desty)
{
    static WORD oldx, oldy;

    /* Old background put back */
    if (dejablitte)
        BltBitMap(bitmap3, 0,0,win->RPort->BitMap, oldx, oldy, width, height, 0xC0, 0xFF, NULL);
    dejablitte=TRUE;
    /* We save the background where we're gonna blit */
    BltBitMap(win->RPort->BitMap, destx, desty, bitmap3, 0, 0, width, height, 0xC0, 0xFF, NULL);
    WaitBlit();
    /* We blit to the new place */
    BltBitMap(bitmap2, x, y, win->RPort->BitMap, destx, desty, width, height, 0xC0, 0xFF, NULL);    //0x20 0xE0 (au premier)
    
    oldx=destx;
    oldy=desty;                                                                          //0xE0 0x20
}

void MoveBall(LONG x, long y, long width, long height, long destx, long desty)
{
    static WORD oldxball, oldyball;

    /* Old background put back */
    if (dejablitteball)
        BltBitMap(bitmap3, 100,100,win->RPort->BitMap, oldxball, oldyball, (width-1), (height-1), 0xC0, 0xFF, NULL);
    dejablitteball=TRUE;
    /* We save the background where we're gonna blit */
    BltBitMap(win->RPort->BitMap, destx, desty, bitmap3, 100, 100, (width-1), (height-1), 0xC0, 0xFF, NULL);
    //WaitBlit();
    /* We blit to the new place */
    BltBitMap(bitmap2, x, y, win->RPort->BitMap, destx, desty, width, height, 0xC0, 0xFF, NULL);    //0x20 0xE0 (au premier)

    oldxball=destx;
    oldyball=desty;                                                                          //0xE0 0x20
}

void FadeToBlack(ULONG *palette1)
{
    int a;
    BOOL fini;

    fini=FALSE;
    while (!fini)
    {
        fini=TRUE;
        for (a=1; a<=768 ;a++)
        {
            if ((palette1[a]>>24)!=0)
            {
                fini=FALSE;
                palette1[a]=palette1[a]-0x01000000;
            }
        }
        LoadRGB32(&scr->ViewPort,palette1);
    }
}

void FadeToPalette(ULONG *frompalette1,ULONG *topalette)
{
    int a;
    BOOL fini;

    fini=FALSE;
    while (!fini)
    {
        fini=TRUE;
        for (a=1; a<=768; a++)
        {

             if ((frompalette1[a]>>24)!=(topalette[a]>>24))
             {
                 fini=FALSE;
                 frompalette1[a]=frompalette1[a]+0x01000000;
             }
        }
        LoadRGB32(&scr->ViewPort,frompalette1);
    }
}

void WaitForKey(ULONG key)
{
    ULONG car=0;

    while (car!=key)
    {
        Delay(2);
        car=GetKey();
    }
    car=GetKey();
}

   

int readmouse(void)
{
    WORD mx, my;
    struct IntuiMessage *msg;

    while (msg = (struct IntuiMessage *)GetMsg(win->UserPort))
    {
        mx = msg->MouseX;
        my = msg->MouseY;
        ReplyMsg((struct Message *)msg);

        switch (msg->Class)
        {
            case IDCMP_MOUSEMOVE:
               //do_move(mx,my);
               // Left Moves
               if ((mx>=3)&&(mx<=10)) return(2);
               if ((mx>10)&&(mx<=17)) return(3);
               if ((mx>17)&&(mx<=26)) return(4);
               if (mx>26) return(5);

               // Right Moves
               if ((mx<=-3)&&(mx>=-10)) return(-2);
               if ((mx<-10)&&(mx>=-17)) return(-3);
               if ((mx<-17)&&(mx>=-26)) return(-4);
               if(mx<-26) return(-5);

               //if (mx>=2) DisplayBeep(screen);
               break;
            
            case IDCMP_ACTIVEWINDOW:
                 active=TRUE;
                 break;

            case IDCMP_INACTIVEWINDOW:
                 active=FALSE;
                 break;

            case IDCMP_MOUSEBUTTONS:
               if (msg->Code==IECODE_RBUTTON)
               {
                   switch(active)
                   {
                      case TRUE: active=FALSE;
                           break;
                      case FALSE: active=TRUE;
                   }
               }
               else
                   return(LEFTMOUSEBUTTON);
               break;
        }
    }
    return(0);
}

int main (void)
{
    BOOL bye=FALSE;
    #ifdef DEBUG
    puts("Creating GUI");
    #endif
    if (GUI(&userprefs))
    {
        #ifdef DEBUG
        puts("Testing userprefs status");
        #endif
        if (userprefs.status==10)
        {
                if (LucyPlayBase=OpenLibrary("lucyplay.library", 0))
                {
                        if (InitIntuition())
                        {
                                if (AllocFlash())
                                {
                                        if (LoadGfx())
                                        {
                                             SetMouseQueue(win, 10);
                                             ReportMouse(TRUE, win);

                                             while(!bye)
                                             {
                                                /*switch(menu())
                                                {
                                                    case PLAYGAME:
                                                       flashngmain();
                                                    break;
                                                    case SCORE:
                                                    break;
                                                    case QUITS:
                                                       bye=TRUE;
                                                    break;
                                                }*/
                                                flashngmain();
                                                //menu();
                                                bye=TRUE;
                                             }
                                        }
                                        else
                                        puts("Unable to load graphics");
                                        CleanupFlash();
                                }
                                else
                                puts("Unable to allocate resources");
                                CleanupIntuition();
                        }
                        else
                        puts("Unable to open a screen/window");
                        CloseLibrary(LucyPlayBase);
                }
                else
                puts("Unable to open lucyplay.library");
        }
        return 0;
    }
    else puts("Unable to open GTLayout.library");
    return 0;
}

int menu(void)
{
    Chunky2Bitmap(logo);
    MoveShape(0,0,319,199,0,0);
    LoadPalette("gfx/DrewLogo.pal",palette3);
    UsePalette(palette3);
    FillScreen(16,59,282,124,0);
    Wait(10);
    return(0);
}


void flashngmain(void)
{
    ULONG tt, b;
    int mouseinput, posi, level, lives;
    //int cgxspeed;
    BOOL lost=FALSE;
    //BOOL cgx, ready;
    struct coords step;
    struct score player1;
    struct ball ball1;
    struct grid grid1;
    struct timeval start, end;
    #define DEFAULTBALLSPEED 110

    dejablitte=FALSE;
    dejablitteball=FALSE;
    
    UsePalette(palette2); // Black screen
    Chunky2Bitmap(logo);
    MoveShape(0,0,319,199,0,0);
    //while (readmouse()!=LEFTMOUSEBUTTON)
    //    Delay(10);
    FadeToPalette(palette2,palette3);

    //SetMouseQueue(win, 10);
    //ReportMouse(TRUE, win);
    posi=134;

    {
        
        BOOL finish=FALSE;
        GetSysTime(&start);
        while (!finish)
            finish=Temps(start,end,20000);
        //WaitForKey(ENTER);
    }

    FadeToBlack(palette3);
    Chunky2Bitmap(sprites);
    FillScreen(0,0,319,199,0);
    UsePalette(palette4);

    //MoveShape(120,190,47,7,posi,180);

    lives=userprefs.lives;
    level=userprefs.startlevel;
    
    //ready:=FALSE;
    grid1.score=0;
    grid1.taille=0;
    grid1.total=0;
    speed=DEFAULTBALLSPEED;
    //cgxspeed:=2.0;
    /*for (b=0;b<=12;b++)
    for (mouseinput=0;mouseinput<=10;mouseinput++) grid1.tab[mouseinput][b].colour=0;

    for (b=0;b<=4;b++)
    for (mouseinput=0;mouseinput<=10;mouseinput++) {
        grid1.tab[mouseinput][b].colour=RangeRand(6);
        if ((grid1.tab[mouseinput][b].colour!=0) && (grid1.tab[mouseinput][b].colour!=5))
            {
            grid1.taille++;
            grid1.total++;
            }
        }
    */

     
    /*for (b=0;b<=4;b++) {
    for (mouseinput=0;mouseinput<=10;mouseinput++) {
        printf("%d ",grid1.tab[mouseinput][b].colour);
        }
    printf("\n");
    } */


    
    MoveShape(0,0,319,4,0,0);    // Barre haut
    MoveShape(286,4,32,195,287,4); // Barre droite
    //MoveShape(2,49,4,8,296,113);   //score: 0
    DisplayScore(&grid1);
    DisplayLevel(level);
    active=TRUE;
    LoadLevel(level,&grid1,"dat/Levels.dat");
    DisplayGrid(&grid1);

    while (lives!=0)
    {
        ball1.coin[1].x=posi+20;ball1.coin[1].y=170;
        ball1.coin[2].x=posi+30;ball1.coin[2].y=170;
        ball1.coin[3].x=posi+30;ball1.coin[3].y=179;
        ball1.coin[4].x=posi+20;ball1.coin[4].y=179;
        Lives(lives);
        //posi=134;
        MoveRect(120,190,48,8,posi,180);

        MoveBall(129,124,10,9,ball1.coin[1].x,ball1.coin[1].y);
        step.z=TRUE;
        step.x=1;step.y=-1;
        step.x=RangeRand(3);
        if (step.x>1)
            step.x=1;
        else
            step.x=-1;
        //timer2=1;
        b=0;
        GetSysTime(&start);
        //GetSysTime(@cgxstart);
        //cgx:=TRUE;
        //WaitForKey(ENTER);
        
        {
            struct timeval Cgxstart, Cgxend;
            int z=1, z2=1;

            GetSysTime(&Cgxstart);
            
            while(readmouse()!=LEFTMOUSEBUTTON)
            {
                if (Temps(Cgxstart,Cgxend,10000))
                {
                    GetSysTime(&Cgxstart);
                    z2=1;z=-z;
                }

                if ((z==1)&&(z2==1))
                {
                    MoveShape(130,152,156,29,80,104);
                    z2=0;
                }

                if ((z==-1)&&(z2==1))
                {
                    Rectangle(80,104,236,133,0);
                    z2=0;
                }
            }
            Rectangle(80,104,236,133,0);

        }
        
        /******************* Main Loop ************/
        tt=0;
        while ((!lost) && (grid1.taille!=0) && (tt!=ESC))
        {
            tt=GetKey();
             /*if ((b==entree) & then
             begin
                for timer2:=100 to 129 do lineH(80,timer2,236);
                bug:=2;
                bug2:=2;
             end;
             */
             /*if (tt==PAUSE) {
                tt=29;
                pause(TRUE);
                WaitForKey(PAUSE);
                pause(FALSE);
                Delay(8);
                tt=GetKey();
                tt=0;
            } */

            mouseinput=readmouse();
            if (!active)
            {
                pause(TRUE);
                while (!active)
                {
                    Delay(10);
                    mouseinput=readmouse();
                }

                pause(FALSE);
            }

            if (mouseinput>0)
            {
                switch (mouseinput)
                {
                    case 2: posi+=2;
                    break;
                    case 3: posi+=5;
                    break;
                    case 4: posi+=8;
                    break;
                    case 5: posi+=15;
                    break;
                }
                if (posi>235)
                    posi=235;
            }

            if (mouseinput<0)
            {
                switch (mouseinput)
                {
                    case -2: posi-=2;//-2;
                    break;
                    case -3: posi-=5;//-5;
                    break;
                    case -4: posi-=8;//-8;
                    break;
                    case -5: posi-=15;//-10;
                    break;
                }
                if (posi<1)
                    posi=1;
            }

            if (mouseinput!=0)
                MoveRect(120,190,47,7,posi,180);

            /*if b=enpause then
            begin
                pause;
            end; */

            /*if (b=entree) and (ready=FALSE) then
            begin
               for timer2:=100 to 129 do lineH(80,timer2,236);
            end;*/
            //if (ready) then
            //begin
               if (Temps(start,end,speed))
               {
                  GetSysTime(&start);
                  lost=Game_MoveBall(&ball1,posi,&step,&grid1);
               }

            //end
            //else
            //getready(timer2);


        }//until (b=esc) or (lost) or (grid1.taille=0);
       
        //with ball1 do
        //for (mouseinput=ball1.coin[1].y;mouseinput<=ball1.coin[1].y+8;mouseinput++) LineH(ball1.coin[1].x,mouseinput,ball1.coin[1].x+9);

        lost=FALSE;
        if (grid1.taille!=0)      // Player lost or pressed ESC
        {
            if (tt==ESC)
                lives=0;
            else
                lives--;

            // flash the screen
            SetRGB32(&scr->ViewPort,0,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF);
            Delay(3);
            SetRGB32(&scr->ViewPort,0,0x00000000,0x00000000,0x00000000);
        }
        else     // We go to the next level
        {
            level++;
            FillScreen(0,6,279,193,0);
            //DisplayScore(&grid1);
            DisplayLevel(level);
            player1.value=grid1.scoretotal;
            LoadLevel(level,&grid1,"dat/Levels.dat");
            grid1.scoretotal=player1.value;
            speed=DEFAULTBALLSPEED;
            DisplayGrid(&grid1);
            //DisplayScore(&grid1);
            dejablitteball=FALSE;
        }

    } /* while (lives!=0) */

    FillScreen(0,0,319,199,0);
    player1.value=grid1.scoretotal;
    GameOver(&player1);
    
    //while (readmouse()!=LEFTMOUSEBUTTON)
    //    Delay(10);


    // Direct port form the FreePascal version...

    palette4[(131*3)+1]=0xFFFFFFFF;
    palette4[(131*3)+2]=0xFFFFFFFF;
    palette4[(131*3)+3]=0xFFFFFFFF;
    palette4[(132*3)+1]=0xDDDDDDDD;
    palette4[(132*3)+2]=0xDDDDDDDD;
    palette4[(132*3)+3]=0xDDDDDDDD;
    palette4[(133*3)+1]=0xC6666666;
    palette4[(133*3)+2]=0xC6666666;
    palette4[(131*3)+3]=0xC6666666;

    SetRGB32(&scr->ViewPort,133,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF);
    SetRGB32(&scr->ViewPort,132,0xBBBBBBBB,0xBBBBBBBB,0xBBBBBBBB);
    SetRGB32(&scr->ViewPort,131,0xAAAAAAAA,0xAAAAAAAA,0xAAAAAAAA);

    for(etoile=1;etoile<117;etoile++)
    {
        etoiles[etoile][1]=RangeRand(320);
        etoiles[etoile][2]=RangeRand(200);
    }


    /****** Starfield begins here... ***************
     *                                             *
     * Note: The WritePixels should be replaced by *
     *       Blits under AGA: I guess it would     *
     *       be a LOT faster !!                    *
     *                                             *
     ***********************************************/

    while(readmouse()!=LEFTMOUSEBUTTON)
    {
      if (readmouse()!=LEFTMOUSEBUTTON)
      {
         SetAPen(win->RPort,131);
         for(etoile=1;etoile<30;etoile++)
         {
            etoile2=ReadPixel(win->RPort,etoiles[etoile][1],etoiles[etoile][2]);
            if (etoile2==0)
                WritePixel(win->RPort,etoiles[etoile][1],etoiles[etoile][2]);
         }
      }

      if (readmouse()!=LEFTMOUSEBUTTON)
      {
         SetAPen(win->RPort,132);
         for(etoile=31;etoile<65;etoile++)
         {
            etoile2=ReadPixel(win->RPort,etoiles[etoile][1],etoiles[etoile][2]);
            if (etoile2==0)
                WritePixel(win->RPort,etoiles[etoile][1],etoiles[etoile][2]);
         }
      }


      if (readmouse()!=LEFTMOUSEBUTTON)
      {
          SetAPen(win->RPort,133);
          for(etoile=66;etoile<117;etoile++)
          {
             etoile2=ReadPixel(win->RPort,etoiles[etoile][1],etoiles[etoile][2]);
             if (etoile2==0)
                WritePixel(win->RPort,etoiles[etoile][1],etoiles[etoile][2]);
          }
      }

      SetAPen(win->RPort,0);

      if (readmouse()!=LEFTMOUSEBUTTON)
      {
          for(etoile=1;etoile<30;etoile++)
          {
              etoile2=ReadPixel(win->RPort,etoiles[etoile][1],etoiles[etoile][2]);
              if (etoile2==131)
                MoveShape(2,180,1,1,etoiles[etoile][1],etoiles[etoile][2]);
              if (etoiles[etoile][1]<318)
              {
                  (etoiles[etoile][1])++;
              }
              else etoiles[etoile][1]=0;
          }
      }

      if (readmouse()!=LEFTMOUSEBUTTON)
      {
         for(etoile=31;etoile<65;etoile++)
         {
            etoile2=ReadPixel(win->RPort,etoiles[etoile][1],etoiles[etoile][2]);
            if (etoile2==132)
                MoveShape(2,180,1,1,etoiles[etoile][1],etoiles[etoile][2]);
            if (etoiles[etoile][1]<317)
            {
               etoiles[etoile][1]=etoiles[etoile][1]+2;
            }
             else  etoiles[etoile][1]=0;
         }
      }

      if (readmouse()!=LEFTMOUSEBUTTON)
      {
          for(etoile=66;etoile<117;etoile++)
          {
             etoile2=ReadPixel(win->RPort,etoiles[etoile][1],etoiles[etoile][2]);
             if (etoile2==133)
                MoveShape(2,180,1,1,etoiles[etoile][1],etoiles[etoile][2]);
             if (etoiles[etoile][1]<316)
             {
                etoiles[etoile][1]=etoiles[etoile][1]+3;
             }
             else etoiles[etoile][1]=0;

          }
      }


    }


    FadeToBlack(palette4);

}

