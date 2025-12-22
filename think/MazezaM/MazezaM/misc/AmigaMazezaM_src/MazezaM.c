/*  ***********************
    *******         *******
    ******* MazezaM *******
    *******         *******
    ***********************

  Amiga Version (C) 2003-2004
      Ventzislav Tzvetkov
     drHirudo@Amigascne.org

  Based on the Sinclair Version
      by  Malcolm  Tyrrell
       tyrrelmr@cs.tcd.ie

     This code may be used
     and distributed under
     the terms of the GNU
     General Public Licence.

   Compile with: vc 610.4.asm MazezaM.c -lauto -o //MazezaM
*/

#include <stdio.h>

#include <intuition/intuition.h>

#include <hardware/custom.h>  /* These twos  are  for  */
#include <hardware/cia.h>    /*  the Joystick handler */

/* The Game uses dirty hardware access to read the Joystick positions  */
/* For speed. If this doesn't work under newer AmigaOS releases I will */
/* Change it. For now it will stuck. Look at the Joystick() function   */
/* For more information, how to adapt it for other platforms.          */

#include "MazezaM.h"

#include <libraries/asl.h> /* For the ScreenMode Requester */

#define LEVELS 10      /* Easily extended. */

extern void TitleMusic();

BOOL close=FALSE,TitleBool=FALSE,Music=1,ReplayFlag=0;
UWORD w,h,l,t,r,rx,lx,mazeno,lives,i,j,BlockX=0,BlockY=16,loop,Line,Man,Brick;
char *a[28],b[28][28]; /* 28 * 28 cells max level size right now, but easily extended */

ULONG CheckClass;
UWORD CheckCode;

UWORD Frame[]={96,88,96,104,121,129,121,113,48,40,48,56,64,80,64,72,136,144,152,160,168,176};
UWORD Posis[]={0,160,168,176,168,136,144,152,144,232,0,8,16,24,32,0,64,0,208,216,224};
void ClipMan(UWORD Frame){
ClipBlit( &my_rast_port, Frame, 0, my_window->RPort, 160, 120, 8,8, 0xC0 );
}

UBYTE Joystick()  /* Returns Joystick position and/or firebutton press */
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

void Title() {
if (ReplayFlag) if (Music) {StopPlayer();}
if (Music) StartSong(0);
Man=0;
WaitTOF();
LoadRGB32(&my_screen->ViewPort,BlackRGB32);
mazeno=1;lives=3;
SetRast(my_window->RPort,0);
SetAPen(my_window->RPort,7);
SetBPen(my_window->RPort,0);
Move(my_window->RPort,40,24);
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, 0, 0, 8,8, 0xC0 );
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, 8, 0, 8,8, 0xC0 );
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, 152, 0, 8,8, 0xC0 );
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, 160, 0, 8,8, 0xC0 );
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, 304, 0, 8,8, 0xC0 );
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, 312, 0, 8,8, 0xC0 );

for (i=8;i!=32;i+=8) for (rx=0;rx!=320;rx+=8) {
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, rx, i, 8, 8, 0xC0 );
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, rx, i+120, 8, 8, 0xC0 );
}

for (i=32;i!=128;i+=8) for (rx=0;rx!=56;rx+=8) {
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, rx, i, 8, 8, 0xC0 );
ClipBlit( &my_rast_port, 8, 8, my_window->RPort, 320-rx, i, 8, 8, 0xC0 );
}
for (rx=272;rx!=320;rx+=8)
ClipBlit( &my_rast_port, 88,8, my_window->RPort, rx, 120, 8,8, 0xC0 );
DrawImage(my_window->RPort,&MazezaMT,113,40);

SetAPen(my_window->RPort,28);
Move (my_window->RPort,73,75);
Text( my_window->RPort, "Amiga Version © 2003-04",23);
SetAPen(my_window->RPort, 9);
Move (my_window->RPort,77,89);
Text( my_window->RPort, "By Ventzislav Tzvetkov",22);
SetAPen(my_window->RPort,19);
RectFill(my_window->RPort,109,8,111,14);
RectFill(my_window->RPort,225,8,227,14);
SetAPen(my_window->RPort,15);
RectFill(my_window->RPort,76,16,76,23);
RectFill(my_window->RPort,77,15,252,24);
RectFill(my_window->RPort,253,16,253,23);

