/*
 *     display.c
 *
 */

#include "Bomber.h"
#include <exec/memory.h>
#include "sound.h"


#ifdef DEBUG
# define D(debug) debug
#else
# define D(debug)
#endif


#define BUTTON_SIZE 12


/*------------------------- Externe Daten...*/


extern struct ExecBase	*SysBase;
extern struct Library	*DOSBase;

extern long				fenster;

extern int				size_x, size_y, spiel_level, practice_mode;


/*------------------------- Daten dieses Moduls...*/


struct IntuitionBase	*IntuitionBase = NULL;
struct GfxBase			*GfxBase = NULL;
struct Library			*GadToolsBase = NULL;

struct TextAttr 		topaz8 =
						{
							"topaz.font", 8, 0,	0
						};

struct TextFont			*font = NULL;
struct Screen			*screen = NULL;
struct Window			*window = NULL;
void					*vi = NULL;
struct Gadget			*glist = NULL;

int						minimal_width, minimal_height,
						spielfeld_links, spielfeld_oben,
						spielfeld_rechts, spielfeld_unten;

char					*texte_level[] =
						{ "Easy", "Medium", "Hard", "Alien" };

enum {
	GAD_NEU = 0, GAD_FLAGS_REMAINING, GAD_COUNT_DOWN,
	GAD_PRACTICE, GAD_LEVEL, GAD_ABOUT, GAD_HIGHSCORE,
	GAD_ANZAHL };

struct Gadget			*mgg[ GAD_ANZAHL ];

int						time_counter = 0,
						flag_counter = 0;


/*------------------------- Images...*/


USHORT ImageData_flag[] = {
	/* Plane 0... */
	0x0000,0x0010,0x0810,0x0fd0,0x0810,0x0810,0x0810,0x0810,
	0x1c10,0x3e10,0x0010,0xfff0,
	/* Plane 1... */
	0xfff0,0x8000,0x87c0,0x87c0,0x87c0,0x8000,0x8000,0x8000,
	0x8000,0x8000,0x8000,0x0000
};

struct Image Image_flag = {
	0, 0,
	12, 12, 2,
	ImageData_flag,
	0x0003, 0x0000,
	NULL
};


USHORT ImageData_clock[] = {
	/* Plane 0... */
	0x71c0,0xeee0,0xb5a0,0x4440,0x4440,0x8420,0xe7e0,0x8020,
	0x4040,0x4440,0x75c0,0xeee0,
	/* Plane 1... */
	0x0000,0x0000,0x0e00,0x3b80,0x3b80,0x7bc0,0x78c0,0x7fc0,
	0x3f80,0x3f80,0x0e00,0x0000,
};

struct Image Image_clock = {
	0, 0,
	11, 12, 2,
	ImageData_clock,
	0x0003, 0x0000,
	NULL
};


USHORT ImageData_bomb[] = {
	/* Plane 0... */
	0x0000,0x16b0,0x4910,0x2f50,0x0610,0x1f90,0x37d0,0x3fd0,
	0x3fd0,0x1f90,0x0010,0xfff0,
	/* Plane 1... */
	0xfff0,0x96a0,0xcf00,0xa040,0x8000,0x8000,0x8c00,0x9000,
	0x8000,0x8000,0x8000,0x0000
};

struct Image Image_bomb = {
	0, 0,
	12, 12, 2,
	ImageData_bomb,
	0x0003, 0x0000,
	NULL
};


USHORT ImageData_cover[] = {
	/* Plane 0... */
	0x0000,0x2ab0,0x5550,0x2ab0,0x5550,0x2ab0,0x5550,0x2ab0,
	0x5550,0x2ab0,0x5550,0xfff0,
	/* Plane 1... */
	0xfff0,0xaaa0,0xd540,0xaaa0,0xd540,0xaaa0,0xd540,0xaaa0,
	0xd540,0xaaa0,0xd540,0x0000
};

struct Image Image_cover = {
	0, 0,
	12, 12, 2,
	ImageData_cover,
	0x0003, 0x0000,
	NULL
};


