/* My game
* This program will open a normal window which is connected to a
* 8-colour Custom screen. I then set-up my data stacks as structures.
* 1 for each possible pile, and 1 for the pile I CARRY around.
* Then I LOAD my 1FF Title pic using the iff.library routines, which
* are a GODSEND to programmers. I also have a Requester set up to be
* called when they choose ABOUT from the menu which has my ABOUT info.
* I set up my menus, etc.. When they choose Play (or NEW) the game
* shuffles, deals, draws the cards, and waits for input. The -input
* is either a MENU choice OR mouse co-ordinates when someone hits
* the left mouse button. Depending on where they hit, I set up my
* options. That's it.. :-)
*/


/* If your program is using Intuition you should include intuition.h: */
#include <intuition/intuition.h>
#include "stdio.h"             /* Always needed. */
#include "stdlib.h"            /* Needed for Random functions */
#include "time.h"              /* Needed for time */
#include "string.h"            /* Needed for string */
#include <graphics/gfxbase.h> /* Needed for Drawimage and others */
#include <libraries/dos.h>    /* These are needed so I can set my */
#include <libraries/dosextens.h> /* directory when starting from WB */
#include <workbench/startup.h>	    /* since WB programs assume start is */
#include <workbench/workbench.h> /* SYS: We take it from WBStartup */
#include <libraries/iff.h>    /* Needed for the IFF routines.. */
#include <exec/types.h>
#include <exec/memory.h>
#include <devices/audio.h>

UBYTE *Version = "\0$VER: Klondike 1.11 (17.04.2023)\0";

#include "easysound.h"

#include "cards.h"             /* This is my card image data.. */

typedef struct WBStartup  WBS; /* Needed for the WBStartup message */

/* Some basics... */
#define NumCards 52
#define NumSuits 4
#define NumColors 2

struct Library *IFFBase=NULL; /* Needed for opening the iff.library */

struct Card
{ int cardname;   /* <1>Ace, <13>King, <12>Queen, <ll>Jack, 10, 9,. etc..*/
	char cardsuit;	/* <C>lubs, <H>earts, <S>pades, or <D>iamonds */
	BOOL facing;	   /* TRUE for UP, FALSE for the card facing down */
} c;

/* This is the Stock. */
struct Card Stock[52]; /* 0 - 51 is 52 cards per deck. */

/* These are the columns.. */
struct Card Column[7][20]; /* 0 -- 6 is 7 columns of 12 cards. */

/* This is the Waste pile, 24 cards at MOST.. */
struct Card Waste[24]; /* 0 - 23 is 24 cards MOST in Waste. */

/* These are the foundation piles. */
struct Card Foundation[4]; /* 0 - is four groups of 1 cards. */

/* This is the pile I will carry around to swap. */
struct Card Carry[20]; /* 1 pile of up to 12 cards... */

/* This is the single card I will use to draw.. */
struct Card Drawcard;

CPTR sound_shuffle;
CPTR sound_card;
CPTR sound_win;
CPTR sound_point;

/* Needed if I plan on using these libraries.. */
struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;


#include "About.h"

#include "Menus.h"

struct TextAttr my_font = {
  "topaz.font", 8, 0, 0
};

/* Declare a pointer to a Screen structure: */
struct Screen *my_screen;

/* Declare and initialize your NewScreen structure: */
struct NewScreen my_new_screen=
{
	0,	 /* LeftEdge Should always be 0. */
	0,	 /* TopEdge Top of the display.*/
	640,	     /* Width	 */
	200,	     /* Height	 */
	3,	 /* Depth    8 colours. */
	0,	 /* DetailPen Text shOuld be printed with colour reg. 0 */
	1,	 /* BlockPen Blocks should be printed with colour reg. 1 */
	HIRES,	 /* ViewModes Hi-resolution. (Non-Interlaced) */
	CUSTOMSCREEN, /* Type	 Your own customized screen. */
	&my_font,    /* Font	 Default font. */
	(char *) "<<Klondike>> by Dr.D. (c)1992 ", /* Title */
	NULL,	 /* Gadget   Must for the moment be NULL. */
	NULL	     /* BitMap	 No special CustomBitMap. */
};


/* Declare a pointer to a Window structure: */
struct Window *my_window;

/* Declare and initialize your NewWindow structure: */
struct NewWindow my_new_window=
{
	00,	  /* LeftEdge	  x position of the window. */
	10,	  /* TopEdge y position of the window. */
	640,	     /* Width 640 pixels wide. */
	190,	     /* Height 190 lines high. */
	0,	  /* DetailPen	   Text should be drawn with colour reg. 0 */
	1,	  /* BlockPen	   Blocks should be drawn with col. reg. 1 */
	GADGETDOWN|	  /* I will be told when a gadget is hit */
	GADGETUP| /* and released */
	MENUPICK| /* and when they hit a menu */
	MENUVERIFY|	  /* and if it's my menu */
	MOUSEBUTTONS,  /* and if they hit the mousebuttons */
	SMART_REFRESH| /* Flags     Intuition should refresh the window. */
	BORDERLESS|	  /*	   No other gadgets!!! */
	ACTIVATE| /*	  The window should be Active when opened. */
	REPORTMOUSE,	  /*	   And I will be told about the mouse. */
	NULL,  /* Pointer to my gadget. */
	NULL,  /* CheckMark */
	NULL,  /* Title Title of the window. */
	NULL,  /* Screen We will later connect it to the screen. */
	NULL,  /* BitMap No Custom BitMap. */
	0,	 /* MinWidth  We do not need to care about these */
	0,	 /* MinHeight	 since we have not supplied the window */
	0,	 /* MaxWidth  with a Sizing Gadget. */
	0,	 /* MaxHeight */
	CUSTOMSCREEN	  /* Type    Connected to a Custom screen. */
};


main()
{ klondike(0);
	printf("<<Klondike>> by Dr.D. v1.11 <c> 1992 Lilliput software!\n");
	return(0);
}

wbmain(wbs)
WBS *wbs;
{
	/*
*  This sets the WB directory to the directory the program was
*  run from rather than SYS: which is the usual default when
*  a program is run from WB.
*/

	BPTR savelock = CurrentDir((BPTR)wbs->sm_ArgList[0].wa_Lock);

	klondike(1);
}