SetAPen(my_window->RPort, 6);
Move (my_window->RPort,77,22);
SetBPen(my_window->RPort,15);
Text( my_window->RPort, "http://drhirudo.hit.bg",22);
SetAPen(my_window->RPort,31);
RectFill(my_window->RPort,141,161,183,169);
SetAPen(my_window->RPort,20);
SetBPen(my_window->RPort,31);   
Move (my_window->RPort,144,168);Text( my_window->RPort, "KEYS:",5);
SetBPen(my_window->RPort,0);
Move (my_window->RPort,112,184);
Text (my_window->RPort, "Move = Arrows",13);
SetAPen(my_window->RPort,4);
Move (my_window->RPort,104,200);
Text (my_window->RPort, "RETRY LEVEL = r",15);
Move (my_window->RPort,104,208);
Text (my_window->RPort, "QUIT   GAME = q",15);
SetAPen(my_window->RPort,18);
Move (my_window->RPort,88,224);
Text (my_window->RPort, "Or use the Joystick",19);
SetAPen(my_window->RPort,15);Move (my_window->RPort,64,248);
Text (my_window->RPort, "Press Space/Fire to start",25);
ClipBlit( &my_rast_port, 0, 0, my_window->RPort, 160, 120, 8,8, 0xC0 );loop=0;Line=0;
LoadRGB32(&my_screen->ViewPort,MazezaMPaletteRGB32);
  /* Stay in the while loop until the end */
  while( close == FALSE )
  {
    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */

  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
    CheckClass=my_message->Class;
    CheckCode=my_message->Code;
    ReplyMsg( my_message ); /* Work done. Reply. */
     }

if(CheckClass == MENUPICK)
  {
   if(CheckCode == 63488) break; /* New Game */
    if (CheckCode == 63520){    /* About */
                      AutoRequest( my_window, &my_body_text, NULL,
                      &my_ok_text, NULL, NULL, 220, 102);}
    if (CheckCode == 63552) {close=TRUE;return;} /* Quit */    
   }
if(CheckClass == RAWKEY) {
    if (CheckCode==16 || CheckCode==69) {close=TRUE;return;}
    if (CheckCode==64) break;  /* Space Pressed */
    if (CheckCode==55) if (Music) {StopPlayer();Music=0;} else {Music=1;
   StartSong(0);}  /* M key Pressed */
    if (CheckCode==68) loop=249; /* Return Pressed */
}
CheckClass=0;
if (Joystick() & FIRE) break;

   WaitTOF();

  switch (Man) {
  
  case 0: ClipMan (0);break;
  case 100: ClipMan (8);break;
  case 130: ClipMan (0);break;
  case 160: ClipMan (16);break;
  case 190: ClipMan (0);break;
  case 211: ClipMan (24);break;
  case 228: ClipMan (0);break; 
  case 242: ClipMan (32);break;
  case 285: ClipMan (0);break;
  case 320: ClipMan (32);break;
  case 390: ClipMan (0);break;
  case 440: ClipMan (24);break;
  case 500: switch(rand()%6) {
    case 0: Man=100; break;
    case 1: Man=211; break;
    case 2: Man=160; break;
    case 3: Man=45; break;
    case 4: Man=320; break;
    default: Man=561;break;
     } break;
  case 580: ClipMan (232);break;
  case 600: Man=0;break;

  default: break;

}
if (++loop==250) {loop=0;
SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,58,108,271,116);
SetAPen(my_window->RPort,22);Brick=strlen(Talk1[Line]);
Move(my_window->RPort,165-(Brick<<2),114);
Text(my_window->RPort,Talk1[Line],Brick);
if (++Line==88) Line=0;}
  Man++;
 }
SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,58,108,271,116);
for (i=160,Man=0;i!=272;i++) {WaitTOF();
ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, i, 120, 7,8, 0xC0 );
  if (++Man==4) Man=0;
}

for (;i!=312;i++) {WaitTOF();
ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, i, 120, 7,8, 0xC0 );
 ClipBlit( &my_rast_port, 88, 15, my_window->RPort, i, 127, 2,1, 0xC0 );
  if (++Man==4) Man=0;
}

}

void ClipMan2(UWORD Frame){
ClipBlit( &my_rast_port, Frame, 0, my_window->RPort, 268, 118, 8,8, 0xC0 );
}

void Water() {          /* Water effect in the winning screen */
rx=ReadPixel(my_window->RPort,151,146);
lx=ReadPixel(my_window->RPort,151,147);
SetAPen(my_window->RPort,lx==15?20:22);
WritePixel(my_window->RPort,135,48);
ScrollRaster(my_window->RPort,-1,0,112,146,151,147);
SetAPen(my_window->RPort,rx);WritePixel(my_window->RPort,112,146);
SetAPen(my_window->RPort,lx);WritePixel(my_window->RPort,112,147);
SetAPen(my_window->RPort,0);
}

void Level(int mazenumber){
char *LevelName,NumberString[]={'0','0'};
Brick=((mazenumber-1)%10)*8;Man=0;
if (!ReplayFlag) if (Music) StopPlayer();WaitTOF();LoadRGB32(&my_screen->ViewPort,BlackRGB32);
SetRast(my_window->RPort,0);SetBPen(my_window->RPort,0);

switch (mazenumber)
   {
   case 1: LevelName="Humble Origins";w=7;h=2;
   lx=1;rx=1;a[1]=" #  #  ";a[2]=" #  $& ";break;

   case 2: LevelName="Easy Does It";w=8;h=3;
   lx=3;rx=2;a[1]="  #  $%&";a[2]="  # # # ";
   a[3]=" # # #  ";break;

   case 3: LevelName="Up, Up and Away";w=5;h=11;
   lx=11;rx=1;a[1]="  #  ";a[2]=" # $&";a[3]=" $&  ";
   a[4]="# #  ";a[5]=" # # ";a[6]=" $%& ";a[7]="# #  ";
   a[8]=" # # ";a[9]=" # # ";a[10]="# $& ";a[11]=" #   ";break;

   case 4: LevelName="To and Fro";w=13;h=6;lx=1;rx=1;
   a[1]="   $%%%&     ";a[2]="# $%%%&  $%& ";a[3]=" # $%& $%%&  ";
   a[4]="# #  $%%%%%& ";a[5]=" $%& #   $&  ";a[6]="# # # $&  #  ";
   break;

   case 5: LevelName="Loop-de-Loop";w=14;h=4;lx=2;rx=4;
   a[1]=" $%%%& $& $&  ";a[2]="   $&  $&  $& ";
   a[3]="$&  # $& $%&  ";a[4]="   $%%%%%%&  #";break;

   case 6: LevelName="Be Prepared";w=7;h=6;lx=5;rx=3;
   a[1]="   #   ";a[2]=" $%%&  ";a[3]=" $%& $&";
   a[4]=" # # # ";a[5]=" # $&  ";a[6]="# $&   ";break;

   case 7: LevelName="Two Front Doors";w=16;h=7;lx=1;rx=7;
   a[1]="       $%%%%%&  ";
   a[2]="  $%%& $%%& # # ";a[3]="$& $& $%%%%& # #";
   a[4]="$&     # #      ";a[5]="  $%%%%%%%%%%%& ";
   a[6]=" # $&    # $%&  ";a[7]="  #   $%&     $&";break;

   case 8: LevelName="Through and through";w=15;h=4;lx=3;rx=1;
   a[1]=" $%%&  $%%&  $&";a[2]=" # $& $& # $&  ";
   a[3]=" # $& $%%& $&  ";a[4]=" # $&  $%%&  # ";break;

   case 9: LevelName="Double Cross";w=9;h=7;lx=7;rx=3;
   a[1]=" #  $%%& ";a[2]=" #  # $& ";a[3]=" # $%%& #";
   a[4]="# $&  #  ";a[5]="  #   $%&";a[6]=" $%%%%&  ";
   a[7]="  #      ";break;

   case 10: LevelName="Inside Out";w=14;h=10;lx=8;rx=1;
   a[1]="            # ";a[2]=" $%%%%%%%%&  #";
   a[3]=" $%&       $& ";a[4]=" # $%%%%%%& # ";
   a[5]=" $%& $%&  $%& ";a[6]=" $%&   #  $%& ";
   a[7]=" # $%%%%%& $& ";a[8]=" # # #    $%& ";
   a[9]=" $%%%%%%%%%%& ";a[10]="              ";break;

default: /* No more Levels. Game Completed */
Brick=(rand()%10)*8;
ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, 96, 0, 8,8, 0xC0 );
ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, 104,0, 8,8, 0xC0 );

for (loop=8;loop!=256;loop+=8) for (i=0;i!=112;i+=8)
{ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, i, loop, 8,8, 0xC0 );}
Brick+=80;
for (i=0;i!=112;i+=8)
ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, i, 120, 8,8, 0xC0 );

for (;i!=152;i+=8) {
ClipBlit( &my_rast_port, 232, 8, my_window->RPort, i, 128, 8,8, 0xC0 );
ClipBlit( &my_rast_port, 208, 8, my_window->RPort, i, 144, 8,8, 0xC0 );
}
SetAPen(my_window->RPort,15);
RectFill(my_window->RPort,112,152,151,255);

for (loop=128;loop!=256;loop+=8) for (i=152;i!=320;i+=8)
ClipBlit( &my_rast_port, 216, 8, my_window->RPort, i, loop, 8,8, 0xC0 );
for (i=152;i!=320;i+=8)
ClipBlit( &my_rast_port, 168, 14, my_window->RPort, i, 126, 8,2, 0xC0 );
ClipBlit( &my_rast_port, 176, 8, my_window->RPort, 230, 120, 32,8, 0xC0 );
ClipBlit( &my_rast_port, 232, 16, my_window->RPort, 279,5, 8,8, 0xC0 );
ClipBlit( &my_rast_port, 232, 24, my_window->RPort,  287,5, 8,8, 0xC0 );

