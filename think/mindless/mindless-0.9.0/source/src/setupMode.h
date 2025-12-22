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

#ifndef SETUPMODE_H
#define SETUPMODE_H

class SetupMode : public GameMode {
 public:
  static void init();
  SetupMode();
  virtual void display();
  virtual void idle(double dt);
  virtual void mouseDown(int button,int x,int y);
  virtual void activated();

  static SetupMode *setupMode;
 private:
  int state;
  int selection;
  int isRandom[2];

  static SDL_Surface *background;
  void start();
  class Game *games[2];
};

#endif
