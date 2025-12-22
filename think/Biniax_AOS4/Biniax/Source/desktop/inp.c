/******************************************************************************
BINIAX INPUT-RELATED IMPLEMENTATIONS
COPYRIGHT JORDAN TUZSUZOV, (C) 2005.
******************************************************************************/

/******************************************************************************
INCLUDES
******************************************************************************/

#include <stdlib.h>

#include "inc.h"

/******************************************************************************
FUNCTIONS
******************************************************************************/


BNX_BOOL inpInit()
{
	_Inp.keyUp		= BNX_FALSE;
	_Inp.keyDown	= BNX_FALSE;
	_Inp.keyLeft	= BNX_FALSE;
	_Inp.keyRight	= BNX_FALSE;
	_Inp.keyA		= BNX_FALSE;
	_Inp.keyB		= BNX_FALSE;

	return BNX_TRUE;
}

void inpUpdate()
{
    SDL_Event event;

    while( SDL_PollEvent( &event ) ) 
	{

        switch( event.type ) 
		{
			case SDL_KEYDOWN:
				switch( event.key.keysym.sym ) 
				{
					case SDLK_SPACE : 
						_Inp.keyA		= BNX_TRUE;
						break;
					case SDLK_RETURN : 
						_Inp.keyA		= BNX_TRUE;
						break;
					case SDLK_ESCAPE : 
						_Inp.keyB		= BNX_TRUE;
						break;
					case SDLK_UP : 
						_Inp.keyUp		= BNX_TRUE;
						break;
					case SDLK_DOWN : 
						_Inp.keyDown	= BNX_TRUE;
						break;
					case SDLK_LEFT : 
						_Inp.keyLeft	= BNX_TRUE;
						break;
					case SDLK_RIGHT : 
						_Inp.keyRight	= BNX_TRUE;
						break;
				}
		}
	}
}

BNX_BOOL inpKeyLeft()
{
	if ( _Inp.keyLeft == BNX_TRUE )
	{
		_Inp.keyLeft = BNX_FALSE;
		return BNX_TRUE;
	}

	return BNX_FALSE;
}

BNX_BOOL inpKeyRight()
{
	if ( _Inp.keyRight == BNX_TRUE )
	{
		_Inp.keyRight = BNX_FALSE;
		return BNX_TRUE;
	}

	return BNX_FALSE;
}

BNX_BOOL inpKeyUp()
{
	if ( _Inp.keyUp == BNX_TRUE )
	{
		_Inp.keyUp = BNX_FALSE;
		return BNX_TRUE;
	}

	return BNX_FALSE;
}

BNX_BOOL inpKeyDown()
{
	if ( _Inp.keyDown == BNX_TRUE )
	{
		_Inp.keyDown = BNX_FALSE;
		return BNX_TRUE;
	}

	return BNX_FALSE;
}

BNX_BOOL inpKeyA()
{
	if ( _Inp.keyA == BNX_TRUE )
	{
		_Inp.keyA = BNX_FALSE;
		return BNX_TRUE;
	}

	return BNX_FALSE;
}

BNX_BOOL inpKeyB()
{
	if ( _Inp.keyB == BNX_TRUE )
	{
		_Inp.keyB = BNX_FALSE;
		return BNX_TRUE;
	}

	return BNX_FALSE;
}

