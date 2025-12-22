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

Item::Item()
{
	x = y = 0;
	type = 0;
	health = Math::rrand(2, 4) * 100;
	image = NULL;
}

void Item::set(int x, int y, int type, SDL_Surface *image)
{
	this->x = x;
	this->y = y;
	this->type = type;
	this->image = image;
}

void Item::destroy()
{
	if (type == ITEM_TEXT)
		SDL_FreeSurface(image);
}
