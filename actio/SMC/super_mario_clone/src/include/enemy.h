/***************************************************************************
                enemy.h  -  headers for the corresponding cpp file
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

#ifndef __ENEMY_H__
#define __ENEMY_H__

#include "include/globals.h"

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

class cEnemy : public cSprite
{
public:
	cEnemy( double x, double y ); 
	virtual ~cEnemy( void );
	
	double walk_count;
	
	bool dead;

	virtual void Die( void );
	virtual void DieStep( void );
	virtual void Update( void );
	virtual void PlayerCollision( int cdirection );

	double counter;
};

#endif
