
/* MasterMind.jl By Kamran Karimi.

   Should be linked with JustLook (© Kamran Karimi) routines.

   To compile:
   1> sc MasterMind.jl.c
   1> slink lib:c.o MasterMind.jl.o JustLook.o Handlers.o lib lib:sc.lib\
            lib:amiga.lib

   To use it, first run MasterMind, then this program. Just Look!. 
*/

#include <stdlib.h>
#include <stdio.h>
#include <intuition/intuition.h>
#include <clib/intuition_protos.h>
#include <clib/exec_protos.h>
#include <clib/dos_protos.h>

#include "JustLook.h"

#include "MasterMind.jl.h"

#define DEBUG
#ifdef DEBUG
#define Write_err if(err) printf("err = %08lx\n",err)
#else
#define Write_err  ;
#endif
 
#define Message Text(JLWindow->RPort,Mess,count2++)

struct IntuitionBase *IntuitionBase;
 
struct Window *JLWindow = NULL;
struct Screen *scr = NULL;
struct ScrMap SM; /* global, so that it can be in various routintes */

VOID CleanUp(VOID);
VOID Text(struct RastPort *rp,char **TextArray,ULONG Index);
VOID ClearLastLine(struct RastPort *rp);
VOID HandleSolutionWindow(VOID);
VOID HandleCheatWindow(VOID);

main()
{
 struct Screen *scr1 = NULL,*scr2 = NULL;
 struct Window *win = NULL;
 ErrorCode err;
 SHORT count,count2 = 0,ShouldClose = FALSE;

 IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library",0);
 if(IntuitionBase == 0) exit(100);

 scr1 = FindScreen("                             MasterMind V1.6");
 scr2 = FindScreen("                             MasterMind V1.6                     Scrollable");
 if((scr1 > SCR_REPEATED) && (scr2 == NULL) || (scr1 == NULL) && (scr2 > SCR_REPEATED))
 {
  scr = (scr1 > SCR_REPEATED) ? scr1 : scr2;
  if((scr->Width > 640) || (scr->Height > 200) && (scr->Height != 256)) 
   ShouldClose = TRUE;
  win = FindWindow("MasterMind Window",scr);
  if(win > WIN_REPEATED) 
  {
   InitSM(&SM,scr);
   err = IEDisable(MOUSE|KBD); Write_err;
   if((scr->LeftEdge) || (scr->TopEdge)) 
    MoveScreen(scr,-(scr->LeftEdge),-(scr->TopEdge)); /*bring the screen up!*/
   ScreenToFront(scr);
   ActivateWindow(win);
   Delay(30);
   if(FindWindow("Choose!",scr) > WIN_REPEATED) Click(&SM,RBUTTON,0,DOWN_UP);
   HandleCheatWindow();
   HandleSolutionWindow();
   Delay(30);
   JLNewWindow.Screen = scr;
   if(!(JLWindow = OpenWindow(&JLNewWindow))) CleanUp();
   Message; if(IEWait(MOUSE) & RBMASK) CleanUp();/* 1 */ 
   ClearLastLine(JLWindow->RPort);
   err = WinResize(&SM,JLWindow,RELATIVE,-135,-45); Write_err;
   Message; if(IEWait(MOUSE) & RBMASK) CleanUp();/*  2 */
   ClearLastLine(JLWindow->RPort);
   err = ClickGad(&SM,win,NULL,502,1); Write_err; /* clear play board */
   Delay(100); /* give some time to MasterMind to open possible window */
   HandleSolutionWindow(); /* this may show up after 'Abort!' */ 
   if(ShouldClose) 
    MoveWindow(JLWindow,0,scr->Height - JLWindow->TopEdge - 150); 
   Message; if(IEWait(MOUSE) & RBMASK) CleanUp();/* 3 */
   ClearLastLine(JLWindow->RPort);
   err = ClickGad(&SM,win,NULL,503,1); Write_err;/* begin changing configuration */
   Delay(30);
   err = ClickGad(&SM,win,NULL,1000,1); Write_err;/* how many colors to guess? */
    Delay(30);
   err = RawType(RawColum,5,10); Write_err;
   Delay(30);
   err = ClickGad(&SM,win,NULL,1001,1); Write_err; /* among how many colors? */
   Delay(20);
   err = RawType(RawColor,6,10); Write_err; 
   Delay(20);
   err = ClickGad(&SM,win,NULL,1002,1); Write_err; /* how many trials are allowed? */
   Delay(30);
   err = RawType(RawRow,5,10); Write_err;
   Delay(30);
   if(ShouldClose) CloseWindow(JLWindow);
   err = ClickGad(&SM,win,NULL,503,1); Write_err;
   /* now it is possible that the screen has changed! */
   if(ShouldClose) 
   {
    Delay(150); /* this should be enough even for the slowest Amigas! */
    scr = FindScreen("                             MasterMind V1.6");
    win = FindWindow("MasterMind Window",scr);
    InitSM(&SM,scr);
    JLNewWindow.Screen = scr; 
    JLNewWindow.Width = 417;
    JLNewWindow.Height = 75;
    JLNewWindow.LeftEdge = 20;
    JLNewWindow.TopEdge = 15;
    if(!(JLWindow = OpenWindow(&JLNewWindow))) CleanUp();
   }
   Message; if(IEWait(MOUSE) & RBMASK) CleanUp();/*  4 */
   ClearLastLine(JLWindow->RPort);
   for(count = 0;count < 4;count++)
   {
    err = ClickGad(&SM,win,NULL,100 + 2 * count,1); Write_err;
    Delay(30);
    err = ClickGad(&SM,win,NULL,1 + count,1); Write_err; 
    Delay(30);
   }                     /* we did not click the last square! */ 
   Message; if(IEWait(MOUSE) & RBMASK) CleanUp();/*  5 */
   ClearLastLine(JLWindow->RPort);
   err = ClickGad(&SM,win,"<- Done",0,1); Write_err;  
   /* here we got an error from MasterMind */
   /* let us "correct" it as follows: */ 
   Message; if(IEWait(MOUSE) & RBMASK) CleanUp();/*  6 */
   ClearLastLine(JLWindow->RPort);
   err = ClickGad(&SM,win,NULL,1 + 4,1); Write_err;
   Delay(30); /* two repetative colors! */
 
   err = ClickGad(&SM,win,"<- Done",0,1); Write_err;/* try again the Done gadget */
   Delay(30); 
   Message; if(IEWait(MOUSE) & RBMASK) CleanUp();/*  7 */
   ClearLastLine(JLWindow->RPort);
   err = ClickGad(&SM,win,NULL,100 + 4 * 2,1); Write_err; 
   Delay(30);
   err = ClickGad(&SM,win,NULL,1 + 4,1); Write_err; 
   Delay(30);
   Message; if(IEWait(MOUSE) & RBMASK) CleanUp();/*  8 */
   ClearLastLine(JLWindow->RPort);
   err = ClickGad(&SM,win,"<- Done",0,1); Write_err; /* try again the Done gadget */
   Delay(30); 

   if(FindGad(win,"   OK   ",0)) /* We Won!!! */
   {
    count2 = 10;
    Message; if(IEWait(MOUSE) & RBMASK) CleanUp();
    ClearLastLine(JLWindow->RPort);
    err = ClickGad(&SM,win,"   OK   ",0,1); 
    Write_err;  Delay(30);
    count2 = 8; 
   }
   Message; if(IEWait(MOUSE) & RBMASK) CleanUp();/*  9 */
   ClearLastLine(JLWindow->RPort);
   err = ClickGad(&SM,win," Cheat! ",0,1); Write_err;
   Delay(30);
   
   HandleCheatWindow();
 
   Message; IEWait(MOUSE); /* 10 */
   CloseWindow(JLWindow);
   err = ClickGad(&SM,win,NULL,502,1);
   Write_err;  Delay(30);
   HandleSolutionWindow();
   Delay(100);
   err = ClickGad(&SM,win,"Quit Game",0,1); /* really DONE! */
   Write_err; 
   err = IEEnable(MOUSE|KBD);
   Write_err;
  }
  else if(win == WIN_REPEATED) 
   printf("Impossible: Two windows with the same name in MasterMind Screen!\n");
  else printf("Impossible: MasterMind window not found!\n");
 }
 else if((scr1 == SCR_REPEATED) || (scr2 == SCR_REPEATED)) 
  printf("you have Two screens with the same name open!\n");
 else if((scr1 == NULL) && (scr2 == NULL))
  printf("you should first run MasterMind, then this program!\n"); 
 CloseLibrary((struct Library *)IntuitionBase);
 exit(0);
}

