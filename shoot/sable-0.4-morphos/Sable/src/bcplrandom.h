/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  bcplrandom.h: replacement routines for random() and srandom().
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

#ifndef _BCPLRANDOM_H_
#define _BCPLRANDOM_H_

#ifdef __cplusplus
extern "C" {
#else
#endif

int bcpl_random (void);
void bcpl_srandom (unsigned int seed);

#ifdef __cplusplus
}
#endif

#endif
