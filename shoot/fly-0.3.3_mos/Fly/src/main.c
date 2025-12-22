/* 
   fly - 3D spaceship combat game

   Copyright (C) 2002 Rafael García Moreno

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software Foundation,
   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  

*/

#ifdef __MORPHOS__
const char *version_tag = "$VER: Fly 0.3.3 (2005-09-01)";
#endif

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include "getopt.h"
#include <signal.h>
#include <assert.h>
#include <GL/gl.h>	// Header File For The OpenGL32 Library
#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>

#include "system.h"
#include "timing.h"
#include "level.h"
#include "texture.h"
#include "cache.h"

#define EXIT_FAILURE 1

// GAME STATES
enum {game_menu, game_running, game_over} game_state; 

// main functions
static void usage(int status);
void cleanup(void);
int process_keyup(SDLKey key);

/* The name the program was run with, stripped of any leading path. */
char *program_name;

/* getopt_long return codes */
enum { DUMMY_CODE = 129 };

/* Option flags and variables */
static struct option const long_options[] = {
    {"help", no_argument, 0, 'h'},
    {"version", no_argument, 0, 'V'},
    {"fullscreen", no_argument, 0, 'f'},
    {"resolution", required_argument, 0, 'r'},
    {"randlevel", required_argument, 0, 'n'},
    {"level", required_argument, 0, 'l'},
    {"bps", required_argument, 0, 'b'},
    {NULL, 0, NULL, 0}
};

static int decode_switches(int argc, char **argv);

/* Global Variables */
SDL_Surface *screen;
struct Level level;

// Game Options
int fullscreen = 0;
int BPP = 16;
int global_pause = 0;
int audio_rate = MIX_DEFAULT_FREQUENCY;
Uint16 audio_format = MIX_DEFAULT_FORMAT;
int audio_channels = 2;

/* Set all the option flags according to the switches specified.
   Return the index of the first non-option argument.  */
static int decode_switches(int argc, char **argv)
{
    int c;

    while ((c = getopt_long(argc, argv, "hVfr:n:l:b:",
			    long_options, (int *) 0)) != EOF) {
	switch (c) {
        case 'v':
	case 'V':
	    printf("fly %s\n", VERSION);
	    exit(0);

	case 'h':
	    usage(0);
	    break;

	case 'f':
	    fullscreen = 1;
	    break;

	case 'r':
	    switch(atoi(optarg)) {
	    
	    case 1:
		Camera_set_size(640, 480);
		break;

	    case 2:
		Camera_set_size(800, 600);
		break;

	    case 3:
		Camera_set_size(1024, 768);
		break;
	
	    default:
		usage(EXIT_FAILURE);
		break;
	    }
	break;

        case 'b': // BPP
	    switch(atoi(optarg)) {
	    
	    case 16:
                BPP = 16;
		break;

	    case 24:
                BPP = 24;
		break;

	    case 32:
                BPP = 32;
		break;
	
	    default:
		usage(EXIT_FAILURE);
		break;
	    }
	break;

	case 'n':
	    level.num_level = atoi(optarg) - 1;
	    break;

        case 'l':
            strcpy(level.name, optarg);
            level.random = 0;
            break;
	    
	default:
	    usage(EXIT_FAILURE);
	}
    }

    return optind;
}


static void usage(int status)
{
    printf(_("%s - 3D shooter game\n"), program_name);
    printf(_("Usage: %s [OPTION]... \n"), program_name);
    printf(_("Options:\n"
	"  -f, --fullscreen           fullscreen mode\n"
	"  -h, --help                 display this help and exit\n"
	"  -V, --version              output version information and exit\n"
	"  -r N, --resolution=N       set screen resolution: 1  640x480 (default)\n"
	"                                                    2  800x600\n"
	"                                                    3 1024x768\n"
	"  -n N, --randlevel=N        set initial level\n"
	"  -l filename, --level=filename        set initial level\n"
	"  -b bpp, --bpp=bpp        set BPP, values: 16, 24 or 32\n"
));
    exit(status);
}

/* A general OpenGL initialization function. */
static void initGL()
{
    float light_ambient[] = { 0.8, 0.8, 0.8, 1.0 };
    float light_diffuse[] = { 0.5, 0.5, 0.5, 1.0 };
    float light_position[] = { 75.0, 75.0, 75.0, 1.0 };
    float light_position2[] = {-75.0, 75.0,-75.0, 1.0 };
    
    glViewport(0, 0, Camera_get_width(), Camera_get_height());
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f); // This Will Clear The Background Color To Black
    glClearDepth(1.0);		// Enables Clearing Of The Depth Buffer
    //glDepthFunc(GL_ALWAYS);	// The Type Of Depth Test To Do
    //glShadeModel(GL_FLAT);
    glShadeModel(GL_SMOOTH);
    glLightfv(GL_LIGHT1, GL_AMBIENT, light_ambient);
    glLightfv(GL_LIGHT2, GL_AMBIENT, light_ambient);
    glLightfv(GL_LIGHT1, GL_DIFFUSE, light_diffuse);
    glLightfv(GL_LIGHT2, GL_DIFFUSE, light_diffuse);
    glLightfv(GL_LIGHT1, GL_POSITION, light_position);
    glLightfv(GL_LIGHT2, GL_POSITION, light_position2);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT1);
    //glEnable(GL_LIGHT2);
    glEnable(GL_DEPTH_TEST);	// Enables Depth Testing
    glEnable(GL_CULL_FACE);
    glEnable(GL_COLOR_MATERIAL);
    glDisable(GL_BLEND);
    glDisable(GL_NORMALIZE);

    glPointSize(4.0);
}

