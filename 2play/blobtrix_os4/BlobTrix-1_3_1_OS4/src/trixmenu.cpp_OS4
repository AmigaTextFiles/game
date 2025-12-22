/*
    Copyright (c) 2004-2005 Markus Kettunen, Jussi-Pekka Erkkilä

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


#include "trixmenu.h"
#include <iostream>
#include <string>

#include "endian.h"

#include "SDL_thread.h"

#include "client.h"
#include "followclient.h"

#include "variable.h"
#include "net.h"

#include "config.h"

#include "files.h"

//using namespace std;

#define SCREEN_WIDTH 800  
#define SCREEN_HEIGHT 600
#define BPP 32

client Client;
followclient Followclient;

font onwood;
font chatfont;
clientconf Clientconf;

extern UDPsocket sock;

Uint32 texttimer=0;



menu::menu(){
}

SDL_Surface *menu::CreateMenuBG(char *filename) {
	SDL_Surface *tmp = Graphics.LoadPicture(filename);
	Graphics.SetTransparentColor(tmp, 255, 0, 0);
	
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
	Uint32 rmask = 0xff000000;
	Uint32 gmask = 0x00ff0000;
	Uint32 bmask = 0x0000ff00;
	Uint32 amask = 0x000000ff;
#else
	Uint32 rmask = 0x000000ff;
	Uint32 gmask = 0x0000ff00;
	Uint32 bmask = 0x00ff0000;
	Uint32 amask = 0xff000000;
#endif
	SDL_Surface *tmp2 = SDL_CreateRGBSurface(SDL_HWSURFACE, 800, 600, 32, rmask, gmask, bmask, amask);
	Graphics.DrawIMG(tmp2, back, 0, 0);
	Graphics.DrawIMG(tmp2, tmp, 0, 0);
	
	SDL_FreeSurface (tmp);
	
	return tmp2;
}

void menu::Initialize() {
	Clientconf = new clientconf;
	Clientconf->LoadConf();

	credits_bg = Graphics.LoadPicture(DATA_BACK02C_PNG);
	back = Graphics.LoadPicture(DATA_BACK02A_PNG);
   
	onwood.Initialize(ONWOOD); // Intializes font
	chatfont.Initialize(CHATFONT);

#ifndef NOSOUND
	klik = sound::LoadWAV(DATA_KLIK_WAV);
	menumusic = sound::LoadMusic("data/btrxmenu.ogg");

	sound::SoundVolume(Clientconf->soundvolume);
	sound::MusicVolume(Clientconf->musicvolume);

	sound::PlayMusic(menumusic, -1);
#endif

/* main menu init */
	mainmenu_bg = Graphics.LoadPicture(DATA_MAINMENU_PNG);
	
	mdown[0]=Graphics.LoadPicture(DATA_MD_NETWORKGAME_PNG);
	mdown[1]=Graphics.LoadPicture(DATA_MD_OPTIONS_PNG);
	mdown[2]=Graphics.LoadPicture(DATA_MD_CREDITS_PNG);
	mdown[3]=Graphics.LoadPicture(DATA_MD_QUIT_PNG);

	mbutton[0]=new button(314, 324, 474, 374, mdown[0], mainmenu_bg);
	mbutton[1]=new button(314, 384, 474, 434, mdown[1], mainmenu_bg);
	mbutton[2]=new button(314, 444, 474, 494, mdown[2], mainmenu_bg);
	mbutton[3]=new button(314, 504, 474, 554, mdown[3], mainmenu_bg);

	barblock = Graphics.LoadPicture(DATA_BARBLOCK_PNG);
	bar_up = Graphics.LoadPicture(DATA_BAR_UP_PNG);
	bar_down = Graphics.LoadPicture(DATA_BAR_DOWN_PNG);
/* end of main menu init */

/* network menu init */
	network_bg = CreateMenuBG("data/network.png");
	nd_selection = Graphics.LoadPicture(DATA_ND_SELECTION_PNG);
