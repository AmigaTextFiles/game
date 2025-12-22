///////////////////////////////////////////////////////////////////////////////
// File         : pics.cpp
// Info         : Manage pictures
// Written by   : Carlo Borreo borreo@softhome.net
///////////////////////////////////////////////////////////////////////////////

#include "lupengo.h"

static SDL_Surface *Bitmap[ NPICS ] ;
static char screen[ BX1 + 3 ][ BY1 + 3 ] ;
static int TransparentColor, RefreshFlag ;

#define PICTOCOORDX(X) ((X)*PICSIZEX+16)
#define PICTOCOORDY(Y) ((Y)*PICSIZEY+30)

int PictureInit( void )
	{
	int i ;
	SDL_Surface *TempBitmap ;
	char Temp[ 64  ] ;

	for ( i = 0 ; i < NPICS ; i ++ )
		{
		sprintf( Temp, "picture/%i.bmp", i ) ;
	        /* Load a BMP image into a surface */
	        TempBitmap = SDL_LoadBMP( Temp ) ;
		if ( TempBitmap == NULL )
			{
			fprintf( stderr, "Error loading BMP file '%s'\n", Temp ) ;
			return 0 ;
			}
		if ( i == 0 && TempBitmap->format->palette != NULL )
			SDL_SetColors( MainScreen, TempBitmap->format->palette->colors, 0, TempBitmap->format->palette->ncolors ) ;
	        Bitmap[ i ] = SDL_DisplayFormat( TempBitmap );
 	        SDL_FreeSurface( TempBitmap ) ;
		}

	TransparentColor = SDL_MapRGB( MainScreen->format, 0xad, 0xad, 0xad ) ;
	for ( i = CIRCLEMIN ; i <= CIRCLEMAX ; i ++ )
		SDL_SetColorKey( Bitmap[ i ], SDL_SRCCOLORKEY, TransparentColor ) ;
	for ( i = CHARMIN ; i <= CHARMAX ; i ++ )
		SDL_SetColorKey( Bitmap[ i ], SDL_SRCCOLORKEY, TransparentColor ) ;

	PictureSetRefresh( 1 ) ;

	return 1 ;
	}

void PictureSetRefresh( int Flag )
	{
	RefreshFlag = Flag ;
	}

void PictureRefreshScreen( void )
	{
	if ( RefreshFlag )
		SDL_UpdateRect( MainScreen, 0, 0, 0, 0 ) ;
	}

void PictureClearAll( void )
	{
	SDL_FillRect( MainScreen, NULL, TransparentColor ) ;
	PictureRefreshScreen() ;
	}

// Clear the bottom of the screen, starting at a predefined y
void PictureClearBottom( void )
	{
	SDL_Rect dstrect ;
	
	dstrect.x = 0 ;
	dstrect.y = PICTOCOORDY( 10 ) ;
	dstrect.w = 640 ;
	dstrect.h = 480 - dstrect.y ;
	SDL_FillRect( MainScreen, &dstrect, TransparentColor ) ;
	PictureRefreshScreen() ;
	}

void PictureReset( void )
	{
	memset( screen, BLANK, sizeof( screen ) ) ;
	}

int PictureDraw( int x, int y, int shp )
	{
	SDL_Rect dstrect ;
	
	dstrect.x = x ;
	dstrect.y = y ;
	dstrect.w = Bitmap[ shp ]->w ;
	dstrect.h = Bitmap[ shp ]->h ;
	SDL_BlitSurface( Bitmap[ shp ], NULL, MainScreen, &dstrect ) ;
	if ( RefreshFlag )
		SDL_UpdateRects( MainScreen, 1, &dstrect ) ;
		
	return x + dstrect.w ;
	}

void PictureRefreshAll( void )
	{
	int x, y ;	

	PictureClearAll() ;
	for ( x = 0 ; x <= BX1 ; x ++ )
		for ( y = 0 ; y <= BY1 ; y ++ )
			PictureRefresh( x, y ) ;
	}

void PictureShow( int x, int y, int shp )
	{
	PictureDraw( PICTOCOORDX( x ), PICTOCOORDY( y ), shp ) ;
	}

void PictureRefresh( int x, int y )
	{
	PictureShow( x, y, screen[ x ][ y ] ) ;
	}

void PicturePutScreen( int x, int y, int shp )
	{
	screen[ x ][ y ] = shp ;
	PictureShow( x, y, shp ) ;
	}

void PicturePutScreenNoSave( int x, int y, int shp )
	{
	PictureShow( x, y, shp ) ;
	}

int PictureReadScreen( int x, int y )
	{
	return screen[ x ][ y ] ;
	}

// Write a number using pictures C0..C9
// Receive the number formatted as a string

static int PictureCharToPic( char c )
	{
	if ( isdigit( c ) )
		return c + ( C0 - '0' ) ;
		
	if ( isalpha( c ) )
		return tolower( c ) + ( CA - 'a' ) ;
	
	return CSPACE ;
	}

static void PictureGetStringSize( char *s, int *px, int *py )
	{
	SDL_Surface *TempBitmap ;

	*px = 0 ;
	*py = 0 ;
	for ( ; *s ; s ++ )
		{
		TempBitmap = Bitmap[ PictureCharToPic( *s ) ] ;
		*px += TempBitmap->w ;
		if ( *py < TempBitmap->h )
			*py = TempBitmap->h ;
		}
	}

void PictureWriteString( int x, int y, char *s, int Flags )
	{
	int SizeX, SizeY ;
	
	x = PICTOCOORDX( x ) ;
	y = PICTOCOORDY( y ) ;
	if ( Flags & WSF_RIGHTALIGN )
		{
		PictureGetStringSize( s, & SizeX, & SizeY ) ;
		x -= SizeX ;
		}
	else if ( Flags & WSF_CENTERALIGN )
		{
		PictureGetStringSize( s, & SizeX, & SizeY ) ;
		x -= ( SizeX / 2 ) ;
		}
	for ( ; *s ; s ++ )
		x = PictureDraw( x, y, PictureCharToPic( *s ) ) ;
	}

void PictureDisplayText( char *msg, int flags )
	{
	static int y0 ;
	int x, y ;

	if ( flags & DF_BOTTOM )
		y0 = 16 ;
	else
		y0 = 8 ;
	for ( x = BX0 ; x <= BX1 ; x ++ )
		for ( y = y0 ; y <= y0 + 4 ; y ++ )
			{
			if ( msg == NULL )
				PictureRefresh( x, y ) ;
			else
				PicturePutScreenNoSave( x, y, BRICKS ) ;
			}
	if ( msg != NULL )
		PictureWriteString( BX0 + ( ( BX1 - BX0 + 1 ) / 2 ), y0 + 2, msg, WSF_CENTERALIGN ) ;

	if ( ! ( flags & DF_NOWAIT ) )
		{
		SavedStatus = CurrentStatus ;
		CurrentStatus = STATUS_DISPLAY ;
		}
	}
