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

#include "grid.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#ifdef _STRICT_ANSI
#define hypot(x, y) sqrt((x)*(x) + (y)*(y))
#endif

void Grid::setDiam(float d) {
	sphereD = d;
	sphereDsqrt13_4 = sphereD*sqrt(13)/4;
	sphereDsqrt3_2 = sphereD*sqrt(3)/2;
	sphereD_2 = sphereD/2;
	sphereD_4 = sphereD/4;
}

void Grid::setShape(float r1, float r2, float h) {
	radius1 = r1;
	radius2 = r2;
	height = h;
	zfact = (radius2-radius1)/height;
}

void Grid::eval(int x, int y, int z, float *out) {
	out[0] = 0;
	out[1] = 0;
	out[2] = sphereD_2;
	if ((z%2) != 0) {
		out[0] += sphereD_2;
		out[1] += sphereD_4;
	}
	if ((y%2) != 0)
		out[0] += sphereD_2;
	out[2] += z*sphereDsqrt13_4;
	out[0] += x*sphereD;
	out[1] += y*sphereDsqrt3_2;
}

bool Grid::fitsWithin(const float *pos) {
	float r = radius1 + zfact*pos[2] - sphereD_2;
	return hypot(pos[0], pos[1]) < r;
}

void Grid::addPos(int z, float *pos) {
	if (numPositions >= maxPositions)
		return;
	memcpy(&positions[3*numPositions], pos, sizeof(float)*3);
	if (zStart[z] < 0) {
		zStart[z] = numPositions;
		zStart[z+1] = -1;
	}
	numPositions++;
}

int Grid::checkRow(int z, int y) {
	int x = 0;
	int found = 0;
	while (true) {
		float pos[3];
		eval(x, y, z, pos);
		if (!fitsWithin(pos))
			break;
		addPos(z, pos);
		x++;
		found++;
	}
	x = -1;
	while (true) {
		float pos[3];
		eval(x, y, z, pos);
		if (!fitsWithin(pos))
			break;
		addPos(z, pos);
		x--;
		found++;
	}
	return found;
}

void Grid::calcPositions(int n) {
	numPositions = 0;
	maxPositions = n;
	delete [] positions;
	positions = new float[3*maxPositions];
	zStart[0] = -1;

	int found = 0;
	int z = 0;
	while (found < n) {
		int y = 0;
		int thisrow = 0;
		do {
			thisrow = checkRow(z, y);
			found += thisrow;
			y++;
		} while (thisrow > 0);
		y = -1;
		do {
			thisrow = checkRow(z, y);
			found += thisrow;
			y--;
		} while (thisrow > 0);
		z++;
	}

	z = 0;
	while (zStart[z] >= 0) {
		int end = zStart[z+1];
		if (end < 0)
			end = numPositions;
		size[z] = end - zStart[z];
		z++;
	}
	size[z] = 0;
}

void Grid::getPos(GLTYPE *out, int n) {
#ifdef USE_FIXED
	out[0] = F(positions[3*n+0]);
	out[1] = F(positions[3*n+1]);
	out[2] = F(positions[3*n+2]);
#else
	memcpy(out, &positions[3*n], sizeof(GLTYPE)*3);
#endif
}

Grid::Grid() {
	positions = NULL;
}

Grid::~Grid() {
	delete [] positions;
}


FillGrid::FillGrid(Grid *g) {
	grid = g;
	indices = new int[grid->numPositions];
	numbers = new int[grid->numPositions];
	for (int i = 0; i < grid->numPositions; i++)
		indices[i] = i;
#ifdef SCREENSHOT
	indices[0] = 3;
	indices[1] = 5;
	indices[2] = 12;
	indices[3] = 14;
#endif
	filled = 0;
}

FillGrid::~FillGrid() {
	delete [] indices;
	delete [] numbers;
}

int FillGrid::getTop() {
	int z = 0;
	while (filled >= grid->zStart[z] + grid->size[z])
		z++;
	return z;
}

int FillGrid::getCeil() {
	int z = 0;
	while (filled > grid->zStart[z])
		z++;
	return z;
}

void FillGrid::add(int number) {
#ifndef SCREENSHOT
	int z = getTop();
	int index = filled + (rand() % (grid->size[z] - (filled - grid->zStart[z])));
	int tmp = indices[filled];
	indices[filled] = indices[index];
	indices[index] = tmp;
#endif
	numbers[filled] = number;
	filled++;
}

void FillGrid::reset() {
	filled = 0;
}


