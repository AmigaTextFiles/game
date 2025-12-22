/* MoleInvasion 0.1 - Copyright (C) 2004 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.\n"); */

# ifndef MIXER_H
# define MIXER_H

#include <stdio.h>
#include <stdlib.h>
#include "SDL.h"
#include "SDL_mixer.h"
#include "list.h"
#include <string.h>

int startTheMusic(char * file);

int stopTheMusic();

int startTheSound(char * file);

/* shared global vars */
#ifdef MIXER_C
	char g_activate_music=1;
	char g_activate_sound=1;
#else
	extern char g_activate_music;
	extern char g_activate_sound;
#endif

#endif
