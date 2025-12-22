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


#ifndef _SPLAYER_H_
#define _SPLAYER_H_

#include "config.h"

#include "SDL.h"
#include "SDL_net.h"
#include "tetrablock.h"

#define XSIZE 14
#define YSIZE 28

class splayer {
	public:
		splayer();

		bool SetNick(char *nick);
		char *GetNick();
		bool SetIPaddress(IPaddress address);

		int GetSelection();
		void SetSelection(int selection);

		int GetAngle();

		void pinged();
		Uint32 lastping();

		tetrablock *blocks[5];
		char slot[5];

		int launchdelay;
		int controlling;

		IPaddress address;
		bool free;
		int movedelay;
		int angle;

		Uint32 loadtime;
		bool loading;

		int shootwait;
		bool canshoot;

		int score;
		int lines;

		Uint32 ping;

		int newgame;

	private:
		char selected;


		Uint32 lping;
		char nick[21];


};












#endif
