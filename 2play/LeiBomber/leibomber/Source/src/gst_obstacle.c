#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <assert.h>

#include "gst_obstacle.h"
#include "gst_divers.h"

char * nom_fichiers [nbre_de_obstacles] = { "brique.gif", "pierre.gif", "metal.gif", 
					    "calcaire.gif",
					    "boite.gif", "bombe.gif", "armure.gif",
					    "poudre.gif", "roquette.gif", "bonus_malus.gif"};

static void 
fabrique_nom_obstacle (char * buff, char * nom)
{
  sprintf (buff, "./Images/divers/%s", nom);
}

type_obstacle
obs_cree (SDL_Surface * screen, SDL_Surface * fondImg)
{
  int i;
  Uint32 formatRGB;
  char nom_fichier [64];
  type_obstacle obs = (type_obstacle) malloc (sizeof (struct type_obstacle));
  for (i = 0; i < nbre_de_obstacles; i++)
    {
      fabrique_nom_obstacle (nom_fichier, nom_fichiers [i]);
      obs->images [i] = IMG_Load (nom_fichier);
      assert (obs->images [i] != NULL);
      if (i == metal)
	SDL_SetAlpha (obs->images [i], SDL_SRCALPHA, 75);
      else if (i >= caisse)
	{
	  formatRGB = SDL_MapRGB (obs->images [i]->format, 0, 255, 255);
	  SDL_SetColorKey (obs->images [i], SDL_SRCCOLORKEY, formatRGB);
	}
    }
  RECT_AFFECTE ((*obs).coords, 0, 0, obs->images [0]->w, obs->images [0]->h);
  obs->screen = screen;
  obs->fondImg = fondImg;  
  return obs;
}

type_un_obstacle
obs_cree_un_obstacle (type_obstacle obstacle, type_enum_obstacles type, int posX, int posY)
{
  type_un_obstacle un_obstacle = (type_un_obstacle) malloc (sizeof (struct type_un_obstacle));
  un_obstacle->type = type;
  RECT_AFFECTE ((*un_obstacle).pos, posX, posY, obstacle->coords.w, obstacle->coords.h);
  un_obstacle->surfaces = obstacle;
  return un_obstacle;
}

void
affiche_un_obstacle (type_un_obstacle un_obstacle)
{
  SDL_BlitSurface (un_obstacle->surfaces->images [un_obstacle->type], &(un_obstacle->surfaces->coords),
		   un_obstacle->surfaces->screen, &(un_obstacle->pos));
  SDL_UpdateRects (un_obstacle->surfaces->screen, 1, &(un_obstacle->pos));
}

void
efface_un_obstacle (type_un_obstacle un_obstacle)
{
  SDL_BlitSurface (un_obstacle->surfaces->fondImg, &(un_obstacle->pos),
		   un_obstacle->surfaces->screen, &(un_obstacle->pos));
  SDL_UpdateRects (un_obstacle->surfaces->screen, 1, &(un_obstacle->pos));
}