Move (my_window->RPort,173,33);SetAPen(my_window->RPort,6);
Text(my_window->RPort,"Congratulations",15);
Move (my_window->RPort,201,48);SetAPen(my_window->RPort,25);
Text(my_window->RPort,"You have",8);
Move (my_window->RPort,201,58);SetAPen(my_window->RPort,2);
Text( my_window->RPort, "escaped.",8);
SetAPen(my_window->RPort,5);RectFill(my_window->RPort,191,66,273,74);
SetAPen(my_window->RPort,20);Move (my_window->RPort,194,73);
SetBPen(my_window->RPort,5);Text( my_window->RPort, "WELL DONE!",10);
SetBPen(my_window->RPort,0);
SetAPen(my_window->RPort,22);WritePixel(my_window->RPort,135,48);
SetAPen(my_window->RPort,30);WritePixel(my_window->RPort,155,12);
SetAPen(my_window->RPort,23);WritePixel(my_window->RPort,194,15);
SetAPen(my_window->RPort,10);WritePixel(my_window->RPort,231,7);
SetAPen(my_window->RPort,13);WritePixel(my_window->RPort,296,43);
SetAPen(my_window->RPort,0);
if (Music) StartSong(mazeno);ReplayFlag=1;
LoadRGB32(&my_screen->ViewPort,MazezaMPaletteRGB32);
for (i=0;i!=112;i++) {
WaitTOF();
 ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, i,120 , 7,8, 0xC0 );
 ClipBlit( &my_rast_port, Brick, 15, my_window->RPort, i, 127, 2,1, 0xC0 );
if (++r%15==0) Water();if (++Man==4) Man=0;}
for (;i!=146;i++){WaitTOF();
 ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, i,120 , 7,8, 0xC0 );
if (++r%15==0) Water(); if (++Man==4) Man=0;}
WaitTOF();
 ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, i,119 , 7,8, 0xC0 );
 WritePixel(my_window->RPort,149,127);WritePixel(my_window->RPort,150,127);
 if (++Man==4) Man=0;i++;
 ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, i,118 , 7,8, 0xC0 );
 RectFill(my_window->RPort,147,126,152,126);
if (++r%15==0) Water(); if (++Man==4) Man=0;i++;
for (;i!=214;i++) {WaitTOF();
 ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, i,118 , 7,8, 0xC0 );
if (++r%15==0) Water(); if (++Man==4) Man=0;
}

for (j=117;j!=105;j--) {WaitTOF();
 ClipBlit( &my_rast_port, Frame[1], 0, my_window->RPort, i,j , 7,8, 0xC0 );
 RectFill(my_window->RPort,i+3,j+8,i+4,j+8);
if (++r%15==0) Water(); i++;
}
RectFill(my_window->RPort,i,j+7,i+6,j+8);
Move(my_window->RPort,218,96);SetAPen(my_window->RPort,15);
Text( my_window->RPort,"Hurray!",7);SetAPen(my_window->RPort,0);

for (;i!=257;i++)
{
 WaitTOF();
 ClipBlit( &my_rast_port, 224, 8, my_window->RPort, i,j , 8,7, 0xC0 );
 RectFill(my_window->RPort,i-1,j+1,i-1,j+6);if (++r%15==0) Water();
}
i--;
for (;i!=261;i++) {j++;WaitTOF();
 ClipBlit( &my_rast_port, 224, 16, my_window->RPort, i,j , 8,8, 0xC0 );
RectFill(my_window->RPort,i,j-1,i+3,j-1);if (++r%15==0) Water();
}

RectFill(my_window->RPort,218,90,270,97);

for (;i!=269;i++) {WaitTOF();
 ClipBlit( &my_rast_port, 224, 24, my_window->RPort, i,j , 8,7, 0xC0 );
 RectFill(my_window->RPort,i-1,j-1,i-1,j+3);
j++;if (++r%15==0) Water();}

ClipMan2 (0);loop=0;Line=0;

while (close == FALSE) {
  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
    CheckClass=my_message->Class;
    CheckCode=my_message->Code;
    ReplyMsg( my_message ); /* Work done. Reply. */
     }

if(CheckClass == MENUPICK)
  {
   if(CheckCode == 63488) break; /* New Game */
    if (CheckCode == 63520){          /* About */
                      AutoRequest( my_window, &my_body_text, NULL,
                      &my_ok_text, NULL, NULL, 220, 102);}
    if (CheckCode == 63552) {close=TRUE;return;} /* Quit */    
   }
if(CheckClass == RAWKEY) {
    if (CheckCode==16 || CheckCode==69) {close=TRUE;return;}
    if (CheckCode==64) break;  /* Space Pressed */
    if (CheckCode==55) if (Music) {StopPlayer();Music=0;} else {Music=1;
   StartSong(0);}  /* M key Pressed */
}
CheckClass=0;
if (Joystick() & FIRE) break;

   WaitTOF();

  switch (Man) {
  
  case 0: ClipMan2 (0);break;
  case 100: ClipMan2 (8);break;
  case 130: ClipMan2 (0);break;
  case 160: ClipMan2 (16);break;
  case 190: ClipMan2 (0);break;
  case 211: ClipMan2 (24);break;
  case 228: ClipMan2 (0);break; 
  case 242: ClipMan2 (32);break;
  case 285: ClipMan2 (0); break;
  case 320: ClipMan2 (32);break;
  case 390: ClipMan2 (0);break;
  case 440: ClipMan2 (24);break;
  case 500: switch(rand()%6) {
    case 0: Man=100; break;
    case 1: Man=211; break;
    case 2: Man=160; break;
    case 3: Man=45; break;
    case 4: Man=320; break;
    default: Man=561;break;
     } break;
  case 580: ClipMan2 (232);break;
  case 600: Man=0;break;

  default: break;

}
if (++r%15==0) Water();Man++;
if (++loop==250) {loop=0;
SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,217,104,319,112);
SetAPen(my_window->RPort,22);Brick=strlen(Talk2[Line]);
Move(my_window->RPort,272-(Brick<<2),110);
Text(my_window->RPort,Talk2[Line],Brick);
if (++Line==16) break;}
 }
