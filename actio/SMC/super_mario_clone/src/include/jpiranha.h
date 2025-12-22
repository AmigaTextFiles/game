/***************************************************************************
              jpiranha.h  -  headers for the corresponding cpp file
                             -------------------
    copyright            : (C) 2003-2005 by FluXy
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

#ifndef __JPIRANHA_H__
#define __JPIRANHA_H__

#include "include/globals.h"
/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

class cjPiranha : public cEnemy 
{
/*	Jumping Prinha
  No Description .
 */

public:
	cjPiranha( double x, double y, int mh = 200 );
	virtual ~cjPiranha();

	virtual void Die( void );
	virtual void DieStep( void );
	virtual void Update( void );

	virtual void PlayerCollision( int cdirection );
	
	SDL_Surface *images[4];
	double wait_time,max_h;
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

#endif
