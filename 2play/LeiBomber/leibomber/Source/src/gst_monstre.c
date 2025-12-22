#include <SDL/SDL.h>
#include <SDL/SDL_thread.h>

#include "gst_monstre.h"
#include "gst_etre.h"
#include "gst_tab_jeu.h"
#include "gst_configure.h"
#include "gst_sons.h"

#define TAB_MIN 8

/* Idée : un monstre est un être qui a quelques particularités (il peut aller + ou - vite, pas de touches
   de directions, etc...). Un fonction spéciale (tdj_position_monstre_valide) s'occupe de gérer ses actions,
   et indique si l'on doit changer de direction.
   
   Lorsque la partie se termine, il faut supprimer les threads de monstres, c'est pourquoi on garde
   dans un tableau dynamique les pointeurs de thread. Lorsqu'un monstre meurt, il met sa case
   appropriée à NULL, ce qui le distingue des threads encore vivants.
   Avec monstre_desactive_tous, on détruit les threads et on réinitialise le tableau.
*/

typedef struct type_monstres_actifs * type_monstres_actifs;
typedef struct type_monstre * type_monstre;

static type_etre monstre_de_base = NULL;
static type_monstres_actifs monstres_actifs = NULL;

struct type_monstre 
{
  int delai;
  int cpt, cpt_max;	// pour le changement de direction
  type_etre etre;
  int * remet_a_zero_quand_meurt;
};

struct type_monstres_actifs
{
  int tab_pos;
  int tab_max;
  int * tab;
};

static 
void monstres_actifs_cree ()
{
  monstres_actifs = (type_monstres_actifs) malloc (sizeof (struct type_monstres_actifs));
  assert (monstres_actifs != NULL);
  monstres_actifs->tab_pos = 0;
  monstres_actifs->tab_max = TAB_MIN;
  monstres_actifs->tab = calloc (sizeof (int), TAB_MIN);
}

void
monstre_cree (SDL_Surface * screen, SDL_Surface * fondImg)
{
  monstre_de_base = cree_etre (screen, fondImg, NULL, CHEMIN_MONSTRE, 0, 0, NULL);
  monstre_de_base->tdj_position_valide = tdj_position_monstre_valide;
  monstre_de_base->repos = 0;
  monstre_de_base->son_mort = son_monstre_mort;
  monstre_de_base->son_blesse = son_monstre_blesse;
  monstre_de_base->info.infos [enum_energy] = config.sante_monstre;

  monstres_actifs_cree ();
}


static void
monstre_change_direction (type_monstre monstre)
{
  type_directions direction = monstre->etre->direction;
  if (++direction == nbre_de_directions)
    direction = 0;
  
  // on tente le coup avec cette nouvelle direction
  modifie_direction (monstre->etre, direction);
}

static int
monstre_thread_fct (void * info)
{
  type_monstre monstre = (type_monstre) info;
  type_etre etre = monstre->etre;
  while (*(monstre->remet_a_zero_quand_meurt))
    {
      affiche_etre (etre);
      
      do
	SDL_Delay (monstre->delai);
      while (*(monstre->remet_a_zero_quand_meurt) == MONSTRE_IMMOBILE);
      if (! --monstre->cpt)
	{
	  monstre->cpt = monstre->cpt_max + (10.0 * rand () / (RAND_MAX + 1.0)); 
	  monstre_change_direction (monstre);
	  affiche_etre (etre);
	}
      if (! deplace_etre (etre) || etre->repos)
	{
	  if (etre->info.infos [enum_energy] <= 0)
	    break;
	  affiche_etre (etre);
	  monstre_change_direction (monstre);
	}
    }
  *(monstre->remet_a_zero_quand_meurt) = 0;
  efface_totalement_etre (monstre->etre);
  free (info);
  /* Adieu beau monstre ;-) */
  return 0;
}

int *
monstre_ajoute_monstre_actif ()
{
  monstres_actifs->tab [monstres_actifs->tab_pos] = MONSTRE_MOBILE;
  if (++(monstres_actifs->tab_pos) == monstres_actifs->tab_max)
    {
      monstres_actifs->tab = (int *) 
	realloc (monstres_actifs->tab, (monstres_actifs->tab_max *= 2) * sizeof (int));
    }
  return &(monstres_actifs->tab [monstres_actifs->tab_pos - 1]);
}

void
monstre_active (int i, int j, int delai, int cpt)
{
  type_monstre monstre = (type_monstre) malloc (sizeof (struct type_monstre));
  type_etre etre = etre_recopie (monstre_de_base, i, j);
  son_joue (son_monstre_apparition);
  monstre->delai = delai;  
  monstre->cpt = monstre->cpt_max = cpt;  
  monstre->etre = etre;
  monstre->remet_a_zero_quand_meurt = monstre_ajoute_monstre_actif ();
  
  SDL_CreateThread (monstre_thread_fct, (void *) monstre);
}

void
monstre_desactive_tous ()
{
  int i;
  for (i = 0; i < monstres_actifs->tab_pos; i++)
    if (monstres_actifs->tab [i] != 0)
      monstres_actifs->tab [i] = 0;
  
  SDL_Delay (300);	// on attend que les monstres aient bien compris l'ordre !
  
  free (monstres_actifs);
  monstres_actifs_cree ();
}

void
monstre_modifie_mouvement_tous (type_mouvement_monstres mvt)
{
  int i;
  for (i = 0; i < monstres_actifs->tab_pos; i++)
    if (monstres_actifs->tab [i] != 0)
      monstres_actifs->tab [i] = (mvt == mobilise_monstres ? MONSTRE_MOBILE : MONSTRE_IMMOBILE);
  
  SDL_Delay (300);	// on attend que les monstres aient bien compris l'ordre !
}
