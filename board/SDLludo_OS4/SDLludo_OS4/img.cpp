/*********************************************
 * Title: Kitten's Fishing Game
 * Desc: Image handling class
 * Authors: GBiatch & Qte
 *
 * $Id: img.cpp,v 1.3 2002/07/21 17:43:32 qte Exp $
 *********************************************/

#include "img.h"

// Constructor
IMG::IMG(const char* path){
  load(path);
}

IMG::IMG(){
}

// Destructor
IMG::~IMG(){
}

void IMG::draw(int x, int y){
  SDL_Rect dest;
  dest.x = x;
  dest.y = y;
  slock();
  SDL_SetColorKey(surface, SDL_SRCCOLORKEY, SDL_MapRGB(surface->format,
			  255, 0, 255));
  SDL_BlitSurface(surface, NULL, screen, &dest);
  sulock();
}

void IMG::load(const char* path){
  surface = SDL_LoadBMP(path);
}

void IMG::slock(){
  if (SDL_MUSTLOCK(screen)){
    if (SDL_LockSurface(screen) < 0) {
      return;
    }
  }
}

void IMG::sulock(){
  if (SDL_MUSTLOCK(screen)){
    SDL_UnlockSurface(screen);
  }
}