//	graphics.SetTransparentColor(nd_selection, 0, 0, 0);
	
	ndown[0]=Graphics.LoadPicture(DATA_ND_REFRESH_PNG);
	ndown[1]=Graphics.LoadPicture(DATA_ND_PINGALL_PNG);
	ndown[2]=Graphics.LoadPicture(DATA_ND_BACKTOMAIN_PNG);
	ndown[3]=Graphics.LoadPicture(DATA_ND_JOIN_PNG);
	ndown[4]=Graphics.LoadPicture(DATA_ND_FOLLOW_PNG);

	nbutton[0]=new button(523, 514, 642, 563, ndown[0], network_bg);
	nbutton[1]=new button(653, 514, 772, 563, ndown[1], network_bg);
	nbutton[2]=new button(13, 514, 132, 563, ndown[2], network_bg);
	nbutton[3]=new button(673, 92, 772, 142, ndown[3], network_bg);
	nbutton[4]=new button(564, 92, 666, 142, ndown[4], network_bg);
	
	nicon[0]=Graphics.LoadPicture(DATA_I_DEDICATED_PNG);
	nicon[1]=Graphics.LoadPicture(DATA_I_LIGHTNING_PNG);
	nicon[2]=Graphics.LoadPicture(DATA_I_FOLLOWERS_PNG);

	nd_bar = Graphics.LoadPicture(DATA_ND_BAR_PNG);

/* end of network menu init */

	Host = new stringblock(&onwood, network_bg, 158, 58, FONT_NORMAL, 606, 255);
	Nick = new stringblock(&onwood, network_bg, 158, 113, FONT_NORMAL, 160, 20, NOSPACE); 
	Port = new stringblock(&onwood, network_bg, 471, 113, FONT_NORMAL, 79, 5);
	Pass = new stringblock(&onwood, network_bg, 339, 113, FONT_NORMAL, 109, 65);
	Pass->SetPassword(true);

	Nick->Set(Clientconf->nick);

/* options menu init */
	options_bg = CreateMenuBG("data/options.png");

	odown[0]=Graphics.LoadPicture(DATA_OD_SETKEYS_PNG);
	odown[1]=Graphics.LoadPicture(DATA_OD_MUSICVOLUME_PNG);
	odown[2]=Graphics.LoadPicture(DATA_OD_SOUNDVOLUME_PNG);
	odown[3]=Graphics.LoadPicture(DATA_OD_BACKTOMAIN_PNG);

	obutton[0]=new button(71, 171, 206, 220, odown[0], options_bg);
	obutton[1]=new button(71, 231, 206, 280, odown[1], options_bg);
	obutton[2]=new button(71, 291, 206, 340, odown[2], options_bg);
	obutton[3]=new button(71, 351, 206, 400, odown[3], options_bg);
/* end of options menu init */


/* set keys menu init */
	setkeys_bg = CreateMenuBG("data/setkeys.png");

	for (int i=0; i<8; i++) {
		char fn[32];
		sprintf (fn, "data/sd_key%d.png", i+1);
		sdown[i]=Graphics.LoadPicture(fn);
	}
	sdown[8]=Graphics.LoadPicture(DATA_SD_BACKTOOPTIONS_PNG);

	for (int i=0; i<6; i++) {
		sbutton[i]=new button(126, 126+i*60, 245, 176+i*60, sdown[i], setkeys_bg);
	}
	for (int i=0; i<2; i++) {
		sbutton[6+i]=new button(445, 126+i*60, 564, 176+i*60, sdown[6+i], setkeys_bg);
	}
	sbutton[8]=new button(446, 426, 565, 475, sdown[8], setkeys_bg);
/* set keys menu init */

	Media.LoadStuff(); // load game sounds
		
	Client.Config = Clientconf;
	Followclient.Config = Clientconf;
	
	Client.LoadStuff();  // load fonts
	Followclient.LoadStuff();
	

	
}

void menu::CleanUp() {
	Clientconf->SaveConf();

	SDL_FreeSurface(background);
	SDL_FreeSurface(credits_bg);
	SDL_FreeSurface(blocks);

	for (int i = 0; i < 5; i++) SDL_FreeSurface(block[i]);

#ifndef NOSOUND
	sound::FreeChunk(klik);
	sound::FreeMusic(menumusic);
	sound::HaltMusic();
#endif

	SDL_FreeSurface(bar_up);
	SDL_FreeSurface(bar_down);
	SDL_FreeSurface(barblock);
	
	SDL_FreeSurface(network_bg);
	SDL_FreeSurface(nd_selection);
	for (int i=0; i<5; i++) SDL_FreeSurface(ndown[i]);
	for (int i=0; i<5; i++) delete nbutton[i];
	for (int i=0; i<3; i++) delete nicon[i];
	SDL_FreeSurface(nd_bar);

	SDL_FreeSurface(mainmenu_bg);
	for (int i=0; i<4; i++) SDL_FreeSurface(mdown[i]);
	for (int i=0; i<4; i++) delete mbutton[i];

	SDL_FreeSurface(options_bg);
	for (int i=0; i<4; i++) SDL_FreeSurface(odown[i]);
	for (int i=0; i<4; i++) delete obutton[i];

	SDL_FreeSurface(setkeys_bg);
	for (int i=0; i<9; i++) SDL_FreeSurface(sdown[i]);
	for (int i=0; i<9; i++) delete sbutton[i];

	//Media.FreeStuff(); moved to destructor
}