/* Here is the program! */
klondike( int wbst)
{
	BOOL start = FALSE, close_me = FALSE, mouse_moved, result;
	ULONG class; /*IDCMP*/
	SHORT x, y; /* MOUSE CoOrds.. */
	USHORT code; /*Code*/
	APTR ifffile = NULL;
	struct IntuiMessage *my_message;
	time_t t = time(NULL);
	struct tm *tp = localtime(&t);

	int seed, PileNumber, GotCard, Score, FirstPile, TopStock,
	TopWaste, Drawx, Drawy, Sound, Cycle, DeckLoop, loop;
	char ifftitle[80];
	/* struct MenuItem *item; */
	/* UWORD colortable[128]; */
	/* struct BitMapHeader *bmhd;  */
	char *title[]=
	{
		"<<Klondike>> by Dr.D. (c)1992 ",
		"Dealing.....",
		"Setting up..."
	};

	/* Here I initialize my random seed based on seconds.. */
	time(NULL);
	localtime(&t);
	seed = (tp->tm_sec * tp->tm_min);
	srand(seed);
	/* Done */

	strcpy(ifftitle, "Title.pic");
	TopWaste = 0;
	PileNumber = 0;
	GotCard = 0;
	Score = 0;
	Sound = 3;   /* Sound starts at 3 (00000011) for ON */
	Cycle = 1;   /* You can re-use the deck */
	DeckLoop = 1; /* 1 card at a time.. */


	/* Open the IFF library, if it's not there, do NOT exit.. */
	IFFBase = (struct IFFBase *)OpenLibrary(IFFNAME,IFFVERSION);

	/* Open the Intuition Library: */
	IntuitionBase = (struct IntuitionBase *)
	OpenLibrary( "intuition.library", 0 );

	if( IntuitionBase == NULL )
	{
		if(IFFBase) CloseLibrary(IFFBase);
		exit(1); /* Could NOT open the Intuition Library! */
	}
	/* Open the Graphics Library: */
	GfxBase = (struct GfxBase *)
	OpenLibrary( "graphics.library", 0 );

	if( GfxBase == NULL )
	{
		/* Could NOT open the Graphics Library! */

		/* Close the Intuition Library since we have opened it: */
		CloseLibrary( IntuitionBase );

		if(IFFBase) CloseLibrary(IFFBase);

		exit(1);
	}

	/* We will now try to open the screen: */
	my_screen= (struct Screen *) OpenScreen( &my_new_screen );

	/* Have we opened the screen succesfully? */
	if (my_screen == NULL)
	{
		/* Could NOT open the Screen! */

		/* Close the Graphics Library since we have opened it: */
		CloseLibrary( GfxBase );

		/* Close the Intuition Library since we have opened it: */
		CloseLibrary( IntuitionBase );

		if(IFFBase) CloseLibrary(IFFBase);
		exit(1);
	}

	/* Set the screens colors */
	SetRGB4( &my_screen->ViewPort, 0, 0x5, 0x2, 0x5 );
	SetRGB4( &my_screen->ViewPort, 1, 0xE, 0xD, 0xC );
	SetRGB4( &my_screen->ViewPort, 2, 0x0, 0x0, 0x0 );
	SetRGB4( &my_screen->ViewPort, 3, 0xF, 0x0, 0x0 );
	SetRGB4( &my_screen->ViewPort, 4, 0x7, 0x3, 0x6 );
	SetRGB4( &my_screen->ViewPort, 5, 0x8, 0x4, 0x7 );
	SetRGB4( &my_screen->ViewPort, 6, 0x9, 0x5, 0x8 );
	SetRGB4( &my_screen->ViewPort, 7, 0xA, 0x6, 0x9 );


	/* Before we can open the window we need to give the NewWindow */
	/* structure a pointer to the opened Custom Screen: */
	my_new_window.Screen = my_screen;


	/* We will now try to open the window: */
	my_window = (struct Window *) OpenWindow( &my_new_window );

	/* Have we opened the window succesfully? */
	if(my_window == NULL)
	{
		/* Could NOT open the Window! */

		/* Close the screen since we have opened it: */
		CloseScreen( my_screen );

		/* Close the Graphics Library since we have opened it: */
		CloseLibrary( GfxBase );

		/* Close the Intuition Library since we have opened it: */
		CloseLibrary( IntuitionBase );

		if(IFFBase) CloseLibrary (IFFBase);
		exit(1);

	}
	/* IF we opened the IFF lib, show the pic... */
	if(IFFBase)
	{
		if(!(ifffile=IFFL_OpenIFF(ifftitle,IFFL_MODE_READ)))

		if( wbst == 0)
		puts("Error opening pic..");


		if(ifffile)
		if(!IFFL_DecodePic(ifffile,&my_screen->BitMap))
		{
			if( wbst == 0)
			puts("Can't decode pic..");
		}
	}

	SetMenuStrip( my_window, &my_menu);

	SetWindowTitles( my_window, -1, title[2]);

	LoadSounds( &Sound);

	SetWindowTitles( my_window, -1, title[0]);

	while( close_me == FALSE )
	{
		mouse_moved = FALSE;
		Wait( 1 <<my_window->UserPort->mp_SigBit );
		while(my_message = (struct IntuitMessage *) GetMsg(my_window->UserPort))
		{
			class = my_message->Class;
			code  = my_message->Code;
			x   = my_message->MouseX;
			y   = my_message->MouseY;

			ReplyMsg( my_message );

			switch( class)
			{
			case MENUPICK:
				/*    if( code != MENUNULL)

	printf("Menu: %d\n", MENUNUM (code));
	printf("Item: %d\n", ITEMNUM (code));
	A menu Item was chosen, which one? */

				/* The PROJECT menu, which function? */
				while (code != MENUNULL)
				{
					/* Check the code whenever there is an action - i.e. not MENUNULL */
					struct MenuItem* item = ItemAddress(&my_menu, code);
					/*  Start Project Menu */
					if ((MENUNUM (code) == 0 ) && (ITEMNUM (code) == 0))
					{
						Score = Score - 52;
						SetUpStock (Stock, Waste, &TopWaste);
						SetUpColumns (Column, Foundation);
						SetUpCarry (Carry, &GotCard);
						SetWindowTitles( my_window, -1, title[1]);
						Shuffle (Stock);
						Deal (Column, Stock, &TopStock);
						DrawCards (Column, &Drawx, &Drawy, &TopWaste, Sound);
						sprintf( title[0], "<<Klondike>> Cash: $%d.00", Score);
						SetWindowTitles( my_window, -1, title[0]);
						start = TRUE;
						break;
					}
					if ((MENUNUM (code) == 0 ) && (ITEMNUM (code) == 1))
					{
						Score = -52;
						SetUpStock (Stock, Waste, &TopWaste);
						SetUpColumns (Column, Foundation);
						SetUpCarry (Carry, &GotCard);
						SetWindowTitles( my_window, -1, title[1]);
						Shuffle (Stock);
						Deal (Column, Stock, &TopStock);
						DrawCards (Column, &Drawx, &Drawy, &TopWaste, Sound);
						sprintf( title[0], "<<Klondike>> Cash: $%d.00", Score);
						SetWindowTitles( my_window, -1, title[0]);
						start = TRUE;
						break;
					}
					if ((MENUNUM (code) == 0 ) && (ITEMNUM (code) == 2))
					{
						result=Request( &my_requester, my_window );
						break;
					}
					if ((MENUNUM (code) == 0 ) && (ITEMNUM (code) == 3))
					{
						close_me = TRUE;
						break;
					}
					/* End Project Menu */

					/* Options Menu  */
					if ((MENUNUM (code) == 1 ) && (ITEMNUM (code) == 0))
					Sound ^= 1UL << 0;
					if ((MENUNUM (code) == 1 ) && (ITEMNUM (code) == 1))
					Sound ^= 1UL << 1;
					if ((MENUNUM (code) == 1 ) && (ITEMNUM (code) == 2))
					Cycle ^= 1UL << 0;
					if ((MENUNUM (code) == 1 ) && (ITEMNUM (code) == 3))
					{
						if (DeckLoop == 1)
						DeckLoop = 3;
						else
						DeckLoop = 1;
					}
					code = item->NextSelect;
				}
				/* End Menu functions */

			case MOUSEBUTTONS:
				switch( code)
				{
				case SELECTUP:
					while (start)
					{
						sprintf( title[0], "<<Klondike>> Cash: $%d.00", Score);
						SetWindowTitles( my_window, -1, title[0]);
						if( x < 65)
						PileNumber = 7;
						if( (x > 64) &&  (x< 134))
						PileNumber = 8;
						if( (x > 133) &&  (x< 207))
						PileNumber = 0;
						if( (x > 206) &&  (x< 280))
						PileNumber = 1;
						if( (x > 279) &&  (x< 353))
						PileNumber = 2;
						if( (x > 352) &&  (x< 426))
						PileNumber = 3;
						if( (x > 425) &&  (x< 499))
						PileNumber = 4;
						if( (x > 498) &&  (x< 572))
						PileNumber = 5;
						if( (x > 571) &&  (x< 641))
						PileNumber = 6;

						if( PileNumber < 7)
						{
							if( GotCard == 0)
							{
								CheckFound( Foundation, Carry, &GotCard, &PileNumber,
								Column, Drawcard, &Drawx, &Drawy, &TopWaste,
								&Score, y, Sound);
								sprintf( title[0], "<<Klondike>> Cash: $%d.00", Score);
								SetWindowTitles( my_window, -1, title[0]);
								if( PileNumber < 7)
								{
									PopOff ( Column, &PileNumber, Carry, &GotCard);
									FirstPile = PileNumber;
								}
							}
							else
							{
								PopOn ( Carry, Column, &GotCard, &PileNumber, &FirstPile, &Drawx, &Drawy, &TopWaste, Sound);

							}
						}
						else if( PileNumber == 7)
						{
							if( y > 142)
							{
								if( GotCard == 0)
								{
									for( loop = 0; loop < DeckLoop; loop++)
									{
										DeckHit( Stock, &TopStock, Waste, &TopWaste, &Drawx, &Drawy, Sound, Cycle, &Score, DeckLoop);
										if( TopStock == 52) break;
										if( TopWaste == 0) break;
									}
									sprintf( title[0], "<<Klondike>> Cash: $%d.00", Score);
									SetWindowTitles( my_window, -1, title[0]);
								}
							}
							else
							{
								if( GotCard == 0)
								{
									HitWasteOff ( Waste, Carry, &TopWaste, Foundation,
									&Drawx, &Drawy, &GotCard, &Score, y, Sound);
									sprintf( title[0], "<<Klondike>> Cash: $%d.00", Score);
									SetWindowTitles( my_window, -1, title[0]);
									FirstPile = PileNumber;
								}
								else if( GotCard == 1)
								{
									if( FirstPile == 7)
									{
										HitWasteOn ( Carry, Column, &GotCard, &PileNumber,
										Waste, &TopWaste, Drawcard, &Drawx,
										&Drawy, &FirstPile);
									}
									else
									{
										/* FirstPile != 7, GotCard != 0 */
									}
								}
							}
						}
						break;
					}
				}
			}
		}
	}

	if(sound_card) RemoveSound( sound_card);
	if(sound_point) RemoveSound( sound_point);
	if(sound_win) RemoveSound( sound_win);

	/* if (ifffile) IFFL_CloseIFF(ifffile); */
	ClearMenuStrip( my_window );

	/* We should always close the windows we have opened before we leave: */
	CloseWindow( my_window );

	/* Remember that all windows connected to a screen must be closed */
	/* before you may close the screen! */
	CloseScreen( my_screen );

	/* Close the Graphics Library since we have opened it: */
	CloseLibrary( GfxBase );

	/* Close the Intuition Library since we have opened it: */
	CloseLibrary( IntuitionBase );

	if(IFFBase) CloseLibrary( IFFBase);
	/* THE END */
}

