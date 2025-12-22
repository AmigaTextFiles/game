///////////////////////////////////////////////////////////////////////////////
// File         : main.c
// Info         : Main source file for Lupengo game
// Written by   : Carlo Borreo borreo@softhome.net
///////////////////////////////////////////////////////////////////////////////

#include "lupengo.h"

#define ATTRACT_QUANTUM 20

SDL_Surface *MainScreen ;

int CurrentStatus ;
int SavedStatus ;
int CurrentGameType ;

static void MenuNewGame( int Argument )
	{
	if ( CurrentStatus != STATUS_PLAYING )
		{
		PlayNewGame( Argument ) ;
		CurrentStatus = STATUS_PLAYING ;
		}
	}

static void MenuRecordDemo( int Argument )
	{
	if ( CurrentStatus != STATUS_PLAYING )
		{
		DemoRecord() ;
		PlayNewGame( Argument ) ;
		CurrentStatus = STATUS_PLAYING ;
		}
	}

//static void MenuPlayDemo( int Argument )
//	{
//	if ( CurrentStatus != STATUS_PLAYING )
//		{
//		DemoPlay() ;
//		PlayNewGame( Argument ) ;
//		CurrentStatus = STATUS_PLAYING ;
//		}
//	}
//
//static void MenuTestTop( int Argument )
//	{
//	TopTenAddScore( 0, 10, 1 ) ;
//	}

void Quit( int Argument )
	{
	SoundsClose() ;
	SDL_Quit();
	exit( 0 ) ;
	}

struct MenuItem {
	char *mi_Text ;
	void (* mi_Command)( int Argument ) ;
	int mi_Argument ;
	} ;

struct MenuItem MainMenuItems[] = {
	{"New Game - One Player",		MenuNewGame,	GAMETYPE_SINGLE },
	{"New Game - Two Players",		MenuNewGame,	GAMETYPE_TEAM },
	{"Record Demo - One Player",	MenuRecordDemo,	GAMETYPE_SINGLE },
	{"Record Demo - Two Players",	MenuRecordDemo,	GAMETYPE_TEAM },
	{"Quit",						Quit,			0 },
//	{"Test Top Scores",				MenuTestTop,	GAMETYPE_TEAM },
	{ NULL,							NULL,			0 }
	} ;

void DisplayMenuItems( void )
	{
	char Buffer[ 128 ] ;
	int i ;

	for ( i = 0 ; MainMenuItems[ i ].mi_Text != NULL ; i ++ )
		{
		sprintf( Buffer, "F%d - %s", i + 1, MainMenuItems[ i ].mi_Text ) ;
		PictureWriteString( 3, i + 4, Buffer, 0 ) ;
		}
	}


int main( int argc, char *argv[] )
	{
	int fk ;

	/* Initialize SDL */
	if ( SDL_Init( SDL_INIT_VIDEO ) < 0 )
		{
		fprintf( stderr, "Couldn't initialize SDL: %s\n", SDL_GetError() ) ;
		Quit( 1 );
		}

	srand( time( NULL ) ) ;

	MainScreen = SDL_SetVideoMode(640, 480, 0, 0);

        SDL_WM_SetCaption("Lupengo 1.0.1", "Lupengo");

	SDL_ShowCursor(0);

	TopTenInit() ;
	if ( PictureInit() == 0 )
		{
		fprintf( stderr, "Error in PictureInit\n" ) ;
		Quit( 1 );
		}

	if ( SoundsInit() == 0 )
		{
		fprintf( stderr, "Error in SoundsInit\n" ) ;
		Quit( 1 );
		}

	AttractStart() ;

	for ( ;; )
		{
		switch ( CurrentStatus )
			{
			case STATUS_PLAYING:
				PlayMainLoop() ;
				break ;
			case STATUS_ATTRACT:
				if ( DoAttractMode( ATTRACT_QUANTUM ) == 0 )
					CurrentStatus = STATUS_PLAYDEMO ;
				readjoy( 0 ) ;
				fk = FunctionKey() ;
				if ( fk >= 0 )
					( MainMenuItems[ fk ].mi_Command )( MainMenuItems[ fk ].mi_Argument ) ;
				break ;
			case STATUS_DISPLAY:
				readjoy( 0 ) ;
				if ( fire )
					CurrentStatus = SavedStatus ;
				break ;
			default:
				break ;
			}
		}
	
	// Should never get here
	return 0 ;
	}
