#ifndef LAVA_H
#define LAVA_H

#include <SDL/SDL.h>

extern void InitLava(void);
extern int ManageLava(void);
extern void DrawLava(SDL_Surface* screen, int cameraY);

#endif