DrawCards ( struct Card Column[7][20], int *Drawx, int *Drawy, int *TopWaste,
int Sound)

{

	int x, y, loop1, loop2, Pile;
	/*   char buffer[10]; */

	SetDrMd(my_window->RPort,JAM2);
	SetBPen(my_window->RPort, 0);

	/* Clear the screen. B Pen is Purple for background */
	Move( my_window->RPort, 0, 0);
	ClearScreen ( my_window->RPort);
	SetBPen(my_window->RPort, 1);
	/* Done clearing and set B to white for card background */

	/* Draw squares for foundation....*/
	x = 69;
	y = 3;
	SetAPen( my_window->RPort, 1);
	for(loop1 = 0; loop1 < 4; loop1++)
	{
		Move( my_window->RPort, x, y);
		Draw( my_window->RPort, x, (y + 42));
		Draw( my_window->RPort, (x + 58), (y + 42));
		Draw( my_window->RPort, (x + 58), y);
		Draw( my_window->RPort, x, y);
		y = y + 47;
	}

	x = 139;
	y = 2;
	for(loop1 = 0; loop1 < 7; loop1++)
	{
		for(loop2 = 0; loop2 < 20; loop2++)
		{
			if( Column[loop1][loop2].cardname != 0)
			{
				if( Column[loop1][loop2].facing != TRUE)
				{
					/*   if( (Sound == 1) || (Sound == 2) )  */
					if( (Sound >> 0) & 1U)
					PlaySound( sound_card, MAXVOLUME, LEFT1, NORMALRATE, 1);
					DrawImage( my_window->RPort, &DOWN_image, x, y);
					/*   if ( (Sound == 1) || (Sound == 2) )  */
					if( (Sound >> 0) & 1U)
					{
						Delay( 8);
						StopSound( LEFT1);
					}
					y = y + 10;
				}
			}
			if( Column[loop1][loop2].facing == TRUE)
			{
				Pile = 4;
				*Drawx = x;
				*Drawy = y;
				PrintCard ( Drawcard, Drawx, Drawy, &Pile, TopWaste, &loop1, &loop2, Sound);
				y = 2;
			}
		}
		x = x + 73;
	}
	/* Draw Deck Card...	 */
	/*    if( (Sound == 1) || (Sound == 2) ) */
	if( (Sound >> 0) & 1U)
	PlaySound( sound_card, MAXVOLUME, LEFT1, NORMALRATE, 1);
	DrawImage( my_window->RPort, &DOWN_image, 1, 143);
	/*    if( (Sound == 1) || (Sound == 2) )  */
	if( (Sound >> 0) & 1U)
	{
		Delay( 8);
		StopSound( LEFT1);
	}
	/* Done Drawing Deck..	 */

}

