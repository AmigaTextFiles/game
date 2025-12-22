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


#ifndef _PARSER_H_
#define _PARSER_H_

#include "SDL.h"
#include <stdlib.h>
#include <stdio.h>
#include <iostream>

#include "config.h"

#define RPL_WELCOME "001"
#define RPL_END_OF_MOTD "376"

class parser {
	public:
		parser();
		~parser();

		bool same (char *a, char *b);

		void GetHost(char *host, char *inpacket, int *i);
		void GetNick(char *nick, char *host);

		char *GetFirstParam(char *msg, int *j);
		char *GetParam(char *msg, int *j);

		int GetNumber(char *str);

};



#endif
