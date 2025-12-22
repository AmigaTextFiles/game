#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>
#include <SDL/SDL_image.h>

#include "gst_divers.h"

#define SORTIE_ERREUR(txt, chemin) \
  { fprintf (stderr, "Couldn't load " txt " data : %s\n", chemin); \
    exit (EXIT_FAILURE); \
  }

void 
sdl_rect_affecte (SDL_Rect * rect, Sint16 x, Sint16 y, Uint16 w, Uint16 h)
{
  rect->x = x;
  rect->y = y;
  rect->w = w;
  rect->h = h;
}

SDL_Surface * 
img_secure_load (char * chemin)
{
  SDL_Surface * tmp = IMG_Load (chemin);
  if (tmp == NULL)
    SORTIE_ERREUR ("video", chemin);
  return tmp;
}

Mix_Chunk * 
mix_secure_load (char * chemin)
{
  Mix_Chunk * tmp = Mix_LoadWAV (chemin);
  if (tmp == NULL)
    SORTIE_ERREUR("sound", chemin);
  return tmp;
}
