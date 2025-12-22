/* mainMode.h
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

#ifndef MAINMODE_H
#define MAINMODE_H

class MainMode : public GameMode {
 public:
  static void init();
  MainMode();

  virtual void idle(double dt);
  virtual void display();
  virtual void activated();
  virtual void mouseDown(int button,int x,int y);
  virtual void deactivated();

  int finished;

  static MainMode *mainMode;
  class Game *games[2];
  static SDL_Surface *colors[8];
  double nextThought;
 private:
  static SDL_Surface *white, *black,*background,*ok;

  void doOk(int g);
};

#endif
