/* game.h
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

#ifndef GAME_H
#define GAME_H

class Game {
 public:
  Game();

  /* state */
  int code[4];           // The correct answer
  int nAnswers;          // Numbers of attempted codes thus far
  int answers[32][4];    // The attempted answers thus far
  int whites[32], blacks[32];
  int finished;

  /* Rules */
  int nColors;
  int isComputer;

  void reset();         // Resets gamestate
  void computeBW(int code[4],int answer[4],int &black,int &white);


  /* AI state and functions */
  int bestMove[4], bestValue;    // The best move yet found
  int thoughts;                   // How long we have thought this far
  void think();
  void commit();
  int test(int sol[4]);          // Tests if a solution is possible
};

#endif
