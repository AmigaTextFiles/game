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


#include "splayer.h"

#include "stdlib.h"
#include "stdio.h"
#include "string.h"

splayer::splayer() {
	free=true;
	movedelay=0;
	angle=0;

	launchdelay=0;
	controlling=0;
	
	selected=0;

	loadtime=0;
	loading=false;

	shootwait=-1;
	canshoot=true;

	nick[0]='\0';

	score=0;
	lines=0;

	newgame=0;

	for (int i=0; i<5; i++) blocks[i]=NULL;

	ping=9999;
}

bool splayer::SetNick(char *nick) {
	if (strlen(nick)<=20) {
		strncpy (this->nick, nick, 20);
		return 1;
	} else return 0;
}

char *splayer::GetNick() {
	return nick;
}

bool splayer::SetIPaddress(IPaddress address) {
	this->address.host = address.host;
	this->address.port = address.port;
	return 1;
}

void splayer::SetSelection(int selection){
	selected=selection;
	while (selected<0) selected+=5;
	while (selected>4) selected-=5;
}

int splayer::GetSelection(){
	return selected;
}

int splayer::GetAngle(){
	return angle;
}


void splayer::pinged() {
	lping = SDL_GetTicks();
}
Uint32 splayer::lastping() {
	return lping;
}