void menu::MainMenu()
{

   Mouse.ResetReleased();

	Graphics.DrawIMG(Window.GetScreen(), mainmenu_bg, 0, 0);

	Uint32 timer=SDL_GetTicks();

	bool ready=false;

	int mx, my;

	while (!ready) {
#ifdef ENABLEDELAYS
		SDL_Delay(3);
#endif

		while (SDL_GetTicks()>=timer) {
			timer+=10;

			Keyboard.HandleInterrupts();

			Mouse.GetCursorCoords(&mx, &my);

			if (mbutton[0]->Handle()) { // network game
				NetworkGame();
				Graphics.DrawIMG(Window.GetScreen(), mainmenu_bg, 0, 0);
				timer=SDL_GetTicks();
			}
			if (mbutton[1]->Handle()) { // options
				Options();
				Graphics.DrawIMG(Window.GetScreen(), mainmenu_bg, 0, 0);
				timer=SDL_GetTicks();
			}
			if (mbutton[2]->Handle()) { // credits
				Credits();
				Graphics.DrawIMG(Window.GetScreen(), mainmenu_bg, 0, 0);
				timer=SDL_GetTicks();
			}
			if (mbutton[3]->Handle()) { // quit
				ready=true;
				Graphics.DrawIMG(Window.GetScreen(), mainmenu_bg, 0, 0);
				timer=SDL_GetTicks();
			}

		}

		for (int i=0; i<4; i++) {
			mbutton[i]->Draw();
		}


		SDL_Flip(Window.GetScreen());
	}




}

#define SCRLINES 64

void menu::Credits()
{

	char *text[SCRLINES]={
		"Blobtrix 1.3.1",
		"By Blobtrox",
		"",
		"Code:",
		"-B- Markus Kettunen (makegho)",
		"-B- Jussi-Pekka Erkkila (tomageeni)",
		"",
		"Arts:",
		"     Joona Karjalainen (jdruid)",
		"-B- Miikka Vartiainen (miiq)",
		"-B- Markus Kettunen (makegho)",
		"",
		"Blobtrox:",
		"-B- Tuomo Havo (tomeloome)",
		"-B- Roope Haimila (rphml)",
		"-B- Markus Kettunen (makegho)",
		"-B- Kaj Tallbacka (kai^)",
		"-B- Jussi-Pekka Erkkila (tomageeni)",
		"-B- Janne Junnila (btw-ii)",
		"-B- Hannu Pyyhtia (HZK1)",
		"-B- Antti Paasivaara (drinn)",
		"-B- Antti Jaakkola (atj)",
		"",
		"Special thanks to",
		"    You",
		"    Me",
		"    Everyone",
		"",
		"",
		"",
		"    And you too!",
		"",
		"",
		" - - - ",
		"",
		"    (read \"README\" for details)",
		"",
		" - - - ",
		"",
		"",
		"",
		"We'd like to thank Suomipelit.com",
		"and Ohjelmointiputka for",
		"organizing the block game",
		"development competition this",
		"great game was made for.",
		"",
		"",
		"",
		"",
		"",
		"",
		"And also thanks to all our beta",
		"testers and our fanclub ;)",
		"",
		"",
		"",
		"And you",
		"",
		"",
		"",
		"",
		"",
		"http://blobtrox.mine.nu/"


	};
		

   int y[SCRLINES]={0};
	for (int i=0; i<SCRLINES; i++) {
		y[i]=30*i;
	}

   int scroll_y = 600, width[SCRLINES];

   for(int a=0;a<SCRLINES;a++)
   {
		width[a]=onwood.GetStringWidth(text[a]);
   }


	Graphics.DrawIMG(Window.GetScreen(), credits_bg, 0, 0);

	Uint32 timer=SDL_GetTicks();

   while(!Keyboard.Pressed(SDLK_ESCAPE) && Mouse.Released(0)!=1 && !Keyboard.Pressed(SDLK_RETURN) ) {
      Keyboard.HandleInterrupts();

     while(SDL_GetTicks() >= timer) {
			timer += 20;
			scroll_y -= 1;
			if(scroll_y < -2000) scroll_y = 630;
		}


		for(int a=0; a<SCRLINES; a++) {   
			if(scroll_y + y[a] < 630 && scroll_y + y[a] > -50) {
				onwood.WriteString(Window.GetScreen(), (char*)text[a], 400, scroll_y + y[a], FONT_CENTERED);
			}
		}
		SDL_Flip(Window.GetScreen());

		for (int a=0; a<SCRLINES; a++) {
			if (scroll_y + y[a] < 630 && scroll_y + y[a] > -50) {
				Graphics.DrawPartOfIMG(Window.GetScreen(), credits_bg, 400-(int)(width[a]/2), scroll_y+y[a]-20,
					width[a], 50, 400-(width[a]/2), scroll_y+y[a]-20);
			}
		}

	}
}

