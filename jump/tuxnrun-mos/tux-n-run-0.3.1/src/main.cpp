/***************************************************************************
                          main.cpp  -  description
                             -------------------
    begin                : Fri Jun 13 15:08:05 EEST 2003
    copyright            : (C) 2003 by Marius Andra
    email                : marius@hot.ee
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/*
 * IN PROGRESS:
 * - Picking up items
 * - Multiple bonus effects on item pickups
 * - General tinkering
 * - Creature collision
 * - Friend or foe
 *
 * PLANNED:
 * - Level editor
 * - Bullets & other special effects
 * - Startup title/menu screen
 * - Audio
 * - Space partitioning
 *
 */

#define VERSION "0.3.1"

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <iostream>
#include <string>
#include <map>

#include <stdlib.h>

#include "cbase.h"
#include "cinput.h"

CBase Base;
CInput Input;

using namespace std;

// todo: parse command line arguments
// parse the ~/.tux-n-run/config file. create if non-existing
map<string, string> parseArguments(int argc, char *argv[])
{
  map<string, string> argumentList;

  argumentList.insert(map<string, string>::value_type("screen_width", "640"));
  argumentList.insert(map<string, string>::value_type("screen_height", "480"));
  argumentList.insert(map<string, string>::value_type("screen_depth", "0"));
  argumentList.insert(map<string, string>::value_type("fullscreen", "0"));
  argumentList.insert(map<string, string>::value_type("datadir", "data"));
  argumentList.insert(map<string, string>::value_type("window_caption", string("Tux-n-Run ")+string(VERSION)));

  return argumentList;
}

int main(int argc, char *argv[])
{
  cout << "Starting Tux-n-Run engine..." << endl;
  Input.init();
  Base.init(parseArguments(argc, argv));
  
  SDL_Event *event = Input.getEvents();

  int td2=0, td=0, btt=0;
  float dt=0, bt=0, bbt=0;
  
  while(!Base.gameOver())
  {
    td2 = SDL_GetTicks();
    bt = dt = ((float)(td2-td))/1000;
    td = td2;

    bt *= 100;
    bbt += bt;
    btt = (int)bbt;
    bbt -= btt;

    while(SDL_PollEvent(event))
    {
      if(event->type == SDL_QUIT)
			{
				Base.gameIsOver();
			} else if(event->type == SDL_KEYDOWN) {
       	Input.keyDown(event->key.keysym.sym);
			} else if(event->type == SDL_KEYUP) {
       	Input.keyUp(event->key.keysym.sym);
			}
    }

    Input.update();

    for(int cnt=0;cnt<btt;cnt++)
    {
      Base.update(Input);
      Input.clear();
    }
    Base.render();
  }
  cout << "Shutting Down" << endl;
  Base.cleanUp();
  
  return EXIT_SUCCESS;
}
