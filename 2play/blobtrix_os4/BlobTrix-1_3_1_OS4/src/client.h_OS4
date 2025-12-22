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

#ifndef _CLIENT_H_
#define _CLIENT_H_

#include "SDL.h"
#include "SDL_net.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "splayer.h"
#include "font.h"
#include "chat.h"

#include "config.h"

#include "stringblock.h"

#include "clientconf.h"

#include "sound.h"
#include "media.h"

#include "config.h"

#define XSIZE 14
#define YSIZE 28

class client {
	public:
		client();

		void LoadStuff();
		void FreeStuff();

		void Reset();
		void game();

		bool SetNick(char *nick);

		bool connect(IPaddress *address, char *errmsg[]);
		
		void DrawRound();


		clientconf *Config;



	private:
		IPaddress servaddress;
		Uint32 lastping;

		font font116;
		font chatfont;
		font onwood;

		splayer Player;
		splayer Enemy;

		char blocks[YSIZE][XSIZE];

		int shootwait;

		int winner;

		bool updateblockmap;
		
		bool alone;

		int gametime;
		int timestep;

		bool chatline;

		chat *chatfirst;
		chat *chatlast;

		bool drawupdatechat;
		bool drawupdatepings;
		bool drawupdateslots;
		bool drawupdatescores;
		bool drawupdateblockmap;
		bool drawupdatenicks;
		bool drawupdateclock;
		bool drawupdateblocks;

		Uint32 alonetime;

		stringblock *Chatline;
/*
#ifndef NOSOUND
		Mix_Chunk *browseclick;
		Mix_Chunk *rotate;
		Mix_Chunk *launch;
		Mix_Chunk *select;
		Mix_Chunk *fossil;

		Mix_Chunk *win, *lose;

		Mix_Music *gamemusic;

		Mix_Music *old;
#endif
*/

};





#endif