SetUpStock ( struct Card Stock[52], struct Card Waste[24], int *TopWaste)

{
	int count, loop1, loop2;

	*TopWaste = 0;
	count = 0;
	for(loop1 = 0; loop1 < 4; loop1++)
	{
		for(loop2 = 0; loop2 < 13; loop2++)
		{
			Stock[count].cardname = (13 - loop2);
			switch(loop1)
			{
			case 0: Stock[count].cardsuit = 'H';    /* Hearts */
				break;
			case 1: Stock[count].cardsuit = 'S';    /* Spades */
				break;
			case 2: Stock[count].cardsuit = 'D';    /* Diamonds */
				break;
			case 3: Stock[count].cardsuit = 'C';    /* Clubs */
				break;
			}
			if( count < 24)
			{
				Waste[count].cardname = 0;
				Waste[count].cardsuit = '0';
			}
			Stock[count].facing = FALSE; /* Cards start out face DOWN */
			count++;
		}
	}
	/* End Setup Cards */
}

SetUpColumns (struct Card Column[7][20], struct Card Foundation[4])

{
	int loop1, loop2;

	for(loop1 = 0; loop1 < 7; loop1++)
	{
		for(loop2 = 0; loop2 < 20; loop2++)
		{
			Column[loop1][loop2].cardname = 0;
			Column[loop1][loop2].cardsuit = '0';
			Column[loop1][loop2].facing = FALSE;
		}
	}
	for(loop1 = 0; loop1 < 4; loop1++)
	{
		Foundation[loop1].cardname = 0;
		if( loop1 == 0)
		Foundation[loop1].cardsuit = 'S';
		if( loop1 == 1)
		Foundation[loop1].cardsuit = 'C';
		if( loop1 == 2)
		Foundation[loop1].cardsuit = 'D';
		if( loop1 == 3)
		Foundation[loop1].cardsuit = 'H';
	}
	/* End Clear columns */
}

Shuffle ( struct Card Stock[52])

{
	int i, loop1, loop2, dummy;
	char holder;

	i = rand() % 52;
	for(loop1 = 0; loop1 < 7; loop1++)
	{
		for(loop2 = 0; loop2 < 52; loop2++)
		{
			i = rand() % 52;
			/* Swap cardsuit */
			holder = Stock[loop2].cardsuit;
			Stock[loop2].cardsuit = Stock[i].cardsuit;
			Stock[i].cardsuit = holder;
			/* Swap cardname */
			dummy = Stock[loop2].cardname;
			Stock[loop2].cardname = Stock[i].cardname;
			Stock[i].cardname = dummy;
			/* No need to swap the facing value, all are still down. */
		}
	}
	/* End Shuffle */
}

Deal ( struct Card Column[7][20], struct Card Stock[52], int *TopStock)

{
	int loop1, loop2, count;

	count = 0;
	for( loop1 = 0; loop1 < 8; loop1++)
	{
		for( loop2 = 0; loop2 < loop1; loop2++)
		{
			Column[loop1-1][loop2].cardname = Stock[count].cardname;
			Column[loop1-1][loop2].cardsuit = Stock[count].cardsuit;
			Stock[count].cardname = 0;
			Stock[count].cardsuit = '0';
			if( (loop1-1) == loop2)
			Column[loop1-1][loop2].facing = TRUE;
			count++;
		}
	}
	*TopStock = count;
	/* END Deal */
}

PopOff (struct Card Column[7][20], int *PileNumber, struct Card Carry[20], int *GotCard)

