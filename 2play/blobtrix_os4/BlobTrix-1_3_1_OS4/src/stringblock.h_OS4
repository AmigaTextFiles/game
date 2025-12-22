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


#ifndef _STRINGBLOCK_H_
#define _STRINGBLOCK_H_

#include "font.h"
#include "config.h"

#define NOSPACE 1

class stringblock {
	public:
		stringblock(font *f, SDL_Surface *bg, int x, int y, Uint32 flags, int width, int maxlen);
		stringblock(font *f, SDL_Surface *bg, int x, int y, Uint32 flags, int width, int maxlen, bool space);
		void MoveTo(int x, int y);
		void SetBg(SDL_Surface *bg);
		void SetPassword(bool b);

		void Listen();
		void ListenNum();

		void Draw(int underscore);
		void Clean();
		char *Get();
		void Set(char *str);

	private:
		int GetWidth(char ch);
		int GetStringWidth(char *str);

		SDL_Surface *bg;
		Uint32 flags;
		int x, y;
		int width;
		int maxlen;

		font *Font;

		char string[257];

		int cursor;
		

		bool space;
		bool passwd;

};




#endif
