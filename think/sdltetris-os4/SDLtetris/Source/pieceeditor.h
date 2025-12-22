#ifndef PIECEEDITOR_H
#define PIECEEDITOR_H

#include <SDL.h>
#include <string>
#include "pieces.h"

SDL_Surface *win;
SDL_Surface *black;
SDL_Surface *blocks;
SDL_Surface *axis;
SDL_Surface *axis2;
string specs[7];
piece thePiece;
int curPiece;
void loadSDL (void);
void loadSpecs (void);
void saveSpecs (void);
void initPieces (void);
void changePiece (int change);
void updateWin (void);

#endif
