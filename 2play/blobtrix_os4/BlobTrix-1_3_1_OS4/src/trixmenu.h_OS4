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


#ifndef _TRIXMENU_H_
#define _TRIXMENU_H_

#include "SDL.h"
#include "SDL_net.h"

#include "config.h"

#include "keyboard.h"
#include "graphics.h"
#include "font.h"
#include "mouse.h"
#include "net.h"
#include "block.h"
#include "client.h"
#include "followclient.h"

#include "clientconf.h"
#include "sound.h"
#include "media.h"

#include "servlist.h"

#include "button.h"

#include "stringblock.h"
#include "scrollbar.h"

#include "servlist.h"

extern graphics Graphics;
extern keyboard Keyboard;
extern mouse Mouse;
extern block Block;
extern media Media;

class menu
{
public:
	menu();
	
	void Initialize();
	void MainMenu();
	void Credits();
	void NetworkGame();
	void SetKeyboard();
	void Options();

	void SetKey(Uint16 *ptr);
   
	void CleanUp();

	void ServerWizard();
   
private:

	SDL_Surface *CreateMenuBG(char *filename);
	void UpdateServerList(servlist *servlist_first, int *servers);

	Uint32 update;
	int rotation, alpha, blocknum;
	SDL_Surface *background, *credits_bg, *rotatedblock;
	SDL_Surface *block[5]; 

	SDL_Surface *blocks;

	clientconf *Clientconf;

#ifndef NOSOUND
	Mix_Music *menumusic;
	Mix_Chunk *klik;
#endif

	stringblock *Nick; 
	stringblock *Host;
	stringblock *Port;
	stringblock *Pass;

	servlist *sl_first;
	servlist *sl_last;
	servlist *sl_lfirst;
	servlist *sl_llast;

	SDL_Surface *network_bg;
	SDL_Surface *ndown[5];
	SDL_Surface *nicon[3];
	button *nbutton[5];
	SDL_Surface *nd_bar;
	SDL_Surface *nd_selection;

	SDL_Surface *mainmenu_bg;
	SDL_Surface *mdown[4];
	button *mbutton[4];

	SDL_Surface *options_bg;
	SDL_Surface *odown[4];
	button *obutton[4];
	SDL_Surface *barblock;

	SDL_Surface *setkeys_bg;
	SDL_Surface *sdown[9];
	button *sbutton[9];

	SDL_Surface *back;
	
	SDL_Surface *bar_up, *bar_down;
//	client Client;

};

#endif

