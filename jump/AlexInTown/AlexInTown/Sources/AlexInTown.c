/* Alex In Town All Levels Game. Copyright © 2002-2003 by Ventzislav   */
/* Tzvetkov <drHirudo@Amigascne.org>. Original Sinclair 128K game by   */
/* Equinox Tetrachloride <eq@cl4.org>.                                 */
/*                                                                     */
/* All this source is free to use. I am not responsible for any damage */
/* this product may make.                                              */
/*                                                                     */
/* Used the freeware C compiler VBCC by Volker Barthelmann             */
/* Compile with >vc AlexInTown.c Player-CIA.asm -o AlexInTown -lauto   */
/*                                                                     */
/* New in version 1.2:                                                 */
/*                         - More Levels.                              */
/*                         - All in one game.                          */
/*                         - Smaller code.                             */
/*                         - Faster Level Renderer.                    */


#include <stdio.h>

#include <intuition/intuition.h>

/* For loading the Levels */
#include <libraries/dos.h>

#include <hardware/custom.h>  /* These twos  are  for  */
#include <hardware/cia.h>    /*  the Joystick handler */
/* The Game uses dirty hardware access to read the Joystick positions  */
/* For speed. If this doesn't work under newer AmigaOS releases I will */
/* Change it. For now it will stuck.                                   */

#include <libraries/asl.h> /* For the ScreenMode Requester */

#include "AlexInTown.h"

UWORD level[32][24];
/* ^ Here we keep the level data - 32*24 Words = 1536 bytes for level */

 struct FileHandle *file_handle;
 long bytes_written;
 long bytes_read;
 char Lives=5;  /* Five tries only */

main()
{
BOOL close=FALSE,dead=FALSE; /* Some switches */
char N,
version[]="$VER: Alex in Town V1.2 (17.03.2003) © (1992-2003)";
struct ScreenModeRequester *ScreenRequest;
ULONG ModeID;

/* Open the Intuition library: */
  IntuitionBase = (struct IntuitionBase *)
    OpenLibrary( "intuition.library", 0 );
  if( !IntuitionBase )
    exit();
/* Open the Graphics library: */
  GfxBase = (struct GfxBase *)
    OpenLibrary( "graphics.library", 0 );
  if( !GfxBase )
  {
  CloseLibrary( IntuitionBase );
  exit();    
  }
/* We will now try to open the screen: */

    if (ScreenRequest=(struct ScreenModeRequester *)AllocAslRequestTags(
                                 ASL_ScreenModeRequest,
                                 ASLSM_TitleText, (ULONG) "Pick 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 8,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
    {
    if (!AslRequestTags(ScreenRequest,    ASLSM_TitleText, (ULONG) "Pick 4Bit 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 4,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
        {
        printf("Error: Invalid ScreenMode\n");
        exit(-1);
        } else {
            ModeID=ScreenRequest->sm_DisplayID;}
    }

 my_screen = (struct Screen *)
 OpenScreenTags( NULL, SA_DisplayID,ModeID,SA_Width,320,
 SA_Height, 256, SA_Depth,     4,
SA_Colors,      ScreenColors, SA_Title,"Alex in Town",TAG_DONE );

  if( !my_screen )
  {
   CloseLibrary( GfxBase );
   CloseLibrary( IntuitionBase );
   exit();
   }

 my_new_window.Screen = my_screen;
 my_window = (struct Window *) OpenWindow( &my_new_window );

if ( !my_window )
  {
    /* Could NOT open the Window! */
    
    /* Close the Intuition Library since we have opened it: */
   CloseScreen( my_screen );
   CloseLibrary( GfxBase );   
   CloseLibrary( IntuitionBase );
   exit();  
  }
SetFont( my_window->RPort, &AlexTownFont);
SetAPen(my_window->RPort,4);
SetBPen(my_window->RPort,0);
Move(my_window->RPort,56,70);
Text( my_window->RPort, "Alex In Town is Loading..." , 26 );
InitPlayer();
srand(Title());
StopSong();InGameSong();
ScreenLevel(Level);

  /* Stay in the while loop until the end */
  while( close == FALSE )
  {

    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */

Sub9980();
Delay(2);
if (K1) {SetAPen(my_window->RPort,0);if (K1>1 && (rand() % 200)/100
&& ReadPixel(my_window->RPort,K1*8+32,200)==0 && ReadPixel(my_window->RPort,K1*8+32,192)==0) {RectFill(my_window->RPort,K1*8+40,186,K1*8+47,201);K1--;}
else if (K1<30 && (rand() % 200)/100 && ReadPixel(my_window->RPort,K1*8+48,200)==0 && ReadPixel(my_window->RPort,K1*8+48,192)==0)
{RectFill(my_window->RPort,K1*8+40,186,K1*8+47,201);K1++;}
if (K2>0 && (rand() % 200)/100 && ReadPixel(my_window->RPort,K2*8+32,200)==0 && ReadPixel(my_window->RPort,K2*8+32,192)==0) {RectFill(my_window->RPort,K2*8+40,186,K2*8+47,201);K2--;}
else if (K2<30 && (rand() % 200)/100 && ReadPixel(my_window->RPort,K2*8+48,200)==0 && ReadPixel(my_window->RPort,K2*8+48,192)==0)
{RectFill(my_window->RPort,K2*8+40,186,K2*8+47,201);K2++;}
DrawAlex(11,13,K1,20);DrawAlex(10,7,K2,20);
if (A>17) if (B==K1-1 || B==K1 || B==K1+1 || B==K2-1 || B==K2 || B==K2+1) dead=TRUE;  }
if (BI) {if (A>18 && B==BI-1 &&
ReadPixel(my_window->RPort,B*8+56,A*8+40)==0) {SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,BI*8+40,186,BI*8+47,201);BI++;
SetAPen(my_window->RPort,11);SetBPen(my_window->RPort,8);
Move(my_window->RPort,BI*8+40,200);Text(my_window->RPort,"è",1);
Move(my_window->RPort,BI*8+40,192);Text(my_window->RPort,"ö",1); }
if (A>18 && B==BI+1 && BI>1 && ReadPixel(my_window->RPort,B*8+24,A*8+40)==0) {SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,BI*8+40,186,BI*8+47,201);BI--;
SetAPen(my_window->RPort,11);SetBPen(my_window->RPort,8);
Move(my_window->RPort,BI*8+40,200);Text(my_window->RPort,"è",1);
Move(my_window->RPort,BI*8+40,192);Text(my_window->RPort,"ö",1); }}

if (C) { SetAPen(my_window->RPort,6);SetBPen(my_window->RPort,0);
if (C==2 && (rand() % 200)/100) {C=1;for (N=15;N<21;N++)
{Move(my_window->RPort,104,N*8+40);Text(my_window->RPort,"Ñ",1);
Delay(1);}}
if (C==1) if (B==8) dead=TRUE; else if ((rand() % 200)/100) {C=2;for (N=20;N>14;N--)
{Move(my_window->RPort,104,N*8+40);Text(my_window->RPort," ",1);
Delay(1);}}}

if (ZZZ) { ZZZ=((rand() % 800)/100)+1;if (ZZZ==4) {
SetBPen(my_window->RPort,0);ZZZ=((rand() % 400)/100)+1;
if (ZZZ==1) {for (N=0;N<21;N++)
{SetAPen(my_window->RPort,2);Move(my_window->RPort,64,N*8+40);Text(my_window->RPort,"ÇÇÇÇ",4);Delay(1);Move(my_window->RPort,64,N*8+40);
Text(my_window->RPort,"    ",4);}if (B>2 && B<7) dead=TRUE;}
if (ZZZ==2) {for (N=0;N<21;N++)
{SetAPen(my_window->RPort,0);SetBPen(my_window->RPort,15);
Move(my_window->RPort,112,112);Text(my_window->RPort,"CARPET",6);
Move(my_window->RPort,112,120);Text(my_window->RPort,"STORES",6);
SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,0);
Move(my_window->RPort,112,N*8+40);
Text(my_window->RPort,"ÇÇÇÇÇ",5);Delay(1);
Move(my_window->RPort,112,N*8+40);
Text(my_window->RPort,"     ",5);}if (B>8 && B<14) dead=TRUE;}
if (ZZZ==3) {for (N=0;N<21;N++)
{SetAPen(my_window->RPort,6);Move(my_window->RPort,160,N*8+40);Text(my_window->RPort,"ÇÇÇÇÇ",5);Delay(1);Move(my_window->RPort,160,N*8+40);
Text(my_window->RPort,"     ",5);}if (B>14 && B<20) dead=TRUE;}
if (ZZZ==4) {for (N=0;N<21;N++)
{SetAPen(my_window->RPort,5);Move(my_window->RPort,216,N*8+40);Text(my_window->RPort,"ÇÇÇÇÇ",5);Delay(1);Move(my_window->RPort,216,N*8+40);
Text(my_window->RPort,"     ",5);}if (B>21 && B<28) dead=TRUE;}
SetAPen(my_window->RPort,2);SetBPen(my_window->RPort,8);
Move(my_window->RPort,64,40);Text(my_window->RPort,"ÇÇÇÇ",4);
SetAPen(my_window->RPort,4);
Move(my_window->RPort,112,40);Text(my_window->RPort,"ÇÇÇÇÇ",5);
SetAPen(my_window->RPort,6);
Move(my_window->RPort,160,40);Text(my_window->RPort,"ÇÇÇÇÇ",5);
SetAPen(my_window->RPort,5);
Move(my_window->RPort,216,40);Text(my_window->RPort,"ÇÇÇÇÇ",5);}}

if (KO1) {SetAPen(my_window->RPort,0); RectFill(my_window->RPort,KO1*8+40,186,KO1*8+47,201);
if (B<=KO1 || B==KO1+1 || B==KO1+2) KO1--; else KO1++;
RectFill(my_window->RPort,KO2*8+40,186,KO2*8+47,201);
if (B<=KO2 || B==KO2+1 || B==KO2+2) KO2--; else KO2++;
RectFill(my_window->RPort,KO3*8+40,186,KO3*8+47,201);
if (B<=KO3 || B==KO3+1 || B==KO3+2) KO3--; else KO3++;
if (KO1==KO2 || KO1==KO3) KO1--;
if (KO2==KO3) KO2++;
if (KO1<0)  KO1=0;
if (KO1>13) KO1=13;
if (KO2<0)  KO2=0;
if (KO2>13) KO2=13;
if (KO3<0)  KO3=0;
if (KO3>13) KO3=13;
if (A>17 && (B==KO1 || B==KO2 || B==KO3 || B==KO1-1 || B==KO1+1 ||
B==KO2-1 || B==KO2+1 || B==KO3-1 || B==KO3+1)) dead=TRUE;
DrawAlex(6,11,KO1,20);DrawAlex(6,12,KO2,20);DrawAlex(6,7,KO3,20);}

if (GA) {SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,GB*8+40,GA*8+26,GB*8+47,GA*8+41);
if (B<GB && ReadPixel(my_window->RPort,GB*8+32,GA*8+40)==0 &&
ReadPixel(my_window->RPort,GB*8+32,GA*8+32)==0) GB--; else
if (B>GB && ReadPixel(my_window->RPort,GB*8+48,GA*8+40)==0 &&
ReadPixel(my_window->RPort,GB*8+48,GA*8+32)==0) GB++; else
if (A<GA && ReadPixel(my_window->RPort,GB*8+40,GA*8+24)==0) GA--; else
if (A>GA && ReadPixel(my_window->RPort,GB*8+40,GA*8+48)==0) GA++;
DrawAlex(7,7,GB,GA);
if ((A==GA || A==GA-1 || A==GA-2 || A==GA+1 || A==GA+2) &&
(B==GB || B==GB-1 || B==GB+1)) dead=TRUE;}


if (Level==16) if (B==12) {SetAPen(my_window->RPort,5);
SetBPen(my_window->RPort,8);for (N=13;N>-1;N--) {
Move(my_window->RPort,136,N*8+40);
Text(my_window->RPort,"ò",1);Delay(1);}dead=TRUE;}

if (Level==18) {if (A==15 && B==14) { SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,B*8+40,A*8+26,B*8+47,A*8+41);B=15;}
if (A==15 && B==15) for (N=15;N<21;N++) { DrawAlex(12,14,B,A);Delay(2);SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,B*8+40,A*8+26,B*8+47,A*8+41);A++;B++;}
}

