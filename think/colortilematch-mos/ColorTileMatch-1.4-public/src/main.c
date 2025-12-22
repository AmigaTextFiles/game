/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

#include "main.h"

int main(int argc, char *argv[])
{
    SDL_Surface *screen;
    
    /* Set up SDL and game screen */
    Require(InitSDL(), "SDL initialization");
    CreateGameScreen(&screen, SDL_DOUBLEBUF | SDL_ANYFORMAT, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    /* Run the game */
    RunGame(&screen);
    
    /* Clean up and exit */
    SDL_FreeSurface(screen);
    SDL_Quit();
    return 0;
}
