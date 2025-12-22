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

#ifndef _FONT_H_
#define _FONT_H_

#define FONT_NORMAL		0x000000
#define FONT_XCENTERED	0x000010
#define FONT_YCENTERED	0x000100
#define FONT_CENTERED	0x000110
#define FONT_RIGHTENED	0x001000

#define FONT_116 0
#define CHATFONT 1
#define ONWOOD 2

#define CHARACTERS 187

#include "SDL.h"
#include "config.h"

class font {
	public:
		font();
		~font();

		void Initialize(int fonttype);

		int GetWidth(Uint8 letter);
		int WriteChar(SDL_Surface *screen, Uint8 letter, Uint32 cx, Uint32 cy);
		void WriteString(SDL_Surface *screen, char *string, Uint32 cx, Uint32 cy, Uint32 flags);
		int GetStringWidth(char *string);
		int GetHeight();

	private:

		int type;

		SDL_Surface *fontpic;

		Uint32 fontdata[CHARACTERS][2];
		Uint32 spacewidth;
		Uint32 letterdist;

};

#endif