void menu::NetworkGame() {
   Mouse.ResetReleased();

	int textsel=-1;


	Graphics.DrawIMG(Window.GetScreen(), network_bg, 0, 0);

	Uint32 timer=SDL_GetTicks();

	bool ready=false;

	int mx, my, ox=0, oy=0;

	servlist *servlist_first = new servlist(0);

	scrollbar Bar(753, 169, 304, 16, nd_bar, bar_up, bar_down, network_bg);
	Bar.SetMaxY(1);
	
	int selection=-1;
	int scroll=0;
	int servers=0;
	int oldscroll=0;
	int scrolltime=0;

	while (!ready) {
#ifdef ENABLEDELAYS
		SDL_Delay(3);
#endif

		while (SDL_GetTicks()>=timer) {
			timer+=10;

			if (texttimer==1) Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);
			if (texttimer>0) texttimer--;



			Mouse.GetCursorCoords(&mx, &my);
			if (mx!=ox || my!=oy) {
				if (mx>=150 && my>=37 && mx <= 773 && my <= 87) textsel=0;
				if (mx>=150 && my>=92 && mx <= 324 && my <= 142) textsel=1;
				if (mx>=333 && my>=92 && mx <= 455 && my <= 142) textsel=2;
				if (mx>=465 && my>=92 && mx <= 555 && my <= 142) textsel=3;
				ox=mx;
				oy=my;
			}

			scroll = Bar.Handle();
			if (scroll>servers-16) scroll=servers-16;
			if (scroll<0) scroll=0;
			Bar.SetScrollY(scroll);
			
			
			if (textsel==-1) Keyboard.HandleInterrupts();
			if (textsel==0) Host->Listen();
			if (textsel==1) Nick->Listen();
			if (textsel==2) Pass->Listen();
			if (textsel==3) Port->ListenNum();
			if (Keyboard.Pressed(SDLK_TAB)) textsel++;
			if (textsel>3) textsel=0;

			if (Mouse.Released(1)==2) {
				servlist *current = servlist_first;
				for (int i=0; i<scroll; i++) {
					current = current->next;
					if (!current) break;
				}
				
				if (current) {
					for (int i=0; i<16; i++) {
						if (mx>=13 && mx<=752 && my>=168+i*20 && my<=168+i*20+19) {
							
							bool found=true;
							for (int j=0; j<=i; j++) {
								current = current->next;
								if (!current) {
									found=false;
									break;
								}
							}
							if (found) {
								Host->Set( current->hoststring );
								char port[6];
								sprintf (port, "%d", net::ConvPort(current->address.port));
								Port->Set( port );
								if (selection!=-1) Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg,
									16, 167+(selection-scroll)*20, 772-16, 20, 16, 167+(selection-scroll)*20);
								selection=scroll+i;
							}
						}
					}

				}

			}


			if (scrolltime>0) scrolltime--;
			if (Mouse.Clicked(1)) {
				if ( mx>= 753 && my>=473 && mx <= 772 && my <= 493 && scrolltime==0 ) {
					scrolltime=15;
					scroll++;
					if (scroll>servers-16) scroll=servers-16;
					if (scroll<0) scroll=0;
					Bar.SetScrollY(scroll);
				}
				if ( mx>= 753 && my>=158 && mx <= 772 && my <= 177 && scrolltime==0 ) {
					scrolltime=15;
					scroll--;
					if (scroll>servers-16) scroll=servers-16;
					if (scroll<0) scroll=0;
					Bar.SetScrollY(scroll);
				}
				if (scroll>servers-16) scroll=servers-16;
				if (scroll<0) scroll=0;
			}





			if (nbutton[0]->Handle()) { // refresh
				servers=0;
				UpdateServerList(servlist_first, &servers);
				Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 13, 148, 751-13, 494-148, 13, 148); 
				timer=SDL_GetTicks();
				fprintf(stderr, "%d\n", servers);
				scroll=0;
				Bar.SetMaxY(servers);
			}

			if (nbutton[1]->Handle()) { // ping all
				Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);
				onwood.WriteString(Window.GetScreen(), "Pinging servers...", 3, 578, FONT_NORMAL);
				SDL_Flip(Window.GetScreen() );

				Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 707, 167, 42, 320, 707, 167);

				servlist *current = servlist_first;

				while (1) {
					current = current->next;
					if (!current) break;
					net::SendUDPpacket_unbound(sock, current->address, "PING");
					current->lastping = SDL_GetTicks();
				}


				UDPpacket *packet = SDLNet_AllocPacket(640);

				// wait 1 sec for answer
				Uint32 starttime=SDL_GetTicks();
				while (SDL_GetTicks() < starttime+1000) {
					if (SDLNet_UDP_Recv(sock, packet) ) {

						current = servlist_first;

						while (1) {
							current = current->next;
							if (!current) break;

							if (packet->address.host == current->address.host && packet->address.port == current->address.port) {
								current->ping = SDL_GetTicks()-current->lastping;
								break;
							}
						}
					}
				}
				Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);
				timer=SDL_GetTicks();
			}

			if (nbutton[2]->Handle()) { // back to main
				ready=true;
			}
			if (nbutton[3]->Handle()) { // join
				// Set nick
				strncpy (Clientconf->nick, Nick->Get(), 21);
				Clientconf->SaveConf();

				char *errmsg=NULL;

				// Set IP address
				IPaddress address;
				if (SDLNet_ResolveHost(&address, Host->Get(), variable::Str2Int(Port->Get(), 0) ) == 0) {

					// Tell the player what we are doing
					Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);

					onwood.WriteString(Window.GetScreen(), "Trying to connect...", 3, 578, FONT_NORMAL);
					SDL_Flip(Window.GetScreen() );

					// Try to join the game, if no luck, tell it.
					
					if (Client.connect( &address, &errmsg)) {
						Client.game();
						Graphics.DrawIMG(Window.GetScreen(), network_bg, 0, 0);
#ifndef NOSOUND
						while(!Mix_FadeOutMusic(300) && Mix_PlayingMusic()) {
							// wait for any fades to complete
							SDL_Delay(100);
						}
						Mix_FadeInMusic(menumusic, -1, 300);
						SDL_Delay(300);
#endif
					}

					
					if (errmsg) {
						if (strlen(errmsg)<200) {
							Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);

							char data[512];
							sprintf (data, "Couldn't connect: %s", errmsg);			

							onwood.WriteString(Window.GetScreen(), data, 3, 578, FONT_NORMAL);
							SDL_Flip(Window.GetScreen());

							texttimer=300;
						}
						delete[] errmsg;
					}
				} else {
					Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);

					char data[]="Couldn't resolve host!";
					onwood.WriteString(Window.GetScreen(), data, 3, 578, FONT_NORMAL);

					texttimer=300;
				}

				timer=SDL_GetTicks();
			}

		}

		
		if (nbutton[4]->Handle()) { // Follow
		
			// Set nick
			strncpy (Clientconf->nick, Nick->Get(), 21);
			Clientconf->SaveConf();
			
			char *errmsg=NULL;

			// Set IP address
			IPaddress address;
			if (SDLNet_ResolveHost(&address, Host->Get(), variable::Str2Int(Port->Get(), 0) ) == 0) {

				// Tell the player what we are doing
				Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);

				onwood.WriteString(Window.GetScreen(), "Trying to connect...", 3, 578, FONT_NORMAL);
				SDL_Flip(Window.GetScreen() );

				// Try to join the game, if no luck, tell it.
					
				if (Followclient.connect( &address, &errmsg)) {
					Followclient.game();
					Graphics.DrawIMG(Window.GetScreen(), network_bg, 0, 0);
#ifndef NOSOUND
					while(!Mix_FadeOutMusic(300) && Mix_PlayingMusic()) {
						// wait for any fades to complete
						SDL_Delay(100);
					}
					Mix_FadeInMusic(menumusic, -1, 300);
					SDL_Delay(300);
#endif
				}

					
				if (errmsg) {
					if (strlen(errmsg)<200) {
						Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);

						char data[512];
						sprintf (data, "Couldn't connect: %s", errmsg);			

						onwood.WriteString(Window.GetScreen(), data, 3, 578, FONT_NORMAL);
						SDL_Flip(Window.GetScreen());

						texttimer=300;
					}
					delete[] errmsg;
				}
			} else {
				Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);

				char data[]="Couldn't resolve host!";
				onwood.WriteString(Window.GetScreen(), data, 3, 578, FONT_NORMAL);

				texttimer=300;
			}

			timer=SDL_GetTicks();
		}
		
		for (int i=0; i<5; i++) {
			nbutton[i]->Draw();
		}

		Host->Clean();
		Nick->Clean();
		Port->Clean();
		Pass->Clean();

		if (textsel==0) Host->Draw(1);
		else Host->Draw(0);
		if (textsel==1) Nick->Draw(1);
		else Nick->Draw(0);
		if (textsel==2) Pass->Draw(1);
		else Pass->Draw(0);
		if (textsel==3) Port->Draw(1);
		else Port->Draw(0);

		servlist *current = servlist_first;

		int y=-scroll; // 153, 163
		
		if (oldscroll != scroll ) {
			Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 16, 167, 772-16, 494-167, 16, 167); 
			oldscroll=scroll;
		}
		
		while (1) {
			current = current->next;
			if (!current) break;

			if (y>=0 && y<16) {
				if (y+scroll==selection)
					Graphics.DrawPartOfIMG(Window.GetScreen(), nd_selection, 16, 167+y*20, 772-16, 20, 0, y*20);
				if (current->hoststring_short) chatfont.WriteString( Window.GetScreen(),
											current->hoststring_short, 290, 168+y*20, FONT_RIGHTENED );
				else chatfont.WriteString( Window.GetScreen(), current->hoststring, 290, 168+y*20, FONT_RIGHTENED );

				char port[6];
				sprintf (port, "%d", net::ConvPort(current->address.port) );
				chatfont.WriteString( Window.GetScreen(), port, 334, 168+y*20, FONT_RIGHTENED );

				if (current->dedicated) Graphics.DrawIMG( Window.GetScreen(), nicon[0], 337, 168+y*20);
				if (current->lightning) Graphics.DrawIMG( Window.GetScreen(), nicon[1], 353, 168+y*20);
				if (current->followers) Graphics.DrawIMG( Window.GetScreen(), nicon[2], 369, 168+y*20);
	
				char gametime[10];
				sprintf (gametime, "%dmin", current->gametime );
				chatfont.WriteString( Window.GetScreen(), gametime, 427, 168+y*20, FONT_RIGHTENED );
	
				char players[3];
				sprintf (players, "%d", current->players );
				chatfont.WriteString( Window.GetScreen(), players, 473, 168+y*20, FONT_RIGHTENED );
	
				chatfont.WriteString( Window.GetScreen(), current->version, 521, 168+y*20, FONT_RIGHTENED );
	
				chatfont.WriteString( Window.GetScreen(), current->metainfo, 615, 168+y*20, FONT_XCENTERED );
	
				if (current->ping > 0) {
					char pingtime[9];
					sprintf (pingtime, "%d", current->ping );
					chatfont.WriteString( Window.GetScreen(), pingtime, 747, 168+y*20, FONT_RIGHTENED );
				}
			}
			y++;
		}
