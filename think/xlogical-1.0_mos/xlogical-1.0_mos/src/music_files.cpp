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

char *musicFiles[] = {
#ifndef __MORPHOS__
	DATA_DIR PATHSEP "music" PATHSEP "intro.mod",
	DATA_DIR PATHSEP "music" PATHSEP "pregame.mod",
	DATA_DIR PATHSEP "music" PATHSEP "ingame.mod",
	DATA_DIR PATHSEP "music" PATHSEP "endgame.mod",
	DATA_DIR PATHSEP "music" PATHSEP "highscore.mod",
	DATA_DIR PATHSEP "music" PATHSEP "wongame.mod"
#else
	"Progdir:music" PATHSEP "intro.mod",
	"Progdir:music" PATHSEP "pregame.mod",
	"Progdir:music" PATHSEP "ingame.mod",
	"Progdir:music" PATHSEP "endgame.mod",
	"Progdir:music" PATHSEP "highscore.mod",
	"Progdir:music" PATHSEP "wongame.mod"
#endif
};
