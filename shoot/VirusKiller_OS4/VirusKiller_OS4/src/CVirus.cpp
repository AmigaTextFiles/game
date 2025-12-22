/*
Copyright (C) 2004 Parallel Realities

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

Virus::Virus()
{
	active = true;
	hasFile = false;
	insideDir = false;
	thinktime = 0;
	type = 0;
	x = y = -1;
	dx = dy = 0;
	targetDir = NULL;
	health = 1;
	speed = Math::rrand(1, 3);
	file = NULL;
	sprite = NULL;
	pointsImage = NULL;
}

Virus::~Virus()
{
	if (pointsImage != NULL)
		SDL_FreeSurface(pointsImage);

	pointsImage = NULL;
}

void Virus::setDestinationDir(Directory *targetDir)
{
	if (targetDir == NULL)
		return;

	this->targetDir = targetDir;

	Math::calculateSlope(x, y, targetDir->x, targetDir->y, &dx, &dy);

	dx /= speed;
	dy /= speed;
}

void Virus::moveErratic()
{
	int targetX = targetDir->x;
	int targetY = targetDir->y;
	int r = rand() % 10;
	
	if (r <= 1)
	{
		targetX += Math::rrand(-50, 100);
		targetY += Math::rrand(-50, 100);
	}
	else if (r <= 4)
	{
		targetX = Math::rrand(50, 750);
		targetY = Math::rrand(50, 550);
	}
	
	Math::calculateSlope(x, y, targetX, targetY, &dx, &dy);
	
	dx /= speed;
	dy /= speed;
	
	thinktime = Math::rrand(500, 2000);
}

void Virus::setBase(Base *base)
{
	this->base = base;
	this->x = base->x;
	this->y = base->y;
}

void Virus::goHome()
{
	Math::calculateSlope(x, y, base->x, base->y, &dx, &dy);

	dx /= speed;
	dy /= speed;
}

void Virus::destroy()
{
	if (pointsImage != NULL)
		SDL_FreeSurface(pointsImage);

	pointsImage = NULL;
}