//		cout << "y: "<<y<<"\n";

		Bar.Draw();

		SDL_Flip(Window.GetScreen());



	}

	// delete list
	servlist *d = servlist_first;
	while (1) {
		if (!d) break;
		servlist *next = d->next;
		delete d;
		d=next;
	}


}

void menu::UpdateServerList(servlist *servlist_first, int *servers) {

	// delete old list
	servlist *d = servlist_first->next;
	while (1) {
		if (!d) break;
		servlist *next = d->next;
		delete d;
		d=next;
	}

	UDPpacket *packet = SDLNet_AllocPacket(64000);

	// send packet to metaserver
	IPaddress metaaddress;
	
		
	char data_[]="Resolving metaserver...";
	onwood.WriteString(Window.GetScreen(), data_, 3, 578, FONT_NORMAL);
	SDL_Flip(Window.GetScreen() );


	if ( !SDLNet_ResolveHost(&metaaddress, "shoebox.ath.cx", 8855) ) {
		net::SendUDPpacket_unbound(sock, metaaddress, "GIVELIST");
	} else {
		Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);
		char data2[]="Couldn't resolve. Are you online?";
		onwood.WriteString(Window.GetScreen(), data2, 3, 578, FONT_NORMAL);
		SDL_Flip(Window.GetScreen() );
		texttimer=300;
		return;
	}
	Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);
	SDL_Flip(Window.GetScreen() );

	
	fprintf (stderr, "Asking for server list.\n");

	// inform player
	Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);
	char data[]="Contacting metaserver...";
	onwood.WriteString(Window.GetScreen(), data, 3, 578, FONT_NORMAL);
	SDL_Flip(Window.GetScreen() );

	// wait 1,5 secs for answer

	
	Uint32 starttime=SDL_GetTicks();
	while (SDL_GetTicks() < starttime+1500) {

		if (SDLNet_UDP_Recv(sock, packet) ) {
			if (packet->address.host == metaaddress.host && packet->address.port == metaaddress.port) {

				servlist *current = servlist_first;
	
				if (variable::str_splitcompare( (char*)packet->data, 0, "LIST") ) {
					int i=1;
					while (1) {
						char *pack = variable::str_split( (char*)packet->data, 0x02, i);
						if (!pack) break;
						(*servers)++;
	
						current = current->next = new servlist(current);
								
						current->address.host = SWAP32(variable::str_splitgetint( pack, ' ', 0 ) );
						current->address.port = SWAP16(variable::str_splitgetint( pack, ' ', 1 ) );
				
						current->dedicated = variable::str_splitgetint( pack, ' ', 2 );
						current->lightning = variable::str_splitgetint( pack, ' ', 3 );
						current->gametime = variable::str_splitgetint( pack, ' ', 4 );
						current->players = variable::str_splitgetint( pack, ' ', 5 );
						current->followers = variable::str_splitgetint( pack, ' ', 6 );
				
						current->version = variable::str_split( (char*)pack, 0x01, 1 );
						current->metainfo = variable::str_split( (char*)pack, 0x01, 2 );
	

						const char *data = SDLNet_ResolveIP(&current->address);
						if (data) {
							int width=0;
							int lastfit=-1;
							bool set=false;

							int chwidth=chatfont.GetStringWidth((char*)data);
							if (chwidth>270) {
								// find out the last character to fit in 260 and add "..."
								int i = strlen(data)-1;
								
								while (chwidth>260 && i>0) {
									chwidth-=chatfont.GetWidth(data[i]);
									i--;
								}
									
								// so now i is the last printable character
								
								current->hoststring_short = new char[ strlen(data)-i+1+1+3 ];
								sprintf (current->hoststring_short, "...%s", &(data[i]) );
							}
							
							current->hoststring = new char[ strlen(data)+1+3 ];
							strcpy (current->hoststring, data);

						} else {
							current->hoststring = new char[15];
							Uint8 ip[4];
							net::GetIP(current->address.host, &ip[0], &ip[1], &ip[2], &ip[3]);
							sprintf (current->hoststring, "%d.%d.%d.%d", ip[0], ip[1], ip[2], ip[3]);
						}

						delete[] pack;
						i++;
					}
				}

			}
		}
	}
	Graphics.DrawPartOfIMG(Window.GetScreen(), network_bg, 0, 578, 800, 22, 0, 578);
}