{
	int loop1, count, start;

	count = 0;
	start = -1;
	for( loop1 = 0; loop1 < 20; loop1++)
	{
		if( Column[*PileNumber][loop1].facing == TRUE)
		{
			if( start == -1)
			start = loop1;
			Carry[count].cardname = Column[*PileNumber][loop1].cardname;
			Carry[count].cardsuit = Column[*PileNumber][loop1].cardsuit;
			Carry[count].facing = TRUE;
			count = count + 1;
			Column[*PileNumber][loop1].cardname = 0;
			Column[*PileNumber][loop1].cardsuit = '0';
			Column[*PileNumber][loop1].facing = FALSE;
		}
	}
	*GotCard = count;
	if( count > 0)
	DrawBox( &start, &count, PileNumber);
}

SetUpCarry (struct Card Carry[20], int *GotCard)

{
	int loop1;

	for( loop1 = 0; loop1 < 20; loop1++)
	{
		Carry[loop1].cardname = 0;
		Carry[loop1].cardsuit = '0';
		Carry[loop1].facing = FALSE;
	}
	*GotCard = 0;
}

PrintColumn ( struct Card Column[7][20], int *PileNumber, int *Drawx,
int *Drawy, int *TopWaste, int sound, int start)

{
	int x, y, loop1, Pile, loop3;
	/*  char buffer[10]; */

	x = 139 + (*PileNumber * 73);
	y = 0;

	if (start == 99)
	{
		for( loop3 = 0; loop3 < 4; loop3++)
		{
			DrawImage( my_window->RPort, &BLANK_image, x, y);
			y = y + 45;
		}
		DrawImage( my_window->RPort, &BLANK_image, x, 145);
		start = 0;
	}

	y = 2 + (start * 10);

	for( loop1 = start; loop1 < 20; loop1++)
	{
		if( Column[*PileNumber][loop1].cardname != 0)
		{
			if( Column[*PileNumber][loop1].facing == FALSE)
			DrawImage( my_window->RPort, &DOWN_image, x, y);
			else
			{
				*Drawx = x;
				*Drawy = y;
				Pile = 4;
				PrintCard ( Drawcard, Drawx, Drawy, &Pile, TopWaste, PileNumber, &loop1, sound);
			}
		}
		y = y + 10;
	}
}

PopOn (struct Card Carry[20], struct Card Column[7][20], int *GotCard,
int *PileNumber, int *FirstPile, int *Drawx, int *Drawy,
int *TopWaste, int Sound)

{

	int x, y, Pile, loop1, loop2, count, start, suit, name, sound, toppile;
	char color1, color2, buffer[80];
	BOOL copy, check, search;

	count = 0;
	loop1 = 0;
	check = TRUE;
	search = TRUE;
	copy = FALSE;
	name = 0;
	suit = 0;
	sound = Sound;

	/* King to Blank Pile */
	if ( (Column[*PileNumber][0].cardname == 0) && (Carry[0].cardname == 13))
	{
		start = 0;
		check = FALSE;
		copy = TRUE;
		name = 1;
		suit = 1;
	}

	/* Pick up and put down in the same pile */
	if( *PileNumber == *FirstPile)
	{
		for( loop2 = 0; loop2 < 20; loop2++)
		{
			if( Column[*PileNumber][loop2].cardname == 0)
			{
				start = loop2;
				loop2 = 20;
			}
		}
		check = FALSE;
		copy = TRUE;
		name = 1;
		suit = 1;
		sound = 0;
	}
	if (Sound == 0)
	sound = 0;
	/* All others not involving the foundations */
	while( check)
	{
		if( Column[*PileNumber][loop1+1].cardname == 0)
		{
			toppile = loop1;
			if( Carry[0].cardname == (Column[*PileNumber][loop1].cardname - 1))
			{
				name = 1;
				if( Carry[0].cardsuit == 'D')
				color1 = 'R';
				if( Carry[0].cardsuit == 'H')
				color1 = 'R';
				if( Carry[0].cardsuit == 'S')
				color1 = 'B';
				if( Carry[0].cardsuit == 'C')
				color1 = 'B';
				if (Column[*PileNumber][loop1].cardsuit == 'D')
				color2 = 'R';
				if (Column[*PileNumber][loop1].cardsuit == 'H')
				color2 = 'R';
				if (Column[*PileNumber][loop1].cardsuit == 'S')
				color2 = 'B';
				if (Column[*PileNumber][loop1].cardsuit == 'C')
				color2 = 'B';
				if (color1 != color2)
				{
					suit = 1;
					copy = TRUE;
					start = loop1 + 1;
					check = FALSE;
				}
			}
		}
		if( loop1 > 18)
		check = FALSE;
		loop1 = loop1 + 1;
	}

	/* If one of the above is true, swap. */
	if( copy)
	{
		for( loop2 = 0; loop2 < *GotCard; loop2++)
		{
			Column[*PileNumber][start + loop2].cardname = Carry[loop2].cardname;
			Column[*PileNumber][start + loop2].cardsuit = Carry[loop2].cardsuit;
			Column[*PileNumber][start + loop2].facing = TRUE;
		}
		loop1 = 0;
		loop2 = 0;
		if( *FirstPile !=7)
		if( Column[*FirstPile][0].cardname == 0)
		search = FALSE;
		if( *FirstPile == 7)
		{
			x = 1;
			y = 2 + (*TopWaste * 5);
			DrawImage( my_window->RPort, &BLANK_image, x, y);
			y = 2 + ((*TopWaste-1) * 5);
			*Drawx = x;
			*Drawy = y;
			Pile = 5;
			PrintCard ( Drawcard, Drawx, Drawy, &Pile, TopWaste, 0, 0, 0);
			search = FALSE;
		}
		while( search)
		{
			if( Column [*FirstPile][loop2 + 1].cardname == 0)
			{
				Column[*FirstPile][loop2].facing = TRUE;
				search = FALSE;
			}
			loop2 = loop2 + 1;
		}
		if( *PileNumber != *FirstPile)
		if( *FirstPile != 7)
		PrintColumn( Column, FirstPile, Drawx, Drawy, TopWaste, sound, 99);
		PrintColumn( Column, PileNumber, Drawx, Drawy, TopWaste, sound, start);
		SetUpCarry( Carry, GotCard);
	}
	if( suit == 0)
	{
		if( name == 0)
		{
			strcpy( buffer, "Card is not 1 value below!");
		}
		else
		strcpy( buffer, "Card is not opposite suit!");
		SetWindowTitles( my_window, -1, buffer);
	}
}