if (Level==19) { if (A==18 && B==5) {SetAPen(my_window->RPort,5);
SetBPen(my_window->RPort,0); for(N=0;N<19;N++){
Move(my_window->RPort,128,N*8+40);Text(my_window->RPort,"í",1);Delay(2);
Move(my_window->RPort,128,N*8+40);Text(my_window->RPort," ",1);}
Move(my_window->RPort,128,184);Text(my_window->RPort,"í",1);
for(N=18;N>1;N--){DrawAlex(12,14,B,A);Delay(1);
SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,B*8+40,A*8+26,B*8+47,A*8+41);A--;}
Move(my_window->RPort,128,184);Text(my_window->RPort," ",1);
SetAPen(my_window->RPort,5);Move(my_window->RPort,128,40);
Text(my_window->RPort,"í",1);}
if (A==18 && B==11) {SetAPen(my_window->RPort,5);for (N=0;N<17;N++) {
Move(my_window->RPort,128,N*8+40);Text(my_window->RPort,"í",1);Delay(2);
Move(my_window->RPort,128,N*8+40);Text(my_window->RPort," ",1);}
Move(my_window->RPort,128,168);Text(my_window->RPort,"í",1);dead=TRUE;}}


if (FLASH) {FLASH++;if (FLASH==8) {SetAPen(my_window->RPort,6);
SetBPen(my_window->RPort,1);Move (my_window->RPort,88,40);
Text(my_window->RPort,"KEEP OFF THE GRASS",18);} else
if (FLASH==15) {SetAPen(my_window->RPort,1);
SetBPen(my_window->RPort,6);Move (my_window->RPort,88,40);
Text(my_window->RPort,"KEEP OFF THE GRASS",18);FLASH=1;}
if (ReadPixel(my_window->RPort,B*8+40,A*8+48)==4)dead=TRUE;}

if (Level==21) {if (A==20 && B>21 && B<28) {DrawAlex(0,0,B,A);A++;}}

if (CAR) { if (B<CAR+2 && CAR>2) {SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,CAR*8+64,171,CAR*8+79,201);CAR--;}
if (B>CAR+2 && CAR<24) {SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,CAR*8+40,171,CAR*8+47,201);CAR++;}
Car();
if ((B==CAR || B==CAR-1 || B==CAR+4 || B==CAR+5) && A>16) dead=TRUE;}


