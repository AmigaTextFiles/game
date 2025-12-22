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

#ifndef MUSIC_FILES_H
#define MUSIC_FILES_H

typedef enum defaultMusic {
	MUSIC_INTRO = 0,
	MUSIC_PRE_GAME,
	MUSIC_IN_GAME,
	MUSIC_END_GAME,
	MUSIC_HIGH_SCORE,
	MUSIC_WON_GAME,
	NUM_DEFAULT_MUSIC	// MUST BE LAST ITEM IN LIST!!!
} DefaultMusic;

extern char *musicFiles[];

#endif
