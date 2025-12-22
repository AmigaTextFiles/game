//////////////////////////////////////////////////////////////////////
// XLogical - A puzzle game
//
// Copyright (C) 2000 Neil Brown, Tom Warkentin
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
// or at the website: http://www.gnu.org
//
////////////////////////////////////////////////////////////////////////

#ifndef SOUND_FILES_H
#define SOUND_FILES_H

typedef enum defaultSounds {
	SOUND_BLOCK_BALL = 0,
	SOUND_BONUS_LIFE,
	SOUND_CATCH_BALL,
	SOUND_EJECT_BALL,
	SOUND_FINISH_LEVEL,
	SOUND_FINISH_SPINNER,
	SOUND_MENU_CLICK,
	SOUND_NEW_BALL,
	SOUND_NEW_PATTERN,
	SOUND_ONE_WAY,
	SOUND_PAINT_BALL,
	SOUND_SPINNER_CLICK,
	SOUND_TELEPORT,
	SOUND_TIME_WARNING,
	NUM_DEFAULT_SOUNDS	// MUST BE LAST ITEM IN LIST!!!
} DefaultSounds;

extern char *soundFiles[];

#endif