if (Level==23) { if (A==17 && B==4 && !KO2) KO2=7;
if (KO2) {KO2++; if (KO2==8) { SetAPen(my_window->RPort,2);
Move (my_window->RPort,72,184);Text(my_window->RPort,"è",1);}
else if (KO2==15) {SetAPen(my_window->RPort,6);
Move (my_window->RPort,72,184);Text(my_window->RPort,"è",1);KO2=1;}}
SetAPen(my_window->RPort,0);
if ((rand() % 200)/100 && ReadPixel(my_window->RPort,K2*8+32,200)==0
&& ReadPixel(my_window->RPort,K2*8+32,192)==0)
{RectFill(my_window->RPort,K2*8+40,186,K2*8+47,201);K2--;}
else
if ((rand() % 200)/100 && ReadPixel(my_window->RPort,K2*8+48,200)==0
&& ReadPixel(my_window->RPort,K2*8+48,192)==0 && K2<31)
{RectFill(my_window->RPort,K2*8+40,186,K2*8+47,201);K2++;}
DrawAlex(2,3,K2,20);
if ((((rand() % 1000)/100)+4)==4) {SetAPen(my_window->RPort,5);
SetBPen(my_window->RPort,0);
for(N=K2+1;N<32;N++) {Move (my_window->RPort,N*8+40,200);
Text(my_window->RPort,"Ç",1);Delay(1);}
if (A==20 && B>K2) dead=TRUE; else 
{SetAPen(my_window->RPort,0); for(N=K2+1;N<32;N++) {Move
(my_window->RPort,N*8+40,200);Text(my_window->RPort," ",1);Delay(1);}}
 }
}

if (A>21) dead=TRUE;

if (B==31) {Level++;if(!(Level%25)) Lives++;ScreenLevel(Level);}
  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
    if (close)
       break;
      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */

if(my_message->Class == MENUPICK && my_message->Code == 63552)
       close=TRUE;

if(my_message->Class == MENUPICK && my_message->Code == 63520)
{SetRGB4( &my_screen->ViewPort, 1,255,255,255);
AutoRequest( my_window, &my_body_text, NULL, &my_ok_text, NULL, NULL, 220, 102);
SetRGB4( &my_screen->ViewPort, 1,0,0,204);}

if(my_message->Class == MENUPICK && my_message->Code == 63488)
{ NewGame=TRUE;}
}

if (dead) {Dead();Lives--;Delay(100);A=20;dead=FALSE;if (Lives>0) ScreenLevel(Level); else
{GameOver();NewGame=TRUE;}}

if (NewGame) {NewGame=FALSE;Level=1;Title();Lives=5;
ScreenLevel(Level);A=20;StopSong();InGameSong();}

  }

/* We should always close the screens we have opened before we leave: */

 StopSong(); KillPlayer(); /* Don't forget */

 ClearMenuStrip( my_window );

 CloseWindow ( my_window ); 

 CloseScreen( my_screen );
  
/* Close the Graphics Library since we have opened it: */
  CloseLibrary( GfxBase );

  /* Close the Intuition Library since we have opened it: */
  CloseLibrary( IntuitionBase );

  /* THE END */
exit();
}

int Title() {int bs=0,Seed;
StopSong();TitleSong();
SetRast(my_window->RPort,0);
ClearMenuStrip( my_window );
SetAPen(my_window->RPort,15);
SetBPen(my_window->RPort,0);
Move(my_window->RPort,48,62);
Text( my_window->RPort, "ííí í   ííí í í" , 15 );
SetAPen(my_window->RPort,7);
Move(my_window->RPort,48,70);
Text( my_window->RPort, "í í í   í   í í" , 15 );
SetAPen(my_window->RPort,7);
Move(my_window->RPort,48,70);
Text( my_window->RPort, "í í í   í   í í" , 15 );
SetAPen(my_window->RPort,14);
Move(my_window->RPort,48,78);
Text( my_window->RPort, "ííí í   ííí  í" , 14 );
SetAPen(my_window->RPort,6);
Move(my_window->RPort,48,86);
Text( my_window->RPort, "í í í   í   í í" , 15 );
SetAPen(my_window->RPort,13);
Move(my_window->RPort,48,94);
Text( my_window->RPort, "í í ííí ííí í í" , 15 );
SetAPen(my_window->RPort,10);
SetBPen(my_window->RPort,14);
Move(my_window->RPort,48,110);
Text( my_window->RPort, "ììììììììììììììì",15);
Move(my_window->RPort,48,126);
Text( my_window->RPort, "ììììììììììììììì",15);
SetAPen(my_window->RPort,0);
SetBPen(my_window->RPort,12);
Move(my_window->RPort,48,118);
Text( my_window->RPort, "    IN TOWN    ",15);
SetAPen(my_window->RPort,0);
SetBPen(my_window->RPort,10);
Move(my_window->RPort,40,142);
Text( my_window->RPort, "By Equinox <eq@cl4.org>   c.1992",32);
Move(my_window->RPort,40,150);
Text( my_window->RPort, "Amiga version by drHirudo c.2002",32);
SetAPen(my_window->RPort,11);
SetBPen(my_window->RPort,0);
Move(my_window->RPort,40,164);
Text( my_window->RPort, "í Full-colour graphics!",23);
Move(my_window->RPort,40,180);
Text( my_window->RPort, "í Thumping 128k sound!",22);
Move(my_window->RPort,40,196);
Text( my_window->RPort, "í Many DEADLY areas!@!!#",24);
while (bs<1750) {bs++;Delay(1); if (Joystick() & FIRE) break;Seed++;}
SetMenuStrip( my_window, &my_menu );
return Seed;
}


UBYTE Joystick()
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

void Sub9980() { DrawAlex(12,14,B,A);
if ((Joystick() & LEFT) && ReadPixel(my_window->RPort,B*8+32,A*8+40)==0 && ReadPixel(my_window->RPort,B*8+32,A*8+32)==0 && B>0)
{SetAPen(my_window->RPort,0); RectFill(my_window->RPort,B*8+40,A*8+26,B*8+47,A*8+41);B--;}
if ((Joystick() & RIGHT) && ReadPixel(my_window->RPort,B*8+48,A*8+40)==0 && ReadPixel(my_window->RPort,B*8+48,A*8+32)==0 && B<31)
{SetAPen(my_window->RPort,0); RectFill(my_window->RPort,B*8+40,A*8+26,B*8+47,A*8+41);B++;}
if ((Joystick() & FIRE) && ReadPixel(my_window->RPort,B*8+40,A*8+24)==0 && ReadPixel(my_window->RPort,B*8+40,A*8+48)!=0) Jump();
if (ReadPixel(my_window->RPort,B*8+40,A*8+48)==0) {SetAPen(my_window->RPort,0);RectFill(my_window->RPort,B*8+40,A*8+26,B*8+47,A*8+41);A++;}
 SetAPen(my_window->RPort,12); SetBPen(my_window->RPort,0);
Move (my_window->RPort,B*8+40,A*8+40);
Text(my_window->RPort,"ë",1);
SetAPen(my_window->RPort,14);
Move (my_window->RPort,B*8+40,A*8+32);
Text(my_window->RPort,"ê",1);
}

void Jump(){char N;

for (N=1;N<6;N++)
{if (ReadPixel(my_window->RPort,B*8+40,A*8+24)!=0) return;

SetAPen(my_window->RPort,0);RectFill(my_window->RPort,B*8+40,A*8+26,B*8+47,A*8+41);A--;DrawAlex(12,14,B,A);
if ((Joystick() & LEFT) && ReadPixel(my_window->RPort,B*8+32,A*8+40)==0 && ReadPixel(my_window->RPort,B*8+32,A*8+32)==0 && B>0)
{SetAPen(my_window->RPort,0); RectFill(my_window->RPort,B*8+40,A*8+26,B*8+47,A*8+41);B--;}
if ((Joystick() & RIGHT) && ReadPixel(my_window->RPort,B*8+48,A*8+40)==0 && ReadPixel(my_window->RPort,B*8+48,A*8+32)==0 && B<31)
{SetAPen(my_window->RPort,0); RectFill(my_window->RPort,B*8+40,A*8+26,B*8+47,A*8+41);B++;}
DrawAlex(12,14,B,A);
Delay(2);
 }
}

