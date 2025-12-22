/* mindless.cc
   Main funcion

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
#include "setupMode.h"
#include <sys/time.h>
#include <sys/types.h>
#include <dirent.h>

using namespace std;

char shareDir[256];
SDL_Surface *screen;
int is_running;

int testDir() {
  DIR *dir = opendir(shareDir);
  if(!dir) return 0;
  else closedir(dir);
  char str[256];
  sprintf(str,"%s/icons",shareDir);
  dir = opendir(shareDir);
  if(!dir) return 0;
  else closedir(dir);
  return 1;
}  

int main(short argc,char **args) {
  int windowed=0;

  if(argc == 2 && strcmp(args[1],"-w")) windowed=1;

  sprintf(shareDir,"./share");
  if(!testDir()) {
	sprintf(shareDir,"../share");
	if(!testDir()) {
	  sprintf(shareDir,"%s",SHARE_DIR);
	  if(!testDir()) {
		fprintf(stderr,"Can't find the resource directory.\n");
		exit(0);
	  }
	}
  }
  printf("Welcome to mindless, using %s as resource directory\n",shareDir);
  SDL_Init(SDL_INIT_VIDEO);
  screen=SDL_SetVideoMode(800,600, 16, SDL_SWSURFACE|SDL_DOUBLEBUF|(windowed?0:SDL_FULLSCREEN));
  atexit(SDL_Quit);

  generalInit();
  MainMode::init();
  SetupMode::init();
  GameMode::activate(SetupMode::setupMode);
  
  struct timeval tv;
  double oldTime,t,td;
  gettimeofday(&tv,NULL);
  oldTime=tv.tv_sec + 1e-6 * tv.tv_usec;

  is_running=1;
  while(is_running) {

	/* Update world */
	gettimeofday(&tv,NULL);
	t=tv.tv_sec + 1e-6 * tv.tv_usec;
	td = t - oldTime;
	oldTime = t;
	if(td > 0.5) td = 0.5;
	GameMode::current->idle(td);

	/* Update display */
	GameMode::current->display();
	SDL_Flip(screen);

	SDL_Event event;
	while(SDL_PollEvent(&event)) {
	  switch(event.type) {
	  case SDL_QUIT: is_running=0; break;
	  case SDL_MOUSEBUTTONDOWN: 
		{ SDL_MouseButtonEvent *e=(SDL_MouseButtonEvent*)&event;
		  GameMode::current->mouseDown(e->button,e->x,e->y);
		}
		break;
	  case SDL_KEYDOWN:
		if(event.key.keysym.sym == SDLK_ESCAPE) {
		  if(GameMode::current == (GameMode*)MainMode::mainMode) 
			GameMode::activate(SetupMode::setupMode);
		  else
			is_running=0;
		}
		break;
	  }
	}
  }

  SDL_Quit();
}
