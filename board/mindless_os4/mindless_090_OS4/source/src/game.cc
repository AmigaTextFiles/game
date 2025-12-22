/* game.cc
   Contains all information about the current game

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
#include "game.h"

using namespace std;

Game::Game() {
  nColors=8;
  isComputer=0;
}

void Game::reset() {
  int i,j;

  finished=0;
  nAnswers=0;
	for(j=0;j<4;j++)
	  code[j] = 0;	
  for(i=0;i<32;i++)
	for(j=0;j<4;j++)
	  answers[i][j] = 0;
  for(i=0;i<32;i++)
	blacks[i]=whites[i]=0;

  bestValue=nColors*nColors*nColors*nColors+1;
  thoughts=0;
}

void Game::computeBW(int code[4],int answer[4],int &black,int &white) {
  int codeUsed[4]={0,0,0,0},answerUsed[4]={0,0,0,0};
  int i,j;
  black=white=0;
  for(i=0;i<4;i++)
	if(answer[i] == code[i]) {black++; codeUsed[i]=1; answerUsed[i]=1; }
  for(i=0;i<4;i++)
	if(!answerUsed[i])
	  for(j=0;j<4;j++)
		if(!codeUsed[j] && answer[i] == code[j]) {white++; codeUsed[j]=1; answerUsed[i]=1; break; }
}

void Game::think() {
  int i;
  int move[4];
  
  for(i=0;i<4;i++) move[i] = rand() % nColors;
  while(!test(move))               // A possible solution we are evaluating
	for(i=0;i<4;i++) move[i] = rand() % nColors;

  /* TODO. Calculate a correct score for it */

  for(i=0;i<4;i++) bestMove[i] = move[i];
  thoughts++;

  /* This displays current bestMove for player */
  for(i=0;i<4;i++) answers[nAnswers][i]=bestMove[i]; 
}
void Game::commit() {
  int i;

  for(i=0;i<4;i++) answers[nAnswers][i]=bestMove[i]; 
  computeBW(code,answers[nAnswers],blacks[nAnswers],whites[nAnswers]);
  if(blacks[nAnswers] == 4) finished=1;
  else {
	nAnswers++;
	thoughts=0;
	bestValue=nColors*nColors*nColors*nColors+1;
  }
}
int Game::test(int sol[4]) {
  int i,b,w;
  
  for(i=0;i<nAnswers;i++) {
	computeBW(sol,answers[i],b,w);
	if(b != blacks[i] || w != whites[i]) return 0;
  }
  return 1;
}
