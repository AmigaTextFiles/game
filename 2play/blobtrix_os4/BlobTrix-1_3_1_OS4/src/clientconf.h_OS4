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

#include "config.h"

#ifndef _CLIENTCONF_H_
#define _CLIENTCONF_H_


class clientconf {
	public:
		clientconf();

		IPaddress address;
		char nick[21];

		Uint16 left;
		Uint16 right;
		Uint16 shoot;
		Uint16 wleft;
		Uint16 wright;
		Uint16 rotate;
		Uint16 newgame;
		Uint16 chatkey;

		int soundvolume;
		int musicvolume;
		bool playsound;
		bool playmusic;

		void LoadConf();
		void SaveConf();
		void Defaults();

	private:
		FILE *fp;
		bool Corrupt(int ch);



};



#endif
