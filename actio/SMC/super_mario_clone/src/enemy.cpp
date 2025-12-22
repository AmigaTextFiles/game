/***************************************************************************
           enemy.cpp  -  base class for all enemies
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

cEnemy :: cEnemy( double x, double y ) : cSprite( NULL, x, y )
{
	dead = 0;
	massive = 1;
	visible = 1;
	state = 0;
	counter = 0;
	Array = ARRAY_ENEMY;

	type = TYPE_ENEMY;
}

cEnemy :: ~cEnemy( void )
{
	
}

void cEnemy :: DieStep( void )
{
	// not used! virtual function, see .h file 
}

void cEnemy :: Die( void )
{
	// not used! virtual function, see .h file 
}

void cEnemy :: Update( void )
{
	// not used! virtual function, see .h file 
}

void cEnemy :: PlayerCollision( int cdirection )
{
	// not used! virtual function, see .h file or below
}
/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */
