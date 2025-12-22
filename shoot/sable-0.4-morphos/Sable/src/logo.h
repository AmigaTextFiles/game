/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  logo.h: The environment for the logo display.
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

#ifndef _LOGO_H_
#define _LOGO_H_

#include "sable.h"
#include "environment.h"

class Logo : public Environment {
 public:
	Logo (void) {}
	virtual ~Logo (void) {}
	virtual void init (void);
	virtual void uninit (void);
	virtual EnvID processEvents (void);
	virtual void frameAdvance (void);
	virtual void renderScreen (void);
 private:
	int intensity, counter, state;
};

#endif