void Dead() { /* Dead Routine */
SetAPen(my_window->RPort,0);
SetBPen(my_window->RPort,4);
Move (my_window->RPort,B*8+40,A*8+40);
Text(my_window->RPort,"ë",1);
SetBPen(my_window->RPort,6);
Move (my_window->RPort,B*8+40,A*8+32);
Text(my_window->RPort,"ê",1);}

void GameOver() { /* Sigh */
int dilay;
ClearMenuStrip( my_window );
SetRast(my_window->RPort,0);
SetAPen(my_window->RPort,5);
SetBPen(my_window->RPort,0);
Move (my_window->RPort,48,48);
Text(my_window->RPort,"HARD LUCK ALEX!",15);
StopSong();GameOverSong();
while (dilay<1850) {dilay++;Delay(1); if (Joystick() & FIRE) break;}
}

void AreaShow (c){ /* Shows some unusefull text */
char Tex[1];
SetRast(my_window->RPort,0);
Tex[0]=c+'0';
SetMenuStrip( my_window, &my_menu );
SetAPen(my_window->RPort,15);
SetBPen(my_window->RPort,0);
Move(my_window->RPort,40,52);
Text( my_window->RPort, "GET READY ALEX" , 14 );
SetAPen(my_window->RPort,14);
Move(my_window->RPort,40,68);
Text( my_window->RPort, "AREA " , 5 );
Text( my_window->RPort, &Tex[0], 1);
Tex[0]=Lives+'0';
SetAPen(my_window->RPort,10);
Move(my_window->RPort,40,84);
Text( my_window->RPort, "Life " , 5 );
Text( my_window->RPort, &Tex[0], 1 );


Delay(150);SetRast(my_window->RPort,0);Move(my_window->RPort,40,208);

}

void DrawAlex(down,up,x,y){  SetAPen(my_window->RPort,down); /* Alex */ SetBPen(my_window->RPort,0);
Move (my_window->RPort,x*8+40,y*8+40);
Text(my_window->RPort,"ë",1);
SetAPen(my_window->RPort,up);
Move (my_window->RPort,x*8+40,y*8+32);
Text(my_window->RPort,"ê",1);}

void Car() {SetAPen(my_window->RPort,13);SetBPen(my_window->RPort,0);
Move (my_window->RPort,CAR*8+40,200);Text(my_window->RPort," O O ",4);
Move (my_window->RPort,CAR*8+40,192);Text(my_window->RPort,"èèèèè",5);
Move (my_window->RPort,CAR*8+40,184);SetAPen(my_window->RPort,5);
Text(my_window->RPort," è",2);SetAPen(my_window->RPort,13);
Text(my_window->RPort,"è",1);SetAPen(my_window->RPort,5);
Text(my_window->RPort,"è",1);SetBPen(my_window->RPort,8);
SetAPen(my_window->RPort,13);
Text(my_window->RPort," ",1);Move (my_window->RPort,CAR*8+40,176);
Text(my_window->RPort," èèè ",5);}

void ScreenLevel(Level) { /* Display the level on the screen */
int i,j;
char Char,LevelName[]="PROGDIR:Levels/Level00";

SetMenuStrip( my_window, &my_menu );
K1=KO1=BI=C=ZZZ=GA=FLASH=B=CAR=0;Move(my_window->RPort,40,208);
if (Level>23) {
LevelName[20]=(Level-23)/10+'0';
LevelName[21]=((Level-23)%10)+'0';

/* Opens the Level file */
file_handle = (struct FileHandle *)
Open( &LevelName, MODE_OLDFILE );
bytes_read = Read( file_handle, level, sizeof( level ) );

if (!file_handle)  {ClearMenuStrip( my_window );
SetAPen(my_window->RPort,5);SetBPen(my_window->RPort,0);
Move (my_window->RPort,28,64);
Text(my_window->RPort,"brought to you by the",21);
Move (my_window->RPort,20,72);
Text(my_window->RPort,"comp.sys.sinclair crap games",28);
Move (my_window->RPort,52,80);
Text(my_window->RPort,"competition 2001",16);
SetAPen(my_window->RPort,9);
Move (my_window->RPort,20,96);
Text(my_window->RPort,"Ported to Amiga 2002",20);
StopSong();WinSong();
for (GB=0;GB<29;GB++) {
SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,2);
Move (my_window->RPort,20,40);
Text(my_window->RPort," ** congraturations you success ** ",35);
Delay(25);SetAPen(my_window->RPort,2);SetBPen(my_window->RPort,4);
Move (my_window->RPort,20,40);
Text(my_window->RPort," ** congraturations you success ** ",35);Delay(25);}NewGame=TRUE;} else {Close( file_handle );
if (!(Level%23)) AreaShow(Level/23+4);
SetRast(my_window->RPort,0);
for (i=0;i<32;i++) for (j=0;j<23;j++) 
if (level[i][j]) {
SetAPen(my_window->RPort,level[i][j]>>12);
SetBPen(my_window->RPort,level[i][j]>>8 & 0x000F);
Char=level[i][j]&0x00FF; Move(my_window->RPort,i*8+40,j*8+40);
Text(my_window->RPort,&Char,1);}

if (level[1][23]) /* A */A=level[1][23];

if (level[2][23]) {/* CAR */
SetAPen(my_window->RPort,13);SetBPen(my_window->RPort,0);
CAR=level[2][23];
Move (my_window->RPort,CAR*8+40,200);
Text(my_window->RPort," O O ",4);
Move (my_window->RPort,CAR*8+40,192);
Text(my_window->RPort,"èèèèè",5);
Move (my_window->RPort,CAR*8+40,184);
SetAPen(my_window->RPort,5);
Text(my_window->RPort," è",2);SetAPen(my_window->RPort,13);
Text(my_window->RPort,"è",1);SetAPen(my_window->RPort,5);
Text(my_window->RPort,"è",1);SetBPen(my_window->RPort,8);
SetAPen(my_window->RPort,13);Text(my_window->RPort," ",1);
Move (my_window->RPort,CAR*8+40,176);
Text(my_window->RPort," èèè ",5);}

if (level[3][23]) {/* GB */
SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,0);
GB=level[3][23];GA=18;
Move (my_window->RPort,GB*8+40,184);
Text(my_window->RPort,"ë",1);
Move (my_window->RPort,GB*8+40,176);
Text(my_window->RPort,"ê",1);}

if (level[4][23]) {/* K1 */
SetAPen(my_window->RPort,11);SetBPen(my_window->RPort,0);
K1=level[4][23];K2=K1+2;
Move (my_window->RPort,K1*8+40,200);
Text(my_window->RPort,"ë",1);SetAPen(my_window->RPort,13);
Move (my_window->RPort,K1*8+40,192);
Text(my_window->RPort,"ê",1);SetAPen(my_window->RPort,10);
Move (my_window->RPort,K2*8+40,200);
Text(my_window->RPort,"ë",1);SetAPen(my_window->RPort,7);Move (my_window->RPort,K2*8+40,192);
Text(my_window->RPort,"ê",1);}

if (level[5][23]){/* BI */
SetAPen(my_window->RPort,11);BI=level[5][23];
SetBPen(my_window->RPort,8);
Move (my_window->RPort,BI*8+40,192);
Text(my_window->RPort,"ö",1);
Move (my_window->RPort,BI*8+40,200);
Text(my_window->RPort,"è",1);}
if (level[6][23]) C=2; /* C */
if (level[7][23]) {KO1=8;KO2=10;KO3=12; /* Three Boys! */
DrawAlex(6,11,KO1,20);DrawAlex(6,12,KO2,20);DrawAlex(6,7,KO3,20);}
}}

