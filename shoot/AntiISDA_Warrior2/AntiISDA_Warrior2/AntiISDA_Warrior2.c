/* AntiISDA_Warrior 2 - Improved Amiga version
    by Ventzislav Tzvetkov
    http://drhirudo.hit.bg

 Compile with: vc AntiISDA_Warrior2.c -o AntiISDA_Warrior2

Version 1.1 - Now the Ships move. (13/11/2004)

Version 1.0 - First public playable version. (09/11/2004)

*/

#define DEPTH 3 /* Screen Depth - only up to 3 in Dual Playfield mode */

#include <intuition/intuition.h> /* I use system friendly code */

#include <hardware/custom.h> /* These twos  are  for  */
#include <hardware/cia.h>   /*  the Joystick handler */

#include <exec/memory.h>   /* Definitions of MEMF_ */

#include <graphics/gfxmacros.h> /* For the DrawCircle macros */

#include "AntiISDA_Warrior2.h" /* Graphics, Window, Requesters etc.. */

BOOL close=FALSE; /* Indicates if we are going to leave the game */

UWORD SubPosX,TorpedoY,DelayCount,DelayValue,ShipsCounter,ShipsY,ShipX[5],
      RightOffset,RightOffsetValues[4]={17,15,8,6},
      LeftOffset,  LeftOffsetValues[4]={5,3,2,1};

int DeltaShip[5], /* Contains the direction for the movement of the ships. */
    ShipNumber;   /* Specific for every level */

/* This will automatically be linked to the Custom structure: */
extern struct Custom custom;

/* This will automatically be linked to the CIA A (8520) chip: */
extern struct CIA ciaa;