USHORT ImageData_field[] = {
	/* Plane 0... */
	0x0000,0x0010,0x0010,0x0010,0x0010,0x0010,0x0010,0x0010,
	0x0010,0x0010,0x0010,0xfff0,
	/* Plane 1... */
	0xfff0,0x8000,0x8000,0x8000,0x8000,0x8000,0x8000,0x8000,
	0x8000,0x8000,0x8000,0x0000
};

struct Image Image_field = {
	0, 0,
	12, 12, 2,
	ImageData_field,
	0x0003, 0x0000,
	NULL
};


typedef struct {
	USHORT *id;
	long size;
	struct Image *im; } CIliste;

#define ELEMENT(a,b) a, sizeof(a), b
#define ENDE NULL, NULL, NULL

CIliste images[] = {
	ELEMENT( ImageData_flag , &Image_flag  ),
	ELEMENT( ImageData_clock, &Image_clock ),
	ELEMENT( ImageData_bomb , &Image_bomb  ),
	ELEMENT( ImageData_cover, &Image_cover ),
	ELEMENT( ImageData_field, &Image_field ),
	ENDE };

struct Remember *ChipImages = NULL;


void InitChipImages( CIliste list[] )
{
	char *memblock;
	long sum = 0;
	int i;
	
	for( i=0; list[i].id; i++ )
		sum += list[i].size;

	memblock = AllocRemember( &ChipImages, sum, MEMF_CHIP );
	
	for( i=0; list[i].id; i++ )
	{
		CopyMem( list[i].id, memblock, list[i].size );
		list[i].im->ImageData = memblock;
		memblock += list[i].size;
	}
}


void FreeChipImages( void )
{
	FreeRemember( &ChipImages, TRUE );
}


/*------------------------- Code-Deklarationen...*/


extern void sendtimereq( long s, long m );
extern void quit( char * );

extern void neues_spiel( void );
extern void spielende( void );
extern void free_spielfeld( void );
extern void set_flag( int x, int y );
extern void uncover_field( int x, int y );

extern void highscore_show( void );

extern void sound_play( int );


static void resize_spielfeld( void );


/*------------------------- Stub-Code...*/


struct Gadget *CreateGadget( unsigned long kind, struct Gadget *gad,
	struct NewGadget *ng, Tag tag1, ... )
{
	return CreateGadgetA( kind, gad, ng, (struct TagItem *)&tag1 );
}

APTR GetVisualInfo( struct Screen *screen, Tag tag1, ... )
{
	return GetVisualInfoA( screen, (struct TagItem *)&tag1 );
}

struct Window *OpenWindowTags( struct NewWindow *newWindow,
	unsigned long tag1Type, ... )
{
	return OpenWindowTagList( newWindow, (struct TagItem *)&tag1Type );
}

void DrawBevelBox( struct RastPort *rp,
	long l, long t, long w, long h,
	Tag tag1, ... )
{
	DrawBevelBoxA( rp, l, t, w, h, (struct TagItem *)&tag1 );
}

void GT_SetGadgetAttrs( struct Gadget *gad, struct Window *win,
	struct Requester *req, Tag tag1, ... )
{
	GT_SetGadgetAttrsA( gad, win, req, (struct TagItem *)&tag1 );
}


void PutChProc( void )
{
	#asm
	move.b	d0,(a3)+
	rts
	#endasm
}


void SPrintf( UBYTE *dst, UBYTE *fmt, ... )
{
	RawDoFmt( fmt, (APTR)((long)&fmt + 4L), PutChProc, dst );
}


/*------------------------- Code-Definitionen...*/


static struct Gadget *create_gadgets(
	struct Gadget **glistptr, void *vi )
{
	struct NewGadget	ng;
	struct Gadget		*gad;
	struct RastPort		*rp;
	int					topborder,
						leftborder;
	long				tl; /* wg. cc-Fehler */
	
	
	// Erste Reihe...
	
	topborder  = screen->WBorTop + screen->Font->ta_YSize + 1;
	leftborder = screen->WBorLeft;
	rp  = & screen->RastPort;
	gad = CreateContext(glistptr);
	
	ng.ng_TopEdge  = topborder + INTERHEIGHT;
	ng.ng_Height = screen->Font->ta_YSize + 4;
	if( ng.ng_Height < 12 ) ng.ng_Height=12;
	ng.ng_VisualInfo = vi;
	ng.ng_TextAttr = screen->Font;
	ng.ng_UserData = 0;
	ng.ng_Flags = 0;
	
