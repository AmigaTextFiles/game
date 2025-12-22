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

#include "net.h"
#include "variable.h"
#include "graphics.h"
#include "window.h"
#include "keyboard.h"
#include "mouse.h"
#include "block.h"

extern graphics Graphics;
extern window Window;
extern keyboard Keyboard;
extern mouse Mouse;
extern block Block;

extern UDPsocket sock;
extern media Media;


client::client() {

}

bool client::SetNick(char *nick) {
	if (strlen(nick)<=20) {
		return Player.SetNick(nick);
	} else return 0;
}

bool client::connect(IPaddress *address, char *errmsg[]) {

	// Open a socket for us and bind the server to it.
	static bool oldbind=false;
	if (oldbind)  SDLNet_UDP_Unbind(sock, 0);

	SDLNet_UDP_Bind(sock, 0, address);

	oldbind=true;

	servaddress.host = address->host;
	servaddress.port = address->port;


	fprintf (stderr, "Bound address!\n");

	// Tell the server we want to connect
	char data[1024];
	sprintf (data, "CONNECT %s", Config->nick);
	net::SendUDPpacket(sock, 0, data);


	fprintf (stderr, "Trying to connect...\n");


	// Wait for 5 seconds if we get an answer back.

	Uint32 time = SDL_GetTicks();
	int connected=0; // 0=waiting, 1=yep, 2=no
	UDPpacket *packet = SDLNet_AllocPacket(1024);

	while (!connected) {
		if (SDL_GetTicks() - time >= 5000) {
			connected=2;
		}

		if (SDLNet_UDP_Recv(sock, packet) ) {
			if (packet->address.host == servaddress.host && packet->address.port == servaddress.port) {
				// right sender

				if (variable::str_splitcompare( (char*)packet->data, 0, "CONNECTIONACCEPTED") ) {
					// Yahoo! We're in!
					fprintf (stderr, "Got in!\n");
					SDLNet_FreePacket(packet);
					return true;
				}
				if (variable::str_splitcompare( (char*)packet->data, 0, "CONNECTIONDENIED") ) {
					// Too bad. Let's tell the user what went wrong.
					*errmsg = variable::str_fullsplit( (char*)packet->data, ' ', 1);
					SDLNet_FreePacket(packet);
					SDLNet_UDP_Unbind(sock, 0);
					return false;
				}
			}
		}
	}

	// set the error message to errmsg, "no answer from server"
	char err[]="No answer from server.";
	*errmsg = new char[ strlen(err)+1 ];
	strcpy (*errmsg, err);

	cout << "Err: "<<*errmsg<<"\n";

	SDLNet_FreePacket(packet);
	SDLNet_UDP_Unbind(sock, 0);
	return false;
}

void client::LoadStuff() {
	font116.Initialize(FONT_116);
	chatfont.Initialize(CHATFONT);
	onwood.Initialize(ONWOOD);
}

void client::Reset() {
	memset(blocks, 0, XSIZE*YSIZE);
	memset(Enemy.slot, 0, 5);
	memset(Player.slot, 0, 5);
	shootwait=0;
	winner=0;
	updateblockmap=false;
	alone=true;

	drawupdatechat=true;
	drawupdatepings=true;
	drawupdateslots=true;
	drawupdatescores=true;

	drawupdateblockmap=true;
	drawupdatenicks=true;
	drawupdateclock=true;

	alonetime=SDL_GetTicks();
}

