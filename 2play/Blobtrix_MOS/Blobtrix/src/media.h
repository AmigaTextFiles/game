/*
    Copyright (c) 2004-2005 Markus Kettunen

    This file is part of Blobtrix.

    Blobtrix is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Blobtrix is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Blobtrix; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


#ifndef _MEDIA_H_
#define _MEDIA_H_

#include "SDL.h"

#ifndef NOSOUND
#include "sound.h"
#endif

class media {
public:
	media();
	~media();
	
	void LoadStuff();
	
#ifndef NOSOUND
	Mix_Chunk *browseclick;
	Mix_Chunk *rotate;
	Mix_Chunk *launch;
	Mix_Chunk *select;
	Mix_Chunk *fossil;
	Mix_Chunk *notalone;

	Mix_Chunk *win, *lose;
		
	Mix_Music *gamemusic;

	Mix_Music *old;
#endif
};



#endif
