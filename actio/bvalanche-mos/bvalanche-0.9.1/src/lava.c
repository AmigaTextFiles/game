#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>

#include "constants.h"

int lava_height;

void InitLava()
{
    /* Initialize lava height */
    lava_height = INITIAL_LAVA_HEIGHT;
}

int ManageLava(void)
{
    lava_height -= LAVA_SPEED;
    return lava_height;
}

void DrawLava(SDL_Surface* screen, int cameraY)
{
    DrawRectangle(screen, 0, lava_height - cameraY, 640, 480 - (lava_height - cameraY), 200, 0, 0);
}
