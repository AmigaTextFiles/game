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


#ifndef _LIST_H_
#define _LIST_H_

#include "SDL.h"
#include "SDL_net.h"

#include "config.h"

class servlist {
	public:
		servlist(servlist *p);
		~servlist();

		IPaddress address;

		char *metainfo;
		char *version;
		int players;

		int gametime;

		int lightning;

		int dedicated;
		int followers;

		servlist *next;
		servlist *prev;

		char *hoststring;
		char *hoststring_short;

		Uint32 ping;

		Uint32 lastping;


};


#endif
