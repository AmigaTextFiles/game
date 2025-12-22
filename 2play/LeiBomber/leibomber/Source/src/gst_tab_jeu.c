#include "gst_tab_jeu.h"
#include "gst_sons.h"
#include "gst_divers.h"

typedef struct type_elementaire * type_elementaire;

struct type_elementaire
{
  SDL_Rect pos;
};


/* Variable globale du tableau de jeu */
type_tab_jeu tdj;

static int tdj_obstacle_choque (type_un_obstacle obstacle);

void
tdj_cree (type_obstacle obstacle)
{
  tdj = (type_tab_jeu) malloc (sizeof (struct type_tab_jeu));
  assert (tdj != NULL);
  tdj->obstacle = obstacle;
}

void
tdj_vide_et_place_piliers (int pos_pilier)
{
  int i, j;
  tdj->pos_pilier = pos_pilier;
  for (i = 0; i < NBRE_CASE_X; i++)
    for (j = 0; j < NBRE_CASE_Y; j++)
      {
	type_enum_elements el = nbre_de_elements;
	if (i == 0 || i == NBRE_CASE_X - 1 || j == 0 || j == NBRE_CASE_Y - 1)	// on pose les bordures
	  {
	    if ((int) (3.0 * rand () / (RAND_MAX + 1.0)) == 0)
	      el = pierre;
	    else
	      el = metal;
	  }
	else if (i % 2 == pos_pilier && j % 2 == pos_pilier)	// on pose les piliers
	  el = brique;
	else
	  {
	    type_tdj_case tmp = { enum_vide, NULL };
	    tdj->tab [i][j] = tmp;	// zone vide
	    continue;
	  }
	tdj_place_case (i, j, (void *) obs_cree_un_obstacle (tdj->obstacle, el, i * 50, j * 50), enum_obstacle);
      }
}

/* Principe : à partir du nombre de caisses voulues, on remplit le tableau de façon aléatoire.
 * A chaque caisse, on associe une case du tableau repartition_bonus qui indique en quoi sera
 * transformé cette caisse lorsqu'elle aura été explosée (0 = détruite).
 */
void
tdj_place_caisses_et_bonus (int prcentage_caisse, int prcentage_bonus)
{
  int cpt;
  /* Nbre de cases dispo = tableau sans bords - piliers */
  int nbre_caisses = (((NBRE_CASE_X - 2) * (NBRE_CASE_Y - 2) - 
		       ((NBRE_CASE_X - 1) / 2 * (NBRE_CASE_Y - 1) / 2)) 
		      / 100.0 * (double) prcentage_caisse);
  int nbre_bonus = nbre_caisses / 100.0 * (double) prcentage_bonus;
  int i, j;
  tdj->bonus.repartition_bonus = (type_enum_obstacles *) calloc (sizeof (int), nbre_caisses);
  tdj->bonus.nbre_caisses_restantes = nbre_caisses;
  for (cpt = 0; cpt < nbre_bonus; cpt++)
    {
      do
	i = (int) ((double) nbre_caisses * rand () / (RAND_MAX + 1.0));
      while (tdj->bonus.repartition_bonus [i] != 0);
      tdj->bonus.repartition_bonus [i] = (cpt % 5) + bonus_bombe;
    }
  for (cpt = 0; cpt < nbre_caisses + 5; cpt++)
    {
      type_enum_elements el;
      do 
	{
	  i = 1 + (int) ((double) (NBRE_CASE_X - 2) * rand () / (RAND_MAX + 1.0));
	  j = 1 + (int) ((double) (NBRE_CASE_Y - 2)* rand () / (RAND_MAX + 1.0));
	}
      while (! tdj_case_vide (i, j) ||
	     (i >= 1 && j >= 2 && i <= 2 && j <= 3) ||
	     (i >= NBRE_CASE_X - 3 && (j == NBRE_CASE_Y - 4 || j == NBRE_CASE_Y - 3)));
      el = (cpt >= nbre_caisses) ? calcaire : caisse;
      tdj_place_case (i, j, (void *) obs_cree_un_obstacle (tdj->obstacle, el, i * 50, j * 50), enum_obstacle);
    }
}

void
tdj_place_monstres (int nbre)
{
  int i, j, cpt;
  int nbre_places_libres = 0;
  type_position * places_libres = (type_position *) malloc (sizeof (type_position) * NBRE_CASE_X * NBRE_CASE_Y);
  
  /* Recherche toutes les places libres */
  for (i = 0; i < NBRE_CASE_X; i++)
    for (j = 0; j < NBRE_CASE_Y; j++)
      if (! (! tdj_case_vide (i, j) || (i >= 1 && j >= 2 && i <= 2 && j <= 3) ||
	     (i >= NBRE_CASE_X - 3 && (j == NBRE_CASE_Y - 4 || j == NBRE_CASE_Y - 3))))
	{
	  type_position tmp;
	  tmp.x = i;
	  tmp.y =j;
	  places_libres [nbre_places_libres++] = tmp;
	}
	  
  
  if (nbre > nbre_places_libres)
    nbre = nbre_places_libres;

  for (cpt = 0; cpt < nbre; cpt++)
    {
      do
	{
	  int place = (int) ((double) (nbre_places_libres) * rand () / (RAND_MAX + 1.0));
	  i = places_libres [place].x;
	  j = places_libres [place].y;
	}
      while (! tdj_case_vide (i, j));
      monstre_active (i, j, 150, 25);
    }
}

