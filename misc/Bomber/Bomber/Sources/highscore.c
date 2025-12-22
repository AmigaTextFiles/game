/*
 *     highscore.c
 *
 */

#include "Bomber.h"
#include "sound.h"


#if DEBUG
# define D(debug) debug
#else
# define D(debug)
#endif


/*------------------------- Externe Daten...*/


extern struct ExecBase	*SysBase;
extern struct Library	*DOSBase;

extern struct IntuitionBase	*IntuitionBase;
extern struct GfxBase	*GfxBase;
extern struct Library	*GadToolsBase;

extern struct Window	*window;
extern struct Screen	*screen;
extern void				*vi;

extern char				*texte_level[];

extern int				gesamtzeit;


/*------------------------- Daten dieses Moduls...*/


struct hisc_entry
{
	char	name[20];
	int		size_x,
			size_y,
			level,
			restzeit;
	long	score;
}						hisc_liste[10];


#define NAME(n)			hisc_liste[n].name
#define X(n)			hisc_liste[n].size_x
#define Y(n)			hisc_liste[n].size_y
#define NLEVEL(n)		hisc_liste[n].level
#define LEVEL(n)		texte_level[ NLEVEL(n) ]
#define ZEIT(n)			hisc_liste[n].restzeit
#define SCORE(n)		hisc_liste[n].score


/*------------------------- Code-Deklarationen...*/


extern void sound_play( int );


/*------------------------- Stub-Code...*/


LONG EasyRequest( struct Window *window, struct EasyStruct *easyStruct,
	ULONG *idcmpPtr, APTR arg1, ... )
{
	return EasyRequestArgs( window, easyStruct, idcmpPtr, (struct TagItem *)&arg1 );
}


/*------------------------- Code-Definitionen...*/


void load_hisc( void )
{
	BPTR fh;
	
	if( fh = Open( "Bomber.HiSc", MODE_OLDFILE ) )
	{
		Read( fh, hisc_liste, sizeof(hisc_liste) );
		Close( fh );
	}
	else
	{
		memset( hisc_liste, 0, sizeof(hisc_liste) );
	}
}


void save_hisc( void )
{
	BPTR fh;
	
	if( fh = Open( "Bomber.HiSc", MODE_NEWFILE ) )
	{
		Write( fh, hisc_liste, sizeof(hisc_liste) );
		Close( fh );
	}
}


void init_highscore( void )
{
	load_hisc();
}


void close_highscore( void )
{
	// Da der HiSc sicherheitshalber nach jedem Eintrag
	// gespeichert wird, bleibt hier nix zu tun.
}


void highscore_show( void )
{
	static struct EasyStruct hiscreq = {
		sizeof (struct EasyStruct), 0,
		"Hall of Fame",
		" 1. %-19s (%ld*%ld %s, %ld seconds left)\n"
		" 2. %-19s (%ld*%ld %s, %ld seconds left)\n"
		" 3. %-19s (%ld*%ld %s, %ld seconds left)\n"
		" 4. %-19s (%ld*%ld %s, %ld seconds left)\n"
		" 5. %-19s (%ld*%ld %s, %ld seconds left)\n"
		" 6. %-19s (%ld*%ld %s, %ld seconds left)\n"
		" 7. %-19s (%ld*%ld %s, %ld seconds left)\n"
		" 8. %-19s (%ld*%ld %s, %ld seconds left)\n"
		" 9. %-19s (%ld*%ld %s, %ld seconds left)\n"
		"10. %-19s (%ld*%ld %s, %ld seconds left)",
		" Back " };
	
	EasyRequest( window, &hiscreq, NULL,
		NAME(0), X(0), Y(0), LEVEL(0), ZEIT(0),
		NAME(1), X(1), Y(1), LEVEL(1), ZEIT(1),
		NAME(2), X(2), Y(2), LEVEL(2), ZEIT(2),
		NAME(3), X(3), Y(3), LEVEL(3), ZEIT(3),
		NAME(4), X(4), Y(4), LEVEL(4), ZEIT(4),
		NAME(5), X(5), Y(5), LEVEL(5), ZEIT(5),
		NAME(6), X(6), Y(6), LEVEL(6), ZEIT(6),
		NAME(7), X(7), Y(7), LEVEL(7), ZEIT(7),
		NAME(8), X(8), Y(8), LEVEL(8), ZEIT(8),
		NAME(9), X(9), Y(9), LEVEL(9), ZEIT(9) );
}


