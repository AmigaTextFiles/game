/******************************************************************************
**********							     **********
********** 		    THE REAL EMULATOR (?)                    **********
**********							     **********
*******************************************************************************
**********							     **********
********** Yet another brain-crash by Magic Ceee (ouch, that hurts!) **********
**********							     **********
******************************************************************************/

#include "intuition/intuition.h"
#include "graphics/gfxbase.h"

struct IntuitionBase		*IntuitionBase;
struct GfxBase			*GfxBase;
struct Screen			*MagicScreen;
struct Window			*MagicWindow;
struct RastPort			*MagicRast;
struct ViewPort			*MagicView;

struct AlertMessage
	{
	WORD X;
	BYTE Y;
	char text[58];
	BYTE count;
	}

texttab[]=
	{
	80,17,"  Illegal copy of  *** MicroBeastie C-64 Emulator ***    ",99,
	80,32,"     Press left mouse button to format your disks.       ",0
	};

/****************************************************************************/

struct NewScreen ns = {
0,0,640,200,2,0,0,HIRES,CUSTOMSCREEN,NULL,NULL,NULL,NULL };

struct NewWindow nw = {
0,0,640,200,0,0,RAWKEY,SIMPLE_REFRESH|BORDERLESS|ACTIVATE,
NULL,NULL,NULL,NULL,NULL,0,0,0,0,CUSTOMSCREEN };

UWORD Sprite_data[] = {		/* Invisible Pointer */
0,0,
0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
0,0 };

char *lies[] = { "Installing 6502 routines...\n",
		 "Installing Kernel..........\n",
		 "Checking Interpreter.......\n",
		 "\nTransforming!\n",
		 "\nAmiga C-64 Emulator V2.7, designed by Magic Ceee.\n\n" };

/*****************************************************************************/

main()
{
 int i;

 Write(Output(),lies[4],strlen(lies[4]));

 for(i=0;i<=3;Tell_A_Lie(lies[i++]));

 OpenStuff();

 /****************************************************************************
 *** Kick pointer outa sight						   ***
 ****************************************************************************/

 SetPointer(MagicWindow,&Sprite_data[0],15,15,-7,-7);

 /****************************************************************************
 *** Steal a RastPort      ...and a ViewPort				   ***
 ****************************************************************************/

 MagicRast=MagicWindow->RPort;

 MagicView=(struct ViewPort *)ViewPortAddress(MagicWindow);

 /****************************************************************************
 *** Set display characteristics					   ***
 ****************************************************************************/

 ShowTitle(MagicScreen,FALSE);		/* No screen title */

 SetRGB4(MagicView,0,0,0,8);		/* Dark blue */
 SetRGB4(MagicView,2,8,8,15);		/* Light blue */
 SetRGB4(MagicView,3,0,0,8);

 SetRast(MagicRast,2);			/* Fill screen using color reg. #2 */
 SetAPen(MagicRast,3);			/* Use color reg. #3 */
 RectFill(MagicRast,38,9,602,189);	/* Display a dark blue area */

 /****************************************************************************
 *** Well...do you believe it's true?					   ***
 ****************************************************************************/

 SetAPen(MagicRast,2);
 Move(MagicRast,179,20);
 Text(MagicRast,"**** COMMODORE 64 BASIC V2 ****",31);
 Move(MagicRast,145,34);
 Text(MagicRast,"64K RAM SYSTEM  38911 BASIC BYTES FREE",38);
 Move(MagicRast,44,53);
 Text(MagicRast,"READY",5);

 for(;;)
    {
     Delay(27);			/* Time left before cursor says hello again */
     SetAPen(MagicRast,2);
     RectFill(MagicRast,44,55,52,62);	/* Draw a cursor  */
     Delay(27);				/* ...and wait... */
     SetAPen(MagicRast,3);
     RectFill(MagicRast,44,55,52,62);	/* ...then kick it outa sight */
     if(GetMsg(MagicWindow->UserPort)) break;	/* Any user activities? */
    }

 DisplayAlert(RECOVERY_ALERT,&texttab,45);	/* Yes, so let's panic */
 GoHome("\f\n\n\n --> Magic Ceee says: ceeein' is beleeevin'...\n\n");
}

/****************************************************************************/

Tell_A_Lie(which_lie)
char *which_lie;
{
 Write(Output(),which_lie,strlen(which_lie));
 Delay(4*50);
}

/****************************************************************************/

OpenStuff()
{
 if(!(IntuitionBase=(struct IntuitionBase *)
   OpenLibrary("intuition.library",0))) 
     GoHome("Intuition won't open!\n");

 if(!(GfxBase=(struct GfxBase *)
   OpenLibrary("graphics.library",0)))
     GoHome("Graphix won't open!\n");

 if(!(MagicScreen=OpenScreen(&ns)))
   GoHome("Can't open that damned screen!\n");

 nw.Screen=MagicScreen;
 if(!(MagicWindow=OpenWindow(&nw)))
   GoHome("It's cold outside - Intuition won't open a window!\n");

 
}

/****************************************************************************/

GoHome(msg)
char *msg;
{
 Write(Output(),msg,strlen(msg));

 			ClearPointer(MagicWindow);
 if(MagicWindow)	CloseWindow(MagicWindow);
 if(MagicScreen)	CloseScreen(MagicScreen);
 if(GfxBase)		CloseLibrary(GfxBase);
 if(IntuitionBase)	CloseLibrary(IntuitionBase);
}