Man=0;
SetAPen(my_window->RPort,0);
for (;i!=312;i++) {WaitTOF();
 ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, i,j , 8,8, 0xC0 );
 RectFill(my_window->RPort,i-1,j-1,i-1,j+3);
if (++Man==4) Man=0;}
TitleBool=TRUE;return;
}


for (i=1;i<h+1;i++) strcpy(&b[i][0],a[i]);
l=((40-w)/2)*8;t=(((32-h)/2)*8)+8;r=l+w*8;

ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, 0, 0, 8,8, 0xC0 );
ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, 8, 0, 8,8, 0xC0 );
NumberString[0]='0'+mazenumber/10;
NumberString[1]='0'+mazenumber%10;
SetAPen(my_window->RPort,10);
Move(my_window->RPort,36,6);
Text( my_window->RPort, "* ",2);
SetAPen(my_window->RPort,29);
Text( my_window->RPort,"LEVEL ",6);
Text( my_window->RPort,&NumberString,2);
SetAPen(my_window->RPort,10);
Text( my_window->RPort, " *",2);
ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, 152, 0, 8,8, 0xC0 );
ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, 160, 0, 8,8, 0xC0 );
NumberString[0]='0'+lives/10;
NumberString[1]='0'+lives%10;
Move(my_window->RPort,188,6);
Text( my_window->RPort, "* ",2);
SetAPen(my_window->RPort,9);
Text( my_window->RPort,"LIVES ",6);
Text( my_window->RPort,&NumberString,2);
SetAPen(my_window->RPort,10);
Text( my_window->RPort, " *",2);

ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, 304, 0, 8,8, 0xC0 );
ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, 312, 0, 8,8, 0xC0 );

for (i=8;i!=t;i+=8) for (j=0;j!=320;j+=8)
ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, j, i, 8,8, 0xC0 );
i-=8;
for (j=1;j<h+1;j++){
Line=i+j*8;
if (j==lx) for (loop=0;loop!=l;loop+=8)
ClipBlit(&my_rast_port,Brick+80,8,my_window->RPort, loop, Line, 8,8, 0xC0);
if (j!=lx) for (loop=0;loop!=l;loop+=8)
ClipBlit(&my_rast_port,Brick,8,my_window->RPort, loop, Line, 8,8, 0xC0);
for (loop=0;loop!=w;loop++) switch (b[j][loop]) {
case '#':
ClipBlit(&my_rast_port,BlockX,BlockY,my_window->RPort, loop*8+l, Line, 8,8, 0xC0);break;
case '$':
ClipBlit(&my_rast_port,BlockX+8,BlockY,my_window->RPort, loop*8+l, Line, 8,8, 0xC0);break;
case '%':
ClipBlit(&my_rast_port,BlockX+16,BlockY,my_window->RPort, loop*8+l, Line, 8,8, 0xC0);break;
case '&':
ClipBlit(&my_rast_port,BlockX+24,BlockY,my_window->RPort, loop*8+l, Line, 8,8, 0xC0);break;
default: break;
}

if (j==rx) for (loop=r;loop!=320;loop+=8)
ClipBlit(&my_rast_port,Brick+80,8,my_window->RPort, loop, Line, 8,8, 0xC0);
if (j!=rx) for (loop=r;loop!=320;loop+=8)
ClipBlit(&my_rast_port,Brick,8,my_window->RPort, loop, Line, 8,8, 0xC0);
BlockX+=32;if(BlockX==224){BlockX=0;if(BlockY==16)BlockY+=8; else BlockY-=8;}
}
for (i=t+h*8;i!=248;i+=8) for (j=0;j!=320;j+=8)
ClipBlit( &my_rast_port, Brick, 8, my_window->RPort, j, i, 8,8, 0xC0 );

j=strlen(LevelName);
i=136-(j/2)*8;
for (loop=0;loop!=i;loop+=8)
ClipBlit(&my_rast_port,Brick,8,my_window->RPort, loop, 248, 8,8, 0xC0);
 Move(my_window->RPort,i+8,254);
 SetAPen(my_window->RPort,1);Text(my_window->RPort, "* ",2);
 SetAPen(my_window->RPort,7);Text(my_window->RPort, LevelName,j);
 SetAPen(my_window->RPort,1);Text(my_window->RPort, " *",2);
 for (loop=320-i+((j%2)*8);loop!=320;loop+=8)
 ClipBlit(&my_rast_port,Brick,8,my_window->RPort, loop, 248, 8,8, 0xC0);
