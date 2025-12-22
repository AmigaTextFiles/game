#ifndef GST_OBSTACLE
#define GST_OBSTACLE

#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <assert.h>

typedef enum
{
  brique = 0,
  pierre,
  metal,
  calcaire,
  caisse,
  bonus_bombe,	// ajouter les bonus toujours après bonus_bombe !
  bonus_armure,
  bonus_poudre,
  bonus_roquette,
  bonus_malus,
  nbre_de_obstacles
} type_enum_obstacles;

typedef struct type_obstacle * type_obstacle;

struct type_obstacle 
{
  SDL_Surface * screen, * fondImg;
  SDL_Surface * images [nbre_de_obstacles];
  SDL_Rect coords;
};

typedef struct type_un_obstacle * type_un_obstacle;

struct type_un_obstacle 
{
  SDL_Rect pos;
  type_enum_obstacles type;
  type_obstacle surfaces;
};

type_obstacle obs_cree (SDL_Surface * screen, SDL_Surface * fondImg);

type_un_obstacle obs_cree_un_obstacle (type_obstacle obstacle, type_enum_obstacles type, int posX, int posY);

void affiche_un_obstacle (type_un_obstacle un_obstacle);

void efface_un_obstacle (type_un_obstacle un_obstacle);

#endif /* GST_OBSTACLE */
