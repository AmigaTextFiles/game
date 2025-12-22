/* AntiISDA_Warrior
    by Ventzislav Tzvetkov
    drHirudo@Amigascne.org
    Music by Flapjack/Madwizards

 Compile with: vc AntiISDA_Warrior.c Player-CIA.asm -lauto -o AntiISDA_Warrior

*/

#include <intuition/intuition.h> /* I use system friendly code */

#include <hardware/custom.h> /* These twos  are  for  */
#include <hardware/cia.h>   /*  the Joystick handler */

#include "AntiISDA_Warrior.h"

#include <libraries/asl.h> /* For the ScreenMode Requester */

BOOL close=FALSE;

/* This will automatically be linked to the Custom structure: */
extern struct Custom custom;

/* This will automatically be linked to the CIA A (8520) chip: */
extern struct CIA ciaa;

main(){
static char version[]="$VER: AntiISDA Warrior V1.0 © 2003";
struct ScreenModeRequester *ScreenRequest;
ULONG ModeID,class;
USHORT code;
SHORT x,y;
UBYTE Level,JoyStack,Direction,Counter=0,Ammo;
BOOL Shoot=FALSE,NewGame=FALSE;
char ShootsText[]="Shoots: n";
struct TextFont *MyFont;

/* Open the Intuition library: */
  IntuitionBase = (struct IntuitionBase *)
    OpenLibrary( "intuition.library", 0 );
  if( !IntuitionBase ) exit();
/* Open the Graphics library: */
  GfxBase = (struct GfxBase *)
    OpenLibrary( "graphics.library", 0 );
  if( !GfxBase ) {CloseLibrary( IntuitionBase ); exit();}

/* Random seed */
CurrentTime( &ModeID, &ModeID );
srand( (ULONG) ( ModeID)  ); /* Nasty eh? */

/* We will now try to open the screen: */

    if (ScreenRequest=(struct ScreenModeRequester *)AllocAslRequestTags(
                                 ASL_ScreenModeRequest,
                                 ASLSM_TitleText,
                                 (ULONG) "Pick 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 8,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
    {
    if (!AslRequestTags(ScreenRequest,    ASLSM_TitleText,
                                 (ULONG) "Pick 5Bit 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 5,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
        {close=TRUE;} else {
            ModeID=ScreenRequest->sm_DisplayID;}
    FreeAslRequest(ScreenRequest);}

 my_screen = (struct Screen *)
 OpenScreenTags( NULL, SA_DisplayID,ModeID,
 SA_Width,320, SA_Height, 256, SA_Depth, 5,
 SA_Colors, ScreenColors, SA_ShowTitle,FALSE,
 SA_Title,"AntiISDA Warrior",TAG_DONE );
  if( !my_screen )
  {CloseLibrary( GfxBase ); CloseLibrary( IntuitionBase ); exit();}
 my_new_window.Screen = my_screen; 
 my_window = (struct Window *) OpenWindow( &my_new_window );

if ( !my_window )
  {
    /* Could NOT open the Window! */
    /* Close the Intuition Library since we have opened it: */
   CloseScreen( my_screen ); CloseLibrary( GfxBase );   
   CloseLibrary( IntuitionBase ); exit(); }


MyFont=(struct TextFont *) OpenFont(&my_font);
SetFont( my_window->RPort,MyFont);
SetAPen(my_window->RPort,28);Move(my_window->RPort,124,80);
Text(my_window->RPort,"Loading...",10);
SetMenuStrip( my_window, &my_menu );
InitPlayer();TitleSong();TitleScreen();
if (!close) Ammo=LevelScreen(Level=1);

x=(rand()%20+10)*8;
y=246;
Move(my_window->RPort,x,y);
Text(my_window->RPort,"*",1);
  /* Stay in the while loop until the end */
  while( close == FALSE )
  {
/* Game here */

WaitTOF();

    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */

  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */
 code=my_message->Code;
 class=my_message->Class;
 ReplyMsg( my_message ); /* Work done. Reply. */
}

if(class == MENUPICK){
    if (code == 63552) close=TRUE;
    if (code == 63520)
        {AutoRequest( my_window, &my_body_text, NULL,
         &my_ok_text, NULL, NULL, 220, 102);}
    if (code == 63488) NewGame=TRUE;
    code=0;class=0;}

if(class == RAWKEY) {
    if (code==69) close=TRUE;
    if (code==64) if (!Shoot) {Shoot=TRUE;
       if(x<160)ShootLeft();else ShootRight();}
    if (code==79) Direction=LEFT;
    if (code==78) Direction=RIGHT;
                     }

JoyStack=JoyStick();
if (JoyStack & FIRE) if (!Shoot) {Shoot=TRUE;
   if(x<160)ShootLeft();else ShootRight();}
if (JoyStack & LEFT) Direction=LEFT;
if (JoyStack & RIGHT) Direction=RIGHT;
if (Shoot) {
Move(my_window->RPort,x,y);
Text(my_window->RPort," ",1);y-=4;
if (Direction==LEFT) x-=(x>0)*4;else if(Direction==RIGHT)x+=(x<312)*4;
if(ReadPixel(my_window->RPort,x,y-7) || ReadPixel(my_window->RPort,x,y+3))
{Counter++;Shoot=FALSE;if (x<160) BoomLeft();else
 BoomRight();SetAPen(my_window->RPort,22);
 Move(my_window->RPort,x-(x%8),Level*12+10);Text(my_window->RPort," ",1);
if (Counter==10) {Ammo=LevelScreen(++Level);y=246;Counter=0;}
 } else
if(ReadPixel(my_window->RPort,x+7,y-7) || ReadPixel(my_window->RPort,x+7,y+2))
{Counter++;Shoot=FALSE;if (x<160) BoomLeft();else BoomRight();
 SetAPen(my_window->RPort,22);
 Move(my_window->RPort,x+(x%8),Level*12+10);Text(my_window->RPort," ",1);
if (Counter==10) {Ammo=LevelScreen(++Level);y=246;Counter=0;}
 }
Move(my_window->RPort,x,y);Text(my_window->RPort,"*",1);
if(y<17 || !Shoot){Delay(4);StopSong();
Move(my_window->RPort,x,y);Text(my_window->RPort," ",1);
Shoot=FALSE;y=246;x=(rand()%20+10)*8;Move(my_window->RPort,x,y);
SetAPen(my_window->RPort,20);Text(my_window->RPort,"*",1);Ammo--;
if(Ammo<10){
 SetAPen(my_window->RPort,7);
 Move(my_window->RPort,120,6);
 ShootsText[8]=Ammo+'0';Text(my_window->RPort,&ShootsText,9);
 SetAPen(my_window->RPort,20);
}}}

if (Level==8) {WinSong();NewGame=Win();StopSong();}
if (Ammo==0) {GameOverSong();NewGame=GameOver();StopSong();}
Direction=0;
if (NewGame){Ammo=LevelScreen(Level=1);
        y=246;x=(rand()%20+10)*8;Move(my_window->RPort,x,y);
        Text(my_window->RPort,"*",1);Shoot=NewGame=FALSE;Counter=0;}
}

 StopSong(); KillPlayer(); /* Don't forget */

/* We should always close the screens we have opened before we leave: */

 ClearMenuStrip( my_window ); /* Clear the menu */

 CloseFont( my_window->IFont );         /* Close the font */

 CloseWindow ( my_window ); 

 CloseScreen( my_screen );

/* Close the Graphics Library since we have opened it: */
  CloseLibrary( GfxBase );

  /* Close the Intuition Library since we have opened it: */
  CloseLibrary( IntuitionBase );

  /* THE END */
exit(0);
}

void TitleScreen()
{
DrawImage(my_window->RPort,&Title,61,14);
DrawImage(my_window->RPort,&SubTitle1,30,54);
DrawImage(my_window->RPort,&SubTitle2,30,143);
DrawImage(my_window->RPort,&SubTitle3,124,213);
SetAPen(my_window->RPort,12);
RectFill(my_window->RPort,115,194,116,194);
SetAPen(my_window->RPort,6);
Move(my_window->RPort,41,245);
Text(my_window->RPort,"© by Ventzislav Tzvetkov 2003",29);
Check();
}


UBYTE JoyStick()
{
  UBYTE data = 0;
  UWORD joy;
  /* PORT 2 ("JOYSTICK PORT") */
    joy = custom.joy1dat;
    data += !( ciaa.ciapra & 0x0080 ) ? FIRE : 0;

  data += joy & 0x0002 ? RIGHT : 0;
  data += joy & 0x0200 ? LEFT : 0;
/*  data += (joy >> 1 ^ joy) & 0x0001 ? DOWN : 0;*/ /* Not used */
/*  data += (joy >> 1 ^ joy) & 0x0100 ? UP : 0;*/   /* Not used */

  return( data );
}

UBYTE LevelScreen(LevelNumber)
{
char LevelText[]="Level N ",i=0,cx;
if (LevelNumber==8) return 100;
LevelText[6]='0'+LevelNumber;
SetRast(my_window->RPort,0);
Move(my_window->RPort,130,90);
SetAPen(my_window->RPort,LevelNumber+3);
Text(my_window->RPort,&LevelText,7);
/*Sound */LevelSong();
Delay(160);/*Change it when setting sound */
SetRast(my_window->RPort,0);
SetBPen(my_window->RPort,30);
StopSong();
do 
 {cx=rand()%40;
 if (!ReadPixel(my_window->RPort,cx*8,LevelNumber*12+10))
 {Move(my_window->RPort,cx*8,LevelNumber*12+10);
  SetAPen(my_window->RPort,i+4);
  Text(my_window->RPort,"©",1);i++;}
 } while (i<10);
SetBPen(my_window->RPort,0);
SetAPen(my_window->RPort,20);
return 25-LevelNumber*2;
}

BOOL GameOver()
{
 SetRast(my_window->RPort,0);
 SetAPen(my_window->RPort,4);
 Move(my_window->RPort,80,50);
 Text(my_window->RPort,"Bad Luck, Webmaster!",20);
 SetAPen(my_window->RPort,8);
 Move(my_window->RPort,40,80);
 Text(my_window->RPort,"All your ammunitions are gone and",33);
 SetAPen(my_window->RPort,9);
 Move(my_window->RPort,40,90);
 Text(my_window->RPort,"you just can not hold it anymore.",33);
 SetAPen(my_window->RPort,10);
 Move(my_window->RPort,74,110);
 Text(my_window->RPort,"Your site was deleted!",22);
 SetAPen(my_window->RPort,7);
 Move(my_window->RPort,126,145);
 Text(my_window->RPort,"GAME OVER",9);
 SetAPen(my_window->RPort,3); Move(my_window->RPort,55,245);
 Text(my_window->RPort,"Press Fire/Space to Play Again",30);
Delay(99);
return Check();

}

BOOL Check(){
ULONG CheckClass;
USHORT CheckCode;

  /* Stay in the while loop until the return */
  while( close == FALSE )
  {
/* Game here */
Delay(1);

    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */

  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */
   CheckClass=my_message->Class;
   CheckCode=my_message->Code;
 ReplyMsg( my_message ); /* Work done. Reply. */
 }

if(CheckClass == MENUPICK){
    if (CheckCode == 63552) {close=TRUE;return FALSE;}
    if (CheckCode == 63520)
        {AutoRequest( my_window, &my_body_text, NULL,
         &my_ok_text, NULL, NULL, 220, 102);}
    if (CheckCode == 63488) return TRUE;
                                  }

if(CheckClass == RAWKEY) {
    if (CheckCode==69) {close=TRUE;return FALSE;}
    if (CheckCode==64) return TRUE;}
CheckClass=0;CheckCode=0;        

if (JoyStick() & FIRE) return TRUE;
}
}

BOOL Win()
{
 SetRast(my_window->RPort,0);
 SetAPen(my_window->RPort,5); Move(my_window->RPort,50,50);
 Text(my_window->RPort,"Congratulatulations, You won",28);
 SetAPen(my_window->RPort,8); Move(my_window->RPort,40,80);
 Text(my_window->RPort,"All ISDA agents are gone, and you",33);
 SetAPen(my_window->RPort,9); Move(my_window->RPort,40,90);
 Text(my_window->RPort,"just found that one of  the jerks",33);
 SetAPen(my_window->RPort,10); Move(my_window->RPort,40,100);
 Text(my_window->RPort,"holds pirated copy  of `Stacker',",33);
 SetAPen(my_window->RPort,11); Move(my_window->RPort,40,110);
 Text(my_window->RPort,"which doubles up  your disk space",33);
 SetAPen(my_window->RPort,12); Move(my_window->RPort,40,120);
 Text(my_window->RPort,"as the  readme  says. Now you can",33);
 SetAPen(my_window->RPort,13); Move(my_window->RPort,40,130);
 Text(my_window->RPort,"upload even more  great software.",33);
 SetAPen(my_window->RPort,14); Move(my_window->RPort,40,140);
 Text(my_window->RPort,"Thanks to ISDA.",15);
 SetAPen(my_window->RPort,19); Move(my_window->RPort,55,245);
 Text(my_window->RPort,"Press Fire/Space to Play Again",30);
 Delay(99);
 return Check();
}