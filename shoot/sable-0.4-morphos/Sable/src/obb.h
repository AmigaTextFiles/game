/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  obb.h: Classes for representing Oriented Bounding Boxes.
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

#ifndef _OBB_H_
#define _OBB_H_

#include <GL/gl.h>
#include <stdio.h>

class OBB {
 public:
	OBB (void);
	OBB (const GLfloat *matrix, const GLfloat *hw, const GLfloat *center_offsets) { update (matrix, hw, center_offsets); }
	~OBB (void) {}
	void update (const GLfloat *matrix, const GLfloat *hw, const GLfloat *center_offsets);
	void dump (FILE *out) const;
	bool intersects (const OBB &o) const;
 private:
	bool axisSeparates (const OBB &o, const GLfloat *t, const GLfloat *l) const;
	GLfloat normals[9], halfwidths[3], location[3];
};

#endif
