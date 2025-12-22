#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <assert.h>
#include <string.h>
#include <math.h>
#include <ctype.h>

#include "gst_caracteres.h"
#include "gst_sons.h"
#include "gst_divers.h"

static type_caracteres car_surfaces;

struct type_caracteres
{
  SDL_Surface * screen, * fondImg;
  SDL_Surface * images [DERNIER_CAR - PREMIER_CAR + 1];
  SDL_Rect coords;
};


static char *
fabrique_nom_car (char * buff, char * debut, int position) 
{
  sprintf (buff, "./Images/caracteres/%s%c%d.gif", debut, ((position < 100) ? '0' : 0), position);
  printf ("Chargement : %s\n", buff);
  fflush (NULL);   
  return buff;
}

void
car_cree (SDL_Surface * screen, SDL_Surface * fondImg)
{
  int i;
  char nom_fichier [64];
  car_surfaces = (type_caracteres) malloc (sizeof (struct type_caracteres));
  assert (car_surfaces != NULL);
  car_surfaces->screen = screen;
  car_surfaces->fondImg = fondImg;
  for (i = PREMIER_CAR; i <= DERNIER_CAR; i++)
    {
      SDL_Surface * image = IMG_Load (fabrique_nom_car (nom_fichier, NOM_BASE, i));
      assert (image != NULL);
      car_surfaces->images [i - PREMIER_CAR] = image;
      SDL_SetColorKey (image, SDL_SRCCOLORKEY, SDL_MapRGB (image->format, 0, 255, 255));
    }
  car_surfaces->coords.x = car_surfaces->coords.y = 0;
  /*car_surfaces->son_pose = Mix_LoadWAV ("./Sons/PoseLettre.wav");
  assert (car_surfaces->son_pose != NULL);
  car_surfaces->son_fondu = Mix_LoadWAV ("./Sons/Fondu.wav");
  assert (car_surfaces->son_fondu != NULL);*/
}

/* Affiche en fondu, en frappe ou normal, retourne le x de fin de ligne */
static int
car_affiche_texte_aux (int x, int y, char * texte, int delai, int alpha)
{
  int i, iMax;
  SDL_Rect dst;
  SDL_Surface * image;
  RECT_AFFECTE (dst, x, y, 0, 0);
  iMax = strlen (texte);
  for (i = 0; i < iMax; i++) 
    {
      int c;
      c = toupper (texte [i]);
      if (c == 32)
	{
	  dst.x += car_surfaces->images [0]->w;
	}
      else
	{
	  if (delai)
	    son_joue (son_car_frappe);
	  //Mix_PlayChannel (-1, car_surfaces->son_pose, 0);
	  image = car_surfaces->images [c - PREMIER_CAR];
	  if (alpha)
	    SDL_SetAlpha (image, SDL_SRCALPHA, alpha);
	  car_surfaces->coords.w = image->w;
	  car_surfaces->coords.h = image->h;
	  SDL_BlitSurface (image, &(car_surfaces->coords), car_surfaces->screen, &(dst));
	  dst.x += image->w + 1;
	  if (delai)
	    {
	      SDL_UpdateRect (car_surfaces->screen, x, y, dst.x - x, image->h);
	      SDL_Delay (delai);
	    }
	}
    }
  SDL_UpdateRect (car_surfaces->screen, x, y, dst.x - x, 16); //car_surfaces->images [50]->h);
  return dst.x;
}

int 
car_longueur_texte (char * texte)
{
  int i, iMax;
  int longueur = 0;
  iMax = strlen (texte);
  for (i = 0; i < iMax; i++) 
    {
      int c = toupper (texte [i]);
      if (c == 32)
	longueur += car_surfaces->images [0]->w;
      else
	longueur += car_surfaces->images [c - PREMIER_CAR]->w + 1;
    }
  return longueur;
}

int
car_affiche_texte (int x, int y, char * texte)
{
  return car_affiche_texte_aux (x, y, texte, 0, 0);
}

int
car_frappe_texte (int x, int y, char * texte, int delai)
{
  return car_affiche_texte_aux (x, y, texte, delai, 0);
}

void 
car_fondu_texte (int numtexte, int * x, int * y, char * * texte, int delai)
{
  int alpha, cpt;
  son_joue (son_car_fondu);
  //Mix_PlayChannel (-1, car_surfaces->son_fondu, 0);
  for (alpha = 25; alpha <= 250; alpha += 25)
    {
      for (cpt = 0; cpt < numtexte; cpt++)
	car_affiche_texte_aux (x [cpt], y [cpt], texte [cpt], 0, alpha);
      SDL_Delay (delai);
    }
}

void
car_affiche_nombre (int x, int y, int valeur, int prctage)
{
  int taille = (valeur == 0 ? 1 : log10 (abs (valeur)));
  char * txt = (char *) malloc (sizeof (char) * taille);
  SDL_Surface * image = car_surfaces->images [50];
  SDL_Rect dst;
  RECT_AFFECTE (dst, x, y, image->w * (taille + 3), image->h + 2);
  SDL_BlitSurface (car_surfaces->fondImg, &dst, car_surfaces->screen, &dst);
  SDL_UpdateRects (car_surfaces->screen, 1, &dst);
  sprintf (txt, "%d%c", valeur, (prctage ? '%' : 0));
  car_affiche_texte (x, y, txt);
  free (txt);
}

void
car_efface (int x, int y, int nbre_de_elements)
{
  SDL_Rect pos;
  RECT_AFFECTE (pos, x, y, 15 * nbre_de_elements, 16);
  SDL_BlitSurface (car_surfaces->fondImg, &pos, car_surfaces->screen, &pos);
  SDL_UpdateRects (car_surfaces->screen, 1, &pos);
}

void
car_efface_texte (int x, int y, char * texte)
{
  SDL_Rect pos;
  RECT_AFFECTE (pos, x, y, car_longueur_texte (texte), 16);
  SDL_BlitSurface (car_surfaces->fondImg, &pos, car_surfaces->screen, &pos);
  SDL_UpdateRects (car_surfaces->screen, 1, &pos);
}


int
car_centre_x (int x, int longueur_panneau, char * texte)
{
  int longueur_texte = car_longueur_texte (texte);
  return x + (longueur_panneau - longueur_texte) / 2;
}