main(){
static char version[]="$VER: V1.1 © 2004";

ULONG ModeID,class;
UWORD code;
UWORD TorpedoX[20],TorpedoColl; /* X coordinates and collided color . */
UBYTE Level,JoyStack,Direction,Ammo;
BOOL Shoot=FALSE,NewGame=FALSE;
char ShootsText[]="Shoots: n";

/* Open the Intuition library: */
  IntuitionBase = (struct IntuitionBase *)
    OpenLibrary( "intuition.library", 0 );
  if( !IntuitionBase ) exit(-1);
/* Open the Graphics library: */
  GfxBase = (struct GfxBase *)
    OpenLibrary( "graphics.library", 0 );
  if( !GfxBase ) {CloseLibrary( IntuitionBase ); exit(-2);}

/* Random seed */
CurrentTime( &ModeID, &ModeID );
srand( (ULONG) ( ModeID)  ); /* Nasty eh? */

/* We will now try to open the screen: */

 my_screen = (struct Screen *)
 OpenScreenTags( NULL, SA_DisplayID,LORES_KEY,/*ModeID,*/
 SA_Width,320, SA_Height, 256, SA_Depth, DEPTH,
 SA_Colors32, Black_PaletteRGB32, SA_ShowTitle,FALSE,
 SA_Font,&my_font, SA_Title,"AntiISDA Warrior 2",
 TAG_DONE );

  if( !my_screen )
  { CloseLibrary( GfxBase ); CloseLibrary( IntuitionBase ); exit(-3);}
 my_new_window.Screen = my_screen;
 my_window = (struct Window *) OpenWindow( &my_new_window );

if ( !my_window )
  {
    /* Could NOT open the Window! */
    /* Close the Intuition Library since we have opened it: */
   CloseScreen( my_screen ); /* Close libraries */
   CloseLibrary( GfxBase );   
   CloseLibrary( IntuitionBase ); exit(-4); }
/*
SetAPen(my_window->RPort,28);Move(my_window->RPort,124,80);
 Text(my_window->RPort,"Loading...",10); */

/* Allocate the second playfield's rasinfo, bitmap, and bitplane */
rinfo2 = (struct RasInfo *)
 AllocMem(sizeof(struct RasInfo), MEMF_PUBLIC | MEMF_CLEAR);
if ( rinfo2 != NULL )
    {
    /* Get a rastport, and set it up for rendering into bmap2 */
    rport2 = (struct RastPort *)
     AllocMem(sizeof(struct RastPort), MEMF_PUBLIC );
    if (rport2 != NULL )
        {
        bmap2 = (struct BitMap *)
         AllocMem(sizeof(struct BitMap), MEMF_PUBLIC | MEMF_CLEAR);
        if (bmap2 != NULL )
            {
            InitBitMap(bmap2, 2, my_screen->Width, my_screen->Height);

            /* extra playfield will use two bitplanes. */

for( DelayCount = 0; DelayCount != 2; DelayCount++ )
{ bmap2->Planes[ DelayCount ] = (PLANEPTR)
   AllocRaster( my_screen->Width, my_screen->Height );
if (bmap2->Planes[ DelayCount ] == NULL ) close=TRUE; }

            if (!close)
                {
                InitRastPort(rport2);
                rport2->BitMap = rinfo2->BitMap = bmap2;

                SetRast(rport2, 0);
		
                /*
		** Manhandle the viewport:
		** install second playfield and change modes
		*/


		ModeID = GetVPModeID(&my_screen->ViewPort);
		if( ModeID != INVALID_ID )
		    {
		    /* you can only play with the bits in the Modes field
		    ** if the upper half of the screen mode ID is zero!!!
		    */
		    if ( (ModeID & 0xFFFF0000L) == 0L )
		        {

		        Forbid();

		        /* Install rinfo for viewport's second playfield */
		        my_screen->ViewPort.RasInfo->Next = rinfo2;
		        my_screen->ViewPort.Modes |= DUALPF;

		        Permit();

		        /* Put viewport change into effect */
		        MakeScreen(my_screen);
		        RethinkDisplay();
	        	} else close=TRUE;
	    	} else close=TRUE;

	}
     } else close=TRUE;
    } else close=TRUE;
   } else close=TRUE;


SetRGB32(&my_screen->ViewPort, 9,0x00000000,0x00000000,0x00000000);
SetRGB32(&my_screen->ViewPort,10,0x00000000,0x00000000,0x00000000);


SetRast(my_window->RPort,0);
SetRast(rport2,0);

for (ModeID=20;ModeID!=256;ModeID++) {
        SetAPen(rport2,1);Move(rport2,0,ModeID);Draw(rport2,319,ModeID);
	SetAPen(rport2,2);ModeID++;
        Move(rport2,0,ModeID);Draw(rport2,319,ModeID);
   }


if (!close) TitleScreen();

if (!close) LevelScreen(Level=1);
Ammo=80; /* One torpedo less for the first game */

  /* Stay in the while loop until the end */
  while( close == FALSE )
  {
/* Game here */

if (++DelayCount==DelayValue) {

/* Ships movement code here */

for (ModeID=0;ModeID!=5;ModeID++) {
if (ShipX[ModeID]) /* Check if this ship is still around. */
{ ShipX[ModeID]+=DeltaShip[ModeID];
  if (ShipX[ModeID]==1 || ShipX[ModeID]==(320-RightOffset) ||
      ReadPixel(my_window->RPort, (ShipX[ModeID]- LeftOffset) ,ShipsY)==1 ||
      ReadPixel(my_window->RPort, (ShipX[ModeID]+RightOffset), ShipsY)==1)

    DeltaShip[ModeID]=-DeltaShip[ModeID];
  

 }

}


DelayCount=0;

WaitTOF();

for (ModeID=0;ModeID!=5;ModeID++) 
/* Draws the Ship if present in the table (i.e. have value). */
if (ShipX[ModeID]) DrawImage(my_window->RPort,&Ship[ShipNumber],ShipX[ModeID],ShipsY);

}

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
    if (code == QUITMENUITEM) close=TRUE;
    if (code == ABOUTMENUITEM)
        {AutoRequest( my_window, &my_body_text, NULL,
         &my_ok_text, NULL, NULL, 220, 102);}
    if (code == NEWGAMEMENUITEM) NewGame=TRUE;
    code=0;class=0;}

if(class == RAWKEY) {
    if (code==ESCAPEKEY) close=TRUE;
    if (code==SPACEKEY) if (!Shoot) {Shoot=TRUE;}
    if (code==LEFTARROWKEY) Direction=LEFT;
    if (code==RIGHTARROWKEY) Direction=RIGHT;
                     }

JoyStack=JoyStick();
if (JoyStack & FIRE)  Shoot=TRUE;
if (JoyStack & LEFT)  Direction=LEFT;
if (JoyStack & RIGHT) Direction=RIGHT;

if (Shoot) { /* Torpedo is fired. */
 SetAPen(my_window->RPort,2);
if (TorpedoY) { /* Torpedo Moving Algorhytm */
   TorpedoColl=ReadPixel(my_window->RPort,TorpedoX[0],TorpedoY-1);
   if (TorpedoY==1 || TorpedoX[0]==0 || TorpedoX[0]==319) {
   /* Torpedo left outside. */
   for (ModeID=18;ModeID!=0;ModeID--) { /* Torpedo clear */
 SetAPen(my_window->RPort,0);
 WritePixel(my_window->RPort,TorpedoX[ModeID],TorpedoY+ModeID);
 if (ModeID%DelayValue==0) WaitTOF();
   }

  TorpedoY=Shoot=FALSE;Ammo--;
  }

 if (TorpedoColl==6) { /* Coral reef hit. */
 SetAPen(my_window->RPort,4);
 DrawCircle ( my_window->RPort, TorpedoX[0], TorpedoY, 1);

   for (ModeID=18;ModeID!=0;ModeID--) { /* Torpedo clear */
   SetAPen(my_window->RPort,0);
   WritePixel(my_window->RPort,TorpedoX[ModeID],TorpedoY+ModeID);
  if (ModeID%DelayValue==0) WaitTOF();
   }

 SetAPen(my_window->RPort,4);
 /* Draw Outer circle */
 DrawCircle ( my_window->RPort, TorpedoX[0], TorpedoY, 2);
 WaitTOF();
 SetAPen(my_window->RPort,0); /* Clear */
 DrawCircle ( my_window->RPort, TorpedoX[0], TorpedoY, 2);
 WaitTOF();
 DrawCircle ( my_window->RPort, TorpedoX[0], TorpedoY, 1);
 DrawEllipse( my_window->RPort, TorpedoX[0], TorpedoY, 2, 1 );
 WritePixel(my_window->RPort,TorpedoX[0], TorpedoY);
  TorpedoY=Shoot=FALSE;Ammo--;

  }

 if (TorpedoColl==1) { /* Ship is hit. */
 SetAPen(my_window->RPort,4);
 DrawCircle ( my_window->RPort, TorpedoX[0], TorpedoY, 1);
 DrawCircle ( my_window->RPort, TorpedoX[0], TorpedoY, 2);
   for (ModeID=18;ModeID!=0;ModeID--) { /* Torpedo clear */
   SetAPen(my_window->RPort,0);
   WritePixel(my_window->RPort,TorpedoX[ModeID],TorpedoY+ModeID);
  if (ModeID%DelayValue==0) WaitTOF();
   }

 SetAPen(my_window->RPort,4);
 /* Draw Outer circle */
 switch (Level) { /* For ever Level different explosions */
  case 1: ShipExplode(14, TorpedoX[0], TorpedoY); break;
  case 2: ShipExplode(10, TorpedoX[0], TorpedoY); break;
  case 3: ShipExplode( 6, TorpedoX[0], TorpedoY); break;
  default:ShipExplode( 3, TorpedoX[0], TorpedoY); break;
  }
 DrawCircle ( my_window->RPort, TorpedoX[0], TorpedoY, 2);
 WaitTOF();
 SetAPen(my_window->RPort,0); /* Clear */
 DrawCircle ( my_window->RPort, TorpedoX[0], TorpedoY, 2);
 WaitTOF();
 DrawCircle ( my_window->RPort, TorpedoX[0], TorpedoY, 1);
 DrawEllipse( my_window->RPort, TorpedoX[0], TorpedoY, 2, 1 );
 WritePixel(my_window->RPort,TorpedoX[0], TorpedoY);
  TorpedoY=Shoot=FALSE;Ammo--;

/* Remove the Ship from the table */

for (ModeID=0;ModeID!=5;ModeID++)
if (TorpedoX[0]>ShipX[ModeID] && TorpedoX[0]<ShipX[ModeID]+RightOffset) {ShipX[ModeID]=0;break;}

for (ModeID=0;ModeID!=5;ModeID++)
if (ShipX[ModeID]) DrawImage(my_window->RPort,&Ship[ShipNumber],ShipX[ModeID],ShipsY);


  if (!(--ShipsCounter)) {LevelScreen(++Level);Ammo+=15;}
  }


 if (Shoot) {TorpedoY--;
 if (Direction==LEFT)  TorpedoX[0]--;
 if (Direction==RIGHT) TorpedoX[0]++;
 for (ModeID=0;ModeID!=19;ModeID++) { /* Torpedo */
  TorpedoX[19-ModeID]=TorpedoX[18-ModeID];
 }

 for (ModeID=1;ModeID!=19;ModeID++)
  if (TorpedoY+ModeID<237)
  WritePixel(my_window->RPort,TorpedoX[ModeID],TorpedoY+ModeID);
 
  if (TorpedoY+ModeID<237) {SetAPen(my_window->RPort,0);
       WritePixel(my_window->RPort,TorpedoX[ModeID],TorpedoY+ModeID);}

 }

}

   else {
 /* Fire Torpedo. */
 TorpedoY=236;
 for (ModeID=0;ModeID!=20;ModeID++) TorpedoX[ModeID]=SubPosX+9;
 WritePixel(my_window->RPort,TorpedoX[0],TorpedoY);
 }
}

if (Level==5) {NewGame=Win();}
if (Ammo==0) { /* No more ammunitions. Game over. */
  SetAPen(my_window->RPort,4);ShipExplode(16,SubPosX+8,240);
  RectFill (my_window->RPort,SubPosX+8,238,SubPosX+12,242);
 Delay(110);NewGame=GameOver();}
Direction=0;
if (NewGame && !close) {LevelScreen(Level=1);Ammo=81;
    NewGame=Shoot=TorpedoY=FALSE;}
}

