/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  ground.h: A representation of the ground's plasma fractal height map.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be entertaining,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.  A copy of the
 *  General Public License is included in the file COPYING.
 */

#ifndef _GROUND_H_
#define _GROUND_H_

#include "sable.h"

class Ground {
 public:
	void init (void);
	void scroll (void);
	void render (void);
 private:
	void fillSquare (int offset, bool first);
	GLfloat offset;
	GLfloat height[193][65];
	GLfloat r[193][65], g[193][65];	
};

extern Ground ground;

#endif