else {

SetRast(my_window->RPort,0);

switch (Level)
{
case 1: {AreaShow(1);SetAPen(my_window->RPort,7); SetBPen(my_window->RPort,5);
Text(my_window->RPort,"íííííííííííííííííííííííííííííííí",32);
 SetBPen(my_window->RPort,10);Move(my_window->RPort,192,200);
 Text(my_window->RPort," ",1);SetAPen(my_window->RPort,10);
 SetBPen(my_window->RPort,8);Move(my_window->RPort,192,192);
 Text(my_window->RPort,"ö",1);SetAPen(my_window->RPort,14);
 Move(my_window->RPort,232,160);Text(my_window->RPort,"õ",1);
 SetAPen(my_window->RPort,7);Move(my_window->RPort,232,168);
 Text(my_window->RPort,"ú",1);Move(my_window->RPort,232,176);
 Text(my_window->RPort,"ú",1);Move(my_window->RPort,232,184);
 Text(my_window->RPort,"ú",1);Move(my_window->RPort,232,192);
 Text(my_window->RPort,"Ñ",1);Move(my_window->RPort,232,200);
 Text(my_window->RPort,"Ñ",1);B=3;break;}

case 2: {SetAPen(my_window->RPort,5); SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûûû",32);
SetAPen(my_window->RPort,2);SetBPen(my_window->RPort,6);
Move(my_window->RPort, 96,168);Text(my_window->RPort,"ììììììì",7);
Move(my_window->RPort, 96,176);
Text(my_window->RPort,"ì",1);Move(my_window->RPort, 96,184);
Text(my_window->RPort,"ì",1);Move(my_window->RPort, 96,192);
Text(my_window->RPort,"ì",1);Move(my_window->RPort, 96,200);
Text(my_window->RPort,"ì",1);SetAPen(my_window->RPort,10);
SetBPen(my_window->RPort,14);Text(my_window->RPort,"ì",1);
SetBPen(my_window->RPort,11);Text(my_window->RPort," ",1);
SetBPen(my_window->RPort,14);Text(my_window->RPort,"ìììì",4);
Move(my_window->RPort, 112,176);Text(my_window->RPort,"ììììì",5);
Move(my_window->RPort, 104,184);Text(my_window->RPort,"ìììììì",6);
Move(my_window->RPort, 120,192);Text(my_window->RPort,"ìììì",4);
Move(my_window->RPort, 104,192);Text(my_window->RPort,"ì",1);
SetAPen(my_window->RPort,11);SetBPen(my_window->RPort,9);
Text(my_window->RPort,"ù",1);SetAPen(my_window->RPort,13);
SetBPen(my_window->RPort,14);Move(my_window->RPort, 104,176);
Text(my_window->RPort,"í",1);Move(my_window->RPort, 120,176);
Text(my_window->RPort,"í",1);Move(my_window->RPort, 136,176);
Text(my_window->RPort,"í",1);SetAPen(my_window->RPort,4);
SetBPen(my_window->RPort,8);Move(my_window->RPort, 96,160);
Text(my_window->RPort,"ñèèèèèó",7);
Move(my_window->RPort, 104,152);Text(my_window->RPort,"ñèèèó",5);
SetAPen(my_window->RPort,6);Move(my_window->RPort, 128,144);
Text(my_window->RPort,"â",1);SetAPen(my_window->RPort,7);
Move(my_window->RPort, 152,200);Text(my_window->RPort,"ïïïïï",5);
SetBPen(my_window->RPort,2);Text(my_window->RPort,"ï",1);
SetBPen(my_window->RPort,8);Text(my_window->RPort,"ïïïïïï",6);
SetBPen(my_window->RPort,2);Text(my_window->RPort,"ï",1);
SetBPen(my_window->RPort,8);Text(my_window->RPort,"ïïïïï",5);
Move(my_window->RPort, 80,200);Text(my_window->RPort,"åè",2);
Move(my_window->RPort, 88,192);Text(my_window->RPort,"å",1);
SetAPen(my_window->RPort,2);Move(my_window->RPort, 192,192);
Text(my_window->RPort,"ô",1);Move(my_window->RPort, 248,192);
Text(my_window->RPort,"ô",1);SetAPen(my_window->RPort,4);
Move(my_window->RPort, 192,184);Text(my_window->RPort,"ò",1);
SetAPen(my_window->RPort,12);Move(my_window->RPort, 248,184);
Text(my_window->RPort,"ò",1);break;}

case 3: {SetAPen(my_window->RPort,5); SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ûûûûûûûû",8);SetAPen(my_window->RPort,4);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîî",24);
SetAPen(my_window->RPort,2);Move(my_window->RPort,120,200);
Text(my_window->RPort,"Ñ  â",4);SetAPen(my_window->RPort,1);
SetBPen(my_window->RPort,7);Move(my_window->RPort,120,192);
Text(my_window->RPort,"WOOD",4);Move(my_window->RPort,120,184);
Text(my_window->RPort,"ALEX",4);K1=15;K2=27;
DrawAlex(11,13,K1,20);DrawAlex(10,7,K2,20);
break;}

case 4: {SetAPen(my_window->RPort,12); SetBPen(my_window->RPort,14);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî",32);
SetAPen(my_window->RPort,10);
SetBPen(my_window->RPort,8);Move(my_window->RPort,64,200);
Text(my_window->RPort,"ô",1);Move(my_window->RPort,80,200);
Text(my_window->RPort,"ô",1);Move(my_window->RPort,120,200);
Text(my_window->RPort,"ô",1);Move(my_window->RPort,160,200);
Text(my_window->RPort,"ô",1);Move(my_window->RPort,280,200);
Text(my_window->RPort,"ôô",2);Move(my_window->RPort,64,192);
Text(my_window->RPort,"ô",1);Move(my_window->RPort,80,192);
Text(my_window->RPort,"ô",1);Move(my_window->RPort,120,192);
Text(my_window->RPort,"ô",1);Move(my_window->RPort,160,192);
Text(my_window->RPort,"ô",1);Move(my_window->RPort,280,192);
Text(my_window->RPort,"ôô",2);SetAPen(my_window->RPort,12);
Move(my_window->RPort,64,186);Text(my_window->RPort,"ò",1);
Move(my_window->RPort,160,186);Text(my_window->RPort,"ò",1);
Move(my_window->RPort,280,186);Text(my_window->RPort,"ò",1);
SetAPen(my_window->RPort,4);Move(my_window->RPort,80,186);
Text(my_window->RPort,"ò",1);Move(my_window->RPort,120,186);
Text(my_window->RPort,"ò",1);Move(my_window->RPort,288,186);
Text(my_window->RPort,"ò",1);break;}

case 5: {SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,5);
Text(my_window->RPort,"íííííííííííííííííííííííííííííííí",32);
SetAPen(my_window->RPort,11);SetBPen(my_window->RPort,8);
Move(my_window->RPort,96,200);Text(my_window->RPort,"è",1);
Move(my_window->RPort,96,192);Text(my_window->RPort,"ö",1);
SetAPen(my_window->RPort,1);SetBPen(my_window->RPort,2);
Move(my_window->RPort,184,200);Text(my_window->RPort,"èè  èè",6);
Move(my_window->RPort,184,192);Text(my_window->RPort,"èè",2);
SetAPen(my_window->RPort,2);SetBPen(my_window->RPort,1);
Move(my_window->RPort,200,192);Text(my_window->RPort,"ñó  ",4);
SetAPen(my_window->RPort,1);SetBPen(my_window->RPort,5);
Move(my_window->RPort,184,184);Text(my_window->RPort,"èèèèèè",6);
Move(my_window->RPort,184,176);Text(my_window->RPort,"èùèèùè",6);
Move(my_window->RPort,184,168);Text(my_window->RPort,"èèèèèè",6);
SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,8);
Move(my_window->RPort,184,160);Text(my_window->RPort,"ñèèèèó",6);
Move(my_window->RPort,192,152);Text(my_window->RPort,"ñèèó",4);
Move(my_window->RPort,200,144);Text(my_window->RPort,"ñó",2);
 BI=7;break;}