if (!ReplayFlag) if (Music) StartSong(mazeno);
LoadRGB32(&my_screen->ViewPort,MazezaMPaletteRGB32);
Brick+=80;j=(t-8)+lx*8;i=j+7;
for (loop=0;loop!=l;loop++){ 
WaitTOF();
 ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, loop, j, 7,8, 0xC0 );
 ClipBlit( &my_rast_port, Brick, 15, my_window->RPort, loop, i, 2,1, 0xC0 );
if (++Man==4) Man=0;
 }
WaitTOF();
ClipBlit( &my_rast_port, 0, 0, my_window->RPort, loop, j, 7,8, 0xC0 );
Delay(15);WaitTOF();
ClipBlit( &my_rast_port, 160, 11, my_window->RPort, loop-8, j, 8,4, 0xC0 );
WaitTOF();
ClipBlit( &my_rast_port, 32, 0, my_window->RPort, loop, j, 7,8, 0xC0 );
Delay(5);WaitTOF();
ClipBlit( &my_rast_port, 160, 8, my_window->RPort, loop-8, j, 8,7, 0xC0 );
Delay(30);WaitTOF();
ClipBlit( &my_rast_port, 0, 0, my_window->RPort, loop, j, 7,8, 0xC0 );
SetAPen(my_window->RPort,0);r--;i=lx;j=ReplayFlag=1;t-=8;
}

int main() /* No arguments */
{

int direction=0;

struct ScreenModeRequester *ScreenRequest;
ULONG ModeID;

/* Open the Intuition library: */
  IntuitionBase = (struct IntuitionBase *)
    OpenLibrary( "intuition.library", 0 );
  if( !IntuitionBase )
    exit(-1);
/* Open the Graphics library: */
  GfxBase = (struct GfxBase *)
    OpenLibrary( "graphics.library", 0 );
  if( !GfxBase )
  {
  CloseLibrary( IntuitionBase );
  exit(-1);    
  }
/* We will now try to open the screen: */
/* Random seed */
CurrentTime( &ModeID, &ModeID );
srand( (ULONG) ( ModeID)  );

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
 SA_Height, 256, SA_Depth, DEPTH,
 SA_Colors32, BlackRGB32,
 SA_Font,&my_font,
 SA_ShowTitle,FALSE,
 SA_Title,"MazezaM",
  TAG_DONE );

  if( !my_screen )
  {
   CloseLibrary( GfxBase );
   CloseLibrary( IntuitionBase );
   exit(-1);
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
   exit(-1);
  }

  /* Prepare spare BitMap: */
  InitBitMap( &my_bit_map, DEPTH, WIDTH, HEIGHT );

  /* Allocate memory for the Raster: */ 
  for( lx = 0; lx < DEPTH; lx++ )
  {
    my_bit_map.Planes[ lx ] = (PLANEPTR) AllocRaster( WIDTH, HEIGHT );
    if( my_bit_map.Planes[ lx ] == NULL ) close=TRUE;
  }

  if (!close)  {InitRastPort( &my_rast_port );
  my_rast_port.BitMap = &my_bit_map;
  DrawImage(&my_rast_port,&MazezaM_image,0,0); /* Set the graphics in the
                                                  spare RastPort.*/ }
