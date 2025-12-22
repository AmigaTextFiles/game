#ifndef GRAPHICS_H
#define GRAPHICS_H

#include <SDL/SDL.h>

extern void DrawRectangle(SDL_Surface* dest, int x, int y, int w, int h, int r, int g, int b);
extern void DrawBackground(SDL_Surface* gameScreen);
extern void DrawPlayer(SDL_Surface* gameScreen, int x, int y);

#endif
