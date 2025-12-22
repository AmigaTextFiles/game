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

#ifndef __MESH_H
#define __MESH_H

#include "glwrapper.h"

class Mesh {
public:
	Mesh();
	~Mesh();
	void draw();
	void getDim(GLTYPE *dim);
	void scale(GLTYPE x, GLTYPE y, GLTYPE z);

	int nVertices;
	GLTYPE *vertices;
	GLTYPE *normals;
	int nFaces;
	short *faces;
};

class AggregateMesh : public Mesh {
public:
	AggregateMesh(int n, Mesh *m);
	~AggregateMesh();

	void setVertices(int n, const GLTYPE *matrix);
	void setFaces();
	void setColor(int n, const GLTYPE *color);
	void draw();

	GLTYPE *colors;
	Mesh *parent;
	int copies;
};

class SphereMesh : public Mesh {
public:
	SphereMesh(int rings, int segments);
};

class TriSphereMesh : public Mesh {
public:
	TriSphereMesh(int levels);
};

class BowlMesh : public Mesh {
public:
	BowlMesh(int segments, bool smooth, float r1, float r2, float r3, float h1);
};

class CircleMesh : public Mesh {
public:
	CircleMesh(int segments);
};

#endif
