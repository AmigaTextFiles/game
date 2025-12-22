#ifndef GAMEOVER_H
#define GAMEOVER_H

#include <SDL/SDL.h>
#include "crate_object.h"

void GameOverMovie(SDL_Surface* screen, crate* crates, int crate_count,
                   int cameraY, int playerX, int playerY);

#endif