CheckFound( struct Card Foundation[4], struct Card Carry[20],
int *GotCard, int *PileNumber, struct Card Column[7][20],
struct Card Drawcard, int *Drawx, int *Drawy, int *TopWaste,
int *Score, int My, int Sound)

{

	int loop1, loop2, Pile, x, y, ColSpot, coordsy, coordey, start;
	BOOL swap, search;
	/*  char buffer[10]; */

	x = 0;
	y = 2;
	loop2 = 0;
	search = TRUE;

	/* Put lastcard from column on Carry */
	while( search)
	{
		if( Column[*PileNumber][loop2 + 1].cardname == 0)
		{
			Carry[0].cardname = Column[*PileNumber][loop2].cardname;
			Carry[0].cardsuit = Column[*PileNumber][loop2].cardsuit;
			search = FALSE;
			ColSpot = loop2;
		}
		if( loop2 == 19)
		search = FALSE;
		loop2 = loop2 + 1;
	}
	/* Done putting last Column Card on Carry... */

	/* Set up check for if they hit ON the card.. */
	coordsy = 1 + (ColSpot * 10);
	coordey = coordsy + 46;
	/* Done setting up... */

	/* Check to see if Carry card is 1 greater than current Foundation */
	swap = FALSE;
	for( loop1 = 0; loop1 < 4; loop1++)
	{
		if( (Carry[0].cardname - 1) == Foundation[loop1].cardname)
		{
			if( Carry[0].cardsuit == Foundation[loop1].cardsuit)
			{
				if( (My > coordsy) && (My < coordey))

				swap = TRUE;
				Pile = loop1;
				*Score = *Score + 5;
			}
		}
	}
	/* Done testing against 4 columns..	 */

	/* Swap card to foundation if it matched.. */
	if ( swap)
	{
		/* Take card off of Column...	 */
		Column[*PileNumber][ColSpot].cardname = 0;
		Column[*PileNumber][ColSpot].cardsuit = '0';
		Column[*PileNumber][ColSpot].facing = FALSE;
		/* Done removing card..   */
		/* Actually put it on the Foundation..	   */
		Foundation[Pile].cardname = Carry[0].cardname;
		Foundation[Pile].cardsuit = Carry[0].cardsuit;
		/* Done putting on Foundation...	      */
		/* Set previous card on column to show..   */
		if( Column[*PileNumber][0].cardname != 0)
		Column[*PileNumber][ColSpot-1].facing = TRUE;
		/* Done setting..	       */
		*Drawx = 68;
		*Drawy = 2;
		PrintCard ( Drawcard, Drawx, Drawy, &Pile, TopWaste, 0, 0, Sound);
		x = 139 + (*PileNumber * 73);
		y = coordsy + 1;
		DrawImage( my_window->RPort, &BLANK_image, x, y);
		/* Redraw pile we took card from and cleanup. */
		start = ColSpot - 1;
		if (start < 0) start = 99;
		PrintColumn( Column, PileNumber, Drawx, Drawy, TopWaste, 0, start);
		SetUpCarry( Carry, GotCard);
		*PileNumber = 8;
		/*   if( (Sound == 1) || (Sound == 3) ) */
		if( (Sound >> 1) & 1U)
		{
			PlaySound( sound_point, MAXVOLUME, RIGHT0, NORMALRATE, 1);
			Delay( 30);
			StopSound( RIGHT0);
		}
		/* DONE!		     */
	}
	if((Foundation[0].cardname == 13) && (Foundation[1].cardname == 13) && (Foundation[2].cardname == 13) && (Foundation[3].cardname == 13))
	{
		YouWon ( Sound);
	}
}


DeckHit( struct Card Stock [52], int *TopStock, struct Card Waste[24],
int *TopWaste, int *Drawx, int *Drawy, int Sound, int Cycle,
int *Score, int DeckLoop)

{

	int Pile, count, x, y;
	/*  char buffer[10]; */

	x = 1;
	y = 2;
	count = 0;
	y = y + (*TopWaste * 5);
	if( *TopStock == 51)
	{
		DrawImage( my_window->RPort, &BLANK_image, 1, 143);
		SetAPen( my_window->RPort, 5);
		Move( my_window->RPort, 1, 143);
		Draw( my_window->RPort, 1, 187);
		Draw( my_window->RPort, 61, 187);
		Draw( my_window->RPort, 61, 143);
		Draw( my_window->RPort, 1, 143);
	}
	if( *TopStock < 52)
	{
		Waste[*TopWaste].cardname = Stock[*TopStock].cardname;
		Waste[*TopWaste].cardsuit = Stock[*TopStock].cardsuit;
		Stock[*TopStock].cardname = 0;
		Stock[*TopStock].cardsuit = '0';

		*TopWaste = *TopWaste + 1;
		*TopStock = *TopStock + 1;

		Pile = 5;
		*Drawx = x;
		*Drawy = y;
		PrintCard ( Drawcard, Drawx, Drawy, &Pile, TopWaste, 0, 0, Sound);
	}
	else
	{
		if( *TopStock == 52)
		{
			if( Cycle == 1)
			{
				CycleDeck(Waste, *TopWaste, Stock, Sound);
				*TopStock = 52 - *TopWaste;
				*TopWaste = 0;
				if( DeckLoop == 1)
				*Score = *Score - 52;
			}
		}
	}
}


HitWasteOff (struct Card Waste[24], struct Card Carry[20], int *TopWaste,
struct Card Foundation[4], int *Drawx, int *Drawy, int *GotCard,
int *Score, int My, int Sound)

