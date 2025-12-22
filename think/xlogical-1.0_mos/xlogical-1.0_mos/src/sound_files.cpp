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

#include "defs.h"

char *soundFiles[] = {
#ifndef __MORPHOS__
	DATA_DIR PATHSEP "sound" PATHSEP "block_ball.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "bonus_life.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "catch_ball.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "eject_ball.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "finish_level.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "finish_spinner.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "menu_click.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "new_ball.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "new_pattern.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "one_way.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "paint_ball.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "spinner_click.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "teleport.wav",
	DATA_DIR PATHSEP "sound" PATHSEP "time_warning.wav"
#else
	"Progdir:sound" PATHSEP "block_ball.wav",
	"Progdir:sound" PATHSEP "bonus_life.wav",
	"Progdir:sound" PATHSEP "catch_ball.wav",
	"Progdir:sound" PATHSEP "eject_ball.wav",
	"Progdir:sound" PATHSEP "finish_level.wav",
	"Progdir:sound" PATHSEP "finish_spinner.wav",
	"Progdir:sound" PATHSEP "menu_click.wav",
	"Progdir:sound" PATHSEP "new_ball.wav",
	"Progdir:sound" PATHSEP "new_pattern.wav",
	"Progdir:sound" PATHSEP "one_way.wav",
	"Progdir:sound" PATHSEP "paint_ball.wav",
	"Progdir:sound" PATHSEP "spinner_click.wav",
	"Progdir:sound" PATHSEP "teleport.wav",
	"Progdir:sound" PATHSEP "time_warning.wav"
#endif
};
