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


#ifndef _SERVCONF_H_
#define _SERVCONF_H_

#include "SDL.h"
#include "config.h"

#define MAXINFOLINELENGTH 60

class servconf {
	public:
		servconf();
		~servconf();

		bool same(char *a, char *b);

		void reset();
		void load(char *filename);

		char infoline[MAXINFOLINELENGTH];

		int gametime;
		int port;
		char contactmetaserver;

		int timeout;
		int newblocktime;
		int noshoottime;
		int noshootboost;
		Uint32 pingtimerate;
		Uint32 timeupdaterate;

		int killcode;

		char lightning;
};




#endif