void
tdj_place_case (int i, int j, void * info, int type)
{
  type_tdj_case tmp;
  tmp.type = type;
  tmp.info = info;
  tdj->tab [i][j] = tmp;
}

void
tdj_place (void * info, int type)
{
  type_tdj_case tmp;
  tmp.type = type;
  tmp.info = info;
  tdj->tab [((type_elementaire) info)->pos.x / 50][((type_elementaire) info)->pos.y / 50] = tmp;    
}

int
tdj_case_vide (int i, int j)
{
  return tdj->tab [i][j].type == enum_vide;
}

void
tdj_vide_case (int i, int j)
{
  tdj->tab [i][j].type = enum_vide;
}

void
tdj_vide (void * info)
{
  tdj->tab [((type_elementaire) info)->pos.x / 50][((type_elementaire) info)->pos.y / 50].type = enum_vide; 
}

int
tdj_verifie_case (int i, int j, int type)
{
  return tdj->tab [i][j].type == type;
}

void
tdj_affiche_obstacles (int avec_alpha)
{
  int alpha;
  int i, j;
  for (alpha = 0; alpha <= 250; alpha += 40)
    {
      for (i = 0; i < NBRE_CASE_X; i++)
	for (j = 0; j < NBRE_CASE_Y; j++)
	  if (tdj->tab [i][j].type == enum_obstacle)
	    {
	      type_un_obstacle obs = (type_un_obstacle) tdj->tab [i][j].info;
	      if (avec_alpha && obs->type >= calcaire)
		SDL_SetAlpha (obs->surfaces->images [obs->type], SDL_SRCALPHA, alpha);
	      if (obs->type >= calcaire || alpha == 0)
		affiche_un_obstacle (obs);
	    }
      if (! avec_alpha)
	break;
      SDL_Delay (70);
    }
  tdj_update ();
}


/* Quand un obstacle est choqué, il peut être transformé en bonus, être détruit ou rester tel qu'il est */
/* Retourne 1 si l'obstacle doit être élimié */
static int
tdj_obstacle_choque (type_un_obstacle obs)
{
  if (obs->type == caisse)	// caisse
    {
      /* Si cette caisse n'a pas été choisie pour devenir un bonus, on retourne 1 pour la détruire */
      if ((obs->type = (tdj->bonus.repartition_bonus [--(tdj->bonus.nbre_caisses_restantes)])) == 0)
      	return 1;			
      efface_un_obstacle (obs);
      affiche_un_obstacle (obs);	// affiche le nouveau bonus à garder
      return 0;
    } 
  if (obs->type == calcaire)
    return ((int) (10.0 * rand () / (RAND_MAX + 1.0)) == 0);
  if (obs->type >= bonus_bombe)		// bonus à détruire 
    return 1;
  return 0;
}

static void
tdj_supprime_un_obstacle (int i, int j, type_un_obstacle obs)
{
  efface_un_obstacle (obs);
  free (obs);
  tdj_vide_case (i, j);
}

/* Vérifie qu'une explosion peut avoir lieu (retourne 1) et agit en conséquence, sinon retourne 0 */
int
tdj_choc_valide_et_gere (int i, int j)
{
  type_enum_elements type;
  if ((type = tdj->tab [i][j].type) != enum_vide)	// la case est utilisée, voyons se qu'il y a dedans
    {
      void * info = tdj->tab [i][j].info;
      if (type == enum_obstacle && tdj_obstacle_choque ((type_un_obstacle) info))	// obstacle détruit 
	tdj_supprime_un_obstacle (i, j, (type_un_obstacle) info);
      else if (type == enum_bombe && ((type_bombe_posable) info)->position < BMB_NBRE_IMAGES - 3)
	((type_bombe_posable) info)->position = BMB_NBRE_IMAGES - 3;
      else if (type == enum_etre)
	{
	  /* Etre touché ou ne pas être ;-) */
	  etre_blesse ((type_etre) info, -25);
	}
      return 0;		// l'explosion s'arrête à cette case
    }
  return 1;
}

