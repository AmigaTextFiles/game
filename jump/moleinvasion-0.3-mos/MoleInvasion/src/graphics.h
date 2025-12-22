/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#ifndef GRAPHICS_H
#define GRAPHICS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <assert.h>

#include <sys/types.h>
#include <sys/stat.h>

#include "SDL.h"
#include "SDL_image.h"

/* from /usr/include/linux/kernel.h :-) */
#define MIN(x,y) ({ \
        typeof(x) _x = (x);	\
        typeof(y) _y = (y);	\
        (void) (&_x == &_y);	\
        _x < _y ? _x : _y; })

#define MAX(x,y) ({ \
        typeof(x) _x = (x);     \
        typeof(y) _y = (y);     \
        (void) (&_x == &_y);	\
        _x > _y ? _x : _y; })

# define GFX_DIR	"gfx"

void quit( int code );

/* chargement images */
SDL_Surface * IMG_LoadOptCkey(char *filename);
SDL_Surface * IMG_LoadOptAlpha(char *filename);
SDL_Surface * IMG_LoadOptNone(char *filename);

void imageGetPixel(SDL_Surface* image, 
	unsigned int x, unsigned int y, 
	unsigned char *r, unsigned char *v ,unsigned char *b); 

Uint32 coef_frame_rate(char show_FPS);

/* shared global vars */
#ifdef GRAPHICS_C
	SDL_Surface * g_SDL_screen;
#else
	extern SDL_Surface * g_SDL_screen;
#endif

typedef enum{
	SINGLE, /* une seule image fixe | pos 0 */
	LIST,	/* une liste d'images , quand on est à la dernière, on reboucle */
	SIMPLE,	/* sprite animé simple en 8 images (4 gche, 4 drte) (avance) */
	FULL,	/* sprite animé complet en 14 images (7 gche, 7 drte) (avance, fall, jump, stop) */
} type_of_sprite;

/* positions dans le tab imgs */
#define L_STATIC		0
#define GCHE_AV1	0
#define GCHE_AV2	1
#define GCHE_AV3	2
#define GCHE_AV4	3
#define GCHE_STOP	4
#define GCHE_JUMP	5
#define GCHE_FALL	6
#define DRTE_AV1	7
#define DRTE_AV2	8
#define DRTE_AV3	9
#define DRTE_AV4	10
#define DRTE_JUMP	11
#define DRTE_FALL	12
#define DRTE_STOP	13

/* generic sprite images */
struct gsi{
	type_of_sprite	type;
	SDL_Surface* 	map;
	SDL_Surface* 	optmap;
	SDL_Surface* 	imgs[20]; /* maximum par defaut */
	char 		imgs_cnt; /* nombre d'images */
};

#define GAME_MODE	0
#define EDITOR_MODE	1
char GFX_loadCompleteSprite(struct gsi * csp, char * sp_name,int spwall_id,
		char * spwall_gfx_dir,char *sp_map,char mode);

#endif
