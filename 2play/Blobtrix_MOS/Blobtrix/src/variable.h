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


#ifndef _VARIABLE_H_
#define _VARIABLE_H_

#include <stdlib.h>
#include <string.h>

#include "config.h"

#include "SDL.h"
#include "endian.h"

namespace variable {
		// type conversions

		int Str2Int(char *str, int from);

		// net tools

		Uint32 Str2IP(char *str, int from); /* This is useless because of SDLNet_ResolveHost */
		char * IP2Str(Uint32 ip); /* This is useless because of SDLNet_ResolveIP */

		// string checkers

		bool Str_CheckLastChars (char *filepath, char *extension); // Checks, for example, the extension of a file name.

		// file functions

		void ToFile_Int(FILE *stream, Uint32 data);
		void FromFile_Int(FILE *stream, Uint32 *data);
		void ToFile_ShortInt(FILE *stream, Uint16 data);
		void FromFile_ShortInt(FILE *stream, Uint16 *data);

		char *str_split(char *str, char ch, int num); // remember to delete the new char-array!
		int str_splitgetint(char *str, char ch, int num);
		bool str_splitcompare(char *str, int num, char *str2);
		char *str_fullsplit(char *str, char ch, int num); // remember to delete the new char-array!

};




#endif
