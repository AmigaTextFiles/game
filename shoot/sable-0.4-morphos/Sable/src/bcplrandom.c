/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  bcplrandom.c: replacement routines for random() and srandom().
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


#include "bcplrandom.h"

/* This is a simple linear congruential random number generator.  It's
 * based on a description of the BCPL random function.  It's not as
 * good as modern libc random(), but it blows the pants off of the
 * traditional rand() and srand(). */

static int value = 0;

int 
bcpl_random (void)
{
	value *= 0x9010836d;
	value += 0x2aa01d31;	
	return value & 0x7FFFFFF;
}

void
bcpl_srandom (unsigned int seed)
{
	value = seed;
}