/* Exit Code */

/*      removeDualPF(my_screen); */

  Forbid();

  my_screen->ViewPort.RasInfo->Next = NULL;
  my_screen->ViewPort.Modes &= ~DUALPF;

  Permit();

  MakeScreen(my_screen);
  RethinkDisplay();

  for ( DelayCount = 0; DelayCount != 2; DelayCount++ )
  if ( bmap2->Planes[ DelayCount ] )
  /* Free the Second PlayField RastPort: */
  FreeRaster( bmap2->Planes[ DelayCount ],
   my_screen->Width, my_screen->Height );

  if (bmap2)  FreeMem(bmap2, sizeof(struct BitMap));

  if (rport2) FreeMem(rport2, sizeof(struct RastPort));

  if (rinfo2) FreeMem(rinfo2, sizeof(struct RasInfo));

/* We should always close the screens we have opened before we leave: */

 ClearMenuStrip( my_window ); /* Clear the menu */

 CloseWindow ( my_window ); 

 CloseScreen( my_screen );

/* Close the Graphics Library since we have opened it: */
  CloseLibrary( GfxBase );

  /* Close the Intuition Library since we have opened it: */
  CloseLibrary( IntuitionBase );

  /* THE END */
exit(0);
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

void LevelScreen(LevelNumber)
{

int x,y;

if (LevelNumber==5) return;

SetRGB32(&my_screen->ViewPort,9,0x00000000,0x00000000,0x00000000);
SetRGB32(&my_screen->ViewPort,10,0x00000000,0x00000000,0x00000000);

/* One color unused */

LoadRGB32(&my_screen->ViewPort,Black_PaletteRGB32);

SetRast(my_window->RPort,0);

for(y=110;y!=128;y+=2)
 for (x=30;x!=290;x++)
 {SetAPen(my_window->RPort,6); WritePixel(my_window->RPort,x,y);
  WritePixel(my_window->RPort,x+1,y+1);
  SetAPen(my_window->RPort,5); WritePixel(my_window->RPort,x,y+1);
  x++;WritePixel(my_window->RPort,x,y);
}


SetAPen(my_window->RPort,3);
RectFill(my_window->RPort,0,244,319,255); /* Draws the bottom */

LevelNumber--;y=16; /* Draw the enemy's ships */

 if (LevelNumber>1) y+=LevelNumber;
 /* On the 3th and 4th Level they are smaller. Add to the y coordinate. */

for (x=50;x!=300;x+=50) /* Draw five of them */ {
DrawImage(my_window->RPort,&Ship[ShipNumber=LevelNumber],x,y);
/* Acknowedge their positions */
ShipX[(x/50)-1]=x; /* 50/50-1 = 0 etc.. */
}

/* Ship directions first, third and fifth move right. */
DeltaShip[0]=DeltaShip[2]=DeltaShip[4]=1;
DeltaShip[1]=DeltaShip[3]=-1; /* Second and fourth move left. */

ShipsY=y; /* The Y position for the ships (varies). */

RightOffset=RightOffsetValues[ShipNumber];
/* Offset to the right to next ship */

LeftOffset=LeftOffsetValues[ShipNumber];
/* Left Offsets */


SubPosX=(rand()%110)+98;
DrawImage(my_window->RPort,&Submarine,SubPosX,237);

TorpedoY=DelayCount=0;DelayValue=4+LevelNumber;
ShipsCounter=5; /* Five ships. */

/* Set the color palette for the both playfields */
LoadRGB32(&my_screen->ViewPort,InGame_PaletteRGB32);
SetRGB32(&my_screen->ViewPort, 9,0x00000000,0x00000000,0xEEEEEEEE);
SetRGB32(&my_screen->ViewPort,10,0x00000000,0x77777777,0xBBBBBBBB);

}