/* Renvoie la position à examiner selon la direction du mouvement de l'élément */
/* S'il va vers l'est par ex, on examine le point au milieu du côté droit */
static void
tdj_position_avant (SDL_Rect * pos, int *posX, int *posY, type_directions direction)
{
  if (direction == nord)
    {
      *posX = pos->x + pos->w / 2;; 
      *posY = pos->y; 
    } else if (direction == sud)
      {
	*posX = pos->x + pos->w / 2;
	*posY = pos->y + pos->h - 1;
      } else if (direction == ouest)
	{
	  *posX = pos->x;
	  *posY = pos->y + pos->h / 2;
	} else 
	  {
	    *posX = pos->x + pos->w - 1;
	    *posY = pos->y + pos->h / 2;
	  }
}

/* Retourne >= 1 si cette position est possible :
 * Lorsqu'un être se déplace, on vérifie uniquement la case vers laquelle il s'avance ;
 * Un être peut se déplacer dans sa case même si elle est occupée (retourne 2), cela lui permet d'en
 * sortir sans pouvoir y re-entrer :-)
 */
int
tdj_position_etre_valide (type_etre etre)
{
  int type;
  int i, j;
  
  tdj_position_avant (&(etre->pos), &i, &j, etre->direction);  
  i /= 50;
  j /= 50;
  if (i == etre->ancien_pos.x / 50 && j == etre->ancien_pos.y / 50)
    return 2;
  if ((type = tdj->tab [i][j].type) != enum_vide)
    {
      void * info = tdj->tab [i][j].info;
      if (type == enum_obstacle && ((type_un_obstacle) info)->type >= bonus_bombe)
	{
	  /* On a ramassé un bonus, on doit ensuite le supprimer */
	  son_joue (son_bonus_ramasse);
	  etre->info.malus = 0;
	  etre_modifie_score (etre, 50);
	  if (((type_un_obstacle) info)->type == bonus_bombe)
	    etre->info.bombe.restantes++;
	  else if (((type_un_obstacle) info)->type == bonus_poudre)
	    etre->info.bombe.intensite++;
	  else if (((type_un_obstacle) info)->type == bonus_armure)
	    etre_modifie_sante (etre, 25);
	  else if (((type_un_obstacle) info)->type == bonus_roquette)
	    etre->info.roq.restantes++;
	  else
	    etre->info.malus = 1;
	    
	  tdj_supprime_un_obstacle (i, j, (type_un_obstacle) info);
	  return 1;
	}
      /* On a rencontré un obstacle qui n'était pas un bonus */
      return 0;
    }
  return 1;
}

int
tdj_position_monstre_valide (type_etre etre)
{
  int type;
  int i, j;
  
  tdj_position_avant (&(etre->pos), &i, &j, etre->direction);  
  i /= 50;
  j /= 50;
  if (i == etre->ancien_pos.x / 50 && j == etre->ancien_pos.y / 50)
    return 2;
  if ((type = tdj->tab [i][j].type) != enum_vide)
    {
      void * info = tdj->tab [i][j].info;
      if (type == enum_etre)
	{
	  son_joue (son_monstre_frotte);
	  etre_blesse ((type_etre) info, BLESSURE_MONSTRE);
	}
      else if (type == enum_obstacle && ((type_un_obstacle) info)->type >= bonus_bombe)
	{
	  tdj_supprime_un_obstacle (i, j, (type_un_obstacle) info);
	  return 1;
	}
      /* On a rencontré un obstacle qui n'était pas un bonus */
      return 0;
    }
  return 1;
}

int 
tdj_position_roquette_valide (type_roquette roquette)
{
  int type;
  int i, j;

  tdj_position_avant (&(roquette->pos), &i, &j, roquette->direction);
  if (i == roquette->pos.x / 50 && j == roquette->pos.y / 50)	// la roquette n'a pas changé de case
    return 1;
  
  i /= 50;
  j /= 50;

  if ((type = tdj->tab [i][j].type) != enum_vide)
    {
      void *info = tdj->tab [i][j].info;
      if (type == enum_obstacle && ((type_un_obstacle) info)->type >= bonus_bombe)
	tdj_supprime_un_obstacle (i, j, (type_un_obstacle) info);
      else if (type == enum_bombe && ((type_bombe_posable) info)->position < BMB_NBRE_IMAGES - 3)
	((type_bombe_posable) info)->position = BMB_NBRE_IMAGES - 3;
      else if (type == enum_etre)
	{
	  /* Etre touché ou ne pas être ;-) */
	  etre_blesse ((type_etre) info, BLESSURE_ROQUETTE);
	}
      return 0;
    }
  return 1;
}

void
tdj_update ()
{
  SDL_Rect src;
  RECT_AFFECTE (src, 0, 0, NBRE_CASE_X * 50, NBRE_CASE_Y * 50);
  SDL_UpdateRects (tdj->obstacle->screen, 1, &src);
}

void
tdj_efface_panneau_de_jeu ()
{
  SDL_Rect src;
  RECT_AFFECTE (src, 0, 0, NBRE_CASE_X * 50, NBRE_CASE_Y * 50);
  SDL_BlitSurface (tdj->obstacle->fondImg, &src, tdj->obstacle->screen, &src);
}
