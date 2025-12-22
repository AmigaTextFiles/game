///////////////////////////////////////////////////////////////////////////////
// File         : demo.c
// Info         : Recorded demo stuff
// Written by   : Carlo Borreo borreo@softhome.net
///////////////////////////////////////////////////////////////////////////////

#include "lupengo.h"

#define DEMOBUFSIZE		30000	// Must be multiple of 6

// The random Seed must be the same when recording and playing demo
static char DemoData[ DEMOBUFSIZE ] ;
static int DemoIndex, DemoStatus, DemoSize ;
static time_t DemoSeed ;

static FILE *DemoOpen( char *mode )
	{
	char filename[ 32 ] ;

	sprintf( filename, "lupdemo%d.dat", CurrentGameType ) ;
	return fopen( filename, mode ) ;
	}

void DemoRecord( void )
	{
	DemoSeed = time( NULL ) ;
	srand( DemoSeed ) ;
	DemoIndex = 0;
	DemoStatus = DEMO_WRITING ;
	}

void DemoPlay( void )
	{
	FILE *f;

	f = DemoOpen( "rb" ) ;
	if ( f != NULL )
		{
		fread( & DemoSeed, sizeof( DemoSeed ), 1, f ) ;
		fread( & DemoSize, sizeof( int ), 1, f ) ;
		fread( DemoData, sizeof( char ), DemoSize, f ) ;
		fclose( f ) ;
		srand( DemoSeed ) ;
		DemoIndex = 0 ;
		DemoStatus = DEMO_READING ;
		}
	}

int DemoGetStatus( void )
	{
	return DemoStatus ;
	}

void DemoStop( void )
	{
	FILE *f ;

	if ( DemoStatus == DEMO_WRITING )
		{
		f = DemoOpen( "wb" ) ;
		if ( f != NULL )
			{
			fwrite( & DemoSeed, sizeof( DemoSeed ), 1, f ) ;
			fwrite( & DemoIndex, sizeof( int ), 1, f ) ;
			fwrite( DemoData, sizeof( char ), DemoIndex, f ) ;
			fclose( f ) ;
			}
		}
	DemoStatus = DEMO_NULL ;
	}

void readjoy( int Player )
	{
	if ( DemoStatus == DEMO_READING )
		{
		joyx = DemoData[ DemoIndex ++ ] ;
		joyy = DemoData[ DemoIndex ++ ] ;
		fire = DemoData[ DemoIndex ++ ] ;
		return ;
		}

	TrueReadJoy( Player ) ;

	if ( DemoStatus == DEMO_WRITING )
		{
		DemoData[ DemoIndex ++ ] = joyx ;
		DemoData[ DemoIndex ++ ] = joyy ;
		DemoData[ DemoIndex ++ ] = fire ;
		if ( DemoIndex >= DEMOBUFSIZE )
			{
			PictureDisplayText( strnomoreroom, 0 ) ;
			DemoStop() ;
			}
		}
	}
