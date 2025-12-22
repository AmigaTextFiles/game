///////////////////////////////////////////////////////////////////////////////
// File         : joy.cpp
// Info         : Joystick and keyboard handling
// Written by   : Carlo Borreo borreo@softhome.net
///////////////////////////////////////////////////////////////////////////////

#include "lupengo.h"
#include <SDL_keysym.h>

#define FNKEYS 10

static int EscIsPressed = 0, SpaceIsPressed = 0 ;
static int JX[ MAXPLAYERS ], JY[ MAXPLAYERS ], JF[ MAXPLAYERS ] ;

// We add a useless '5' key so that index numbers are like keypad numbers
static int SelectedKeys[ MAXPLAYERS ][ 10 ] = {
	{ SDLK_KP5,   SDLK_KP1, SDLK_KP2, SDLK_KP3, SDLK_KP4, 0, SDLK_KP6, SDLK_KP7, SDLK_KP8, SDLK_KP9 },
	{ SDLK_SPACE, SDLK_e,   SDLK_r,   SDLK_t,   SDLK_d,   0, SDLK_f,   SDLK_x,   SDLK_c,   SDLK_v   }
	} ;

static int FunctionKeys[ FNKEYS ] = {
	SDLK_F1, SDLK_F2, SDLK_F3, SDLK_F4, SDLK_F5, SDLK_F6, SDLK_F7, SDLK_F8, SDLK_F9, SDLK_F10
	} ;

static void ProcessKey( SDLKey Key, int Flag ) ;

static void ProcessKey( SDLKey Key, int Flag )
	{
	int k1, k2, k3, k4, k6, k7, k8, k9 ;
	int *KeySet ;
	Uint8 *KeyStates ;
	int i ;
	
	switch ( Key )
		{
		case SDLK_ESCAPE:
			EscIsPressed = Flag ;
			break ;
		case SDLK_SPACE:
			SpaceIsPressed = Flag ;
			break ;
		default:
			break ;
		}
		
	KeyStates = SDL_GetKeyState( NULL ) ;
	for ( i = 0 ; i < MAXPLAYERS ; i ++ )
		{
		KeySet = SelectedKeys[ i ] ;
		k1 = KeyStates[ KeySet[ 1 ] ] ;
		k2 = KeyStates[ KeySet[ 2 ] ] ;
		k3 = KeyStates[ KeySet[ 3 ] ] ;
		k4 = KeyStates[ KeySet[ 4 ] ] ;
		k6 = KeyStates[ KeySet[ 6 ] ] ;
		k7 = KeyStates[ KeySet[ 7 ] ] ;
		k8 = KeyStates[ KeySet[ 8 ] ] ;
		k9 = KeyStates[ KeySet[ 9 ] ] ;
		JY[i] = ( k1 | k2 | k3 ) ;
		JY[i]-= ( k7 | k8 | k9 ) ;
		JX[i] = ( k3 | k6 | k9 ) ;
		JX[i]-= ( k1 | k4 | k7 ) ;
		JF[i] = KeyStates[ KeySet[ 0 ] ] ;
		}
	}

void TrueReadJoy( int Player )
	{
	SDL_Event MyEvent ;
	
	while ( SDL_PollEvent( NULL ) > 0 )
		{
		SDL_WaitEvent( & MyEvent ) ;
		switch ( MyEvent.type )
			{
			case SDL_QUIT:
				Quit( 0 ) ;
				break ;
			case SDL_KEYDOWN:
			case SDL_KEYUP:
				ProcessKey( MyEvent.key.keysym.sym, ( MyEvent.key.type==SDL_KEYDOWN ) ) ;
				break ;
			}
		}
	joyx = JX[ Player ] ;
	joyy = JY[ Player ] ;
	fire = JF[ Player ] ;
	}

int ReadKey( void )
	{
	SDL_Event MyEvent ;
	
	while ( SDL_PollEvent( NULL ) > 0 )
		{
		SDL_WaitEvent( & MyEvent ) ;
		if ( MyEvent.type == SDL_KEYDOWN )
			return MyEvent.key.keysym.sym ;
		}

	return 0 ;
	}

// FunctionKey return 0..FNKEYS-1 if a function key is pressed, or -1 for none

int FunctionKey( void )
	{
	int i ;
	Uint8 *KeyStates ;

	KeyStates = SDL_GetKeyState( NULL ) ;
	for ( i = 0 ; i < FNKEYS ; i ++ )
		if ( KeyStates[ FunctionKeys[ i ] ] )
			return i ;
	return -1 ;
	}

int EscPressed( void )
	{
	return EscIsPressed ;
	}

int SpacePressed( void )
	{
	return SpaceIsPressed ;
	}

void SetKeyBoard( int Flag )
	{
	}