BOOL GameOver()
{

SetRGB32(&my_screen->ViewPort,9,0x00000000,0x00000000,0x00000000);
SetRGB32(&my_screen->ViewPort,10,0x00000000,0x00000000,0x00000000);

 SetRast(my_window->RPort,0); SetAPen(my_window->RPort,4);
 Move(my_window->RPort,80,50);
 Text(my_window->RPort,"Hard Luck, Webmaster!",20);
 SetAPen(my_window->RPort,1); Move(my_window->RPort,40,80);
 Text(my_window->RPort,"The selfdestroying sequence  have",33);
 SetAPen(my_window->RPort,6); Move(my_window->RPort,40,90);
 Text(my_window->RPort,"destroyed  your  submarine  after",33);
 SetAPen(my_window->RPort,3); Move(my_window->RPort,40,100);
 Text(my_window->RPort,"the last torpedo.  At least  they",33);
 SetAPen(my_window->RPort,6); Move(my_window->RPort,40,110);
 Text(my_window->RPort,"didn't got hold of your warez!",30);
 SetAPen(my_window->RPort,4); Move(my_window->RPort,126,155);
 Text(my_window->RPort,"GAME OVER",9);
 SetAPen(my_window->RPort,7); Move(my_window->RPort,55,245);
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
/* Delay Loop to save resources. */
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
    if (CheckCode == QUITMENUITEM) {close=TRUE;return FALSE;}
    if (CheckCode == ABOUTMENUITEM)
        {AutoRequest( my_window, &my_body_text, NULL,
         &my_ok_text, NULL, NULL, 220, 102);}
    if (CheckCode == NEWGAMEMENUITEM) return TRUE;
                                  }

