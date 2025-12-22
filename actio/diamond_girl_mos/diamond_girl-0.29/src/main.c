/*
  Diamond Girl - Game where player collects diamonds.
  Copyright (C) 2005  Joni Yrjana
  
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


  Complete license can be found in the LICENSE file.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <SDL/SDL.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <string.h>
#include <errno.h>

#include "diamond_girl.h"

int fullscreen;

#if !defined(AMIGA)
static char hdname[1024];
#endif

const char * get_save_filename(const char * name)
{
  static char buf[1024 * 4];

#if defined(AMIGA)
  snprintf(buf, sizeof buf, "PROGDIR:%s", name);
#else
  snprintf(buf, sizeof buf, "%s/%s", hdname, name);
#endif
  
  return buf;
}

const char * get_data_filename(const char * name)
{
  static char buf[1024 * 4];

#if defined(AMIGA)
  snprintf(buf, sizeof buf, "PROGDIR:%s", name);
#else
  snprintf(buf, sizeof buf, "%s", name);
#endif
  
  return buf;
}


int main(int argc, char * argv[])
{
  int rv;
  int homedir_ok;

  assert(argc == argc);
  assert(argv == argv);

  fullscreen = 0;

#if defined(AMIGA)
  homedir_ok = 1;
#else
  { /* change working directory to $HOME/.diamond_girl, making sure it exists, set homedir_ok variable accordingly */
    char * hd;

    homedir_ok = 0;
    hd = getenv("HOME");
    if(hd != NULL)
      {
	struct stat sb;

	snprintf(hdname, sizeof hdname, "%s/.diamond_girl", hd);
	mkdir(hdname, S_IREAD | S_IWRITE | S_IEXEC);
	if(stat(hdname, &sb) == 0)
	  homedir_ok = 1;
	else
	  fprintf(stderr, "Failed to setup working directory %s.\n", hdname);
      }
    else
      fprintf(stderr, "Failed to get environment variable HOME: %s\n", strerror(errno));
  }
#endif

  if(!homedir_ok)
    fprintf(stderr, "Warning! Unable to load/save highscores and other settings!\n");

  if(SDL_Init(0) == 0)
    {
      if(gfx_initialize())
	{
	  sfx_initialize();
	  main_menu(homedir_ok);
	  rv = EXIT_SUCCESS;
	  sfx_cleanup();
	}
      else
	rv = EXIT_FAILURE;

      gfx_cleanup();
    }
  else
    {
      fprintf(stderr, "Failed to initialize SDL: %s\n", SDL_GetError());
      rv = EXIT_FAILURE;
    }

  SDL_Quit();

  return rv;
}
