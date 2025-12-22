/* mainMode.cc
   Used when playing a game

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
#include "mainMode.h"
#include "game.h"
#include "setupMode.h"

using namespace std;

MainMode *MainMode::mainMode;
SDL_Surface *MainMode::colors[8];
SDL_Surface *MainMode::white,*MainMode::black,*MainMode::background,*MainMode::ok;

void MainMode::init() { 
  char name[256];
  int i;

  /* Load images here */
  for(i=0;i<8;i++) {
	sprintf(name,"color%d.png",i);
	colors[i] = loadImage(name);
  }
  background=loadImage("background.png");
  white=loadImage("white.png"); black=loadImage("black.png");
  ok=loadImage("ok.png");
  mainMode = new MainMode(); 
}
MainMode::MainMode() { }
void MainMode::idle(double dt) {
  /* Update world, (eg. countdown etc.) here */
  int i;

  nextThought-=dt;
  if(nextThought>0.0) return;
  nextThought+=1.0;

  // game globally finished
  finished=(games[0]->finished && games[1]->nAnswers>=games[0]->nAnswers) ||
	(games[1]->finished && games[0]->nAnswers>=games[1]->nAnswers);

  if(!finished) 
	for(i=0;i<2;i++) 
	  if(games[i]->isComputer) {
		if(games[i]->nAnswers < games[(i+1)%2]->nAnswers && (!games[(i+1)%2]->isComputer)) games[i]->commit();
		else if(games[i]->nAnswers <= games[(i+1)%2]->nAnswers || games[(i+1)%2]->finished) {
		  games[i]->think();
		  if(games[i]->thoughts > 30) games[i]->commit();
		}
	  }
}
void MainMode::display() {
  int i,j,bw;

  blit(background,0,0);

  for(int g=0;g<2;g++) {
	Game *game=games[g];
	int xOffset=40+screen->w/2*g;

	/* Draw answers this far */
	for(i=0;i<=game->nAnswers;i++) {
	  for(j=0;j<4;j++) 
		blit(colors[game->answers[i][j]],xOffset+60+40*j,530-45*i);
	  bw=game->blacks[i]+game->whites[i];
	  for(j=0;j<bw;j++)
		blit(j<game->blacks[i]?black:white,xOffset+20+(j%2)*18,550-45*i-18*(j/2));
	}
	
	/* Draw "ok" button */
	if(!game->isComputer) blit(ok,xOffset+240,543-45*game->nAnswers);
	/* Show correct code */
	//else {
	if(game->isComputer || finished)
	  for(j=0;j<4;j++) 
		blit(colors[game->code[j]],xOffset+60+40*j,20);
	  //}
  }

  if(finished) {
	if(games[0]->finished && games[1]->finished)
	  drawText("Draw",400,10,1,0,0,0);
	else if(games[0]->finished)
	  drawText("Winner",200,10,1,0,0,0);
	else 
	  drawText("Winner",600,10,1,0,0,0);
  }
}
void MainMode::activated() {
  finished=0;
  nextThought=1.0;
}
void MainMode::mouseDown(int button,int x,int y) {
  int row,column,g;

  if(finished) { GameMode::activate(SetupMode::setupMode); return; }  
  for(g=0;g<2;g++) {
	if(games[g]->nAnswers>games[(g+1)%2]->nAnswers && !games[(g+1)%2]->finished) continue;
	Game *game=games[g];	
	if(game->isComputer) continue;
	int xOffset=40+screen->w/2*g;

	row=game->nAnswers;
	if(y >= 530-45*row && y <= 530-45*row+40) {
	  if(x >= 240+xOffset && x <= xOffset + 240 + 40) doOk(g);
	  for(column=0;column<4;column++)
		if(x >= xOffset + 60+column*40+5 && x <= xOffset + 60+40*column+colors[0]->w-5) {
		  game->answers[row][column]=mymod(game->answers[row][column]+(button==1?1:-1),game->nColors);
		  //game->computeBW(game->code,game->answers[row],game->blacks[row],game->whites[row]); 
		  return;
		}
	}
  }
}

void MainMode::doOk(int g) {
  Game *game = games[g];
  if(game->finished) return;
  int row=game->nAnswers;
  game->computeBW(game->code,game->answers[row],game->blacks[row],game->whites[row]);
  if(game->blacks[row] == 4) game->finished=1;
  else {
	game->nAnswers++;
	for(int i=0;i<4;i++)
	  game->answers[game->nAnswers][i] = game->answers[game->nAnswers-1][i];
  }
  if(games[0]->finished && games[1]->finished) exit(0);

}

void MainMode::deactivated() {
}