	ng.ng_GadgetID = GAD_PRACTICE;
	ng.ng_GadgetText = "Practice";
	tl = TextLength( rp, "Practice", 8 );
	ng.ng_LeftEdge = leftborder + 2*INTERWIDTH + tl;
	ng.ng_Width = ng.ng_Height;
	
	mgg[GAD_PRACTICE] = gad = CreateGadget( CHECKBOX_KIND, gad, &ng,
		GTCB_Checked, FALSE,
		TAG_DONE );
	
	ng.ng_GadgetID = GAD_LEVEL;
	ng.ng_GadgetText = NULL;
	ng.ng_LeftEdge += mgg[GAD_PRACTICE]->Width + 2*INTERWIDTH;
	tl = TextLength( rp, " Medium ", 8 );
	ng.ng_Width = tl + 28;
	
	mgg[GAD_LEVEL] = gad = CreateGadget( CYCLE_KIND, gad, &ng,
		GTCY_Labels, &texte_level,
		TAG_DONE );
	
	ng.ng_GadgetID = GAD_ABOUT;
	ng.ng_GadgetText = "About";
	ng.ng_LeftEdge += mgg[GAD_LEVEL]->Width + 2*INTERWIDTH;
	tl = TextLength( rp, " About ", 7 );
	ng.ng_Width = tl + 4;
	
	mgg[GAD_ABOUT] = gad = CreateGadget( BUTTON_KIND, gad, &ng,
		TAG_DONE );
	
	
	// Zweite Reihe...
	
	ng.ng_TopEdge += ng.ng_Height + INTERHEIGHT;
	
	
	ng.ng_GadgetID = GAD_NEU;
	ng.ng_GadgetText = "New";
	ng.ng_LeftEdge = leftborder + INTERWIDTH;
	tl = TextLength( rp, " New ", 5 );
	ng.ng_Width = tl + 4;
	
	mgg[GAD_NEU] = gad = CreateGadget( BUTTON_KIND, gad, &ng,
		TAG_DONE );
	
	ng.ng_GadgetText = NULL;
	tl = TextLength( rp, "00000", 5 );
	ng.ng_Width = tl + 8;
	
	ng.ng_GadgetID = GAD_FLAGS_REMAINING;
	ng.ng_LeftEdge += gad->Width + 12 + 3*INTERWIDTH;
	
	mgg[GAD_FLAGS_REMAINING] = gad = CreateGadget( NUMBER_KIND, gad, &ng,
		GTNM_Number, 0,
		GTNM_Border, TRUE,
		GTBB_Recessed, TRUE,
		TAG_DONE );
	
	ng.ng_GadgetID = GAD_COUNT_DOWN;
	ng.ng_LeftEdge += gad->Width + 12 + 2*INTERWIDTH;
	
	mgg[GAD_COUNT_DOWN] = gad = CreateGadget( NUMBER_KIND, gad, &ng,
		GTNM_Number, 0,
		GTNM_Border, TRUE,
		GTBB_Recessed, TRUE,
		TAG_DONE );
	
	ng.ng_GadgetID = GAD_HIGHSCORE;
	ng.ng_GadgetText = "HiSc";
	tl = TextLength( rp, " HiSc ", 6 );
	ng.ng_Width = tl + 4;
	ng.ng_LeftEdge = mgg[GAD_ABOUT]->LeftEdge
					+ mgg[GAD_ABOUT]->Width - ng.ng_Width;
	
	mgg[GAD_HIGHSCORE] = gad = CreateGadget( BUTTON_KIND, gad, &ng,
		TAG_DONE );
	
	return( gad );
}