if (!close) {SetMenuStrip( my_window, &my_menu );Title();}
if (!close) Level(mazeno);

  /* Stay in the while loop until the end */
  while( close == FALSE )
  {
/* Game here */
WaitTOF();
if (TitleBool) {Title();TitleBool=FALSE;if (!close) {ReplayFlag=0;Level(mazeno);} else break;}
    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */

  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   {
    CheckClass=my_message->Class;
    CheckCode=my_message->Code;
    ReplyMsg( my_message ); /* Work done. Reply. */
   }
if(CheckClass == MENUPICK){
    if (CheckCode == 63552) close=TRUE;
    if (CheckCode == 63520)
        {AutoRequest( my_window, &my_body_text, NULL,
         &my_ok_text, NULL, NULL, 220, 102);}
    if (CheckCode == 63488){lives=3;ReplayFlag=0;Level(mazeno=1);}
                          } /* New Game */

if(CheckClass == RAWKEY) {
    if (CheckCode==16 || CheckCode==69) {lives=0;direction=GAMEOVER;}
    if (CheckCode==78) direction=RIGHT;
    if (CheckCode==79) direction=LEFT;
    if (CheckCode==77) direction=DOWN;
    if (CheckCode==76) direction=UP;
    if (CheckCode==55) if (Music) {StopPlayer();Music=0;} else {Music=1;
   StartSong(mazeno);} /* M pressed */
#ifdef TESTVERSION
    if (CheckCode==64) {ReplayFlag=0;Level(++mazeno);}  /* Space Pressed */
#endif

    if (CheckCode==19) direction=DEAD;}
        

CheckClass=Joystick();

if (CheckClass & RIGHT ) direction=RIGHT;
if (CheckClass & LEFT  ) direction=LEFT;
if (CheckClass & DOWN  ) direction=DOWN;
if (CheckClass & UP    ) direction=UP;

CheckClass=0;

Line=t+i*8;

if (!direction) {WaitTOF();
ClipBlit( &my_rast_port, Posis[Man], 0, my_window->RPort, l+((j-1)*8), Line, 8,8, 0xC0 );
if (Man==1 || Man==5) {Man++;loop=25;}
if (Man==0) {loop=40;Man=10;}
loop++;
if (loop==39) {Man++;loop=25;if (Man==8 || Man==4) {Man=9;loop=0;}}
if (loop==19) Man=0;
if (loop==74) {Man=10+rand()%8; /* random pose */ loop=48;}
continue;
}

if (!loop) {WaitTOF();
ClipBlit( &my_rast_port, Posis[Man], 0, my_window->RPort, l+((j-1)*8), Line, 8,8, 0xC0 );}

if (direction==RIGHT && (i==rx && j==w)) {
for (loop=r-7,Man=0;loop!=r+1;loop++) {WaitTOF();
ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, loop, Line, 7,8, 0xC0 );
  if (++Man==4) Man=0;
}

for (;loop!=313;loop++) {WaitTOF();
ClipBlit( &my_rast_port,Frame[Man],0,my_window->RPort,loop,Line,7,8,0xC0 );
ClipBlit( &my_rast_port, Brick, 15, my_window->RPort, loop, Line+7, 2,1, 0xC0 );
  if (++Man==4) Man=0;
}
WaitTOF();
ClipBlit( &my_rast_port,Posis[0]+1,0,my_window->RPort,loop,Line,6,8,0xC0 );

SetAPen(my_window->RPort,15);SetBPen(my_window->RPort,5);
Line-=3;WaitTOF();
switch (rand()%11)
{
case 0: Move(my_window->RPort,264,Line);
         Text( my_window->RPort,"Hurray!",7);break;

case 1: Move(my_window->RPort,264,Line);
         Text( my_window->RPort,"Hurrah!",7);break;

case 2: Move(my_window->RPort,256,Line);
         Text( my_window->RPort,"Yes-Yes!",8);break;

case 3: Move(my_window->RPort,272,Line);
         Text( my_window->RPort,"Great!",6);break;

case 4: Move(my_window->RPort,256,Line);
         Text( my_window->RPort,"Yee-hah!",8);break;

case 5: Move(my_window->RPort,256,Line);
         Text( my_window->RPort,"Yay-yia!",8);break;

case 6: Move(my_window->RPort,264,Line);
         Text( my_window->RPort,"Yuppie!",7);break;

case 7: Move(my_window->RPort,256,Line);
         Text( my_window->RPort,"Success!",8);break;

case 8: Move(my_window->RPort,264,Line);
         Text( my_window->RPort,"SuperB!",7);break;

case 9: Move(my_window->RPort,264,Line);
         Text( my_window->RPort,"Groovy!",7);break;

default: Move(my_window->RPort,256,Line);
         Text( my_window->RPort,"Suppaah!",8);break;
   }
Delay(79);lives++;ReplayFlag=0;Level(++mazeno);
 direction=0;}

if (direction==RIGHT && j<w) if (b[i][j]==' '){

for (loop=l+((j-1)*8),Man=0;loop!=l+(j*8);loop++) {WaitTOF();
ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, loop, Line, 8,8, 0xC0 );
  if (++Man==4) Man=0;
}
j++;
Man=0;

} else

if (b[i][w-1]==' ') {
for (ModeID=w-1;ModeID>0;ModeID--) b[i][ModeID]=b[i][ModeID-1];
b[i][0]=' ';b[i][w]=0;ModeID=Line+7;

for (loop=l+((j-1)*8),Man=16;loop!=l+(j*8);loop++) {
ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, loop, Line, 8,8, 0xC0 );
WaitTOF();ScrollRaster(my_window->RPort,-1,0,l,Line,r,ModeID);
  if (++Man==19) Man=16;
}j++;Man=0;
} else Man=5;

if (direction==LEFT && j>1) if (b[i][j-2]==' '){
j--;
for (loop=l+(j*8),Man=4;loop!=l+((j-1)*8);loop--) {WaitTOF();
ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, loop, Line, 8,8, 0xC0 );
  if (++Man==8) Man=4;
} Man=0;
} else

if (b[i][0]==' ') {
for (ModeID=1;ModeID<w;ModeID++) b[i][ModeID-1]=b[i][ModeID];
b[i][w-1]=' ';j--;ModeID=Line+7;
for (loop=l+(j*8),Man=19;loop!=l+((j-1)*8);loop--) {
ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, loop, Line, 8,8, 0xC0 );
WaitTOF();ScrollRaster(my_window->RPort,1,0,l,Line,r,ModeID);
if (++Man==22) Man=19;
}Man=0;
} else Man=1;