case 6:
{AreaShow(2);SetAPen(my_window->RPort,2);SetBPen(my_window->RPort,6);
Text(my_window->RPort,"ììììììììì",9);Move(my_window->RPort,176,208);
Text(my_window->RPort,"ììììììììììììììì",15);SetAPen(my_window->RPort,7);
SetBPen(my_window->RPort,8);Move(my_window->RPort,40,200);
Text(my_window->RPort,"ÑÑÑÑÑÑÑÑ",8);
Move(my_window->RPort,176,200);
Text(my_window->RPort,"ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ",15);
Move(my_window->RPort,40,192);
Text(my_window->RPort,"ããããããããá",9);
Move(my_window->RPort,176,192);
Text(my_window->RPort,"ããããããããããããããã",15);
A=18;break;}

case 7:{SetAPen(my_window->RPort,8);SetBPen(my_window->RPort,7);
Text(my_window->RPort,"ìììììììììììììììììììììììììììììììì",32);
Move(my_window->RPort,40,216);
Text(my_window->RPort,"ìììììììììììììììììììììììììììììììì",32);
SetAPen(my_window->RPort,5);SetBPen(my_window->RPort,8);
Move(my_window->RPort,112,200);Text(my_window->RPort,"î",1);
SetAPen(my_window->RPort,4);Text(my_window->RPort,"è",1);
SetAPen(my_window->RPort,5);Text(my_window->RPort,"îîî",3);
SetAPen(my_window->RPort,13);Move(my_window->RPort,168,200);
Text(my_window->RPort,"îîîî",4);SetAPen(my_window->RPort,6);
Text(my_window->RPort,"è",1);SetAPen(my_window->RPort,13);
Text(my_window->RPort,"îîî",3);SetAPen(my_window->RPort,5);
Move(my_window->RPort,112,192);
Text(my_window->RPort,"î",1);SetAPen(my_window->RPort,4);
Text(my_window->RPort,"ù",1);SetAPen(my_window->RPort,5);
Text(my_window->RPort,"îîî",3);SetAPen(my_window->RPort,13);
Move(my_window->RPort,168,192);Text(my_window->RPort,"îîîî",4);
SetAPen(my_window->RPort,6);Text(my_window->RPort,"ù",1);
SetAPen(my_window->RPort,13);Text(my_window->RPort,"îîî",3);
SetAPen(my_window->RPort,5);Move(my_window->RPort,112,184);
Text(my_window->RPort,"îîîîî",5);SetAPen(my_window->RPort,13);
Move(my_window->RPort,168,184);Text(my_window->RPort,"îîîîîîîî",8);
SetAPen(my_window->RPort,14);Move(my_window->RPort,104,176);
Text(my_window->RPort,"Ñ",1);SetAPen(my_window->RPort,10);
SetBPen(my_window->RPort,14);Text(my_window->RPort,"PAULS",5);
SetAPen(my_window->RPort,14);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"â",1);SetAPen(my_window->RPort,13);
SetBPen(my_window->RPort,9);Move(my_window->RPort,168,176);
Text(my_window->RPort,"KWIKMART",8);break; }

case 8: {SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"îîîîîîîî",8);SetAPen(my_window->RPort,11);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîî",24);
SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,2);
Move(my_window->RPort,104,144);
Text(my_window->RPort,"INSTAROLL CARPET FITTERS",24);
Move(my_window->RPort,104,152);
Text(my_window->RPort,"èèèèèèèèèèèèèèèèèèèèèèèè",24);
SetAPen(my_window->RPort,2);SetBPen(my_window->RPort,7);
Move(my_window->RPort,104,136);
Text(my_window->RPort,"ãããããããããããããããããããããããã",24);
 C=2;break;}

case 9: {SetAPen(my_window->RPort,3);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî",32);
SetAPen(my_window->RPort,0);SetBPen(my_window->RPort,15);
Move(my_window->RPort,112,112);Text(my_window->RPort,"CARPET",6);
Move(my_window->RPort,112,120);Text(my_window->RPort,"STORES",6);
SetAPen(my_window->RPort,2);SetBPen(my_window->RPort,8);
Move(my_window->RPort,64,40);Text(my_window->RPort,"ÇÇÇÇ",4);
SetAPen(my_window->RPort,4);
Move(my_window->RPort,112,40);Text(my_window->RPort,"ÇÇÇÇÇ",5);
SetAPen(my_window->RPort,6);
Move(my_window->RPort,160,40);Text(my_window->RPort,"ÇÇÇÇÇ",5);
SetAPen(my_window->RPort,5);
Move(my_window->RPort,216,40);Text(my_window->RPort,"ÇÇÇÇÇ",5);
 ZZZ=1;break;}

case 10: {SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇ",18);
Move(my_window->RPort,264,208);Text(my_window->RPort,"ÇÇÇÇ",4);
SetAPen(my_window->RPort,14);
Move(my_window->RPort,112,176);Text(my_window->RPort,"ñ",1);
SetBPen(my_window->RPort,10);Text(my_window->RPort,"ó    ",5);
SetAPen(my_window->RPort,10);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ó",1);
SetAPen(my_window->RPort,14);SetBPen(my_window->RPort,13);
Move(my_window->RPort,112,184);Text(my_window->RPort,"äÜ",2);
SetAPen(my_window->RPort,6);Text(my_window->RPort,"èèèèè",5);
SetAPen(my_window->RPort,14);Move(my_window->RPort,112,184);
Text(my_window->RPort,"éå",2);SetAPen(my_window->RPort,6);
Text(my_window->RPort,"èèèèè",5);SetAPen(my_window->RPort,14);
Move(my_window->RPort,112,192);Text(my_window->RPort,"èè",2);
SetAPen(my_window->RPort,6);Text(my_window->RPort,"èèèèè",5);
SetAPen(my_window->RPort,14);
Move(my_window->RPort,112,200);Text(my_window->RPort,"èè",2);
SetAPen(my_window->RPort,6);Text(my_window->RPort,"èèèèè",5);
A=20;break;}

case 11: {AreaShow(3);
SetAPen(my_window->RPort,5);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ûûûûûûûûûûûûûûûûû",17);
SetAPen(my_window->RPort,0);SetBPen(my_window->RPort,7);
Text(my_window->RPort,"ûûûûûûûûûûûûû",13);
SetAPen(my_window->RPort,5);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ûû",2);
SetAPen(my_window->RPort,2);Move(my_window->RPort,104,200);
Text(my_window->RPort,"Ñâ",2);SetAPen(my_window->RPort,4);
Move(my_window->RPort,96,192);Text(my_window->RPort,"ñèèó",4);
Move(my_window->RPort,96,184);Text(my_window->RPort,"ñèèó",4);
Move(my_window->RPort,96,176);Text(my_window->RPort,"ñèèó",4);
Move(my_window->RPort,104,168);Text(my_window->RPort,"ñó",2);
SetAPen(my_window->RPort,15);SetBPen(my_window->RPort,2);
Move(my_window->RPort,160,144);
Text(my_window->RPort,"DANGER ROADWORKS",16); break;}

