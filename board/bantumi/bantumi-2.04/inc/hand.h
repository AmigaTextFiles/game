/*
    Bantumi
    Copyright 2005 - 2007 Martin Storsjö

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Martin Storsjö
    martin@martin.st
*/

#ifndef __HAND_H
#define __HAND_H

#include "glwrapper.h"

class DataSource;
class Bone;

class Hand {
public:
	Hand();
	~Hand();

	void getDim(GLTYPE *v);
	void scale(GLTYPE f);

	void draw();

	void setPose(int n, GLTYPE pose);
	void setPose(GLTYPE pose);
	void doPose();

private:
	void initFromFile(const char *name);
	void initFromMem(const void *ptr);
	void initFromDS(DataSource *ds);

	int nFaces;
	short *faces;

	int nVertices;
	GLTYPE *vertices;
	GLTYPE *normals;
	GLTYPE dim[3];

	int nBones;
	Bone *bones;

};

#endif