void menu::SetKeyboard() {
   Mouse.ResetReleased();

	Graphics.DrawIMG(Window.GetScreen(), setkeys_bg, 0, 0);

   Uint16 *usedkeys[8]={
      &Clientconf->left,
      &Clientconf->right,
      &Clientconf->shoot,
      &Clientconf->wleft,
      &Clientconf->wright,
      &Clientconf->rotate,
      &Clientconf->newgame,
      &Clientconf->chatkey
   };



	Uint32 timer=SDL_GetTicks();

	bool ready=false;

	int mx, my;

	while (!ready) {
#ifdef ENABLEDELAYS
		SDL_Delay(3);
#endif

		while (SDL_GetTicks()>=timer) {
			timer+=10;

			Keyboard.HandleInterrupts();

			Mouse.GetCursorCoords(&mx, &my);

			for (int i=0; i<8; i++) {
				if (sbutton[i]->Handle()) {
					sbutton[i]->Draw();
					SDL_Flip( Window.GetScreen() );
					SetKey(usedkeys[i]);
				}
			}
			if (sbutton[8]->Handle()) { // back to options
				ready=true;
			}

		}

		for (int i=0; i<9; i++) {
			sbutton[i]->Draw();
		}

		for (int i=0; i<6; i++) {
			Graphics.DrawPartOfIMG( Window.GetScreen(), setkeys_bg, 257, 128+i*60, 400-257, 176-128, 257, 128+i*60 );
			chatfont.WriteString( Window.GetScreen(), SDL_GetKeyName( (SDLKey)*usedkeys[i] ), 332, 152+i*60, FONT_CENTERED);
		}

		for (int i=0; i<2; i++) {
			Graphics.DrawPartOfIMG( Window.GetScreen(), setkeys_bg, 571, 128+i*60, 713-571, 176-128, 571, 128+i*60);
			chatfont.WriteString( Window.GetScreen(), SDL_GetKeyName( (SDLKey)*usedkeys[6+i] ), 644, 152+i*60, FONT_CENTERED);
		}

		SDL_Flip( Window.GetScreen() );

	}

}


