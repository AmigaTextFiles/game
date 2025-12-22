/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  sable.cpp: main file.  Parses command line options and initializes
 *  video.
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

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "textures.h"
#include "geometry.h"
#include "models.h"
#include "environment.h"
#include "input.h"
#include "sound.h"

#ifdef __MORPHOS__
const char *version_tag = "$VER: Sable 0.4 (22.01.2006)";
#endif

void init_graphics (void);
void uninit_graphics (void);

static VertexCompiler *vc;

int last_score, high_score;

static int screen_width, screen_height;
static float gamma;
static bool full_screen;

void
parse_cmdline (int argc, char **argv)
{
	int i = 1;
	int w = -1, h = -1;

	gamma = 1.0;
	while (i < argc) {
		if (!strcasecmp (argv[i], "-f")) {
			full_screen = true;
		} else if (!strcasecmp (argv[i], "-w")) {
			full_screen = false;
		} else if (!strcasecmp (argv[i], "-r")) {
			++i;
			if (i < argc) {
				char *temp;
				w = strtol (argv[i], &temp, 10);
				if (*temp == 'x') {
					h = strtol (temp+1, NULL, 10);
				} else {
					fprintf (stderr, "Invalid argument '%s' to -r: expected something of the form '1024x768'\n", argv[i]);
				}
			} else {
				fprintf (stderr, "-r requires an argument: using 640x480\n");
			}
		} else if (!strcasecmp (argv[i], "-g")) {
			++i;
			if (i < argc) {
				float g = atof (argv[i]);
				if ((g < 0.1) || (g > 10.0)) {
					fprintf (stderr, "Invalid gamma value, using 1.0\n");
					g = 1.0;
				}
				gamma = g;
			} else {
				fprintf (stderr, "-g requires an argument: using 1.0\n");
			}
		}
		i++;
	}

	if ((w >= 640) && (h < 480)) {
		fprintf (stderr, "No or invalid height specified, maintaining aspect ratio\n");
		h = w * 3 / 4;
	} else if (h < 480) {
		w = 640; h = 480;
	} else if (w < 640) {
		fprintf (stderr, "No or invalid width specified, maintaining aspect ratio\n");
		w = h * 4 / 3;
	}
	screen_width = w;
	screen_height = h;
}

void
compile_models (void)
{
	vc = new VertexCompiler ();
	vc->registerGeometry (&geomPlayer);
	vc->registerGeometry (&geomEnemy);
	vc->registerGeometry (&geomPylon);
	vc->registerGeometry (&geomTransparentPylon);
	vc->registerGeometry (&geomBullet);
	vc->registerGeometry (&geomDeathBlossom);

	vc->compile ();
}	

void
init_graphics (void)
{
	const SDL_VideoInfo* info = NULL;
	if( SDL_Init( SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_JOYSTICK | SDL_INIT_TIMER ) < 0 ) {
		/* Failed, exit. */
		fprintf( stderr, "SDL PANIC: Video initialization failed: %s\n",
			 SDL_GetError( ) );
		exit (-1);
	}

	SDL_JoystickEventState (SDL_ENABLE);
	int joycount = SDL_NumJoysticks();
	printf("%i joysticks were found.\n\n", joycount );
	if (joycount) {
		printf("The names of the joysticks are:\n");
		
		for(int i = 0; i < SDL_NumJoysticks(); i++ ) 
		{
			printf("    %s\n", SDL_JoystickName(i));
		}
	}

	playerInput.init ();

	info = SDL_GetVideoInfo( );
	if( !info ) {
		fprintf( stderr, "Video query failed: %s\n",
			 SDL_GetError( ) );
		SDL_Quit ();
		exit(-1);
	}

	int bpp = info->vfmt->BitsPerPixel;

	/* Ensure various sizes */
	SDL_GL_SetAttribute( SDL_GL_RED_SIZE, 8 );
	SDL_GL_SetAttribute( SDL_GL_GREEN_SIZE, 8 );
	SDL_GL_SetAttribute( SDL_GL_BLUE_SIZE, 8 );
	SDL_GL_SetAttribute( SDL_GL_DEPTH_SIZE, 16 );
	SDL_GL_SetAttribute( SDL_GL_DOUBLEBUFFER, 1 );
	
	int width = screen_width, height = screen_height;
	Uint32 flags = SDL_OPENGL;

	if (full_screen)
		flags |= SDL_FULLSCREEN;

	if( SDL_SetVideoMode( width, height, bpp, flags ) == 0 ) {
		fprintf( stderr, "SDL PANIC: Video mode set failed: %s\n",
			 SDL_GetError( ) );
		SDL_Quit ();
		exit (-1);
	}

	SDL_WM_SetCaption ("Sable", NULL);
	SDL_ShowCursor (false);
	SDL_SetGamma (gamma,gamma,gamma);

	glViewport (0, 0, width, height);

	compile_models ();

	load_textures ();

	atexit (uninit_graphics);
}

void
uninit_graphics (void)
{
	SDL_ShowCursor (true);
	delete vc;
	playerInput.uninit ();
	SDL_Quit ();
}

int
main (int argc, char **argv) 
{
	last_score = 0;
	high_score = 0;
	parse_cmdline (argc, argv);
	srandom (time (NULL));
	init_graphics ();
	load_sound ();
	main_loop ();
	free_sound ();
	return 0;
}
