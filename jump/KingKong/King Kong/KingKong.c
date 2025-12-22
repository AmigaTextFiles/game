/*  King Kong

    Programming by Ventzislav Tzvetkov - drHirudo@Amigascne.org
    Music by Vanja Utne - Vanja_Utne@yahoo.no

    Based on the Oric game 4KKong by Mikael Pointier

 Compile with >vc KingKong.c Player-CIA.asm -lauto -o KingKong -cpu=68020
*/

#include <stdio.h> /* Use standart IO for saving the ModeID and Highscore */

#include <intuition/intuition.h> /* I use system friendly code */

#include <hardware/custom.h> /* These twos  are  for  */
#include <hardware/cia.h>   /*  the Joystick handler */

#include <exec/memory.h>

#include <graphics/gels.h>

int Lives,HighScore=0,Score,MarioPosition,KingKongPosition,Level;

unsigned int Barels;

#include "KingKong.h"

#include <libraries/asl.h> /* For the ScreenMode Requester */

BOOL close=FALSE;

/* This will automatically be linked to the Custom structure: */
extern struct Custom custom;

/* This will automatically be linked to the CIA A (8520) chip: */
extern struct CIA ciaa;

main(){
char version[]="$VER: King Kong V1.1 © 2003";
struct ScreenModeRequester *ScreenRequest;
ULONG ModeID,class;
UWORD code;
int Direction,Jump,CraneStatus,Hooks,DeadFlag=0,JoyStack=0,Girder,Ticks=0,
GirderDelay,BarelDelay,OldHighScore;
struct GelsInfo    *my_ginfo;
BOOL KeyFlag=FALSE,NewGame=TRUE;
FILE *SaveFile;

/* Open the Intuition library: */
  IntuitionBase = (struct IntuitionBase *)
    OpenLibrary( "intuition.library", 0 );
  if( !IntuitionBase ) exit(1);
/* Open the Graphics library: */
  GfxBase = (struct GfxBase *)
    OpenLibrary( "graphics.library", 0 );
  if( !GfxBase ) {CloseLibrary( IntuitionBase ); exit(2);}

/* Random seed */
CurrentTime( &ModeID, &ModeID );
srand( (ULONG) ( ModeID)  ); /* Nasty eh? */
ModeID=0;

/* Try to read the ModeID and the HighScore */
if (SaveFile=fopen("KingKong.sav","rb")) {
fread(&ModeID,sizeof(ModeID),1,SaveFile);
fread(&HighScore,sizeof(HighScore),1,SaveFile);
fclose(SaveFile);}
OldHighScore=HighScore;

/* We will now try to open the screen: */
if (!ModeID){
    if (ScreenRequest=(struct ScreenModeRequester *)AllocAslRequestTags(
                                 ASL_ScreenModeRequest,
                                 ASLSM_TitleText,
                                 (ULONG) "Pick 320x240 Screenmode",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 5,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
    {
    if (AslRequestTags(ScreenRequest,    ASLSM_TitleText,
                                 (ULONG) "Pick 5Bit 320x240 Screenmode",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 5,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
                   ModeID=ScreenRequest->sm_DisplayID;
    FreeAslRequest(ScreenRequest);}}
if (ModeID) my_screen = (struct Screen *)
 OpenScreenTags( NULL, SA_DisplayID,ModeID,
 SA_Width,320, SA_Height, 240, SA_Depth, 5,
 SA_Colors32, BlackRGB32, SA_ShowTitle,FALSE,
 SA_Font,&my_font,
 SA_Title,"King Kong",TAG_DONE );

  if( !my_screen )
  {CloseLibrary( GfxBase ); CloseLibrary( IntuitionBase ); exit(3);}
 InitPlayer(); /* Initialise AHX player and routines */
 my_window = (struct Window *) OpenWindowTags(NULL,
  WA_Width, 320,
  WA_Height, 240,
  WA_IDCMP, IDCMP_MENUPICK|IDCMP_RAWKEY,
  WA_Flags, WFLG_SMART_REFRESH|WFLG_BACKDROP|WFLG_BORDERLESS|WFLG_ACTIVATE,
  WA_CustomScreen,my_screen,
 TAG_DONE );

if ( !my_window )
  {
    /* Could NOT open the Window! */
    /* Close the Intuition Library since we have opened it: */
   CloseScreen( my_screen ); CloseLibrary( GfxBase );   
   CloseLibrary( IntuitionBase ); exit(4); }

SetMenuStrip( my_window, &my_menu ); /* Attach menu */

TitleScreen(); /* Show the title screeen */

/* Add bobs to the window: */
if (NULL == (my_ginfo = setupGelSys(my_window->RPort, 0x04))) close=TRUE;

if (NULL == (MarioBob = makeBob(&MarioImagesBob))) close=TRUE;
else AddBob(MarioBob, my_window->RPort);

if (NULL == (KingKongBob = makeBob(&KingKongImagesBob))) close=TRUE;
else AddBob(KingKongBob, my_window->RPort);

  /* Stay in the while loop until the end */
  while( close == FALSE )
  {
if (NewGame) {LevelScreen();Hooks=4;
BarelDelay=6;GirderDelay=5;Barels=Jump=CraneStatus=Girder=NewGame=0;}

/* Game here */

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

if (class == MENUPICK){
    if (code == 63552) close=TRUE; /* Quit menu item */
    if (code == 63520) /* About menu item */
        AutoRequest( my_window, &my_body_text, NULL,
         &my_ok_text, NULL, NULL, 220, 102);
    if (code == 63488) NewGame=TRUE; /* New Game menu item */
}

if (class == RAWKEY) {
    if ( code == 69 ) close = TRUE; /* Escape key pressed */
    if ( code == 25 ) AutoRequest( my_window, &Pause_text, NULL,
         &my_ok_text, NULL, NULL, 220, 102); /* P key pressed */
if (!KeyFlag) {
    if ( code == 79 ) Direction = LEFT;
    if ( code == 78 ) Direction = RIGHT;
    if ( code == 76 ) Direction = UP;
    if ( code == 77 ) Direction = DOWN;
    if ( code == 64 && !Jump) Jump=6;}

if (Direction || Jump) KeyFlag=TRUE;
                     }
if (!Direction) {
if (JoyStack=JoyStick()){if (!KeyFlag){
KeyFlag=TRUE;
if (JoyStack & UP)   {Direction=UP;}
if (JoyStack & DOWN) {Direction=DOWN;}
if (JoyStack & LEFT) {Direction=LEFT;}
if (JoyStack & RIGHT){Direction=RIGHT;}
if ((JoyStack & FIRE) && !Jump) Jump=6;
}} else if (KeyFlag && !Direction) KeyFlag=FALSE;}

/* Mario moves: */
if (Direction && !Jump) switch (Direction) {
        case LEFT:

if (MarioPosition==12) if (!CraneStatus) DrawCraneControl(CraneStatus=21);

if (MarioPosition>0 && MarioPosition<5) if  
((MarioPosition==1 && (Barels & 1))|| (MarioPosition==2 && (Barels & 2))
|| (MarioPosition==3 && (Barels & 4))|| (MarioPosition==4 && (Barels & 8)))
 DeadFlag=TRUE; else {MoveMario(--MarioPosition);Ticks++;}
if (MarioPosition>4 && MarioPosition<9) if  
((MarioPosition==5 && (Barels & 64))|| (MarioPosition==6 && (Barels & 128))
|| (MarioPosition==7 &&(Barels & 256))|| (MarioPosition==8 &&(Barels & 512)))
 DeadFlag=TRUE; else {MoveMario(++MarioPosition);Ticks++;}
if (MarioPosition>12) {MoveMario(--MarioPosition);Ticks++;}
break;
          case RIGHT:
if (MarioPosition==5) if (Barels & 32) DeadFlag=TRUE;
else MoveMario(MarioPosition=17); else {
if (MarioPosition<4) if
((MarioPosition==0 && (Barels & 1))  || (MarioPosition==1 && (Barels & 2))
|| (MarioPosition==2 && (Barels & 4))|| (MarioPosition==3 && (Barels & 8)))
DeadFlag=TRUE; else {MoveMario(++MarioPosition);Ticks++;}
if (MarioPosition>5 && MarioPosition<10) if
((MarioPosition==6 && (Barels & 64))  || (MarioPosition==7 && (Barels & 128))
|| (MarioPosition==8 &&(Barels & 256))|| (MarioPosition==9 &&(Barels & 512)))
DeadFlag=TRUE; else {MoveMario(--MarioPosition);Ticks++;}

if (MarioPosition>11&&MarioPosition<15){MoveMario(++MarioPosition);Ticks++;}}
break;

       case UP:
if (MarioPosition==4) {MoveMario(++MarioPosition);Ticks++;}
if (MarioPosition>8 && MarioPosition<12){MoveMario(++MarioPosition);Ticks++;}
break;

       case DOWN:
if (MarioPosition==5) {MoveMario(--MarioPosition);Ticks++;}
if (MarioPosition>9 && MarioPosition<13){MoveMario(--MarioPosition);Ticks++;}
break;
}

/* Is the crane switched on? */
if (CraneStatus) {
CraneStatus--;if (MarioPosition==12) if (CraneStatus) {
MarioBob->BobVSprite->ImageData = MarioManetteHandUp;
MarioBob->BobVSprite->X=73;
InitMasks(MarioBob->BobVSprite);} else {MoveMario(MarioPosition);}

 switch(CraneStatus) {
case 20:
 DrawImage(my_window->RPort,&CraneHook1,212,61);
 break;

case 16:
 RectFill(my_window->RPort,212,61,223,64);
 DrawImage(my_window->RPort,&CraneHook2,210,62);
 break;

case 12:
 RectFill(my_window->RPort,210,62,217,69);
 DrawImage(my_window->RPort,&CraneHook3,208,62);
 break;

case 8:
 RectFill(my_window->RPort,208,62,211,73);
 DrawImage(my_window->RPort,&CraneHook4,201,61);
 break;

case 4:
 RectFill(my_window->RPort,201,61,206,71);
 DrawImage(my_window->RPort,&CraneHook5,196,60);
 break;

case 0:
if (MarioPosition==12){
MoveMario(MarioPosition);SortGList(my_window->RPort);WaitTOF();
DrawGList(my_window->RPort, ViewPortAddress(my_window));}
DrawCraneControl(0);
break;
}
}

/* Work is done with movement and message variables, erase them: */
Direction=class=0;

/* Is Mario Jumping? */
if (Jump) {
Jump--;if (Jump==5) switch (MarioPosition) {
 case 0: MoveMario(MarioPosition=19);Ticks++;break;
 case 3: MoveMario(MarioPosition=20);Ticks++;break;
 case 6: MoveMario(MarioPosition=21);Ticks++;break;
 case 7: MoveMario(MarioPosition=22);Ticks++;break;
 case 14: MoveMario(MarioPosition=23);Jump=1;Ticks++;
 if (CraneStatus) CraneStatus++;
 break;
 default: Jump=0;break;
}
if (!Jump) switch (MarioPosition) {
 case 19: MoveMario(MarioPosition=0);break;
 case 20: MoveMario(MarioPosition=3);break;
 case 21: MoveMario(MarioPosition=6);break;
 case 22: MoveMario(MarioPosition=7);break;
 case 23: Delay(20);if (CraneStatus>0 && CraneStatus<5)
 {MarioWin(Hooks--);if(!Hooks) Hooks=4;Barels&=0xFFFFFFF8;
 MarioPosition=0;break;}
 MoveMario(MarioPosition=15);
 break;
 default: KeyFlag=FALSE;break;
} 
}

/* Delay more or less ((4-(Level/2))/50) seconds. Depending on Level. */
Delay(4-(Level/2));SortGList(my_window->RPort);
WaitTOF(); /* Wait for the beam and draw the bobs and the Barels: */
DrawGList(my_window->RPort, ViewPortAddress(my_window));
DrawBarels();

/* If the Girder Delay needs refresh - redraw the girders */
GirderDelay--; if (GirderDelay==0) {Girder<<=1;
GirderDelay=5; if ((rand()%80)<11+Level) Girder++;
if (Girder & 16)DrawImage(my_window->RPort,&Girder1,68,131);
 else RectFill(my_window->RPort, 68,131, 91,141);
if (Girder & 8) DrawImage(my_window->RPort,&Girder2,98,131);
 else RectFill(my_window->RPort, 98,131,121,141);
if (Girder & 4) DrawImage(my_window->RPort,&Girder1,128,131);
 else RectFill(my_window->RPort,128,131,151,141);
if (Girder & 2) DrawImage(my_window->RPort,&Girder2,158,131);
 else RectFill(my_window->RPort,158,131,181,141);
if (Girder & 1) DrawImage(my_window->RPort,&Girder1,188,131);
 else RectFill(my_window->RPort,188,131,211,141);
}
BarelDelay--; if (BarelDelay==0) {Ticks++;Ticks++;
/* Check if Barel hits Mario */
if ((MarioPosition==0 &&(Barels & 1)) || (MarioPosition==1 && (Barels & 2))
|| (MarioPosition==2 &&(Barels & 4))  || (MarioPosition==3 && (Barels & 8))
|| (MarioPosition==4 &&(Barels & 16)) || (MarioPosition==5 && (Barels & 64))
|| (MarioPosition==6 &&(Barels & 128))||(MarioPosition==7 && (Barels & 256))
||(MarioPosition==8 &&(Barels & 512))||(MarioPosition==9 && (Barels & 1024))
||(MarioPosition==11&&(Barels&0x1000))||(MarioPosition==12&&(Barels&0x4000))
|| (MarioPosition==13 && (Barels & 524288))
|| (MarioPosition==14 && (Barels & 0x1000000))) DeadFlag=TRUE;
if (!DeadFlag) {if (Barels & 1) DrawScore(++Score);
if (Barels & 0x200000) Barels=(Barels & 0xFFDFFFFF)|0x40000;
if (Barels & 0x10000 ) Barels=(Barels & 0xFFFEFFFF)|0x2000;
Barels>>=1;BarelDelay=6;
if (KingKongPosition & 8 ) {
if (KingKongPosition==8) Barels|=0x8000;
if (KingKongPosition==9) Barels|=0x100000;
if (KingKongPosition==10) Barels|=0x2000000;
KingKongPosition-=4;
KingKongBob->BobVSprite->ImageData = KingKong;}
else if (KingKongPosition & 4) KingKongPosition-=4; else {
if ((rand()%90)<26+Level) {KingKongPosition+=8;
KingKongBob->BobVSprite->ImageData=KingKongBarel;} else if ((rand()%90<45))
{if (KingKongPosition==1) if ((rand() % 20)<10)
KingKongPosition=0; else KingKongPosition=2;
else KingKongPosition=1;
KingKongBob->BobVSprite->X=KongXCoordinates[KingKongPosition];}
}

InitMasks(KingKongBob->BobVSprite);
} else BarelDelay=1;
}

/* Make The Ticks. */
if (Ticks) {StartSong(Ticks);Ticks=0;}
/* Check for some killing positions */
if (MarioPosition==15 || MarioPosition==17) {++MarioPosition;DeadFlag=TRUE;}

if ((MarioPosition==10 &&(Girder & 16))||(MarioPosition==21 &&(Girder & 2 ))
|| (MarioPosition==22 && (Girder & 4 ))) DeadFlag=TRUE;

if (DeadFlag) {StartSong(4);Delay(20);
for (Jump=0;Jump<4;Jump++){
Delay(10);MoveMario(MarioPosition);StartSong(2);
SortGList(my_window->RPort);WaitTOF();
DrawGList(my_window->RPort, ViewPortAddress(my_window));
DrawBarels();
Delay(10);
MarioBob->BobVSprite->ImageData = MarioBlank;
InitMasks(MarioBob->BobVSprite);
SortGList(my_window->RPort);WaitTOF();
DrawGList(my_window->RPort, ViewPortAddress(my_window));
DrawBarels();}
MoveMario(MarioPosition=0);Lives--;DrawLives();
/* Remove first three barels and clear the flags */
Barels&=0xFFFFFFF8;DeadFlag=Jump=FALSE;}

if (!Lives) {GameOver();NewGame=TRUE;}

}

StopSong();KillPlayer(); /* Don't forget with AHX. */

/* We should always remove the bobs we have attached to the window: */

 if (KingKongBob) {  RemBob(KingKongBob);
                     freeBob(KingKongBob,KingKongImagesBob.nb_RasDepth);}

 if (MarioBob) {     RemBob(MarioBob);
                     freeBob(MarioBob,MarioImagesBob.nb_RasDepth);}

 if (my_ginfo) cleanupGelSys(my_ginfo,my_window->RPort);

/* We should always close the screens we have opened before we leave: */

 ClearMenuStrip( my_window ); /* Clear the menu */

 CloseWindow ( my_window );   /* Close the window */

 CloseScreen( my_screen );    /* Close the screen */

/* Close the Graphics Library since we have opened it: */
  CloseLibrary( GfxBase );

  /* Close the Intuition Library since we have opened it: */
  CloseLibrary( IntuitionBase );
/* Save the ModeID and the HighScore if there is new HighScore: */
if (HighScore>OldHighScore) if (SaveFile=fopen("KingKong.sav","wb")){
fwrite(&ModeID,sizeof(ModeID),1,SaveFile);
fwrite(&HighScore,sizeof(HighScore),1,SaveFile);
fclose(SaveFile);
}
  /* THE END */
exit(0);
}

void TitleScreen() /* Draw the Title Screen and play the title song */
{ULONG CheckClass;
UWORD CheckCode;
int y1=105,y2=125,y3=0,dy1=1,dy2=-1,dy3=8;
SetRast(my_window->RPort,0);
StartSong(0);
DrawImage(my_window->RPort,&TitleImage1,30,30);
DrawImage(my_window->RPort,&TitleImage2,170,30);
SetAPen(my_window->RPort,6);
Move(my_window->RPort,64,234);
Text(my_window->RPort,"Press Fire/Space to start",25);
LoadRGB32(&my_screen->ViewPort,PaletteRGB32);
SetRGB32(&my_screen->ViewPort,1,0xB0000000,0xAAAAAAAA,0xDDDDDDDD);
SetRGB32(&my_screen->ViewPort,2,0x44444444,0x66666666,0xFFFFFFFF);
SetRGB32(&my_screen->ViewPort,3,0x33333333,0xB0000000,0x00000000);
  /* Stay in the while loop until the return */
SetAPen(my_window->RPort,0);
  while( close == FALSE )
  {
Title_intui_text2.TopEdge=y1;
Title_intui_text3.TopEdge=y2;
Title_intui_text1.LeftEdge=dy3;
Title_intui_text1.IText=&TitleScroll[y3];
CheckCode=(dy2==1)?-1:8;
WaitTOF();
if (dy1==1) RectFill(my_window->RPort,82,y1-1,237,y1-1);
RectFill(my_window->RPort,68,y2+CheckCode,230,y2+CheckCode);
PrintIText( my_window->RPort, &Title_intui_text1 ,0,0);

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
    if (CheckCode == 63552) close=TRUE;
    if (CheckCode == 63520)
        {AutoRequest( my_window, &my_body_text, NULL,
         &my_ok_text, NULL, NULL, 220, 102);}
    if (CheckCode == 63488) return;
                                  }

if(CheckClass == RAWKEY) {
    if (CheckCode==69) close=TRUE;
    if (CheckCode==64) return;}
CheckClass=0;        

if (y1<65 || y1>219) dy1=-dy1;
if (y2<65 || y2>156) dy2=-dy2;

y1+=dy1;
y2+=dy2;
dy3--; if(dy3<1) {y3++;if(y3>602)y3=0;dy3=8;}
if (JoyStick() & FIRE) return;
}
return;
}



UBYTE JoyStick() /* Read the joystick directly from the hardware (FAST) */
{
  UBYTE data = 0;
  UWORD joy;
  /* PORT 2 ("JOYSTICK PORT") */
    joy = custom.joy1dat;
    data += !( ciaa.ciapra & 0x0080 ) ? FIRE : 0;

  data += joy & 0x0002 ? RIGHT : 0;
  data += joy & 0x0200 ? LEFT : 0;
  data += (joy >> 1 ^ joy) & 0x0001 ? DOWN : 0;
  data += (joy >> 1 ^ joy) & 0x0100 ? UP : 0;

  return( data );
}

void GameOver() /* Mario have no more lives */
{
ULONG EndClass;
UWORD EndCode;
int Counter=0,Crying=0,Dancing=0,DeltaDance=2,x=180,y=68,dx=-1,dy=1,
GameOverBool=0;
Barels=0;
if (KingKongPosition==0 || KingKongPosition==4 || KingKongPosition==8)
Dancing=96;
KingKongBob->BobVSprite->ImageData = KingKong;
InitMasks(KingKongBob->BobVSprite);
MarioBob->BobVSprite->ImageData = GameOverImage[GameOverBool/8];
MarioBob->BobVSprite->X=x;
MarioBob->BobVSprite->Y=y;
InitMasks(MarioBob->BobVSprite);
SortGList(my_window->RPort);
WaitTOF();
DrawGList(my_window->RPort, ViewPortAddress(my_window));
Delay(95);StartSong(8);DrawBarels();
  /* Stay in the while loop until the return */
  while( close == FALSE)
  {
  Counter++;
  Crying++;
  Dancing+=DeltaDance;
  x+=dx;
  y+=dy;
  GameOverBool++;
  if (GameOverBool==16) GameOverBool=0;
  if (x==56 || x==225) dx=-dx;
  if (y==14 || y==159) dy=-dy;
if (Dancing==98 || Dancing==0) DeltaDance=-DeltaDance;
KingKongBob->BobVSprite->X=DancingKong[Dancing];
KingKongBob->BobVSprite->Y=DancingKong[Dancing+1];
InitMasks(KingKongBob->BobVSprite);
MarioBob->BobVSprite->ImageData = GameOverImage[GameOverBool/8];
MarioBob->BobVSprite->X=x;
MarioBob->BobVSprite->Y=y;
InitMasks(MarioBob->BobVSprite);
SortGList(my_window->RPort);
  WaitTOF();
DrawGList(my_window->RPort, ViewPortAddress(my_window));
if (Crying==35) {DrawImage(my_window->RPort,&PrincessCrying1,57,23);}
if (Crying==70) {
DrawImage(my_window->RPort,&PrincessCrying2,57,23);Crying=0;}
    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */

  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */
   EndClass=my_message->Class;
   EndCode=my_message->Code;
 ReplyMsg( my_message ); /* Work done. Reply. */
 }

if(EndClass == MENUPICK){
    if (EndCode == 63552) close=TRUE;
    if (EndCode == 63520)
        {AutoRequest( my_window, &my_body_text, NULL,
         &my_ok_text, NULL, NULL, 220, 102);}
    if (EndCode == 63488) return;
                                  }

if(EndClass == RAWKEY) {
    if (EndCode==69) close=TRUE;
    if (EndCode==64) return;}
EndClass=0;        

if (JoyStick() & FIRE) return;
/* Show the title screen if 4600 TOFs passed since the end */ 

if (Counter>4600) {TitleScreen();return;}
}

}

void LevelScreen(){int i;StopSong();
LoadRGB32(&my_screen->ViewPort,BlackRGB32);
MoveMario(MarioPosition=0);
KingKongBob->BobVSprite->ImageData = KingKong;
KingKongBob->BobVSprite->X=KongXCoordinates[KingKongPosition=0];
KingKongBob->BobVSprite->Y=19;
InitMasks(KingKongBob->BobVSprite);
SortGList(my_window->RPort);SetRast(my_window->RPort,0);
WaitTOF();
SetAPen(my_window->RPort,27);
RectFill(my_window->RPort,0,216,319,223);
DrawGList(my_window->RPort, ViewPortAddress(my_window));
for(i=16;i<207;i+=10){
DrawImage(my_window->RPort,&VerticalGirderPattern, 44,i);
DrawImage(my_window->RPort,&VerticalGirderPattern,254,i);}
for(i=0;i<49;i+=2)
DrawImage(my_window->RPort,&HorizontalGirderPattern,
HGirderPatCoords[i],HGirderPatCoords[i+1]);
for(i=0;i<23;i+=2)
DrawImage(my_window->RPort,&Ladder,LadderCoords[i],LadderCoords[i+1]);
SetAPen(my_window->RPort,17);
RectFill(my_window->RPort,68,100,169,100);
RectFill(my_window->RPort,68,128,217,128);
RectFill(my_window->RPort,56,181,217,181);
SetAPen(my_window->RPort,7);
RectFill(my_window->RPort,68,101,169,101);
RectFill(my_window->RPort,68,129,217,129);
RectFill(my_window->RPort,56,182,217,182);
SetAPen(my_window->RPort,21);
RectFill(my_window->RPort,68,102,169,102);
RectFill(my_window->RPort,68,130,217,130);
RectFill(my_window->RPort,56,183,217,183);
for(i=74;i<147;i+=36) DrawImage(my_window->RPort,&Platform,i,54);
for(i=182;i<201;i+=6) DrawImage(my_window->RPort,&Hook,i,33);
DrawCraneControl(0);
DrawImage(my_window->RPort,&HookPattern,190,16);
DrawImage(my_window->RPort,&Princess,57,23);
DrawImage(my_window->RPort,&CraneControl,56,94);
Lives=4;SetAPen(my_window->RPort,4);
RectFill(my_window->RPort,0,224,319,239);
DrawImage(my_window->RPort,&LivesBar,44,224);
DrawLives();
/* Draw Stars */
SetAPen(my_window->RPort,31);
WritePixel(my_window->RPort,10,33);
WritePixel(my_window->RPort,28,76);
SetAPen(my_window->RPort,3);
WritePixel(my_window->RPort,11,57);
WritePixel(my_window->RPort,32,55);
WritePixel(my_window->RPort,21,117);
WritePixel(my_window->RPort,277,56);
SetAPen(my_window->RPort,11);
WritePixel(my_window->RPort,13,99);
WritePixel(my_window->RPort,285,94);
SetAPen(my_window->RPort,25);
WritePixel(my_window->RPort,290,23);
WritePixel(my_window->RPort,308,71);
SetAPen(my_window->RPort,10);
WritePixel(my_window->RPort,273,30);
SetAPen(my_window->RPort,1);
WritePixel(my_window->RPort,290,45);
WritePixel(my_window->RPort,291,101);
WritePixel(my_window->RPort,8,72);

DrawImage(my_window->RPort,&Cloud,(270*(rand()%2))+rand()%19,18+rand()%10);
DrawImage(my_window->RPort,&ScoreBar,136,224);
DrawImage(my_window->RPort,&Tree1,1,145);
DrawImage(my_window->RPort,&Tree2,299,151);
DrawImage(my_window->RPort,&Car,266,201);
DrawScore(Score=0);
DrawImage(my_window->RPort,&BestBar,210,225);
DrawHighScore(HighScore);Level=2;SetAPen(my_window->RPort,0);
LoadRGB32(&my_screen->ViewPort,PaletteRGB32);
}
