#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <assert.h>
#include <math.h>

#include "gst_tab_jeu.h"
#include "gst_sons.h"
#include "gst_roquette.h"
#include "gst_divers.h"


#define ROQ_DEPLACEMENT 10
#define ROQ_POSITIONS 4

static type_surfaces_roq roq_surfaces;

static void
fabrique_nom_roq (char * buff, int position, int direction) 
{
  sprintf (buff, "./Images/roquette/roq%c%d.gif", position + 97, direction);
}


void 
roq_cree (SDL_Surface *screen, SDL_Surface *fondImg)
{
  int i, j;
  char nom_fichier [64];
  roq_surfaces = (type_surfaces_roq) malloc (sizeof (struct type_surfaces_roq));
  roq_surfaces->screen = screen;
  roq_surfaces->fondImg = fondImg;
  for (i = 0; i < nbre_de_directions; i++)
    {
      for (j = 0; j < ROQ_POSITIONS; j++)
	{
	  if (j >= 2)	// Pour l'explosion, on n'a qu'une seule direction
	    fabrique_nom_roq (nom_fichier, j, 0);
	  else
	    fabrique_nom_roq (nom_fichier, j, i);
	  printf ("Nom du fichier : %s i %d, j %d\n", nom_fichier, i, j);
	  fflush (NULL); 
	  assert ((roq_surfaces->images [i][j] = IMG_Load (nom_fichier)) != NULL);
	  SDL_SetColorKey (roq_surfaces->images [i][j], SDL_SRCCOLORKEY, 
			   SDL_MapRGB (roq_surfaces->images [i][j]->format, 0, 255, 255));
	}
      RECT_AFFECTE (roq_surfaces->coords [i], 0, 0, roq_surfaces->images [i][0]->w, roq_surfaces->images [i][0]->h);
    }
}

static void 
roq_update (type_roquette roquette)
{
  int x = roquette->pos.x;
  int y = roquette->pos.y;
  int w = roquette->pos.w;
  int h = roquette->pos.h;
  if (roquette->ancien_posX > x)
    {
      w += roquette->ancien_posX - x;
    }
  else
    {
      w += x - roquette->ancien_posX;
      x = roquette->ancien_posX;
    }
  if (roquette->ancien_posY > y)
    {
      h += roquette->ancien_posY - y; 
    }
  else
    {
      h += y - roquette->ancien_posY; 
      y = roquette->ancien_posY;
    }
  SDL_UpdateRect (roq_surfaces->screen, x, y, w, h);
}

static void 
roq_affiche (type_roquette roquette) 
{
  SDL_Surface * image = roq_surfaces->images [roquette->direction][roquette->position];
  SDL_Rect src;
  RECT_AFFECTE (src, 0, 0, image->w, image->h);
  SDL_BlitSurface (image, &(src), roq_surfaces->screen, &(roquette->pos));
  roq_update (roquette);
}

static void 
roq_efface (type_roquette roquette)
{
  SDL_BlitSurface (roq_surfaces->fondImg, &(roquette->pos), 
		   roq_surfaces->screen, &(roquette->pos));
}

static void 
roq_deplace (type_roquette roquette)
{
  roquette->position = (roquette->position + 1) % 2;
  if (valeurs_directions [roquette->direction].x == 0)
    {
      roquette->ancien_posY = roquette->pos.y;
      roquette->pos.y += valeurs_directions [roquette->direction].y * 5;
    }
  else
    {
      roquette->ancien_posX = roquette->pos.x;
      roquette->pos.x += valeurs_directions [roquette->direction].x * 5;
    }
}

static void
roq_annule_deplacement (type_roquette roquette)
{
  roquette->pos.x = roquette->ancien_posX;
  roquette->pos.y = roquette->ancien_posY;
}

static void
roq_fait_exploser (type_roquette roquette)
{
  RECT_AFFECTE (roquette->pos, (int) (roquette->pos.x / 50) * 50, (int) (roquette->pos.y / 50) * 50,
		50, 50);
  
  for (roquette->position = 2; roquette->position < 4; roquette->position++)
    {
      roq_affiche (roquette);
      SDL_UpdateRect (roq_surfaces->screen, roquette->pos.x, roquette->pos.y, 50, 50);
      SDL_Delay (200);
      roq_efface (roquette);
    }
}

static int
roq_fct_thread (void * arg)
{
  for (;;)
    {
      if (! tdj_position_roquette_valide ((type_roquette) arg))
	{
	  son_joue (son_roq_explose);
	  roq_annule_deplacement ((type_roquette) arg);
	  roq_fait_exploser ((type_roquette) arg);
	  break;
	}
      roq_affiche ((type_roquette) arg);
      if (((type_roquette) arg)->delai > 5)
	SDL_Delay (((type_roquette) arg)->delai--);
      else
	SDL_Delay (((type_roquette) arg)->delai);
      roq_efface ((type_roquette) arg);
      roq_deplace ((type_roquette) arg);
    }
  roq_update ((type_roquette) arg);
  (*(((type_roquette) arg)->compteur))++;
  free ((type_roquette) arg);	// désalloue la roquette désintégrée ;-)
  return 0;
}

void
roq_lance (int i, int j, type_directions direction, int delai, int *compteur)
{
  SDL_Thread * thread_roquette;
  type_roquette roquette = (type_roquette) malloc (sizeof (struct type_roquette));
  (*compteur)--;
  roquette->compteur = compteur;
  roquette->pos.w = roq_surfaces->coords [direction].w;
  roquette->pos.h = roq_surfaces->coords [direction].h;
  
  roquette->ancien_posX = i * 50;
  roquette->ancien_posY = j * 50;
  if (direction == nord)
    {
      roquette->pos.y = roquette->ancien_posY - roq_surfaces->coords [direction].h;
      roquette->pos.x = roquette->ancien_posX + (50 - roq_surfaces->coords [direction].w) / 2;
    }
  else if (direction == sud)
    {
      roquette->pos.y = roquette->ancien_posY + 50;
      roquette->pos.x = roquette->ancien_posX + (50 - roq_surfaces->coords [direction].w) / 2;
      printf ("Pos (%d, %d) (%d, %d)\n", i, j, roquette->pos.x / 50, roquette->pos.y / 50);
    }
  else if (direction == est)
    {
      roquette->pos.x = roquette->ancien_posX + 50;
      roquette->pos.y = roquette->ancien_posY + (50 - roq_surfaces->coords [direction].h) / 2;
    }
  else 
    {
      roquette->pos.x = roquette->ancien_posX - 25; //roq_surfaces->coords [direction].w;
      roquette->pos.y = roquette->ancien_posY + 18; //(50 - roq_surfaces->coords [direction].h) / 2;
    }
  if (! tdj_case_vide (roquette->pos.x / 50, roquette->pos.y / 50))
    {
      printf ("Explose dans le joueur !!\n");
      roq_annule_deplacement (roquette);
    }
  else
    son_joue (son_roq_tir);
  roquette->position = 0;
  roquette->direction = direction;
  roquette->delai = delai;
  thread_roquette = SDL_CreateThread (roq_fct_thread, (void *) roquette);  
}

