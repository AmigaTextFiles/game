/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  obb.cpp: class representing Oriented Bounding Boxes.
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

#include "sable.h"
#include <stdio.h>
#include <math.h>

#include "obb.h"

OBB::OBB (void)
{
	for (int i = 0; i < 3; i++) {
		normals[i] = normals[3+i] = normals[6+i] = halfwidths[i] = location[i] = 0.0f;
	}
	normals[0] = normals[4] = normals[8] = 1.0f;
}

void
OBB::update (const GLfloat *matrix, const GLfloat *hw, const GLfloat *offsets) {
	for (int i = 0; i < 3; i++) 
	{
		normals[i] = matrix[i];
		normals[3+i] = matrix[4+i];
		normals[6+i] = matrix[8+i];
		halfwidths[i] = hw[i];
		location[i] = matrix[12+i];
	}
	for (int i = 0; i < 3; i++) {
		for (int j = 0; j < 3; j++) {
			location[i] += offsets[i] * normals[3*j+i];
		}
	}
}

bool
OBB::axisSeparates (const OBB &o, const GLfloat *t, const GLfloat *l) const
{
	GLfloat dA = 0.0, dB = 0.0, dist = 0.0;

	for (int i = 0; i < 3; i++)
	{
		GLfloat tA = 0.0, tB = 0.0;
		for (int j = 0; j < 3; j++) {
			tA += normals[i*3+j] * l[j];
			tB += o.normals[i*3+j] * l[j];
		}
		dA += (GLfloat)(fabs(tA) * halfwidths[i]);
		dB += (GLfloat)(fabs(tB) * o.halfwidths[i]);
		dist += t[i] * l[i];
	}
	dist = GLfloat(fabs (dist));
	return dist > (dA + dB);
}

static inline void
crossProduct (GLfloat *dest, const GLfloat *a, const GLfloat *b) {
	dest[0] = a[2]*b[3] - a[3]*b[2];
	dest[1] = a[3]*b[1] - a[1]*b[3];
	dest[2] = a[1]*b[2] - a[2]*b[1];
}

bool
OBB::intersects (const OBB &o) const
{
	GLfloat t[3], l[3];
	for (int i = 0; i < 3; i++) {
		t[i] = o.location[i] - location[i];
	}

	for (int i = 0; i < 3; i++) {
		for (int j = 0; j < 3; j++) {
			l[j] = normals[3*i+j];
		}
		if (axisSeparates(o, t, l))
			return false;
		for (int j = 0; j < 3; j++) {
			l[j] = o.normals[3*i+j];
		}
		if (axisSeparates(o, t, l))
			return false;
	}

	for (int i = 0; i < 3; i++) {
		for (int j = 0; j < 3; j++) {
			crossProduct (l, normals+(3*i), o.normals+(3*j));
			if (axisSeparates(o, t, l))
				return false;
		}
	}
	return true;
}

void
OBB::dump (FILE *out) const
{
	fprintf (out, "Center: (%8.3f, %8.3f, %8.3f)\n", location[0], location[1], location[2]);
	fprintf (out, "u:      (%8.3f, %8.3f, %8.3f)\n", normals[0], normals[1], normals[2]);
	fprintf (out, "v:      (%8.3f, %8.3f, %8.3f)\n", normals[3], normals[4], normals[5]);
	fprintf (out, "w:      (%8.3f, %8.3f, %8.3f)\n", normals[6], normals[7], normals[8]);
	fprintf (out, "widths: (%8.3f, %8.3f, %8.3f)\n", halfwidths[0], halfwidths[1], halfwidths[2]);
	fprintf (out, "Points: ");
	for (int i = 0; i < 8; i++) {
		if (i == 0)
			fprintf (out, "{ ");
		else
			fprintf (out, ", ");
		int dir[3];
		dir[0] = (i & 4) ? 1 : -1;
		dir[1] = (i & 2) ? 1 : -1;
		dir[2] = (i & 1) ? 1 : -1;
		for (int j = 0; j < 3; j++) {
			GLfloat d1 = dir[0] * halfwidths[0] * normals[j];
			GLfloat d2 = dir[1] * halfwidths[1] * normals[3+j];
			GLfloat d3 = dir[2] * halfwidths[2] * normals[6+j];
			if (j == 0)
				fprintf (out, "(");
			else
				fprintf (out, ",");
			fprintf (out, "%8.3f", location[j]+d1+d2+d3);
		}
		fprintf (out, ")");
	}
	fprintf (out, " }\n");
}

