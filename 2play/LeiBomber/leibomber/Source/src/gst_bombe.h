#ifndef GST_BOMBE_H
#define GST_BOMBE_H

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_thread.h>
#include <math.h>

#include "gst_tab_jeu.h"

#define BMB_NBRE_IMAGES 9
#define BOMBES_MAX 16

typedef struct type_bombe_surfaces * type_bombe_surfaces;

struct type_bombe_surfaces 
{
  SDL_Rect coords;
  SDL_Surface * screen, * fondImg;
  SDL_Surface * images [BMB_NBRE_IMAGES];
};

typedef struct type_bombe_posable * type_bombe_posable;

struct type_bombe_posable
{
  SDL_Rect pos;
  SDL_Surface * ancienFondImg;
  type_bombe_surfaces surfaces;
  int *compteur;	
  int delai, position;
  int intensite [4];
  type_etre poseur;
};

typedef struct type_bombe * type_bombe;

struct type_bombe 
{
  int tab_debut;
  type_bombe_posable bombes [BOMBES_MAX];
};

void bmb_cree (SDL_Surface * screen, SDL_Surface * fondImg);

/* Le compteur doit être > 1 car il est décrémenté au début puis incrémenté après l'explosion */
void bmb_pose (SDL_Rect * pos, int intensite, int delai, int * compteur, type_etre poseur);

/* Fait exploser une bombe à un endroit donné */
void bmb_pose_intro (int x, int y, int delai);

#endif /* GST_BOMBE_H */
