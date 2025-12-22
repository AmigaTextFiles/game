#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>

#include "constants.h"
#include "graphics.h"

void DrawRectangle(SDL_Surface* dest, int x, int y, int w, int h, int r, int g, int b)
{
    SDL_PixelFormat *pixelFormat = dest -> format;
    Uint32 rectColor = SDL_MapRGB(pixelFormat, r, g, b);
    struct SDL_Rect rectRegion = { x, y, w, h };
    SDL_FillRect(dest, &rectRegion, rectColor);
}

void DrawBackground(SDL_Surface* gameScreen)
{
    /* white BG */
    DrawRectangle(gameScreen, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 255, 255, 255);
}

void DrawPlayer(SDL_Surface* gameScreen, int x, int y)
{
    DrawRectangle(gameScreen, x, y, PLAYER_WIDTH, PLAYER_HEIGHT, 127, 127, 127);
}
