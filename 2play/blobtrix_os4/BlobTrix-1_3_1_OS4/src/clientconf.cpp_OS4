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

#include "client.h"

#include "variable.h"

clientconf::clientconf() {
	address.host=0;
	address.port=0;

	memset (nick, 0, 21);

	left=SDLK_LEFT;
	right=SDLK_RIGHT;
	shoot=SDLK_RSHIFT;
	wleft=SDLK_COMMA;
	wright=SDLK_PERIOD;
	rotate=SDLK_UP;
	newgame=SDLK_F1;
	chatkey=SDLK_RETURN;

	soundvolume=64;
	musicvolume=16;
	playsound=true;
	playmusic=true;
}

void clientconf::LoadConf() {
	fp = fopen ("client.dat", "rb");

	if (fp==NULL) {
		fprintf (stderr, "No client.dat found! Using defaults!\n");
		Defaults();
		return;
	}

	// read nick
	fread(nick, 21, 1, fp);
	nick[21]='\0';

	// read keys (Uint16)
	variable::FromFile_ShortInt(fp, &left);
	variable::FromFile_ShortInt(fp, &right);
	variable::FromFile_ShortInt(fp, &shoot);
	variable::FromFile_ShortInt(fp, &wleft);
	variable::FromFile_ShortInt(fp, &wright);
	variable::FromFile_ShortInt(fp, &rotate);
	variable::FromFile_ShortInt(fp, &newgame);
	variable::FromFile_ShortInt(fp, &chatkey);


	fread(&soundvolume, sizeof(char), 1, fp);
	if (soundvolume>0) playsound=true;
	else playsound=false;

	fread(&musicvolume, sizeof(char), 1, fp);
	if (musicvolume>0) playmusic=true;
	else playmusic=false;

	fclose(fp);
}

void clientconf::SaveConf() {
	fp = fopen ("client.dat", "wb");

	fwrite(nick, 21, 1, fp);

	// write keys (Uint16)
	variable::ToFile_ShortInt(fp, left);
	variable::ToFile_ShortInt(fp, right);
	variable::ToFile_ShortInt(fp, shoot);
	variable::ToFile_ShortInt(fp, wleft);
	variable::ToFile_ShortInt(fp, wright);
	variable::ToFile_ShortInt(fp, rotate);
	variable::ToFile_ShortInt(fp, newgame);
	variable::ToFile_ShortInt(fp, chatkey);

	fwrite(&soundvolume, sizeof(char), 1, fp);
	fwrite(&musicvolume, sizeof(char), 1, fp);

	fclose(fp);
}


void clientconf::Defaults() {
	sprintf (nick, "Player");

	left=SDLK_LEFT;
	right=SDLK_RIGHT;
	shoot=SDLK_RSHIFT;
	wleft=SDLK_COMMA;
	wright=SDLK_PERIOD;
	rotate=SDLK_UP;
	newgame=SDLK_F1;
	chatkey=SDLK_RETURN;

	soundvolume=127;
	musicvolume=80;
	playsound=true;
	playmusic=true;
}


// private

bool clientconf::Corrupt(int ch) {
	if (ch==EOF) {
		fprintf (stderr, "Client.dat is corrupted.\n");
		Defaults();
		fclose(fp);
		return true;
	}
	return false;
}
