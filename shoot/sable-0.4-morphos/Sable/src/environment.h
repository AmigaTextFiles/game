/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  environment.h: Abstraction layer representing various activities
 *  the player may be doing
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

#ifndef _ENVIRONMENT_H_
#define _ENVIRONMENT_H_

typedef enum {
	ENVIRON_EXIT = 0,
	ENVIRON_LOGO,
	ENVIRON_MENU,
	ENVIRON_GAME,
	NUM_ENVIRONS
} EnvID;

class Environment {
 public:
	Environment (void) {}
	virtual ~Environment (void) {}
	virtual void init (void) { }
	virtual void uninit (void) { }
	virtual EnvID processEvents (void) = 0;
	virtual void frameAdvance (void) = 0;
	virtual void renderScreen (void) = 0;
};

void main_loop (void);

#endif