void window_sizing( BOOL possible )
{
	if( possible )
	{
		/* Window-Sizing lösen */
		WindowLimits( window, minimal_width, minimal_height,
							  -1,			 -1 );
		
		/* Gadgets einschalten */
		GT_SetGadgetAttrs( mgg[GAD_PRACTICE], window, NULL,
			GA_DISABLED, FALSE, TAG_DONE );
		GT_SetGadgetAttrs( mgg[GAD_LEVEL], window, NULL,
			GA_DISABLED, FALSE, TAG_DONE );
		GT_SetGadgetAttrs( mgg[GAD_ABOUT], window, NULL,
			GA_DISABLED, FALSE, TAG_DONE );
		GT_SetGadgetAttrs( mgg[GAD_HIGHSCORE], window, NULL,
			GA_DISABLED, FALSE, TAG_DONE );
	}
	else
	{
		/* Window fixieren */
		WindowLimits( window, window->Width, window->Height,
							  window->Width, window->Height );
		
		/* Gadgets ausschalten */
		GT_SetGadgetAttrs( mgg[GAD_PRACTICE], window, NULL,
			GA_DISABLED, TRUE, TAG_DONE );
		GT_SetGadgetAttrs( mgg[GAD_LEVEL], window, NULL,
			GA_DISABLED, TRUE, TAG_DONE );
		GT_SetGadgetAttrs( mgg[GAD_ABOUT], window, NULL,
			GA_DISABLED, TRUE, TAG_DONE );
		GT_SetGadgetAttrs( mgg[GAD_HIGHSCORE], window, NULL,
			GA_DISABLED, TRUE, TAG_DONE );
	}
}


void init_display( void )
// Libs, Fenster öffnen etc.
{
	if( !(GfxBase = (struct GfxBase *)
			OpenLibrary("graphics.library", 36L)) )
		quit( "No graphics.library >= V36!\n" );
	
	if( !(IntuitionBase = (struct IntuitionBase *)
			OpenLibrary("intuition.library", 36L)) )
		quit( "No intuition.library >= V36!\n" );
	
	if( !(GadToolsBase = OpenLibrary("gadtools.library", 36L)) )
		quit( "No gadtools.library >= V36!\n" );
	
	if( !(font = OpenFont(&topaz8)) )
		quit( "Can't open topaz.font!\n" );
	
	if( !(screen = LockPubScreen(NULL)) )
		quit( "Can't lock pubscreen!\n" );
	
	if( !(vi = GetVisualInfo(screen,TAG_DONE)) )
		quit( "No VisualInfo!\n" );
	
	InitChipImages( images );
	
	if( !create_gadgets(&glist,vi) )
		quit( "Can't create gadgets!\n" );
	
	window = OpenWindowTags( NULL,
		WA_Title,			"Bomber 1.2",
		WA_Width,			100,
		WA_Height,			50,
		WA_MinWidth,		100,
		WA_MinHeight,		50,
		WA_MaxWidth,		-1,
		WA_MaxHeight,		-1,
		WA_PubScreen,		screen,
		
		WA_SizeGadget,		TRUE,
		WA_DragBar,			TRUE,
		WA_DepthGadget,		TRUE,
		WA_CloseGadget,		TRUE,
		WA_RMBTrap,			TRUE,
		WA_SmartRefresh,	TRUE,
		WA_Activate,		TRUE,
		
		WA_IDCMP, CLOSEWINDOW | REFRESHWINDOW |
				  BUTTONIDCMP | NEWSIZE | MOUSEBUTTONS,
		TAG_DONE );
	
	if( !window )
		quit( "Unable to open window!\n" );
	
	spielfeld_links = mgg[GAD_NEU]->LeftEdge;
	
	minimal_width  = mgg[GAD_ABOUT]->LeftEdge + mgg[GAD_ABOUT]->Width +
					 INTERWIDTH + window->BorderRight;
	
	spielfeld_oben = mgg[GAD_NEU]->TopEdge + mgg[GAD_NEU]->Height +
					 INTERHEIGHT;
	
	minimal_height = spielfeld_oben + 2*BUTTON_SIZE+2 +
					 INTERHEIGHT + window->BorderBottom;
	
	/* Fenster verändern (Auftrag an Intuition!) */
	ChangeWindowBox( window,
		(screen->Width - minimal_width ) / 2,
		(screen->Height - minimal_height - 6*BUTTON_SIZE) / 2,
		minimal_width, minimal_height + 6*BUTTON_SIZE );
	
	/* Fensterveränderungen abwarten! */
	Delay( 8 );
	
	WindowLimits( window, minimal_width, minimal_height, -1, -1 );
	
	/* Fensterveränderungen abwarten! */
	Delay( 8 );
	
	fenster = 1 << window->UserPort->mp_SigBit;
	
	AddGList( window, glist, 0, -1, NULL );
	RefreshGList( glist, window, NULL, -1 );
	GT_RefreshWindow( window, NULL );
	
	DrawImage( window->RPort, &Image_flag,
		mgg[GAD_FLAGS_REMAINING]->LeftEdge - 12 - INTERWIDTH,
		mgg[GAD_FLAGS_REMAINING]->TopEdge +
			(mgg[GAD_FLAGS_REMAINING]->Height - 12) / 2 );
	DrawImage( window->RPort, &Image_clock,
		mgg[GAD_COUNT_DOWN]->LeftEdge - 12 - INTERWIDTH,
		mgg[GAD_COUNT_DOWN]->TopEdge +
			(mgg[GAD_COUNT_DOWN]->Height - 12) / 2 );
	
	resize_spielfeld();
}


