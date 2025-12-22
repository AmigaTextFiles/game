/*
Copyright (C) 2003 Parallel Realities

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

#include "headers.h"

Ball::Ball()
{
	this->x = -1;
	this->y = -1;
	this->dx = this->dy = 0;
	onBoard = false;
	this->sprite = NULL;
	this->ballType = UNDEFINED_BALL;
}

void Ball::place(int type, int x, int y, Sprite *sprite)
{
	this->ballType = type;
	this->x = x;
	this->y = y;
	this->sprite = sprite;
	this->dx = this->dy = 0;
	onBoard = true;
}

bool Ball::move()
{
	if ((dx != 0) || (dy != 0))
	{
		x += dx;
		y += dy;
		return true;
	}

	return false;
}

void Ball::backup()
{
	x -= dx;
	y -= dy;
	dx = dy = 0;
}

void Ball::remove()
{
	onBoard = false;
	x = -1;
	y = -1;
}

void Ball::setSprite(Sprite *sprite)
{
	this->sprite = sprite;
}

SDL_Surface *Ball::image()
{
	return sprite->getCurrentFrame();
}
