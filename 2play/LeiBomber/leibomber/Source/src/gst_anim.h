#ifndef GST_ANIM_H
#define GST_ANIM_H

#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

#define FICHIERS_VISAGE "./Images/fond/visage .gif"

typedef struct
{
  SDL_Rect pos;
  SDL_Rect coord;
  SDL_Surface * screen;
  SDL_Surface * images [2];  
  int cpt;
} type_visage;

extern void anim_cree_visage (int x, int y, SDL_Surface * screen);

extern int anim_survol_visage ();

extern void anim_gere_visage ();

extern void anim_allume_visage ();

#endif /* GST_ANIM_H */
