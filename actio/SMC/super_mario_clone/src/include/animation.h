/***************************************************************************
			Animation.h  -  Animation header

			Version : 1.1.0

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

#include "include/globals.h"
#include "include/sprite.h"

#ifndef __ANIMATION_H__
#define __ANIMATION_H__

class cAnimation : public cSprite 
{
public:
	cAnimation( double posx, double posy, int animtype, int height = 40, int width = 20 );
	~cAnimation(void);

	virtual void Update( void );

	SDL_Surface *images[3];

	double counter;

	SDL_Rect rects[4];
};

void UpdateAnimatons( void );

void AddAnimation( double posx, double posy, unsigned int animtype = 1, int height = 40, int width = 20 );

void DeleteAllAnimations( void );

#endif
