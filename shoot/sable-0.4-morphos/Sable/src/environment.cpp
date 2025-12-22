/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  environment.cpp: The main loop for the program; also handles
 *  frameskips if necessary
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be entertaining,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.  A copy of the
 *  General Public License is included in the file COPYING.
 */

#include "sable.h"
#include <SDL.h>
#include "environment.h"
#include "logo.h"
#include "menu.h"
#include "game.h"

static Environment *envs[NUM_ENVIRONS];

void
main_loop (void)
{
	EnvID current = ENVIRON_LOGO;
	EnvID old = ENVIRON_EXIT;

	envs[ENVIRON_EXIT] = NULL;
	envs[ENVIRON_LOGO] = new Logo ();
	envs[ENVIRON_MENU] = new Menu ();
	envs[ENVIRON_GAME] = new Game ();

	Uint32 target = SDL_GetTicks ();
	while (current != ENVIRON_EXIT) {
		if (current != old) {
			envs[current]->init ();
		}

		envs[current]->frameAdvance ();

		Uint32 now = SDL_GetTicks ();
		target += 10;
		if (now < target) {
			envs[current]->renderScreen ();
			SDL_Delay (target - now);
		}

		old = current;
		current = envs[current]->processEvents ();
		if (current != old) {
			envs[old]->uninit ();
		}
	}

	delete envs[ENVIRON_MENU];
	delete envs[ENVIRON_GAME];
}
