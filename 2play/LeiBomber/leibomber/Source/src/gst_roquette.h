#ifndef GST_ROQUETTE_H
#define GST_ROQUETTE_H

#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <assert.h>
#include <math.h>

#include "gst_tab_jeu.h"

#define ROQ_POSITIONS 4

typedef struct type_surfaces_roq *type_surfaces_roq;
struct type_surfaces_roq 
{
  SDL_Surface *screen, *fondImg;
  SDL_Surface *images [nbre_de_directions][ROQ_POSITIONS];
  SDL_Rect coords [nbre_de_directions];
  SDL_Rect decalage [nbre_de_directions];
};

typedef struct type_roquette *type_roquette;
struct type_roquette 
{
  SDL_Rect pos;
  int ancien_posX, ancien_posY;
  int i, j;
  int position, delai;
  type_directions direction;
  int *compteur;
};

void roq_cree (SDL_Surface *screen, SDL_Surface *fondImg);

void roq_lance (int i, int j, type_directions direction, int delai, int *compteur);


#endif /* GST_ROQUETTE_H */