get_spielernamen( char *ziel )
{
	static char			input[20] = "";
	
	struct Window		*w;
	struct NewGadget	ng;
	struct Gadget		*glist=NULL, *gad;
	int					topborder,
						leftborder,
						width, height;
	long				tl;
	
	struct IntuiMessage	*imsg;
	ULONG				class;
	BOOL				ende = FALSE;
	
	
	// Create String Gadget
	
	topborder  = screen->WBorTop + screen->Font->ta_YSize + 1;
	leftborder = screen->WBorLeft;
	gad = CreateContext( & glist );
	
	ng.ng_TopEdge  = topborder + 3*INTERHEIGHT + screen->Font->ta_YSize;
	ng.ng_LeftEdge = leftborder + INTERWIDTH;
	tl = TextLength( &screen->RastPort, "XXXXXXXXXXXXXXXXXXXXXX", 22 );
	ng.ng_Width = tl;
	ng.ng_Height = screen->Font->ta_YSize + 4;
	if( ng.ng_Height < 12 ) ng.ng_Height=12;
	
	ng.ng_VisualInfo = vi;
	ng.ng_TextAttr = screen->Font;
	ng.ng_GadgetText = "Please enter your Name:";
	ng.ng_Flags = PLACETEXT_ABOVE;
	
	gad = CreateGadget( STRING_KIND, gad, &ng,
		GTST_String, input,
		GTST_MaxChars, 19,
		TAG_DONE );
	
	if( !gad ) return;
	
	// Open Window
	
	width  = gad->LeftEdge + gad->Width + leftborder + 2*INTERWIDTH;
	height = gad->TopEdge + gad->Height + 2*INTERHEIGHT;
	
	w = OpenWindowTags( NULL,
		WA_Title,			"Congratulations!",
		WA_Left,			(screen->Width  - width ) / 2,
		WA_Top,				(screen->Height - height) / 2,
		WA_Width,			width,
		WA_Height,			height,
		WA_PubScreen,		screen,
		
		WA_DragBar,			TRUE,
		WA_DepthGadget,		TRUE,
		WA_RMBTrap,			TRUE,
		WA_SmartRefresh,	TRUE,
		WA_Activate,		TRUE,
		
		WA_IDCMP, REFRESHWINDOW | STRINGIDCMP,
		TAG_DONE );
	
	if( !w ) return;
	
	// Add Gadget
	
	AddGList( w, glist, 0, -1, NULL );
	RefreshGList( glist, w, NULL, -1 );
	GT_RefreshWindow( w, NULL );
	
	// Aktivieren
	
	ActivateGadget( gad, w, 0 );
	
	// MainLoop
	
	do
	{
		WaitPort( w->UserPort );
		
		while( imsg = GT_GetIMsg(w->UserPort) )
		{
			class = imsg->Class;
			GT_ReplyIMsg( imsg );
			
			if( class == REFRESHWINDOW )
			{
				GT_BeginRefresh( w );
				GT_EndRefresh( w, TRUE );
			}
			else
			{
				ende = TRUE;
			}
		}
	} while( !ende );
	
	// Eine Kopie hierbehalten
	strcpy( input, ((struct StringInfo *)gad->SpecialInfo)->Buffer );
	
	// Resultat einsetzen
	strcpy( ziel, input );
	
	// Schulz jetz
	CloseWindow( w );
	FreeGadgets( glist );
}


void highscore_eintrag( int x, int y, int zeit, int level )
{
	long	spieler_score;
	int		i;
	
	D(printf("eintrag %d %d %d %d\n", x,y,zeit,level));
	
	/*
	 * SCORE-BERECHNUNG: Level sollte am stärksten eingehen,
	 * dann Feldgröße und zuletzt die Restzeit.
	 * (wobei die Feldgröße schon indirekt durch die Zeit drin ist)
	 * 
	 * Feldgröße: x*y = > 30 und < 50000
	 *
	 */
	
	spieler_score =   1000000 * level
					+      10 * x * y
					+     100 * zeit / gesamtzeit;
	
	for( i=0; i<=9; ++i )
	{
		if( spieler_score > hisc_liste[i].score )
			break;
	}
	
	if( i < 10 )
	{
		sound_play( SOUND_HIGHSCORE );
		
		if( i < 9 )
		{
			memmove( &hisc_liste[i+1], &hisc_liste[i],
				(9 - i) * sizeof(struct hisc_entry) );
		}
		
		get_spielernamen( NAME(i) );
		X(i)      = x;
		Y(i)      = y;
		NLEVEL(i) = level;
		ZEIT(i)   = zeit;
		SCORE(i)  = spieler_score;
		
		save_hisc();
		highscore_show();
	}
}
