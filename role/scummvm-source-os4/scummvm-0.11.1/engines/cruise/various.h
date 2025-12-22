/* ScummVM - Graphic Adventure Engine
 *
 * ScummVM is the legal property of its developers, whose names
 * are too numerous to list here. Please refer to the COPYRIGHT
 * file distributed with this source distribution.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 * $URL: https://scummvm.svn.sourceforge.net/svnroot/scummvm/scummvm/tags/release-0-11-1/engines/cruise/various.h $
 * $Id: various.h 30944 2008-02-23 22:50:18Z sev $
 *
 */

#ifndef CRUISE_VARIOUS_H
#define CRUISE_VARIOUS_H

#include "cruise/cell.h"

namespace Cruise {

extern uint16 remdo;
extern uint16 PCFadeFlag;

int16 readB16(void *ptr);

int16 objInit(int ovlIdx, int param1, int param2);
char *getText(int textIndex, int overlayIndex);
} // End of namespace Cruise

#endif
