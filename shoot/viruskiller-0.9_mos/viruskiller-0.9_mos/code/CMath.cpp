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

void Math::limitChar(signed char *in, int low, int high)
{
	if (*in < low)
		*in = low;
	if (*in > high)
		*in = high;
}

void Math::limitChar(unsigned char *in, int low, int high)
{
	if (*in < low)
		*in = low;
	if (*in > high)
		*in = high;
}

void Math::limitInt(int *in, int low, int high)
{
	if (*in < low)
		*in = low;
	if (*in > high)
		*in = high;
}

void Math::limitFloat(float *in, float low, float high)
{
	if (*in < low)
		*in = low;
	if (*in > high)
		*in = high;
}

void Math::wrapChar(signed char *in, signed char low, signed char high)
{
	if (*in < low)
		*in = high;
	if (*in > high)
		*in = low;
}

void Math::wrapInt(int *in, int low, int high)
{
	if (*in < low)
		*in = high;
	if (*in > high)
		*in = low;
}

void Math::wrapFloat(float *in, float low, float high)
{
	if (*in < low)
		*in = high;
	if (*in > high)
		*in = low;
}

void Math::swap(int *i1, int *i2)
{
	int temp = *i1;
	*i2 = *i1;
	*i1 = temp;
}

void Math::swap(float *f1, float *f2)
{
	float temp = *f1;
	*f2 = *f1;
	*f1 = temp;
}

int Math::rrand(int min, int max)
{
	int r = min;

	max++;

	if ((max - min) == 0)
		return min;

	r += rand() % (max - min);

	return r;
}

bool Math::boolFromWord(char *word)
{
	if (strcmp(word, "TRUE") == 0)
		return true;

	return false;
}

void Math::addBit(unsigned int *currentBits, int newBits)
{
	if (!(*currentBits & newBits))
		*currentBits += newBits;
}

void Math::removeBit(unsigned int *currentBits, int oldBits)
{
	if (*currentBits & oldBits)
		*currentBits -= oldBits;
}

void Math::calculateSlope(float x, float y, float x2, float y2, float *dx, float *dy)
{
	int steps = (int)max(fabs(x - x2), fabs(y - y2));
	if (steps == 0)
	{
		*dx = 0;
		*dy = 0;
		return;
	}

	*dx = (x - x2);
	*dx /= steps;
	*dy = (y - y2);
	*dy /= steps;
}
