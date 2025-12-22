/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

#ifndef _DRAWTILES_H
#define _DRAWTILES_H

#include "libraries.h"

extern void DrawTileSet(SDL_Surface **screen);
extern void OldDrawTileSet(SDL_Surface **screen);
void CTM3D_Cube(GLfloat x, GLfloat y, int color_code);
void CTM3D_CubeFace(int a, int b, int c, int d, int color_code);

#endif