{

	int loop1, x, y, Pile, coordsy, coordey;
	/* char buffer[10]; */
	BOOL swap;

	swap = FALSE;
	x = 1;
	y = 2;

	/* Set up check for if they hit ON the card.. */
	coordsy = 1 + ((*TopWaste - 1) * 5);
	coordey = coordsy + 46;
	/* Done setting up... */

	if( Waste[*TopWaste-1].cardname != 0)
	{
		Carry[0].cardname = Waste[*TopWaste-1].cardname;
		Carry[0].cardsuit = Waste[*TopWaste-1].cardsuit;
		Waste[*TopWaste-1].cardname = 0;
		Waste[*TopWaste-1].cardsuit = '0';
		*TopWaste = *TopWaste - 1;
		DrawWasteBox (TopWaste);
		*GotCard = 1;

		for( loop1 = 0; loop1 < 4; loop1++)
		{
			if( (Carry[0].cardname - 1) == Foundation[loop1].cardname)
			{
				if( Carry[0].cardsuit == Foundation[loop1].cardsuit)
				{
					if( (My > coordsy) && (My < coordey))
					{
						y = 2 + (*TopWaste * 5);
						DrawImage( my_window->RPort, &BLANK_image, x, y);
						y = 2 + ((*TopWaste-1) * 5);
						*Drawx = x;
						*Drawy = y;
						Pile = 5;
						PrintCard ( Drawcard, Drawx, Drawy, &Pile, TopWaste, 0, 0, 0);
						swap = TRUE;
						Pile = loop1;
						*Score = *Score + 5;
					}
				}
			}
		}
		/* Done testing against 4 columns.. */

		if( swap)
		{
			Foundation[Pile].cardname = Carry[0].cardname;
			Foundation[Pile].cardsuit = Carry[0].cardsuit;
			*Drawx = 68;
			*Drawy = 2;
			PrintCard ( Drawcard, Drawx, Drawy, &Pile, TopWaste, 0, 0, Sound);
			SetUpCarry ( Carry, GotCard);
			/*  if( (Sound == 1) || (Sound == 3) ) */
			if( (Sound >> 1) & 1U)
			{
				PlaySound( sound_point, MAXVOLUME, RIGHT0, NORMALRATE, 1);
				Delay( 30);
				StopSound ( RIGHT0) ;
			}
			if((Foundation[0].cardname == 13) && (Foundation[1].cardname == 13) &&
					(Foundation[2].cardname == 13) && (Foundation[3].cardname == 13))
			{
				YouWon ( Sound);
			}
		}
	}
}

PrintCard (struct Card Drawcard, int *Drawx, int *Drawy, int *Pile,
int *TopWaste, int *loop1, int *loop2, int Sound)

{
	int x, y;
	char buffer[10];
	BOOL Found;

	x = *Drawx;
	y = *Drawy;
	if (y > 145)
	y = 145;
	Found = FALSE;

	/*  if( (sound == 1) || (sound == 2) ) */
	if( (Sound >> 0) & 1U)
	PlaySound( sound_card, MAXVOLUME, LEFT1, NORMALRATE, 1);

	if (*Pile == 5)
	{
		Drawcard.cardname = Waste[*TopWaste-1].cardname;
		Drawcard.cardsuit = Waste[*TopWaste-1].cardsuit;
	}
	if( *Pile == 4)
	{
		Drawcard.cardname = Column[*loop1][*loop2].cardname;
		Drawcard.cardsuit = Column[*loop1][*loop2].cardsuit;
	}
	if( *Pile < 4)
	{
		Drawcard.cardname = Foundation[*Pile].cardname;
		Drawcard.cardsuit = Foundation[*Pile].cardsuit;
		Found = TRUE;
	}

	if( Drawcard.cardname != 0)
	{
		/* Get name for drawing to image..	*/
		if( Drawcard.cardname < 11)
		sprintf(buffer, "%d", Drawcard.cardname);
		else if( Drawcard.cardname == 11)
		sprintf(buffer, "%c", 'J');
		else if( Drawcard.cardname == 12)
		sprintf(buffer, "%c", 'Q');
		else if( Drawcard.cardname == 13)
		sprintf(buffer, "%c", 'K');
		if( Drawcard.cardname == 1)
		sprintf(buffer, "%c", 'A');
		/* Got name...	 */
		/* Choose which suit and where to draw it... */
		if( Drawcard.cardsuit == 'H')
		{
			if( Found)
			y = y + 141;
			DrawImage( my_window->RPort, &HEART_image, x, y);
			SetAPen(my_window->RPort, 3);
		}
		if( Drawcard.cardsuit == 'S')
		{
			if( Found)
			y = y + 0;
			DrawImage( my_window->RPort, &SPADE_image, x, y);
			SetAPen(my_window->RPort, 2);
		}
		if ( Drawcard.cardsuit == 'C')
		{
			if( Found)
			y = y + 47;
			DrawImage( my_window->RPort, &CLUB_image, x, y);
			SetAPen(my_window->RPort, 2);
		}
		if( Drawcard.cardsuit == 'D')
		{
			if( Found)
			y = y + 94;
			DrawImage( my_window->RPort, &DIAMOND_image, x, y);
			SetAPen(my_window->RPort, 3);
		}
		/* Done drawing suit image...	  */
		/* Draw card name on card..  */
		Move ( my_window->RPort, (x + 2), (y + 8));
		Text( my_window->RPort, buffer, strlen(buffer));
		Move ( my_window->RPort, (x + 51), (y + 42));
		if( Drawcard.cardname == 10)
		Move ( my_window->RPort, (x + 43), (y + 42));
		Text( my_window->RPort, buffer, strlen(buffer));
		/* Done drawing name on card... */
	}
	/*  if( (sound == 1) || (sound == 2) ) */
	if( (Sound >> 0) & 1U)
	{
		Delay( 8);
		StopSound( LEFT1);
	}
}

HitWasteOn (struct Card Carry[20], struct Card Column[7][20], int *GotCard,
int *PileNumber, struct Card Waste[24], int *TopWaste,
struct Card Drawcard, int *Drawx, int *Drawy, *FirstPile)

{
	int loop1, count, Pile;
	/*  char colorl, color2; */
	BOOL copy, check, search;

	count = 0;
	loop1 = 0;
	check = TRUE;
	search = TRUE;
	copy = FALSE;

