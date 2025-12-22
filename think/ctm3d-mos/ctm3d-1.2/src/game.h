/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

#ifndef _GAME_H
#define _GAME_H

#include "libraries.h"

extern void RunGame(SDL_Surface **GameScreen);
extern int getTileData(int x, int y);
extern int getTileColor(int x, int y);
extern void setTileData(int x, int y, int val);
extern void setTileColor(int x, int y, int val);
extern void introIsDone(void);

#endif