static void initSDL()
{
    /* Initialize SDL for video output */
    if (SDL_Init(SDL_INIT_JOYSTICK | SDL_INIT_VIDEO | SDL_INIT_AUDIO)) {
	fprintf(stderr, "Unable to initialize SDL: %s\n", SDL_GetError());
	exit(1);
    }

    atexit(cleanup);
    signal(SIGINT, exit);
    signal(SIGTERM, exit);

    /* Init video */
    if (fullscreen) {
	screen = SDL_SetVideoMode(Camera_get_width(), Camera_get_height(), BPP,
                SDL_OPENGL | SDL_FULLSCREEN | SDL_DOUBLEBUF);
	if (screen == NULL) {
	    printf("Cannot get full screen display\n");
	    screen = SDL_SetVideoMode(Camera_get_width(), Camera_get_height(), 0,
                    SDL_OPENGL | SDL_RESIZABLE | SDL_DOUBLEBUF);
	}
	SDL_ShowCursor(0);
    } else {
	screen = SDL_SetVideoMode(Camera_get_width(), Camera_get_height(), 0, 
                SDL_OPENGL | SDL_RESIZABLE | SDL_DOUBLEBUF);
    }

    if (!screen) {
	fprintf(stderr, "Couldn't set %dx%d GL video mode: %s\n",
		Camera_get_width(), Camera_get_height(), SDL_GetError());
	SDL_Quit();
	exit(2);
    }

    printf("Video mode: %dx%d %d Bytes per pixel\n", screen->w, screen->h,
	   screen->format->BytesPerPixel);
    SDL_WM_SetCaption("Fly", "fly");

    /* Init audio */
    if (Mix_OpenAudio(audio_rate, audio_format, audio_channels, 4096) < 0) {
	fprintf(stderr, "Couldn't open audio: %s\n", SDL_GetError());
	exit(2);
    } else {
	Mix_QuerySpec(&audio_rate, &audio_format, &audio_channels);
	printf("Opened audio at %d Hz %d bit %d channels\n", audio_rate,
	       (audio_format & 0xFF), audio_channels);
    }
    
}

void init_game()
{
    Timing_init();
    Cache_init();
    Texture_load();
    //level.num_level = 0;
    Level_next(&level);
}

int process_keyup(SDLKey key)
{
 
    if (key == SDLK_p) {
	if (global_pause) {
	    global_pause = 0;
	} else {
	    global_pause = 1;
	}
    }

    if(key == SDLK_ESCAPE) return 0;
    
    if (key == SDLK_c || key == SDLK_RETURN) { // CONTINUE
        if(key == SDLK_RETURN) level.num_level = 0;
        else level.num_level--; // TODO: only create the player

        Level_next(&level);
    }

    if(key == SDLK_x) printf("FPS=%d\n",fps);

    if(key == SDLK_n) level.show_text = ++level.show_text % 2;

    if(!global_pause) Level_process_keyup(&level, key);
    
    return 1;
}
    
void cleanup(void)
{
  printf("Exiting...\n");

  // free level
  Level_free(&level);

  SDL_FreeSurface(screen);
  Mix_CloseAudio();  
  SDL_Quit();  
}

/* do rasterising only */
void rasonly() 
{
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glOrtho(0.0f, (GLfloat) Camera_get_width(), 0.0f, (GLfloat) Camera_get_height(), 0.0f, 1.0f);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  //glViewport(0, 0, Camera_get_width(), Camera_get_height());
}

int main(int argc, char **argv)
{
    int i;
    SDL_Event event;
    int done=0;
	
    Camera_set_size(640, 480);
    level.num_level = 0;
 
    program_name = argv[0];

    printf("(c)2002 Rafael Garcia <bladecoder@gmx.net>\n");
    i = decode_switches(argc, argv);
    
    initSDL();
    initGL();
    init_game();

    while (!done) {
	while (SDL_PollEvent(&event)) {
	    switch (event.type) {
	    case SDL_VIDEORESIZE:
		screen = SDL_SetVideoMode(event.resize.w, event.resize.h, 0,
                    SDL_OPENGL | SDL_RESIZABLE | SDL_DOUBLEBUF);
		if (screen) {
                    Camera_set_size(event.resize.w, event.resize.h);
                    glViewport(0,0,event.resize.w,event.resize.h);
		} else {
		    printf("Uh oh, we couldn't set the new video mode??\n");
                    exit(0);
		}
		break;

	    case SDL_QUIT:
		done = 1;
		break;

	    case SDL_KEYUP:
		if(!process_keyup(event.key.keysym.sym)) done = 1;
	    }
	}

	Timing_update();

        if(global_pause) Level_draw(&level);
        else Level_frame(&level);

    }
    exit(0);
}

