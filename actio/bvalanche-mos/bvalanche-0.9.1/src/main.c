#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>

#include "constants.h"
#include "require.h"

int main(int argc, char* argv[])
{
    SDL_Surface *gameScreen;
    SDL_VideoInfo *currentVideoInfo;

    require(SDL_Init(SDL_INIT_EVERYTHING) == 0, "SDL initialization");

    /* Get video information */
    currentVideoInfo = (SDL_VideoInfo *)SDL_GetVideoInfo();

    /* Setup game screen based on current video information */
    gameScreen = SDL_SetVideoMode
                 (SCREEN_WIDTH, SCREEN_HEIGHT,
                  currentVideoInfo -> vfmt -> BitsPerPixel,
                  SDL_DOUBLEBUF);

    require(gameScreen != NULL, "game screen initialization");

    bvalanche(gameScreen);

    /* Clean up */
    SDL_FreeSurface(gameScreen);

    SDL_Quit();
    return 0;
}
