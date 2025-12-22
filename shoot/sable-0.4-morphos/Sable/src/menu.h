/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  menu.h: The main menu environment
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

#ifndef _MENU_H_
#define _MENU_H_

#include "sable.h"
#include "environment.h"

class Menu : public Environment {
 public:
	Menu (void) {}
	virtual ~Menu (void) {}
	virtual void init (void);
	virtual void uninit (void);
	virtual EnvID processEvents (void);
	virtual void frameAdvance (void);
	virtual void renderScreen (void);
 private:
	int selection;
	bool button_down;
	GLfloat rotate;
};

#endif