if (direction==DOWN && i<h) if (b[i+1][j-1]==' '){

for (loop=Line+1,Man=8;loop!=Line+7;loop++) {WaitTOF();
ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, l+((j-1)*8), loop, 8,8, 0xC0 );
RectFill(my_window->RPort,l+((j-1)*8),loop-1,l+(j*8)-1,loop-1);
  if (++Man==12) Man=8;
}i++;RectFill(my_window->RPort,l+((j-1)*8),loop-1,l+(j*8)-1,loop);Man=0;
}

if (direction==UP && i>1) if (b[i-1][j-1]==' '){
for (loop=Line-1,Man=12;loop!=Line-8;loop--) {WaitTOF();
ClipBlit( &my_rast_port, Frame[Man], 0, my_window->RPort, l+((j-1)*8), loop, 8,8, 0xC0 );
RectFill(my_window->RPort,l+((j-1)*8),loop+8,l+(j*8)-1,loop+8);
  if (++Man==16) Man=12;
}RectFill(my_window->RPort,l+((j-1)*8),loop+8,l+(j*8)-1,loop+8);i--;Man=0;
}

if (direction==DEAD) {lives--;if (lives>0){
    SetAPen(my_window->RPort,4);SetBPen(my_window->RPort,5);
    Move(my_window->RPort,l+j*8-24,Line-8);
    Text( my_window->RPort, ARGH[rand()%9],5);WaitTOF();
    ClipBlit( &my_rast_port, 184, 0, my_window->RPort, l+((j-1)*8), Line, 8,8, 0xC0 );
    Delay(7);WaitTOF();
    ClipBlit( &my_rast_port, 192, 0, my_window->RPort, l+((j-1)*8), Line, 8,8, 0xC0 );
    Delay(7);WaitTOF();
    ClipBlit( &my_rast_port, 200, 0, my_window->RPort, l+((j-1)*8), Line, 8,8, 0xC0 );
    Delay(7);WaitTOF();
    Man=18;
    for (loop=0;loop!=25;loop++) {
    WaitTOF();
    ClipBlit( &my_rast_port, Posis[Man], 0, my_window->RPort, l+((j-1)*8), Line, 8,8, 0xC0 );
    if (++Man==21) Man=18;Delay(2);}
    Level(mazeno);}}

if (lives==0) {SetAPen(my_window->RPort,25);
SetBPen(my_window->RPort,31);
ClipBlit( &my_rast_port, 208, 0, my_window->RPort, l+((j-1)*8), Line, 8,8, 0xC0 );
Move(my_window->RPort,120,112);WaitTOF();Text( my_window->RPort, "GAME OVER!",10);
Move(my_window->RPort,252,6);SetAPen(my_window->RPort,9);
SetBPen(my_window->RPort,0);Text( my_window->RPort,"00",2);
if (Music) {StopPlayer();Delay(30);StartSong(LEVELS+2);}loop=0;
  while( close == FALSE )
  {
    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */

  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
    CheckClass=my_message->Class;
    CheckCode=my_message->Code;
    ReplyMsg( my_message ); /* Work done. Reply. */
     }

if(CheckClass == MENUPICK)
  {
   if(CheckCode == 63488) {lives=3;ReplayFlag=CheckClass=0;Level(mazeno=1);
                           break;} /* New Game */
    if (CheckCode == 63520){    /* About */
                      AutoRequest( my_window, &my_body_text, NULL,
                      &my_ok_text, NULL, NULL, 220, 102);}
    if (CheckCode == 63552) close=TRUE; /* Quit */
   }
if(CheckClass == RAWKEY) {
    if (CheckCode==16 || CheckCode==69) close=TRUE;
    if (CheckCode==64) {TitleBool=TRUE;break;}  /* Space Pressed */
    if (CheckCode==55) if (Music) {StopPlayer();Music=0;} else {Music=1;
   StartSong(LEVELS+2);}  /* M key Pressed */
    if (CheckCode==68) loop+=249; /* Return Pressed */
}
CheckClass=0;
if (Joystick() & FIRE) {TitleBool=TRUE;break;}

 WaitTOF();if (++loop>5000) {TitleBool=TRUE;break;}
    }
   }
direction=loop=0;
  }

LoadRGB32(&my_screen->ViewPort,BlackRGB32);

/* We should always close the screens we have opened before we leave: */

 for( ModeID = 0; ModeID < DEPTH; ModeID++ )
  if( my_bit_map.Planes[ ModeID ] )

  /* Free the spare RastPort: */
  FreeRaster( my_bit_map.Planes[ ModeID ], WIDTH, HEIGHT );

 ClearMenuStrip( my_window );
 if (Music) StopPlayer();
 CloseWindow ( my_window ); 

 CloseScreen( my_screen );
  
/* Close the Graphics Library since we have opened it: */
  CloseLibrary( GfxBase );

  /* Close the Intuition Library since we have opened it: */
  CloseLibrary( IntuitionBase );

  /* THE END */
exit(0);
}