void client::game() {
	Reset();
#ifndef NOSOUND

	while(!Mix_FadeOutMusic(300) && Mix_PlayingMusic()) {
    // wait for any fades to complete
		SDL_Delay(100);
	}
	Mix_FadeInMusic(Media.gamemusic, -1, 300);

#endif


	chatfirst = new chat;

	chat *current = chatfirst;
	for (int i=0; i<5; i++) {
		current->next = new chat;
		current = current->next;
	}

	chatlast = current;


/*

chatfirst
  [   ] ->
           [   ] ->
                    [   ] ->
                             [   ] ->
                                      [   ] ->
                                               [   ]
                                             chatlast

	Drop chatfirst and add a new one after chatlast.
	Chatfirst and chatlast both advance one step and old chatfirst will be deleted.

*/

	SetNick(Config->nick);

	Keyboard.ResetReleased();

	for (int i=0; i<5; i++) {
		Player.blocks[i] = new tetrablock((char*)blocks);
		Enemy.blocks[i] = new tetrablock((char*)blocks);
	}

	UDPpacket *packet = SDLNet_AllocPacket(1024);

	Uint32 nextupdate = SDL_GetTicks();
	Uint32 physframetime = 10; // ~(1000/100) phys frames per second

	bool ready=false;

	lastping=SDL_GetTicks();

	chatline=false;
	Chatline = new stringblock (&chatfont, Block.GetBackground(), 353, 533, FONT_NORMAL, 796-353-chatfont.GetStringWidth(Player.GetNick())-chatfont.GetStringWidth("<>"), 99);


	gametime=0;
	timestep=0;

	while (!ready) {
#ifndef DISABLEDELAYS
		SDL_Delay(3);
#endif

		while (SDL_GetTicks() >= nextupdate) {
			nextupdate+=physframetime;
			// physics

			if (alone) {
				// waiting for other player

				if (Keyboard.Pressed(SDLK_ESCAPE)) {
					ready=true;
				}
	
				if (SDL_GetTicks()-lastping > 4000) {
					fprintf (stderr, "Server hasn't pinged us for 4 seconds - disconnecting\n");
					ready=true;
				}

			} else {
				// game

				if (winner==0) {
					if ( gametime-timestep >= 0 ) gametime-=timestep;
					else gametime=0;
				}

				if (Keyboard.Pressed(SDLK_ESCAPE)) {
					if (chatline) chatline=false;
					else ready=true;
				}

				if (SDL_GetTicks()-lastping > 4000) {
					fprintf (stderr, "Server hasn't pinged us for 4 seconds - disconnecting\n");
					ready=true;
				}

				if (Player.movedelay > 0) Player.movedelay--;

				if (!chatline && Keyboard.Pressed( Config->chatkey ) ) {
					Keyboard.ResetEvents();
					Chatline->Set("\0");
					chatline=true;
				}
				if (chatline && Keyboard.Pressed(SDLK_RETURN) ) {
					if (strlen( Chatline->Get() )>0) {
						char data[512];
						sprintf (data, "CHAT %s", Chatline->Get());
						net::SendUDPpacket(sock, 0, data);
					}
					chatline=false;
				}

				if (!chatline) {
					if (!winner) {
						if (Keyboard.Hold(Config->left) && Player.movedelay==0) {
#ifndef NOSOUND
							sound::PlayChunk(-1, Media.browseclick, 0);
#endif
							char data[]="LEFT";
							Player.movedelay+=15;
							net::SendUDPpacket(sock, 0, data);
						}
						if (Keyboard.Hold(Config->right) && Player.movedelay==0) {
#ifndef NOSOUND
							sound::PlayChunk(-1, Media.browseclick, 0);
#endif
							char data[]="RIGHT";
							Player.movedelay+=15;
							net::SendUDPpacket(sock, 0, data);
						}
						if (Keyboard.Pressed(Config->rotate)) {
#ifndef NOSOUND
							sound::PlayChunk(-1, Media.rotate, 0);
#endif
							char data[]="ROTATE";
							net::SendUDPpacket(sock, 0, data);
						}
						if (Keyboard.Hold(Config->shoot) ) {
							shootwait--;
							if (shootwait <=0) {
								char data[]="SHOOT";
								Player.loading=true;
								net::SendUDPpacket(sock, 0, data);
								shootwait+=15;
							}
						} else {
							shootwait=0;
						}
		
						if (Keyboard.Pressed(Config->wleft) ) {
#ifndef NOSOUND
							sound::PlayChunk(-1, Media.select, 0);
#endif
							char data[]="SELECTIONLEFT";
							net::SendUDPpacket(sock, 0, data);
						}
						if (Keyboard.Pressed(Config->wright) ) {
#ifndef NOSOUND
							if (!winner) sound::PlayChunk(-1, Media.select, 0);
#endif
							char data[]="SELECTIONRIGHT";
							net::SendUDPpacket(sock, 0, data);
						}
					}
				} else {
					Chatline->Listen();
				}


				// check for new game and disconnect buttons
				bool m0r = Mouse.Released(0);
				int mx=0, my=0;
				Mouse.GetCursorCoords(&mx, &my);
	
				if ( ((m0r==1) && (mx>=518 && my >= 561 && mx <= 652 && my <= 599)) ||
					(!chatline && Keyboard.Pressed(Config->newgame) )  ){
					char data[]="NEWGAME";
					net::SendUDPpacket(sock, 0, data);
				}
	
				if ( (m0r==1) && (mx>=653 && my >= 561 && mx <= 799 && my <= 599) ) {
					ready=true;
				}
			}


			// handle incoming packages from the server


			if (SDLNet_UDP_Recv(sock, packet) ) {
				if (packet->address.host == servaddress.host && packet->address.port == servaddress.port) {
					// server sends

					if (variable::str_splitcompare( (char*)packet->data, 0, "YOURBLOCKDELETED") ) {
						int num = variable::str_splitgetint( (char*)packet->data, ' ', 1);
						int num2 = variable::str_splitgetint( (char*)packet->data, ' ', 2);
						Player.blocks[num]->SetUsed(0);

						drawupdateblockmap=true;
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "ENEMYBLOCKDELETED") ) {
						int num = variable::str_splitgetint( (char*)packet->data, ' ', 1);
						int num2 = variable::str_splitgetint( (char*)packet->data, ' ', 2);
						Enemy.blocks[num]->SetUsed(0);
						
						drawupdateblockmap=true;
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "BLOCKMAP") ) {
						// updating our blockmap //
						char *data = variable::str_fullsplit( (char*)packet->data, ' ', 1);
						int i=0;
						for (int y=0; y<YSIZE; y++) {
							for (int x=0; x<XSIZE; x++) {
								blocks[y][x]=data[i]-'0';
								i++;
							}
						}
						delete[] data;

						drawupdateblockmap=true;
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "YOURSLOTS") ) {
						for (int i=0; i<5; i++) {					
							Player.slot[i] = variable::str_splitgetint( (char*)packet->data, ' ', i+1);
						}
						// tells us our currently controlled block
						Player.SetSelection( variable::str_splitgetint( (char*)packet->data, ' ', 6) );
						int pslot = variable::str_splitgetint( (char*)packet->data, ' ', 7);
						if (Player.GetSelection() >=0) Player.slot[Player.GetSelection()]=pslot;
						drawupdateslots=true;
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "ENEMYSLOTS") ) {
						for (int i=0; i<5; i++) {					
							Enemy.slot[i] = variable::str_splitgetint( (char*)packet->data, ' ', i+1);
						}
						// tells us our currently controlled block
						Enemy.SetSelection( variable::str_splitgetint( (char*)packet->data, ' ', 6) );
						int eslot = variable::str_splitgetint( (char*)packet->data, ' ', 7);
						if (Enemy.GetSelection() >=0) Enemy.slot[Enemy.GetSelection()]=eslot;
						drawupdateslots=true;
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "PING") ) {
						int k = variable::str_splitgetint((char*)packet->data, ' ', 1);
						char data[100];
						sprintf (data, "PONG %d", k);
						
						lastping = SDL_GetTicks();
						
						net::SendUDPpacket(sock, 0, data);
						
						drawupdatepings=true;
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "YOURBLOCK") ) {
						int num = variable::str_splitgetint( (char*)packet->data, ' ', 1);
						int x = variable::str_splitgetint( (char*)packet->data, ' ', 2);
						int y = variable::str_splitgetint( (char*)packet->data, ' ', 3);
						int type = variable::str_splitgetint( (char*)packet->data, ' ', 4);
						int angle = variable::str_splitgetint( (char*)packet->data, ' ', 5);

						Player.blocks[num]->SetX(x);
						Player.blocks[num]->SetY(y);
						Player.blocks[num]->SetType(type);
						Player.blocks[num]->SetAngle(angle);
						Player.blocks[num]->SetUsed(true);
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "ENEMYBLOCK") ) {
						int num = variable::str_splitgetint( (char*)packet->data, ' ', 1);
						int x = variable::str_splitgetint( (char*)packet->data, ' ', 2);
						int y = variable::str_splitgetint( (char*)packet->data, ' ', 3);
						int type = variable::str_splitgetint( (char*)packet->data, ' ', 4);
						int angle = variable::str_splitgetint( (char*)packet->data, ' ', 5);

						Enemy.blocks[num]->SetX(x);
						Enemy.blocks[num]->SetY(y);
						Enemy.blocks[num]->SetType(type);
						Enemy.blocks[num]->SetAngle(angle);
						Enemy.blocks[num]->SetUsed(true);
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "YOUNOSHOOT") ) {
						Player.canshoot=false;
					}
					if (variable::str_splitcompare( (char*)packet->data, 0, "ENEMYNOSHOOT") ) {
						Enemy.canshoot=false;
					}
					if (variable::str_splitcompare( (char*)packet->data, 0, "YOUCANSHOOT") ) {
						Player.canshoot=true;
					}
					if (variable::str_splitcompare( (char*)packet->data, 0, "ENEMYCANSHOOT") ) {
						Enemy.canshoot=true;
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "YOUNEWGAME") ) {
						Player.newgame=true;
					}
					if (variable::str_splitcompare( (char*)packet->data, 0, "ENEMYNEWGAME") ) {
						Enemy.newgame=true;
					}
					if (variable::str_splitcompare( (char*)packet->data, 0, "YOUNONEWGAME") ) {
						Player.newgame=false;
					}
					if (variable::str_splitcompare( (char*)packet->data, 0, "ENEMYNONEWGAME") ) {
						Enemy.newgame=false;
					}



					if ( variable::str_splitcompare( (char*)packet->data, 0, "CHAT") ) {
						char *msg = variable::str_fullsplit( (char*)packet->data, ' ', 1);
						if (strlen(msg)>0 && strlen(msg)<512) {

							chatlast = chatlast->next = new chat;

							chat *oldfirst = chatfirst;
							chatfirst = chatfirst->next;
							delete oldfirst;

							chatlast->SetLine(msg);
							
							fprintf (stderr, "CHAT: %s\n", msg);

							drawupdatechat=true;
						}
						if (msg) {
							delete[] msg;
						}

					}

					if ( variable::str_splitcompare( (char*)packet->data, 0, "YOURSCORE") ) {
						Player.score = variable::str_splitgetint( (char*)packet->data, ' ', 1);
						drawupdatescores=true;
					}
					if ( variable::str_splitcompare( (char*)packet->data, 0, "ENEMYSCORE") ) {
						Enemy.score = variable::str_splitgetint( (char*)packet->data, ' ', 1);
						drawupdatescores=true;
					}
					if ( variable::str_splitcompare( (char*)packet->data, 0, "YOURLINES") ) {
						int oldlines = Player.lines;
						Player.lines = variable::str_splitgetint( (char*)packet->data, ' ', 1);
#ifndef NOSOUND
						if (Player.lines>oldlines && !alone) sound::PlayChunk(-1, Media.fossil, 0);
#endif
						drawupdatescores=true;
					}
					if ( variable::str_splitcompare( (char*)packet->data, 0, "ENEMYLINES") ) {
						int oldlines = Enemy.lines;
						Enemy.lines = variable::str_splitgetint( (char*)packet->data, ' ', 1);
#ifndef NOSOUND
						if (Enemy.lines>oldlines && !alone) sound::PlayChunk(-1, Media.fossil, 0);
#endif

						drawupdatescores=true;
					}
					if ( variable::str_splitcompare( (char*)packet->data, 0, "PINGTIME") ) {
						Player.ping = variable::str_splitgetint( (char*)packet->data, ' ', 1);
						Enemy.ping = variable::str_splitgetint( (char*)packet->data, ' ', 2);
					}
					if ( variable::str_splitcompare( (char*)packet->data, 0, "TIMELEFT") ) {
						gametime = variable::str_splitgetint( (char*)packet->data, ' ', 1);
						if (Player.ping!=9999) gametime-= (int)(Player.ping/20); // approx. lag correction :)

						timestep = variable::str_splitgetint( (char*)packet->data, ' ', 2);
						
						drawupdateclock=true;
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "NEWGAME") ) {
						winner=-1;
					}
					if (variable::str_splitcompare( (char*)packet->data, 0, "YOUWON") ) {
#ifndef NOSOUND
						if (winner!=1 && !alone) sound::PlayChunk(-1, Media.win, 0);
#endif
						winner=1;
					}
					if (variable::str_splitcompare( (char*)packet->data, 0, "YOULOST") ) {
#ifndef NOSOUND
						if (winner!=2 && !alone) sound::PlayChunk(-1, Media.lose, 0);
 #endif
						winner=2;
					}
					if (variable::str_splitcompare( (char*)packet->data, 0, "YOUAREALONE") ) {
						alone=true;
						alonetime=SDL_GetTicks();
					}


					if (variable::str_splitcompare( (char*)packet->data, 0, "YOUARETWO") ) {
						if (alone) {

							// graphics things

							Block.SetBackground();
							drawupdateslots=true;
							drawupdatescores=true;
							drawupdateblockmap=true;
							drawupdatechat=true;
							drawupdatepings=true;
							alone=false;
#ifndef NOSOUND
							if (alonetime>0 && SDL_GetTicks()-alonetime > 3000) {
								sound::PlayChunk(-1, Media.notalone, 0);
								alonetime=0;
							}
#endif

						}

					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "ENEMYNICK") ) {
						char *enemynick = variable::str_split( (char*)packet->data, ' ', 1);
						if (enemynick) {
							Enemy.SetNick(enemynick);
							fprintf (stderr, "Set enemy nick to '%s'\n", enemynick);
							delete[] enemynick;
						}
						
						drawupdatenicks=true;
						
						
						
					}

					if (variable::str_splitcompare( (char*)packet->data, 0, "EVENT") ) {
						int soundno = variable::str_splitgetint( (char*)packet->data, ' ', 1);
						switch (soundno) {
							case 0: /* Player shoot */
#ifndef NOSOUND
								if (!alone) sound::PlayChunk(-1, Media.launch, 0);
#endif
								drawupdateslots=true;
							break;
							case 1: /* Enemy shoot */
#ifndef NOSOUND
								if (!alone) sound::PlayChunk(-1, Media.launch, 0);
#endif
								drawupdateslots=true;
							break;
							default:
								fprintf (stderr, "Can't play sound for event %d: no such event\n", soundno);
							break;
						}

					}




				}

			}



			if (!chatline) Keyboard.HandleInterrupts();
		}

		DrawRound();

	}

	SDLNet_FreePacket(packet);

	delete Chatline;

}


