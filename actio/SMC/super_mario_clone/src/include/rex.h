/***************************************************************************
                rex.h  -  headers for the corresponding cpp file
                             -------------------
    copyright            : (C) 2004-2005 by FluXy
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

#ifndef __REX_H__
#define __REX_H__

#include "include/globals.h"

class cRex : public cEnemy
{
/*	Rex

 state == 1: normal walking
 state == 2: mini walking

 */

public:
	cRex( double x, double y );
	virtual ~cRex( void );

	virtual void Update( void );
	virtual void Die( void );
	virtual void DieStep( void );
	virtual void PlayerCollision( int cdirection );
	virtual void EnemyCollision( int cdirection );

	SDL_Surface *images[10];

	double speed;
	/* The speed */
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

#endif