if(CheckClass == RAWKEY) {
    if (CheckCode==ESCAPEKEY) {close=TRUE;return FALSE;}
    if (CheckCode==SPACEKEY) return TRUE;}
CheckClass=0;CheckCode=0;        

if (JoyStick() & FIRE) return TRUE;
}
}

BOOL Win()
{
 SetRast(my_window->RPort,0);

SetRGB32(&my_screen->ViewPort,9,0x00000000,0x00000000,0x00000000);
SetRGB32(&my_screen->ViewPort,10,0x00000000,0x00000000,0x00000000);

 SetAPen(my_window->RPort, 2); Move(my_window->RPort,50,50);
 Text(my_window->RPort,"Congratulatulations, You won",28);
 SetAPen(my_window->RPort, 1); Move(my_window->RPort,40,80);
 Text(my_window->RPort,"All  Codepasters  ships are gone.",33);
 SetAPen(my_window->RPort, 6); Move(my_window->RPort,40,90);
 Text(my_window->RPort,"Now you can serve your warez  for",33);
 SetAPen(my_window->RPort, 4); Move(my_window->RPort,40,100);
 Text(my_window->RPort,"years to come. If only there were",33);
 SetAPen(my_window->RPort, 6); Move(my_window->RPort,40,110);
 Text(my_window->RPort,"girls down there, but  you  still",33);
 SetAPen(my_window->RPort, 1); Move(my_window->RPort,40,120);
 Text(my_window->RPort,"have the Internet. Good Luck!",29);

 SetAPen(my_window->RPort,7); Move(my_window->RPort,55,245);
 Text(my_window->RPort,"Press Fire/Space to Play Again",30);
 Delay(99);
 return Check();
}

void TitleScreen() {
LoadRGB32(&my_screen->ViewPort,Black_PaletteRGB32);

SetRGB32(&my_screen->ViewPort,9,0x00000000,0x00000000,0x00000000);
SetRGB32(&my_screen->ViewPort,10,0x00000000,0x00000000,0x00000000);

DrawImage (my_window->RPort, &AntiISDA2_Title,37,29);

SetAPen(my_window->RPort,6);
Move(my_window->RPort,41,236);
Text(my_window->RPort,"© 2004 by Ventzislav Tzvetkov",29);
SetAPen(my_window->RPort,7);
Move(my_window->RPort,64,160);
Text(my_window->RPort,"Press Space/Fire to play",24);

SetAPen(my_window->RPort,3);SetBPen(my_window->RPort,5);
Move(my_window->RPort,33,245);
Text(my_window->RPort,"    http://drhirudo.hit.bg     ",31);
SetBPen(my_window->RPort,0);

SetMenuStrip( my_window, &my_menu );

LoadRGB32(&my_screen->ViewPort,Title_PaletteRGB32);

Check();

}

void ShipExplode (UWORD size, UWORD X, UWORD Y) { /* Explosion size big */

UWORD loop;

for (loop=2;loop!=size;loop++) { /* Explosion. */
  DrawEllipse (my_window->RPort, X, Y,loop,loop/2);
  if (loop%3==0) WaitTOF();
  }
  WaitTOF();
  SetAPen(my_window->RPort,0); /* Clear the explosion and what's left. */
  for (loop=size;loop!=2;loop--) { 
  DrawEllipse (my_window->RPort, X, Y,loop,loop/2);
  DrawEllipse (my_window->RPort, X, Y,loop,loop);
  if (loop%3==0) WaitTOF(); }

}
