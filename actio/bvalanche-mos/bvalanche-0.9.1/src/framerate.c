#include <SDL/SDL.h>
#include "framerate.h"
#include "constants.h"


Uint32 ticks, start_ticks;

void LimitFPS()
{
    start_ticks = SDL_GetTicks();
    ticks = SDL_GetTicks();

    while(ticks-start_ticks<1000/FPS)
        ticks = SDL_GetTicks();

}