void close_display( void )
{
	if(window) CloseWindow(window);

	if(GadToolsBase)
	{
		FreeGadgets(glist);
		FreeVisualInfo(vi);
		CloseLibrary(GadToolsBase);
	}

	FreeChipImages();
	if(screen) UnlockPubScreen(NULL, screen);
	if(font) CloseFont(font);

	if(IntuitionBase) CloseLibrary(IntuitionBase);
	if(GfxBase) CloseLibrary(GfxBase);
}


void draw_field( int x, int y, UBYTE inhalt )
{
	static struct IntuiText zahl = {
		1,0, JAM1, 2,2, &topaz8, "0", NULL
	};
	
	x *= BUTTON_SIZE; x += spielfeld_links + 1;
	y *= BUTTON_SIZE; y += spielfeld_oben  + 1;
	
	if( inhalt & 64 )
	{
		DrawImage( window->RPort, &Image_flag, x, y );
	}
	else if( inhalt & 128 )
	{
		DrawImage( window->RPort, &Image_cover, x, y );
	}
	else if( inhalt & 32 )
	{
		DrawImage( window->RPort, &Image_bomb, x, y );
	}
	else
	{
		DrawImage( window->RPort, &Image_field, x, y );
		
		if( inhalt & 31 )
		{
			*zahl.IText = '0' + inhalt;
			PrintIText( window->RPort, &zahl, x, y );
		}
	}
}


void clear_spielfeld( void )
{
	SetAPen( window->RPort, 0 );
	RectFill( window->RPort,
		spielfeld_links  + 1, spielfeld_oben  + 1,
		spielfeld_rechts - 1, spielfeld_unten - 1 );
}


static void handle_button( struct Gadget *gad, UWORD code )
{
	static struct EasyStruct aboutreq = {
		sizeof (struct EasyStruct), 0,
		"About Bomber 1.2",
		"Amiga Version by Michael Balzer, October 1991\n\n"
		"Find all bombs! Use right button to flag bombs,\n"
		"left button to uncover fields / remove flags.\n"
		"Click right button over flag to reveal a field\n" 
		"(attention: time punishment of 5 percent).\n"
		"Uncovered fields will show the number of bombs\n"
		"next to them (up to 8)...\n\n"
		"This software is »HappyWare« - if you use it,\n"
		"remember to smile!   :-)\n\n"
		"        Have fun!",
		" I'll do! " };
	
	
	switch( gad->GadgetID )
	{
		case GAD_NEU:
			neues_spiel();
			break;
		
		case GAD_LEVEL:
			spiel_level = code;
			break;
		
		case GAD_PRACTICE:
			practice_mode = gad->Flags & SELECTED;
			break;
		
		case GAD_ABOUT:
			EasyRequestArgs( window, &aboutreq, NULL, NULL );
			break;
		
		case GAD_HIGHSCORE:
			highscore_show();
			break;
	}
}


static void handle_click( int x, int y, UWORD code )
{
	if( time_counter || practice_mode )
	{
		if( code==SELECTDOWN )
		{
			uncover_field( x, y );
		}
		else if( code==MENUDOWN )
		{
			set_flag( x, y );
		}
	}
}


