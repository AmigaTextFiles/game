/* setupMode.h
   Sets up the game parameters

   Copyright (C) 2000  Mathias Broxvall

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include "general.h"
#include "gameMode.h"
#include "setupMode.h"
#include "game.h"
#include "mainMode.h"

using namespace std;

SDL_Surface *SetupMode::background;
SetupMode *SetupMode::setupMode;

#define P1_TYPE 0
#define P1_CODE 1
#define P1_COLORS 2
#define P2_TYPE 3
#define P2_CODE 4
#define P2_COLORS 5
#define START 7
#define QUIT 8

#define CODE_OK 7

void SetupMode::init() {
  background = loadImage("setupBG.png");
  setupMode = new SetupMode();
}
SetupMode::SetupMode() {
  for(int i=0;i<2;i++)
	games[i]=new Game();
}
void SetupMode::display() {
  char str[256];
  int i;

  blit(background,0,0);

  if(state == -1) {
	/* Main menu */
	drawBigText("Mindless",400,150,1,0,0,0);
	
	sprintf(str,"Player 1 is %s",games[0]->isComputer?"computer":"human");
	if(selection == P1_TYPE) drawText(str,400,300+30*P1_TYPE,1,255,255,255);
	else drawText(str,400,300+30*P1_TYPE,1,0,0,0);
	
	sprintf(str,"Player 1 code is %s",isRandom[0]?"random":"custom");
	if(selection == P1_CODE) drawText(str,400,300+30*P1_CODE,1,255,255,255);
	else drawText(str,400,300+30*P1_CODE,1,0,0,0);
	
	sprintf(str,"Player 1 has %d colors ",games[0]->nColors);
	if(selection == P1_COLORS) drawText(str,400,300+30*P1_COLORS,1,255,255,255);
	else drawText(str,400,300+30*P1_COLORS,1,0,0,0);
	
	sprintf(str,"Player 2 is %s",games[1]->isComputer?"computer":"human");
	if(selection == P2_TYPE) drawText(str,400,300+30*P2_TYPE,1,255,255,255);
	else drawText(str,400,300+30*P2_TYPE,1,0,0,0);
	
	sprintf(str,"Player 2 code is %s",isRandom[1]?"random":"custom");
	if(selection == P2_CODE) drawText(str,400,300+30*P2_CODE,1,255,255,255);
	else drawText(str,400,300+30*P2_CODE,1,0,0,0);
	
	sprintf(str,"Player 2 has %d colors ",games[1]->nColors);
	if(selection == P2_COLORS) drawText(str,400,300+30*P2_COLORS,1,255,255,255);
	else drawText(str,400,300+30*P2_COLORS,1,0,0,0);
	
	if(selection == START) drawText("Start",400,300+30*START,1,255,255,255);
	else drawText("Start",400,300+30*START,1,0,0,0);

	if(selection == QUIT) drawText("Quit",400,300+30*QUIT,1,255,255,255);
	else drawText("Quit",400,300+30*QUIT,1,0,0,0);

  } else {

	sprintf(str,"Select code for player %d",state+1);
	drawBigText(str,400,150,1,0,0,0);

	/* Select code for some player */
	if(selection == CODE_OK) drawText("Ok",400,300+30*CODE_OK,1,255,255,255);
	else drawText("Ok",400,300+30*CODE_OK,1,0,0,0);

	for(i=0;i<4;i++)
	blit(MainMode::colors[games[state]->code[i]],400-80+40*i,300);
  }
}
void SetupMode::idle(double dt) {
  int x,y;
  Uint8 mouseState=SDL_GetMouseState(&x,&y);
  selection=-1;
  if(y >= 300) selection = (y - 300) / 30;
}
void SetupMode::mouseDown(int button,int x,int y) {
  selection=-1;
  if(y >= 300) selection = (y - 300) / 30;
  if(state > -1 && selection == CODE_OK) { state=-1; return; }
  if(state > -1 && y > 300 && y < 348) {
	int xsel=(x-(400-80))/40;
	if(xsel >= 0 && xsel <= 3)
	  games[state]->code[xsel] = mymod(games[state]->code[xsel]+(button==1?1:-1),games[state]->nColors);
	return;
  }

  switch(selection) {
  case P1_TYPE: games[0]->isComputer=mymod(games[0]->isComputer+(button==1?1:-1),2); break;
  case P2_TYPE: games[1]->isComputer=mymod(games[1]->isComputer+(button==1?1:-1),2); break;
  case P1_COLORS: games[0]->nColors=mymod(games[0]->nColors-2+(button==1?1:-1),7)+2; break;
  case P2_COLORS: games[1]->nColors=mymod(games[1]->nColors-2+(button==1?1:-1),7)+2; break;
  case P1_CODE: if(button==1) { state=0; isRandom[0]=0; } else isRandom[0]=1; break;
  case P2_CODE: if(button==1) { state=1; isRandom[1]=0; } else isRandom[1]=1; break;
  case START: start(); break;
  case QUIT: exit(0); break;
  }
}
void SetupMode::activated() {
  int i;
  isRandom[0]=isRandom[1]=1;  
  for(i=0;i<2;i++)
	games[i]->reset();
  games[1]->isComputer=1;
  state=-1;
}
void SetupMode::start() {
  int i,j;

  GameMode::activate(MainMode::mainMode);
  
  for(i=0;i<2;i++) {
	MainMode::mainMode->games[i] = games[i];
	if(isRandom[i]) 
	  for(j=0;j<4;j++)
		games[i]->code[j] = rand() % games[i]->nColors;
  }
}
