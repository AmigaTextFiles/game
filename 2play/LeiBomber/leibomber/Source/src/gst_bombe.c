#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_thread.h>
#include <math.h>

#include "gst_bombe.h"
#include "gst_sons.h"
#include "gst_divers.h"

#define BUFF_MAX 64

static type_bombe bmb_tab;

/* Idée : 
 * bombe_posable = bombe compléte (avec les images et les positions)
 * On créé lors de l'initialisation un tableau de bombes posables pour éviter une allocation dynamique.
 * Un curseur sur le tableau indique quelle case est disponible. Pour poser une bombe,
 * on initialise la case porposée et on la passe au thread.
 */


/* ------------------------------- */
/* Prototype des fonctions privées */
/* ------------------------------- */

static void bmb_update (type_bombe_posable bombe_posable);

/* Pour la bombe centrale */
static void bmb_affiche (type_bombe_posable bombe_posable);

/* Pour la bombe centrale */
static void bmb_efface (type_bombe_posable bombe_posable);

/* Remet fondImg comme il était et efface l'onde de choc */
static void bmb_efface_tout (type_bombe_posable bombe_posable);

static void bmb_affiche_choc (type_bombe_posable bombe_posable);

static void bmb_efface_choc (type_bombe_posable bombe_posable);

static void bmb_applique_onde_choc (type_bombe_posable bombe_posable, void (* fct) (type_bombe_posable bombe_posable));

static int bmb_active (void * b);

static void fabrique_nom_bombe (char * buff, int position);


/* ---------------------------- */
/* Implémentation des fonctions */
/* ---------------------------- */

static void
fabrique_nom_bombe (char * buff, int position) 
{
  sprintf (buff, "./Images/bombe/bombe0%d.gif", position);
}


void
bmb_cree (SDL_Surface * screen, SDL_Surface * fondImg)
{
  int i;
  char nom_fichier [BUFF_MAX];
  Uint32 formatRGB = 0;
  type_bombe_surfaces surfaces = (type_bombe_surfaces) malloc (sizeof (struct type_bombe_surfaces));
  bmb_tab = (type_bombe) malloc (sizeof (struct type_bombe));
  assert (bmb_tab != NULL);
  assert (surfaces != NULL);
  /* Charge les surfaces et leurs info, partagées par toutes les bombes posables */
  for (i = 0; i < BMB_NBRE_IMAGES; i++) 
    {
      SDL_Surface * image;
      fabrique_nom_bombe (nom_fichier, i);
      image = IMG_Load (nom_fichier);
      assert (image != NULL);
      surfaces->images [i] = image;
      formatRGB = SDL_MapRGB (image->format, 0, 255, 255);
      SDL_SetColorKey (image, SDL_SRCCOLORKEY, formatRGB);
    }
  RECT_AFFECTE ((*surfaces).coords, 0, 0, surfaces->images [0]->w, surfaces->images [0]->h);
  surfaces->screen = screen;
  surfaces->fondImg = fondImg;
  bmb_tab->tab_debut = 0;
  /* Initialisation des bombes posables */
  for (i = 0; i < BOMBES_MAX; i++)
    {
      bmb_tab->bombes [i] = (type_bombe_posable) malloc (sizeof (struct type_bombe_posable));
      bmb_tab->bombes [i]->surfaces = surfaces;
      bmb_tab->bombes [i]->ancienFondImg = SDL_AllocSurface (SDL_HWSURFACE, surfaces->coords.w, surfaces->coords.h, 
							  screen->format->BitsPerPixel,
							  screen->format->Rmask, screen->format->Gmask,
							  screen->format->Bmask, screen->format->Amask);
    }
}

void
bmb_pose (SDL_Rect * pos, int intensite, int delai, int * compteur, type_etre poseur)
{
  /* Case où doit être posée la bombe */
  int i = RINT (pos->x / 50.0);	
  int j = RINT (pos->y / 50.0);
  if (tdj_case_vide (i, j) || tdj_verifie_case (i, j, enum_etre))	// la case est vide, on y va
    {
      SDL_Thread * thread_bombe_posable;
      type_bombe_posable bombe_posable = bmb_tab->bombes [bmb_tab->tab_debut];
      son_joue (son_bombe_pose);
      (*compteur)--;
      bombe_posable->compteur = compteur;
      bombe_posable->intensite [0] = intensite;
      bombe_posable->delai = delai;
      bombe_posable->poseur = poseur;
      RECT_AFFECTE ((*bombe_posable).pos, i * 50, j * 50,
		   bombe_posable->surfaces->coords.w, bombe_posable->surfaces->coords.h); 
      SDL_BlitSurface (bombe_posable->surfaces->fondImg, &(bombe_posable->pos), 
		       bombe_posable->ancienFondImg, &(bombe_posable->surfaces->coords));
      bmb_tab->tab_debut = (bmb_tab->tab_debut + 1) % BOMBES_MAX;
      tdj_place_case (i, j, bombe_posable, enum_bombe);	// on remplit la case 
      thread_bombe_posable = SDL_CreateThread (bmb_active, (void *) bombe_posable); 
    }
}

static void 
bmb_update (type_bombe_posable bombe_posable) 
{
  SDL_UpdateRects (bombe_posable->surfaces->screen, 1, &(bombe_posable->pos));
}

/* Pour la bombe centrale */
static void 
bmb_affiche (type_bombe_posable bombe_posable) 
{
  SDL_Surface * image = bombe_posable->surfaces->images [bombe_posable->position];
  SDL_BlitSurface (image, &(bombe_posable->surfaces->coords), 
		   bombe_posable->surfaces->screen, &(bombe_posable->pos));
  SDL_BlitSurface (image, &(bombe_posable->surfaces->coords), 
		   bombe_posable->surfaces->fondImg, &(bombe_posable->pos));
  bmb_update (bombe_posable);
}

/* Pour la bombe centrale */
static void 
bmb_efface (type_bombe_posable bombe_posable)
{
  SDL_BlitSurface (bombe_posable->ancienFondImg, &(bombe_posable->surfaces->coords), 
		   bombe_posable->surfaces->screen, &(bombe_posable->pos));
}

/* Remet fondImg comme il était et efface l'onde de choc */
static void
bmb_efface_tout (type_bombe_posable bombe_posable)
{
  SDL_BlitSurface (bombe_posable->ancienFondImg, &(bombe_posable->surfaces->coords), 
		   bombe_posable->surfaces->fondImg, &(bombe_posable->pos));
  SDL_BlitSurface (bombe_posable->ancienFondImg, &(bombe_posable->surfaces->coords), 
		   bombe_posable->surfaces->screen, &(bombe_posable->pos));
  bmb_update (bombe_posable);
}

static void
bmb_affiche_choc (type_bombe_posable bombe_posable)
{
  SDL_Surface * image = bombe_posable->surfaces->images [bombe_posable->position];
  SDL_BlitSurface (image, &(bombe_posable->surfaces->coords), 
		   bombe_posable->surfaces->screen, &(bombe_posable->pos));
  bmb_update (bombe_posable);
}

static void 
bmb_efface_choc (type_bombe_posable bombe_posable)
{
  SDL_BlitSurface (bombe_posable->surfaces->fondImg, &(bombe_posable->pos), 
		   bombe_posable->surfaces->screen, &(bombe_posable->pos));
}


static void
bmb_applique_onde_choc (type_bombe_posable bombe_posable, void (* fct) (type_bombe_posable bombe_posable))
{
  int cpt, deltaI, deltaJ;
  int posX = bombe_posable->pos.x;
  int posY = bombe_posable->pos.y;
  int direction;

  for (direction = 0; direction < 4; direction++)
    {
      if (direction % 2 == 0)
	{
	  deltaI = 0; 
	  deltaJ = (1 - direction);// == 0 ? 1 : -1);
	}
      else 
	{
	  deltaI = (direction == 1 ? -1 : 1);
	  deltaJ = 0;
	}
      for (cpt = 1; cpt <= bombe_posable->intensite [direction]; cpt++)
	{
	  bombe_posable->pos.x = posX + 50 * cpt * deltaI;
	  bombe_posable->pos.y = posY + 50 * cpt * deltaJ;
	  fct (bombe_posable);
	}
    }
  bombe_posable->pos.x = posX;
  bombe_posable->pos.y = posY;
}

/* Remplit le tableau d'intensité et passe la gestion des conséquences sur les obstacles à tdj_choc_valide_et_gere */
static void 
bmb_calcule_intensite_et_gere (type_bombe_posable bombe_posable)
{
  int i = bombe_posable->pos.x / 50;
  int j = bombe_posable->pos.y / 50;
  int deltaI, deltaJ;
  int cpt, direction;
  int intensite_max = bombe_posable->intensite [0];
  for (direction = 0; direction < 4; direction++)
    {
      if (direction % 2 == 0)
	{
	  deltaI = 0; 
	  deltaJ = (1 - direction);// == 0 ? 1 : -1);
	}
      else 
	{
	  deltaI = (direction == 1 ? -1 : 1);
	  deltaJ = 0;
	}
      for (cpt = 1; cpt <= intensite_max; cpt++)
	if (! tdj_choc_valide_et_gere (i + cpt * deltaI, j + cpt * deltaJ))
	    break;
      bombe_posable->intensite [direction] = cpt - 1;
    }
}

static void
bmb_gere_explosion_centrale (type_bombe_posable bombe_posable)
{
  if (bombe_posable->poseur->i == bombe_posable->pos.x / 50 &&
      bombe_posable->poseur->j == bombe_posable->pos.y / 50)
    {
      etre_blesse (bombe_posable->poseur, -50);
      tdj_place_case (bombe_posable->poseur->i, bombe_posable->poseur->j, bombe_posable->poseur, enum_etre); 
    }
}

static int
bmb_active (void * b)
{
  type_bombe_posable bombe_posable = (type_bombe_posable) b;
  int * position = &(bombe_posable->position);
  for (*position = 0; *position < BMB_NBRE_IMAGES; (*position)++)
    {
      bmb_affiche (bombe_posable);
      if (*position >= BMB_NBRE_IMAGES - 2)	// Explosion !
	{
	  if (*position == BMB_NBRE_IMAGES - 2)
	    {
	      son_joue (son_bombe_explose);
	      tdj_vide (bombe_posable);
	      bmb_gere_explosion_centrale (bombe_posable);
	      bmb_calcule_intensite_et_gere (bombe_posable);
	    }
	  bmb_applique_onde_choc (bombe_posable, bmb_affiche_choc);
	}
      SDL_Delay (((type_bombe_posable) bombe_posable)->delai);
      bmb_efface (bombe_posable);
      if (*position >= BMB_NBRE_IMAGES - 2)	// Explosion !
	bmb_applique_onde_choc (bombe_posable, bmb_efface_choc);
    }
  bmb_efface_tout (bombe_posable);
  bmb_applique_onde_choc (bombe_posable, bmb_update);
  (*(bombe_posable->compteur))++;
  bombe_posable->pos.x = 0;
  bombe_posable->pos.y = 0;
  return 0;
}


/* Explosion réservée à l'intro */

static int
bmb_active_intro (void * b)
{
  type_bombe_posable bombe_posable = (type_bombe_posable) b;
  
  son_joue (son_bombe_explose);
  
  for (bombe_posable->position = BMB_NBRE_IMAGES - 2; bombe_posable->position < BMB_NBRE_IMAGES; 
       (bombe_posable->position)++)
    {
      bmb_affiche (bombe_posable);
      SDL_Delay (((type_bombe_posable) bombe_posable)->delai);
      bmb_efface (bombe_posable);
    }
  bmb_efface_tout (bombe_posable);
  return 0;
}

extern 
void bmb_pose_intro (int x, int y, int delai)
{
  SDL_Thread * thread_bombe_posable;
  type_bombe_posable bombe_posable = bmb_tab->bombes [bmb_tab->tab_debut];
  bombe_posable->delai = delai;
  RECT_AFFECTE ((*bombe_posable).pos, x, y,
		bombe_posable->surfaces->coords.w, bombe_posable->surfaces->coords.h); 
  SDL_BlitSurface (bombe_posable->surfaces->fondImg, &(bombe_posable->pos), 
		   bombe_posable->ancienFondImg, &(bombe_posable->surfaces->coords));
  bmb_tab->tab_debut = (bmb_tab->tab_debut + 1) % BOMBES_MAX;
  thread_bombe_posable = SDL_CreateThread (bmb_active_intro, (void *) bombe_posable); 
}