static void resize_spielfeld( void )
{
	/* size_x/y neu berechnen, Spielfeldrahmen zeichnen */
	static char sizetext[10];
	static struct IntuiText sizeitext = {
		1,0, JAM1, 0,0, &topaz8, sizetext, NULL
	};
		
	
	// Speicher freigeben
	free_spielfeld();
	
	SetAPen( window->RPort, 0 );
	RectFill( window->RPort, spielfeld_links, spielfeld_oben,
		window->Width  - window->BorderRight  - 1,
		window->Height - window->BorderBottom - 1 );
	
	spielfeld_rechts = window->Width - window->BorderRight - INTERWIDTH;
	size_x = spielfeld_rechts - spielfeld_links - 1;
	spielfeld_rechts -= size_x % BUTTON_SIZE;
	size_x /= BUTTON_SIZE;
	
	spielfeld_unten = window->Height - window->BorderBottom - INTERHEIGHT;
	size_y = spielfeld_unten - spielfeld_oben - 1;
	spielfeld_unten -= size_y % BUTTON_SIZE;
	size_y /= BUTTON_SIZE;
	
	DrawBevelBox( window->RPort,
		spielfeld_links, spielfeld_oben,
		spielfeld_rechts - spielfeld_links + 1,
		spielfeld_unten - spielfeld_oben + 1,
		GTBB_Recessed, TRUE,
		GT_VisualInfo, vi,
		TAG_DONE );
	
	SPrintf( sizetext, "%ld*%ld", size_x, size_y );
	sizeitext.LeftEdge = (spielfeld_rechts - spielfeld_links
						 - 8*strlen(sizetext)) / 2;
	sizeitext.TopEdge  = (spielfeld_unten  - spielfeld_oben - 4) / 2;
	PrintIText( window->RPort, &sizeitext,
				spielfeld_links, spielfeld_oben );
}


BOOL handle_window_event( void )
{
	struct IntuiMessage	*imsg;
	struct Gadget		*gad;
	ULONG				class;
	UWORD				code;
	WORD				x, y;
	
	
	while( imsg = GT_GetIMsg(window->UserPort) )
	{
		class = imsg->Class;
		code  = imsg->Code;
		gad = (struct Gadget *)imsg->IAddress;
			// ^^^ natürlich nur bei Gadgets gültig
		x = imsg->MouseX;
		y = imsg->MouseY;
		GT_ReplyIMsg( imsg );
		
		switch( class )
		{
			case MOUSEBUTTONS:
				if( x>spielfeld_links && x<spielfeld_rechts
				 && y>spielfeld_oben  && y<spielfeld_unten )
				{
					handle_click(
						(x-spielfeld_links-1) / BUTTON_SIZE,
						(y-spielfeld_oben-1 ) / BUTTON_SIZE,
						code );
				}
				break;
			
			case GADGETUP:
				handle_button( gad, code );
				break;
			
			case NEWSIZE:
				if( time_counter == 0 )
				{
					resize_spielfeld();
				}
				break;
			
			case CLOSEWINDOW:
				return( TRUE );
				break;
			
			case REFRESHWINDOW:
				GT_BeginRefresh( window );
				GT_EndRefresh( window, TRUE );
				break;
		}
	}
	
	return( FALSE );
}


void count_down( void )
{
	D(printf("count_down: time=%d\n", time_counter));
	
	if( ! time_counter ) return;
	
	--time_counter;
	
	/* Zeit auch während graf. Lock weiterzählen */
	if( AttemptLockLayerRom(window->RPort->Layer) )
	{
		UnlockLayerRom( window->RPort->Layer );
		GT_SetGadgetAttrs( mgg[GAD_COUNT_DOWN], window, NULL,
			GTNM_Number, time_counter,
			TAG_DONE );
	}
	
	if( time_counter )
	{
		sendtimereq( 1, 0 );
	}
	else
	{
		sound_play( SOUND_EXPLOSION );
		window_sizing( TRUE );
		
		if( !practice_mode )
		{
			/* GAME OVER durch TimeOut */
			spielende();
		}
	}
}


void change_flagcounter( int wert )
{
	flag_counter += wert;
	
	// s.o.
	if( AttemptLockLayerRom(window->RPort->Layer) )
	{
		UnlockLayerRom( window->RPort->Layer );
		GT_SetGadgetAttrs( mgg[GAD_FLAGS_REMAINING], window, NULL,
			GTNM_Number, flag_counter,
			TAG_DONE );
	}
}
