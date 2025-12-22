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

Base::Base()
{
	x = y = 0;
	place();
}

void Base::place()
{
	int place = rand() % 4;
	
	if ((place == 0) || (place == 1))
			x = Math::rrand(0, 800);

	if ((place == 2) || (place == 3))
		y = Math::rrand(0, 600);

	if (place == 0)
		y = 30;

	if (place == 1)
		y = 570;

	if (place == 2)
		x = 30;

	if (place == 3)
		x = 770;
}
