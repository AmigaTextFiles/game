/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  sable.h: Compatibility #defines and globals.
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

#ifndef _SABLE_H_
#define _SABLE_H_

#ifdef WIN32
#include <windows.h>
#define for if(0);else for
#define NO_RANDOM
#define strcasecmp stricmp
#include <string.h>
#elif defined __MORPHOS__
#define NO_RANDOM
#include <strings.h>
#else
#include <strings.h>
#endif

#ifndef SABLE_RESOURCEDIR
#define SABLE_RESOURCEDIR ""
#endif

#ifdef NO_RANDOM
#define random() bcpl_random()
#define srandom(x) bcpl_srandom (x)

#include "bcplrandom.h"
#endif

#include <SDL.h>
#include <GL/gl.h>
#include <GL/glu.h>

extern int last_score, high_score;
extern GLfloat ground_speed;
#endif
