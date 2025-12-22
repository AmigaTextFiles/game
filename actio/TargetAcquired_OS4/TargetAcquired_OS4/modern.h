/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/

#ifndef __MODERN_H__
#define __MODERN_H__

#include <SDL.h>
#include "ta.h"

typedef struct {
	byte valid;
	byte *outline;
	SDL_Surface *surface;
} graphic;

typedef struct {
	int length;
	char **lines;
} scrollingtext;

extern graphic gfx[];
extern graphic *GFX_Main_Menu, *GFX_High_Score, *GFX_Enter_Name;
extern graphic *GFX_Credits, *GFX_Briefing, *GFX_End_Credits;

extern SDL_Surface *screen, *workspace;

void init_SDL_layer(int);
void cleanup_SDL_layer(void);
void clean_exit(int);

/* Graphical routines */
void clear_graphic(SDL_Surface *);
void draw_graphic(graphic *, int, int, SDL_Surface *);

/* Font handling routines */
void writeXE(int, int, char *, SDL_Surface *);
void cwriteXE(int, char *, SDL_Surface *);
int XElen(char *);
void scroll_text (graphic *, scrollingtext *, Uint32);

/* Top level event handler */
void handle_event_top(SDL_Event *);

/* Random number generator */
void seed_random(Uint32);
int get_random(int);

#endif