void client::DrawRound() {
	// drawing

	if (alone) {
		Block.DrawWaiting();
		SDL_Flip(Window.GetScreen());
		SDL_Delay(50);
	} else {
		if (winner==-1) {
			fprintf (stderr, "winner==-1!\n");
			Block.SetBackground();
			drawupdatechat=true;
			drawupdatepings=true;
			drawupdateslots=true;
			drawupdatescores=true;
			drawupdateblockmap=true;

			winner=0;
		}
		
	
		if (drawupdateblockmap) {	
			for (int y=0; y<YSIZE; y++) {
				for (int x=0; x<XSIZE; x++) {
					Block.Draw(46+19*x, 17+19*(y), blocks[y][x]);
				}
			}
			if (winner>=3) drawupdateblocks=true;
			drawupdateblockmap=false;
		}
	
		if (drawupdateslots) {
			// clean

			Block.Clean(350, 113, 799, 205); // p1 blocks

			Block.Clean(350, 291, 799, 382); // p2 blocks

			if (Enemy.controlling>=0) Block.DrawSelected(350+Enemy.GetSelection()*90, 113, 0);
			if (Player.controlling>=0) Block.DrawSelected(350+Player.GetSelection()*90, 292, 0);

			// draw
			for (int i=0; i<5; i++) {
				Block.DrawBlockGroup(357+90*i, 121, Enemy.slot[i], 1);
			} 
			for (int i=0; i<5; i++) {
				Block.DrawBlockGroup(357+90*i, 299, Player.slot[i], 1);
			}
	
			if (Enemy.GetSelection()>=0) Block.DrawSelected(350+Enemy.GetSelection()*90, 113, Enemy.canshoot+1);
			if (Player.GetSelection()>=0) Block.DrawSelected(350+Player.GetSelection()*90, 291, Player.canshoot+1);

			drawupdateslots=false;
		}
		
		Block.DrawYesno(448, 566, Enemy.newgame);
		Block.DrawYesno(481, 566, Player.newgame);


		char str[125];
	
		sprintf (str, "%s", Enemy.GetNick());
		onwood.WriteString(Window.GetScreen(), str, 574, 93, FONT_CENTERED);

		sprintf (str, "%s", Player.GetNick());
		onwood.WriteString(Window.GetScreen(), str, 574, 271, FONT_CENTERED);
	
	
		if (drawupdatescores) {
			Block.Clean(350, 203, 559, 239); // score 1
			Block.Clean(567, 203, 696, 239); // lines 1

			Block.Clean(350, 381, 559, 421); // score 2
			Block.Clean(567, 381, 696, 421); // lines 2

			sprintf (str, "%d", Enemy.score);
			onwood.WriteString(Window.GetScreen(), str, 558, 221, FONT_YCENTERED|FONT_RIGHTENED);

			sprintf (str, "%d", Player.score);
			onwood.WriteString(Window.GetScreen(), str, 558, 400, FONT_YCENTERED|FONT_RIGHTENED);

			drawupdatescores=true;
		}

		sprintf (str, "%d", Enemy.lines);
		onwood.WriteString(Window.GetScreen(), str, 693, 221, FONT_YCENTERED|FONT_RIGHTENED);

		sprintf (str, "%d", Player.lines);
		onwood.WriteString(Window.GetScreen(), str, 693, 400, FONT_YCENTERED|FONT_RIGHTENED);
	
	
		if (drawupdatepings) {
			Block.Clean(703, 206, 796, 239); // enemy ping
			Block.Clean(703, 384, 796, 417); // player ping
	
			sprintf (str, "%d ms", Enemy.ping);
			onwood.WriteString(Window.GetScreen(), str, 796, 221, FONT_YCENTERED|FONT_RIGHTENED);
	
			sprintf (str, "%d ms", Player.ping);
			onwood.WriteString(Window.GetScreen(), str, 796, 400, FONT_YCENTERED|FONT_RIGHTENED);
			drawupdatepings=false;
		
		}

		if (chatline) {
			Chatline->Clean();
			Chatline->Draw(1);
		} else {
			Chatline->Clean();
		}
	
		if (drawupdatechat) {
			Block.Clean(353, 434, 797, 527);

			chat *current=chatfirst;
			for (int i=0; i<6; i++) {
				sprintf (str, "%s", current->GetLine() );
				current=current->next;
	
				chatfont.WriteString(Window.GetScreen(), str, 353, 434+i*15, FONT_NORMAL);
			}

			drawupdatechat=false;
		}
		
		if (winner!=3&&winner!=4) {
			if (drawupdateclock) {
				sprintf (str, "%.2d:", (int)(gametime/6000) );
				font116.WriteString(Window.GetScreen(), str, 532, 34, FONT_YCENTERED|FONT_RIGHTENED);
				sprintf (str, "%.2d", (int)(gametime/100)%60);
				font116.WriteString(Window.GetScreen(), str, 532, 34, FONT_YCENTERED);
			}
		}


		
		if (drawupdateblocks || (winner!=3&&winner!=4) ) {
			// draw falling blocks
			for (int i=0; i<5; i++) {
				if (Player.blocks[i]->IsUsed())
					Block.DrawBlockGroup(46+19* Player.blocks[i]->GetX(), 17+19* Player.blocks[i]->GetY(), Player.blocks[i]->GetType(), Player.blocks[i]->GetAngle() );
				if (Enemy.blocks[i]->IsUsed())
					Block.DrawBlockGroup(46+19* Enemy.blocks[i]->GetX(), 17+19* Enemy.blocks[i]->GetY(), Enemy.blocks[i]->GetType(), Enemy.blocks[i]->GetAngle() );
			}
			if (winner==3||winner==4) {
				Block.DrawWinner(winner-2);
			}
			drawupdateblocks=false;
		}
		
		// draw win/lose screen
		
		if (winner==1||winner==2) {
			Block.DrawWinner(winner);
			winner+=2;
		}

		
		// flipping
		SDL_Flip(Window.GetScreen());

		// cleaning falling blocks
		if (winner!=3&&winner!=4) {
			for (int i=0; i<5; i++) {
				if (Player.blocks[i]->IsUsed()) {
					int type, angle;
					int x, y;
						
					type = Player.blocks[i]->GetType();
					angle = Player.blocks[i]->GetAngle();
					x = Player.blocks[i]->GetX();
					y = Player.blocks[i]->GetY();
				
					for (int dy = y + Block.GetMinY(type, angle); dy <= y + Block.GetMaxY(type, angle); dy++ ) {
						for (int dx = x + Block.GetMinX(type, angle); dx <= x + Block.GetMaxX(type, angle); dx++ ) {
	//						Block.Draw(46+19*dx, 17+19*(dy), blocks[y+dy][x+dx]);
							if (Block.IsNonzero(type-1, angle, dx-x, dy-y)) Block.Draw(46+19*dx, 17+19*dy, blocks[dy][dx]);
						}
					}
				}
				
				if (Enemy.blocks[i]->IsUsed()) {
					int type, angle;
					int x, y;
						
					type = Enemy.blocks[i]->GetType();
					angle = Enemy.blocks[i]->GetAngle();
					x = Enemy.blocks[i]->GetX();
					y = Enemy.blocks[i]->GetY();
						
	//				fprintf (stderr, "x:%d y:%d\n", Block.GetMinY(type, angle), Block.GetMaxY(type, angle) );
		
					for (int dy = y + Block.GetMinY(type, angle); dy <= y + Block.GetMaxY(type, angle); dy++ ) {
						for (int dx = x + Block.GetMinX(type, angle); dx <= x + Block.GetMaxX(type, angle); dx++ ) {
							if (Block.IsNonzero(type-1, angle, dx-x, dy-y)) Block.Draw(46+19*dx, 17+19*dy, blocks[dy][dx]);
						}
					}
	
				}
	/*
			if (Player.blocks[i]->IsUsed())
				Block.DrawBlockGroup(46+19* Player.blocks[i]->GetX(), 17+19* Player.blocks[i]->GetY(), -Player.blocks[i]->GetType(), Player.blocks[i]->GetAngle() );
			if (Enemy.blocks[i]->IsUsed())
				Block.DrawBlockGroup(46+19* Enemy.blocks[i]->GetX(), 17+19* Enemy.blocks[i]->GetY(), -Enemy.blocks[i]->GetType(), Enemy.blocks[i]->GetAngle() );
			*/
			}
		}
		
		if (drawupdatenicks) {
			Block.Clean(350, 74, 799, 112); // nick 1
			Block.Clean(350, 252, 799, 289); // nick 2
			drawupdatenicks=false;
		}

		if (winner!=3&&winner!=4) {
			if (drawupdateclock) {
				Block.Clean(323, 0, 692, 73); // clock
			}
		}
	}
}