VOID HandleCheatWindow(VOID)
{
 struct Window *win;
 ErrorCode err;

 win = FindWindow("Naughty!",scr);
 if(win)
 {
  Delay(50);
  err = WinAct(&SM,win,CLOSEWIN); Write_err;
 }
} 

VOID HandleSolutionWindow(VOID)
{
 struct Window *win;
 ErrorCode err;

 win = FindWindow("Solution",scr);
 if(win) 
 {
  err = WinDrag(&SM,win,ABSOLUTE,250,30); Write_err; 
  Delay(50);
  err = WinAct(&SM,win,CLOSEWIN); Write_err;
 }
}

VOID CleanUp(VOID)
{
 if(JLWindow) CloseWindow(JLWindow);
 IEEnable(MOUSE|KBD);
 CloseLibrary((struct Library *)IntuitionBase);
 exit(0);
}

VOID Text(struct RastPort *rp,char **TextArray,ULONG Index)
{
 int count;

 for(count = 0;count < 6;count++)
 {
  TextToShow[0].IText = TextToShow[1].IText;
  TextToShow[1].IText = TextToShow[2].IText;
  TextToShow[2].IText = TextToShow[3].IText;
  TextToShow[3].IText = TextToShow[4].IText;
  TextToShow[4].IText = TextToShow[5].IText;
  TextToShow[5].IText = TextArray[Index * 6 + count];
  PrintIText(rp,&TextToShow[5],0,0);
 }
}

VOID ClearLastLine(struct RastPort *rp)
{
 PrintIText(rp,&BlankLine,0,0);
}