	/* Pick up and put down in the same pile */
	if( *PileNumber == *FirstPile)
	{
		Waste[*TopWaste].cardname = Carry[0].cardname;
		Waste[*TopWaste].cardsuit = Carry[0].cardsuit;
		*TopWaste = *TopWaste + 1;
		Pile = 5;
		*Drawx = 1;
		*Drawy = 2 + ((*TopWaste - 1) * 5);
		PrintCard ( Drawcard, Drawx, Drawy, &Pile, TopWaste, 0, 0, 0);
		check = FALSE;
		copy = FALSE;
		SetUpCarry( Carry, GotCard);
	}

}

DrawBox ( int *start, int *count, int *PileNumber)

{
	int sx, sy, ex, ey; /* start and end x,y co-ords */

	sx = 139 + ( *PileNumber * 73);
	sy = 2 + ( *start * 10);
	ex = sx + 60;
	ey = sy + 44 + ((*count - 1) * 10);
	if( ey > 189)
	ey = 189;
	SetAPen( my_window->RPort, 3);
	Move( my_window->RPort, sx, sy);
	Draw( my_window->RPort, sx, ey);
	Draw( my_window->RPort, ex, ey);
	Draw( my_window->RPort, ex, sy);
	Draw( my_window->RPort, sx, sy);

}

DrawWasteBox ( int *TopWaste)

{

	int sx, sy, ex, ey; /* start and end x,y co-ords */

	sx = 1;
	sy = 2 + ( (*TopWaste) * 5);
	ex = sx + 60;
	ey = sy + 44;
	SetAPen( my_window->RPort, 3);
	Move( my_window->RPort, sx, sy);
	Draw( my_window->RPort, sx, ey);
	Draw( my_window->RPort, ex, ey);
	Draw( my_window->RPort, ex, sy);
	Draw( my_window->RPort, sx, sy);

}

YouWon ( int Sound )
{
	int loop;
	char *wintext[]=
	{
		"YOU",
		"WON"
	};

	SetDrMd(my_window->RPort,JAM2);
	SetBPen(my_window->RPort, 0);

	/* Clear the screen. B Pen is Purple for background */
	Move( my_window->RPort, 0, 0);
	ClearScreen( my_window->RPort);
	SetBPen(my_window->RPort, 1);

	/*  if( (sound == 1) || (sound == 3) ) */
	if( (Sound >> 1) & 1U)
	{
		PlaySound( sound_win, MAXVOLUME, LEFT1, NORMALRATE, 0);
		Delay( 28);
		PlaySound( sound_win, MAXVOLUME, RIGHT0, NORMALRATE, 0);
	}
	for( loop = 20; loop < 560; loop = loop + 20)
	{
		/*    if( (sound == 1) || (sound == 2) ) */
		if( (Sound >> 0) & 1U)
		PlaySound( sound_card, MAXVOLUME, RIGHT1, NORMALRATE, 1);
		DrawImage( my_window->RPort, &DOWN_image, loop, 10);
		DrawImage( my_window->RPort, &DOWN_image, loop, 130);
		/*    if( (sound == 1) || (sound == 2) )  */
		if( (Sound >> 0) & 1U)
		{
			Delay(8);
			StopSound( RIGHT1);
		}
	}
	/*  if( (sound == 1) || (sound == 2) )	*/
	if( (Sound >> 0) & 1U)
	PlaySound( sound_card, MAXVOLUME, RIGHT1, NORMALRATE, 1);
	DrawImage( my_window->RPort, &HEART_image, 285, 70);
	Move( my_window->RPort, 303, 79);
	Text( my_window->RPort, wintext[0], 3);
	Move( my_window->RPort, 303, 111);
	Text( my_window->RPort, wintext[1], 3);
	/*  if( (sound == 1) || (sound == 2) ) */
	if( (Sound >> 0) & 1U)
	{
		Delay(8);
		StopSound( RIGHT1);
	}
	/*  if( (sound == 1) || (sound == 3) )	*/
	if( (Sound >> 1) & 1U)
	{
		Delay(50);
		StopSound( LEFT1);
		StopSound( RIGHT0);
	}
}

LoadSounds (int *Sound)
{
	USHORT number;

	/* Time to do the sound stuff	*/
	sound_card = PrepareSound( "card.iff");
	if( !sound_card) RemoveSound( sound_card);

	sound_point = PrepareSound( "point.iff");
	if( !sound_point) RemoveSound( sound_point);

	sound_win = PrepareSound( "win.iff");
	if ( !sound_win) RemoveSound ( sound_win);

	if((!sound_card) || (!sound_point) || (!sound_win))
	{
		number = SHIFTMENU( 1 ) + SHIFTITEM( 0 ) + SHIFTSUB( NOSUB );
		OffMenu (my_window, number);
		number = SHIFTMENU( 1 ) + SHIFTITEM( 1 ) + SHIFTSUB( NOSUB );
		OffMenu (my_window, number);
		*Sound = 0;
	}
}

CycleDeck ( struct Card Waste[24], int TopWaste, struct Card Stock[52],
int Sound)
{
	int loop, loop1;

	DrawImage( my_window->RPort, &BLANK_image, 1,0);
	DrawImage( my_window->RPort, &BLANK_image, 1,45);
	DrawImage( my_window->RPort, &BLANK_image, 1,90);
	DrawImage( my_window->RPort, &BLANK_image, 1,135);
	DrawImage( my_window->RPort, &BLANK_image, 1,143);

	loop1 = 0;
	for( loop = 0; loop < 52; loop++)
	{
		if( loop > (51 - TopWaste))
		{
			Stock[loop].cardname = Waste[loop1].cardname;
			Stock[loop].cardsuit = Waste[loop1].cardsuit;
			loop1 = loop1 + 1;
		}
		else
		Stock[loop].cardname = 0;
	}
	for( loop = 0; loop < 24; loop ++)
	Waste[loop].cardname = 0;

	/* Draw Deck Card...	       */
	/* if( (Sound == 1) || (Sound == 2) ) */
	if( (Sound >> 0) & 1U)
	PlaySound( sound_card, MAXVOLUME, LEFT1, NORMALRATE, 1);
	DrawImage( my_window->RPort, &DOWN_image, 1, 143);
	if( (Sound == 1) || (Sound == 2) )
	{
		Delay( 8);
		StopSound( LEFT1);
	}
}