void menu::SetKey(Uint16 *ptr)
{
	while (1)
   {
      Keyboard.HandleInterrupts();
      for (Uint16 j=0;j<SDLK_LAST; j++)
      {
			char p = Keyboard.Pressed(j);
			if (p) {
				if (j==SDLK_ESCAPE) return;
				*ptr=j;
			   update = SDL_GetTicks();
				return;
			}
		}
#ifdef ENABLEDELAYS
	SDL_Delay(3);
#endif
	}

}

void menu::Options() {
   Mouse.ResetReleased();

	Graphics.DrawIMG(Window.GetScreen(), options_bg, 0, 0);

	Uint32 timer=SDL_GetTicks();

	bool ready=false;

	int mx, my;

	static int musicold=0;
	static int soundold=0;

	int barsel=-1;

	while (!ready) {
#ifdef ENABLEDELAYS
		SDL_Delay(3);
#endif

		while (SDL_GetTicks()>=timer) {
			timer+=10;

			Keyboard.HandleInterrupts();

			Mouse.GetCursorCoords(&mx, &my);

			char mr=Mouse.Released(1);
			if (mr==2 && mx>=234 && my>=242 && mx<=238+262 && my<=242+29) {
				barsel=0;
			}
			if (mr==2 && mx>=234 && my>=302 && mx<=238+262 && my<=302+29) {
				barsel=1;
			}



			if (!Mouse.Clicked(1) ) barsel=-1;

			if (barsel>=0) {
				int pow =(int)( (mx-242)/2 );
				if (pow<0) pow=0;
				if (pow>127) pow=127;

				if (barsel==0) {
					Clientconf->musicvolume=pow;
#ifndef NOSOUND
					sound::MusicVolume(pow);
#endif
				}
				if (barsel==1) {
					Clientconf->soundvolume=pow;
#ifndef NOSOUND
					sound::SoundVolume(pow);
					Mix_HaltChannel(0);
					sound::PlayChunk(0, klik, 0);
#endif
				}
			}

			if (obutton[0]->Handle()) { // set keys
				SetKeyboard();
				Graphics.DrawIMG(Window.GetScreen(), options_bg, 0, 0);
				timer=SDL_GetTicks();
			}
			if (obutton[1]->Handle()) { // music volume
				if (Clientconf->musicvolume!=0) {
					musicold = Clientconf->musicvolume;
					Clientconf->musicvolume=0;
				} else {
					Clientconf->musicvolume=musicold;
				}
/*				int tmp=musicold;
				musicold=Clientconf->musicvolume;
				Clientconf->musicvolume=tmp;*/
#ifndef NOSOUND
				sound::MusicVolume(Clientconf->musicvolume);
#endif
			}
			if (obutton[2]->Handle()) { // sound volume
				if (Clientconf->soundvolume!=0) {
					soundold = Clientconf->soundvolume;
					Clientconf->soundvolume=0;
				} else {
					Clientconf->soundvolume=soundold;
				}
#ifndef NOSOUND
				sound::SoundVolume(Clientconf->soundvolume);
#endif
			}
			if (obutton[3]->Handle()) { // back
				ready=true;
			}

		}

		for (int i=0; i<4; i++) {
			obutton[i]->Draw();
		}

		Graphics.DrawPartOfIMG( Window.GetScreen(), options_bg, 234, 242, 266, 29, 234, 242 );
		Graphics.DrawPartOfIMG( Window.GetScreen(), options_bg, 234, 302, 266, 29, 234, 302 );
		Graphics.DrawIMG( Window.GetScreen(), barblock, 234 + Clientconf->musicvolume*2, 242);
		Graphics.DrawIMG( Window.GetScreen(), barblock, 234 + Clientconf->soundvolume*2, 302);

		SDL_Flip(Window.GetScreen());
	}


}