case 12: {SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî",32);
SetAPen(my_window->RPort,2);Move(my_window->RPort,160,200);
Text(my_window->RPort,"èè",2);Move(my_window->RPort,160,192);
Text(my_window->RPort,"èè",2);
SetAPen(my_window->RPort,8);SetBPen(my_window->RPort,7);
Move(my_window->RPort,144,176);Text(my_window->RPort," ALEX ",6);
SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ó",1);
SetAPen(my_window->RPort,8);SetBPen(my_window->RPort,7);
Move(my_window->RPort,144,184);Text(my_window->RPort,"SCHOOLñ",7);
break;}
case 13: {SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî",32);
SetAPen(my_window->RPort,5);
Move(my_window->RPort,152,200);Text(my_window->RPort,"èèèè  èèèè",10);
Move(my_window->RPort,152,192);Text(my_window->RPort,"èèèè  èèèè",10);
Move(my_window->RPort,152,184);Text(my_window->RPort,"èèèèèèèèè",9);
SetAPen(my_window->RPort,3);SetBPen(my_window->RPort,5);
Text(my_window->RPort,"ì",1);Move(my_window->RPort,152,176);
Text(my_window->RPort,"  ì       ",10);
SetAPen(my_window->RPort,6);SetBPen(my_window->RPort,8);
Move(my_window->RPort,152,168);Text(my_window->RPort,"ñèèèèèèèèó",10);
Move(my_window->RPort,160,160);Text(my_window->RPort,"ñ",1);
SetAPen(my_window->RPort,8);SetBPen(my_window->RPort,6);
Text(my_window->RPort,"SCHOOL",6);SetAPen(my_window->RPort,6);
SetBPen(my_window->RPort,8);Text(my_window->RPort,"ó",1);
Move(my_window->RPort,168,152);Text(my_window->RPort,"ñ",1);
SetAPen(my_window->RPort,8);SetBPen(my_window->RPort,6);
Text(my_window->RPort,"ALEX",4);SetAPen(my_window->RPort,6);
SetBPen(my_window->RPort,8);Text(my_window->RPort,"ó",1);
Move(my_window->RPort,176,144);Text(my_window->RPort,"ñèèó",4);
Move(my_window->RPort,184,136);Text(my_window->RPort,"ñó",2);
KO1=12;KO2=10;KO3=8;
DrawAlex(6,11,KO1,20);DrawAlex(6,12,KO2,20);DrawAlex(6,7,KO3,20);
break;}

case 14:{SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî",32);
SetAPen(my_window->RPort,7);Move(my_window->RPort,80,200);
Text(my_window->RPort,"èè",2);Move(my_window->RPort,80,192);
Text(my_window->RPort,"èè",2);Move(my_window->RPort,80,192);
Text(my_window->RPort,"ñó",2);Move(my_window->RPort,144,200);
Text(my_window->RPort,"Ñâ  è",5);Move(my_window->RPort,144,192);
Text(my_window->RPort,"Ñâ  è",5);Move(my_window->RPort,136,184);
Text(my_window->RPort,"Ñèèâèèè",7);Move(my_window->RPort,144,176);
Text(my_window->RPort,"Ñâ",2);Move(my_window->RPort,176,176);
Text(my_window->RPort,"è",1);GB=17;
for (GA=16;GA>7;GA--){DrawAlex(7,7,GB,GA);
Delay(2);Move (my_window->RPort,GB*8+40,GA*8+40);Text(my_window->RPort," ",1);}
break;}

case 15:{SetAPen(my_window->RPort,5);SetBPen(my_window->RPort,7);
Text(my_window->RPort,"íííííííííííííííííííííííííííííííí",32);
SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,8);
Move (my_window->RPort,176,200);Text(my_window->RPort,"Ñ",1);
Move (my_window->RPort,192,200);Text(my_window->RPort,"ïïïï",4);
SetBPen(my_window->RPort,2);Text(my_window->RPort,"ï",1);
SetBPen(my_window->RPort,8);Text(my_window->RPort,"ïïïïïïïï",8);
Move (my_window->RPort,176,192);Text(my_window->RPort,"ú",1);
Move (my_window->RPort,176,184);Text(my_window->RPort,"ú",1);
SetAPen(my_window->RPort,14);Move (my_window->RPort,176,176);
Text(my_window->RPort,"õ",1);SetAPen(my_window->RPort,2);
Move (my_window->RPort,224,192);Text(my_window->RPort,"ô",1);
SetAPen(my_window->RPort,4);
Move (my_window->RPort,224,184);Text(my_window->RPort,"ò",1);
SetAPen(my_window->RPort,5);SetBPen(my_window->RPort,2);
Move (my_window->RPort,80,200);Text(my_window->RPort,"ííííí",5);
Move (my_window->RPort,80,192);Text(my_window->RPort,"ííííí",5);
Move (my_window->RPort,80,184);Text(my_window->RPort,"ííííí",5);
Move (my_window->RPort,80,176);Text(my_window->RPort,"ííííí",5);
SetAPen(my_window->RPort,6);Move (my_window->RPort,80,168);
Text(my_window->RPort,"PHONE",5);Move (my_window->RPort,80,160);
Text(my_window->RPort,"     ",5);Move (my_window->RPort,64,184);
SetBPen(my_window->RPort,8);Text(my_window->RPort," ",1);
break;}

case 16:{AreaShow(4);
SetAPen(my_window->RPort,11);SetBPen(my_window->RPort,15);
Text(my_window->RPort,"ìììììììììììììììììììììììììììììììì",32);
SetAPen(my_window->RPort,14);Move (my_window->RPort,96,200);
Text(my_window->RPort,"èè",2);SetAPen(my_window->RPort,10);
Text(my_window->RPort,"è",1);SetAPen(my_window->RPort,14);
Text(my_window->RPort,"èèèèè",5);Move (my_window->RPort,96,192);
Text(my_window->RPort,"èè",2);SetAPen(my_window->RPort,10);
Text(my_window->RPort,"è",1);SetAPen(my_window->RPort,14);
Text(my_window->RPort,"èèèèè",5);Move (my_window->RPort,96,184);
Text(my_window->RPort,"èè",2);SetAPen(my_window->RPort,10);
SetBPen(my_window->RPort,13);Text(my_window->RPort,"ù",1);
SetAPen(my_window->RPort,14);SetBPen(my_window->RPort,14);
Text(my_window->RPort,"è",1);SetAPen(my_window->RPort,13);
Text(my_window->RPort,"í í ",4);SetAPen(my_window->RPort,14);
Move (my_window->RPort,96,176);Text(my_window->RPort,"èèèèèèèè",8);
SetAPen(my_window->RPort,10);SetBPen(my_window->RPort,8);
Move (my_window->RPort,96,168);Text(my_window->RPort,"ñèèèèèèó",8);
SetAPen(my_window->RPort,13);Move (my_window->RPort,136,160);
Text(my_window->RPort,"è",1);Move (my_window->RPort,136,152);
Text(my_window->RPort,"è",1);
break;}

