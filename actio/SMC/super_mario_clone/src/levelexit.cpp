/***************************************************************************
     levelexit.cpp  -  class for a little door to enter the next level
                             -------------------
    copyright            : (C) 2003-2004 by Artur Hallmann, (C) 2003-2005 by FluXy
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

#include "include/globals.h"

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

cLevelExit :: cLevelExit( double x, double y ) : cActiveSprite( x, y )
{
	image = GetImage( "game/level/door_yellow_1.png" );
	SetImage( image );
	
	type = TYPE_LEVELEXIT;
	
	visible = 1;
	massive = 0;
	
	SetPos( x, y );
}

cLevelExit :: ~cLevelExit( void )
{

}

void cLevelExit :: Update( void )
{
	if( ( keys[pPreferences->Key_up] || pJoystick->Button( pPreferences->Joy_jump ) ) && ( timedisplay->counter && RectIntersect( &pPlayer->rect, &rect ) ) &&
		pPlayer->onGround )
	{
		pAudio->FadeOutMusic( 500 );
		pAudio->PlaySound( MUSIC_DIR "/Game/victory_3.ogg" );
		
		pPlayer->GotoNextLevel();
	}
	else
	{
		Draw( screen );
	}
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */
