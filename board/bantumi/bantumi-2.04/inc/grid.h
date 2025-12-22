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

#ifndef __GRID_H
#define __GRID_H

#include "glwrapper.h"

class FillGrid;

class Grid {
public:
	friend class FillGrid;

	Grid();
	~Grid();

	void setDiam(float d);
	void setShape(float r1, float r2, float h);
	void calcPositions(int n);

	bool fitsWithin(const float *pos);
	void eval(int x, int y, int z, float *out);
	void getPos(GLTYPE *pos, int n);

private:
	void addPos(int z, float *pos);
	int checkRow(int z, int y);

	float sphereD, sphereDsqrt13_4, sphereDsqrt3_2, sphereD_2, sphereD_4;

	float radius1, radius2, height, zfact;

	int numPositions, maxPositions;
	float *positions;
	int zStart[10];
	int size[10];
};

class FillGrid {
public:
	FillGrid(Grid *g);
	~FillGrid();

	void add(int number);
	void reset();
	int getTop();
	int getCeil();

	int *indices;
	int filled;
	int *numbers;

private:
	Grid *grid;
};

#endif
