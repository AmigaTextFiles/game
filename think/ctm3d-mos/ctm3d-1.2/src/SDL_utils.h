/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

#ifndef _SDL_UTILS_H
#define _SDL_UTILS_H

#include "libraries.h"

extern int InitSDL(void);
extern void CreateGameScreen(SDL_Surface **screen, Uint32 SDLVideoFlags, int width, int height);

#endif
