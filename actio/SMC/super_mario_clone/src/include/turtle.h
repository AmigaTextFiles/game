/***************************************************************************
                turtle.h  -  headers for the corresponding cpp file
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

#ifndef __TURTLE_H__
#define __TURTLE_H__

#include "include/globals.h"

class cTurtle : public cEnemy
{
/*	Turtle

 state == 1: normal walking
 state == 2: shell "standing"
 state == 3: fast moving shell
 state == 4: (todo) flying

 */

public:
	cTurtle( double x, double y, int color = 1 );
	virtual ~cTurtle( void );

	virtual void Update( void );
	virtual void Die( void );
	virtual void DieStep( void );
	virtual void PlayerCollision( int cdirection );
	virtual void EnemyCollision( int cdirection );

	SDL_Surface *images[12];

	double speed;
	/* The speed */

	double playercounter;
	/* If the player kicked the shell
	 * this counter starts
	 * if this counter is higher than 0
	 * mario cannot get killed by the shell
	 */
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

#endif
