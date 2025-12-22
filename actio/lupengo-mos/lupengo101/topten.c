///////////////////////////////////////////////////////////////////////////////
// File         : topten.c
// Info         : Show and maintain top scores
// Written by   : Carlo Borreo borreo@softhome.net
///////////////////////////////////////////////////////////////////////////////

#include "lupengo.h"

#define NAME_POS	0
#define SCOREPOS	17
#define LEVELPOS	14
#define VERTPOS(A)	((A)+(VERTPOS0+2))

#define VERTPOS0	10

#define TOPS 10
#define NAMESIZE 16

static struct TheBest {
	char name[ NAMESIZE ] ;
	long score ;
	int level ;
	} top[ GAMETYPES ][ TOPS ] ;

static void TopTenClear( void )
	{
	int i, j ;

	memset( & top, 0, sizeof( top ) ) ;
	for ( i = 0 ; i < GAMETYPES ; i ++ )
		for ( j = 0 ; j < TOPS ; j ++ )
			strcpy( top[ i ][ j ].name, strnobody ) ;
	}

void TopTenInit( void )
	{
	FILE *fp ;

	fp = fopen( scorename, "rb" ) ;
	if ( fp == NULL )
		TopTenClear() ;
	else
		{
		fread( & top, sizeof( top ), 1, fp ) ;
		fclose( fp ) ;
		}
	}

void TopTenDisplay( int gametype, int hilight )
	{
	int i, x ;
	char work[ 10 ] ;

	PictureClearBottom();

	PictureWriteString( NAME_POS, VERTPOS0, gametypenames[ gametype ], 0 ) ;
	PictureWriteString( SCOREPOS, VERTPOS0, strscore, WSF_RIGHTALIGN ) ;
	PictureWriteString( LEVELPOS, VERTPOS0, strlevel, WSF_RIGHTALIGN ) ;
	for( i = 0 ; i < TOPS ; i ++ )
		{
		if ( i == hilight )
			for ( x = NAME_POS ; x < SCOREPOS ; x ++ )
				PicturePutScreen( x, VERTPOS(i), BRICKS ) ;
		PictureWriteString(NAME_POS, VERTPOS(i),top[ gametype ][ i ].name, 0 ) ;
		sprintf(work,"%ld",top[ gametype ][ i ].score ) ;
		PictureWriteString(SCOREPOS, VERTPOS(i), work, WSF_RIGHTALIGN ) ;
		sprintf(work,"%d", top[ gametype ][ i ].level ) ;
		PictureWriteString(LEVELPOS, VERTPOS(i), work, WSF_RIGHTALIGN ) ;
		}
	}

static void TopTenSave( void )
	{
	FILE *fp ;

	fp = fopen( scorename, "wb" ) ;
	if ( fp != NULL )
		{
		fwrite( & top, sizeof( top ), 1, fp ) ;
		fclose( fp ) ;
		}
	}

void InputAt( int x, int y, char *Buffer, int BufSize )
	{
	int i, k, Len ;
	
	Buffer[ 0 ] = 0 ;
	Len = 0 ;
	for ( ;; )
		{
		PictureSetRefresh( 0 ) ;
		for ( i = NAME_POS ; i < NAME_POS + 12 ; i ++ )
			PicturePutScreenNoSave( i, y, BRICKS ) ;
		PictureWriteString( x, y, Buffer, 0 ) ;
		PictureSetRefresh( 1 ) ;
		PictureRefreshScreen() ;
		k = ReadKey() ;
		if ( isprint( k ) && Len < BufSize - 1 )
			{
			Buffer[ Len ++ ] = k ;
			Buffer[ Len ] = 0 ;
			continue ;
			}
		if ( k == SDLK_BACKSPACE && Len > 0 )
			Buffer[ -- Len ] = 0 ;
		if ( k == SDLK_RETURN )
			{
			Buffer[ Len ] = 0 ;
			return ;
			}
		}
	}
	
// Add a score to score table, but if a score is really to be added, the operation is not complete
// A later call to TopTenSetName is required

void TopTenAddScore( int gametype, long lastscore, int lastlevel )
	{
	int i, j ;

	if ( lastscore > top[ gametype ][ TOPS - 1 ].score )
		{
		PictureClearAll() ;
		for( i = 0 ; i < TOPS ; i ++ )
			{
			if ( lastscore > top[ gametype ][ i ].score )
				{
				for ( j = TOPS - 1 ; j > i ; j -- )
					top[ gametype ][ j ] = top[ gametype ][ j - 1 ] ;
				top[ gametype ][ i ].score = lastscore ;
				top[ gametype ][ i ].level = lastlevel ;
				strcpy( top[ gametype ][ i ].name, "" ) ;
				break ;
				}
			}

		TopTenDisplay( gametype, i ) ;
		InputAt( NAME_POS, VERTPOS(i), top[ gametype ][ i ].name, NAMESIZE ) ;
		TopTenDisplay( gametype, i ) ;
		TopTenSave() ;
		}
	SDL_Delay( 5000 ) ;
	AttractStart() ;
	}


//void TopTenSetName( char *Name )
//	{
//	static int LastGameType, LastPos ;
//
//	if ( Name == NULL || Name[ 0 ] == 0 )
//		Name = stranon ;
//	strcpy( top[ LastGameType ][ LastPos ].name, Name ) ;
//	TopTenSave() ;
//	TopTenDisplay( LastGameType, LastPos ) ;
//	TopTenDone() ;
//	}