case 17:{ SetAPen(my_window->RPort,6);SetBPen(my_window->RPort,4);
Text(my_window->RPort,"íííííííííííííííííííííííííííííííí",32);
SetAPen(my_window->RPort,2);SetBPen(my_window->RPort,6);
for (GB=18;GB>-1;GB--) {Move (my_window->RPort,40,GB*8+40);
Text(my_window->RPort,"ìììììììììììììììììììììììììììììììì",32);}
Move (my_window->RPort,96,80);
Text(my_window->RPort,"IìLUVìALEX",10);
Move (my_window->RPort,48,128);Text(my_window->RPort,"PHìWOZ",6);
Move (my_window->RPort,56,136);Text(my_window->RPort,"ERE!",4);
Move (my_window->RPort,152,112);Text(my_window->RPort,"JKì4ìBD",7);
Move (my_window->RPort,104,168);Text(my_window->RPort,"YOìIìRULE",9);
SetAPen(my_window->RPort,1);SetBPen(my_window->RPort,15);
Move (my_window->RPort,192,136);Text(my_window->RPort,"CIRCUS",6);
SetAPen(my_window->RPort,2);Move (my_window->RPort,192,144);
Text(my_window->RPort,"COMING",6);SetAPen(my_window->RPort,3);
Move (my_window->RPort,192,152);Text(my_window->RPort,"*SOON*",6);
SetAPen(my_window->RPort,4);Move (my_window->RPort,192,160);
Text(my_window->RPort,"   ê  ",6);SetAPen(my_window->RPort,5);
Move (my_window->RPort,192,168);Text(my_window->RPort,".    .",6);
A=20;break;}

case 18:{ SetAPen(my_window->RPort,12);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî",32);
SetAPen(my_window->RPort,7);Move (my_window->RPort,80,200);
Text(my_window->RPort,"Ñ     â",7);Move (my_window->RPort,80,192);
Text(my_window->RPort,"Ñ",1);SetAPen(my_window->RPort,5);
Text(my_window->RPort,"Ééãåá",5);
SetAPen(my_window->RPort,7);Text(my_window->RPort,"â",1);
Move (my_window->RPort,80,184);Text(my_window->RPort,"Ñ ",2);
SetAPen(my_window->RPort,6);Text(my_window->RPort,"â Ñ",3);
SetAPen(my_window->RPort,7);Text(my_window->RPort," â",2);
Move (my_window->RPort,80,176);Text(my_window->RPort,"ÑÇäÇÜÇâ",7);
SetAPen(my_window->RPort,3);Move (my_window->RPort,152,200);
Text(my_window->RPort,"è   ",4);SetAPen(my_window->RPort,8);
SetBPen(my_window->RPort,3);Text(my_window->RPort,"ó",1);
SetAPen(my_window->RPort,3);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ó",1);Move (my_window->RPort,152,192);
Text(my_window->RPort,"è  ",3);SetAPen(my_window->RPort,8);
SetBPen(my_window->RPort,3);Text(my_window->RPort,"ó",1);
SetAPen(my_window->RPort,3);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ó",1);Move (my_window->RPort,152,184);
Text(my_window->RPort,"è ",2);SetAPen(my_window->RPort,8);
SetBPen(my_window->RPort,3);Text(my_window->RPort,"ó",1);
SetAPen(my_window->RPort,3);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ó",1);Move (my_window->RPort,152,176);
Text(my_window->RPort,"è",1);SetAPen(my_window->RPort,8);
SetBPen(my_window->RPort,3);Text(my_window->RPort,"ó",1);
SetAPen(my_window->RPort,3);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ó",1);Move (my_window->RPort,152,168);
Text(my_window->RPort,"èó",2);SetAPen(my_window->RPort,2);
Move (my_window->RPort,240,200);Text(my_window->RPort,"Ñ  â",4);
SetAPen(my_window->RPort,1);SetBPen(my_window->RPort,15);
Move (my_window->RPort,240,192);Text(my_window->RPort,"PARK",4);
Move (my_window->RPort,240,184);Text(my_window->RPort,"ALEX",4);
SetBPen(my_window->RPort,0);Move (my_window->RPort,200,208);
Text(my_window->RPort,"  ",2);break;}

case 19:{ SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî",32);
SetAPen(my_window->RPort,2);Move (my_window->RPort,264,200);
Text(my_window->RPort,"è",1);Move (my_window->RPort,264,192);
Text(my_window->RPort,"ö",1);SetAPen(my_window->RPort,5);
Move (my_window->RPort,128,40);Text(my_window->RPort,"í",1);
SetAPen(my_window->RPort,2);SetBPen(my_window->RPort,6);
for (GB=20;GB>10;GB--) {Move (my_window->RPort,160,GB*8+40);
Text(my_window->RPort,"ì",1);}SetAPen(my_window->RPort,4);
SetBPen(my_window->RPort,8);Move (my_window->RPort,104,200);
Text(my_window->RPort,"è",1);Move (my_window->RPort,80,192);
Text(my_window->RPort,"èèèèèèè",7);Move (my_window->RPort,104,184);
Text(my_window->RPort,"ã",1);break;}

case 20:{ SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"îîî",3);SetAPen(my_window->RPort,3);
Text(my_window->RPort,"îîî",3);SetAPen(my_window->RPort,4);
Text(my_window->RPort,"îîî",3);SetAPen(my_window->RPort,3);
Text(my_window->RPort,"îî",2);SetAPen(my_window->RPort,4);
Text(my_window->RPort,"î",1);SetAPen(my_window->RPort,3);
Text(my_window->RPort,"î",1);SetAPen(my_window->RPort,4);
Text(my_window->RPort,"îîîîî",5);SetAPen(my_window->RPort,3);
Text(my_window->RPort,"îî",2);SetAPen(my_window->RPort,4);
Text(my_window->RPort,"îîîîî",5);SetAPen(my_window->RPort,3);
Text(my_window->RPort,"îîî",3);SetAPen(my_window->RPort,4);
Text(my_window->RPort,"îîîî",4);SetAPen(my_window->RPort,6);
SetBPen(my_window->RPort,1);Move (my_window->RPort,88,40);
Text(my_window->RPort,"KEEP OFF THE GRASS",18);FLASH=TRUE;break;}

case 21:{ AreaShow(5);SetAPen(my_window->RPort,10);
SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇÇ",22);
SetAPen(my_window->RPort,15);Text(my_window->RPort,"ÇÇÇÇÇÇ",6);
SetAPen(my_window->RPort,10);Text(my_window->RPort,"ÇÇÇÇ",4);
SetAPen(my_window->RPort,10);Move (my_window->RPort,176,200);
Text(my_window->RPort,"Ñâ",2);SetAPen(my_window->RPort,11);
SetBPen(my_window->RPort,15);Move (my_window->RPort,176,192);
Text(my_window->RPort,"M4",2);SetAPen(my_window->RPort,8);
Text(my_window->RPort,"ñ",1);SetAPen(my_window->RPort,11);
Move (my_window->RPort,176,184);Text(my_window->RPort,"TO",2);
SetAPen(my_window->RPort,15);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"ó",1);break;}

case 22: {SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"èèèèèèèèèèèèèèèèèèèèèèèèèèèèèèèè",32);CAR=15;
Car();break;}

case 23: {SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,8);
Text(my_window->RPort,"îîîîîîîîîîîîîîîîîîîîîîîîîîîîîîîî",32);
for (GB=20;GB>16;GB--) {SetAPen(my_window->RPort,10);
Move (my_window->RPort,88,GB*8+40);Text(my_window->RPort,"è",1);
SetAPen(my_window->RPort,13);Text(my_window->RPort,"ûûûûûûûû",8);
SetAPen(my_window->RPort,10);Text(my_window->RPort,"è",1);}
Move (my_window->RPort,88,GB*8+40);Text(my_window->RPort,"èèè",3);
SetAPen(my_window->RPort,15);SetBPen(my_window->RPort,10);
Text(my_window->RPort,"FIRE",4);SetAPen(my_window->RPort,10);SetBPen(my_window->RPort,8);Text(my_window->RPort,"èèè",3);
Move (my_window->RPort,88,(GB-1)*8+40);
Text(my_window->RPort,"ãããããããããã",10);K2=18;KO2=0;DrawAlex(2,3,K2,20);
break;}
   }

  }

}
