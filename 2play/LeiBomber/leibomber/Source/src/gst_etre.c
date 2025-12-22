#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <assert.h>
#include <math.h>
#include <string.h>

#include "gst_etre.h"
#include "gst_tab_jeu.h"
#include "gst_caracteres.h"
#include "gst_anim.h"
#include "gst_configure.h"
#include "gst_divers.h"

#define BUFF_MAX 64

enum 
{
  vertical, horizontal
};

static void actualise_taille_image (type_etre etre);

static void update_etre (type_etre etre);

static void centre_position_x (type_etre etre);

static void arrondi_position_x (type_etre etre);

static void etre_meurt (type_etre etre);

static void
fabrique_nom_etre (char * buff, char * debut, int position, int direction) 
{
  sprintf (buff, "./Images/%s%c%d.gif", debut, position + 97, direction);
}

void
re_initialise_position_etre (type_etre etre, int posI, int posJ)
{
  etre->coords.x = etre->coords.y = 0;
  etre->pos.x = posI * 50;
  etre->pos.y = posJ * 50;
  etre->i = posI;
  etre->j = posJ;
  actualise_taille_image (etre);
  centre_position_x (etre);
  etre->ancien_pos = etre->pos;
  if (tdj_verifie_case (posI, posJ, enum_vide))
    tdj_place_case (posI, posJ, etre, enum_etre);
}

void
re_initialise_etre (type_etre etre, int garde_score)
{
  type_arme_joueur bombe = { 1, 1, 350 };
  type_arme_joueur roq = { 1, 1, 150 };
  etre->info.bombe = bombe;
  etre->info.roq = roq;
  etre->info.infos [enum_energy] = config.sante_joueurs;
  if (! garde_score)
    {
      etre->info.infos [enum_score] = 0;
      etre->info.infos [enum_life] = config.vie_joueurs;
    }
  etre->info.malus = 0;
  etre->situation = mouvement;
  etre->position = 0;
  etre->direction = sud;
  etre->repos = 1;
  etre->changement = 1;
}

type_etre
cree_etre (SDL_Surface * screen, SDL_Surface * fondImg,
	   SDLKey mes_touches [nbre_de_actions], 
	   char * debut_nom_fichier, int posI, int posJ, type_position * pos_affichage)
{
  int nbre_positions [nbre_de_situations] = { NBRE_MOUVEMENTS, 2, 1, 5 };
  char nom_fichier [BUFF_MAX];
  int i, j, k, cpt_j = 0;
  Uint32 formatRGB = 0;
  type_etre etre = (type_etre) malloc (sizeof (struct type_etre));
  assert (etre != NULL);
  /* Initialisation des touches */
  for (i = 0; i < nbre_de_actions; i++) 
    {
      /*if (mes_touches != NULL)
	etre->touches_actions [i] = mes_touches [i];*/
	etre->etat_touches [i] = SDL_KEYUP;
      etre->touches_actions = mes_touches;
    }
  /* Pour toutes les situations */
  for (k = 0; k < nbre_de_situations; k++) 
    {
      etre->images [k].nbre_positions = nbre_positions [k];
      /* Pour toutes les directions */
      for (i = 0; i < nbre_de_directions; i++) 
	{
	  etre->images [k].images_situation [i] = 
	    (SDL_Surface * *) malloc (sizeof (SDL_Surface *) * nbre_positions [k]); 
	  /* Pour toutes les positions */
	  for (j = 0; j < nbre_positions [k]; j++) 
	    {
	      SDL_Surface * image;
	      if (k == meurt)
		fabrique_nom_etre (nom_fichier, debut_nom_fichier, cpt_j + j, 0);
	      else
		fabrique_nom_etre (nom_fichier, debut_nom_fichier, cpt_j + j, i);
	      image = img_secure_load (nom_fichier);
	      etre->images [k].images_situation [i][j] = (void *) image;
	      formatRGB = SDL_MapRGB (image->format, 0, 255, 255);
	      SDL_SetColorKey (image, SDL_SRCCOLORKEY, formatRGB);
	    }
	}
      cpt_j += nbre_positions [k];
    }
  /* Attention : les initialisations ont un ordre !! */
  etre->screen = screen;
  etre->fondImg = fondImg;
  re_initialise_etre (etre, 0);
  re_initialise_position_etre (etre, posI, posJ);
  
  if (pos_affichage != NULL)
    for (i = 0; i < NBRE_ETRE_INFO; i++)
      etre->info.pos_affichage [i] = pos_affichage [i];
  else
    etre->info.pos_affichage [0].x = -1;
  return etre;
}

type_etre
cree_joueur (SDL_Surface * screen, SDL_Surface * fondImg,
	     SDLKey mes_touches [nbre_de_actions], 
	     char * debut_nom_fichier, int posI, int posJ, type_position * pos_affichage)
{
  type_etre tmp = cree_etre (screen, fondImg, mes_touches, debut_nom_fichier, posI, posJ, pos_affichage);
  tmp->tdj_position_valide = tdj_position_etre_valide;
  tmp->son_mort = son_joueur_mort;
  tmp->son_blesse = son_joueur_blesse;
  return tmp;
}
     
void
etre_affiche_info (type_etre etre)
{
  int i;
  for (i = 0; i < NBRE_ETRE_INFO; i++)
    {
      car_affiche_nombre (etre->info.pos_affichage [i].x, etre->info.pos_affichage [i].y, 
			  etre->info.infos [i], i == enum_energy);
    }
}

void
etre_efface_info (type_etre etre)
{
  int i;
  for (i = 0; i < NBRE_ETRE_INFO; i++)
    car_efface (etre->info.pos_affichage [i].x, etre->info.pos_affichage [i].y, 5);
}

void 
affiche_etre (type_etre etre)
{
  /*if (etre->repos)
    {
      if (etre->changement)
	etre->changement--;
      else
	if (! tdj_verifie_case (etre->i, etre->j, enum_bombe))
	  return;
	  }*/
  // Efface d'abord l'ancienne image
  SDL_BlitSurface (etre->fondImg, &(etre->ancien_pos), etre->screen, &(etre->ancien_pos));
  
  etre->coords.w = etre->pos.w;
  etre->coords.h = etre->pos.h;
  SDL_BlitSurface (etre->images [etre->situation].images_situation [etre->direction][etre->position],
		   &(etre->coords), etre->screen, &(etre->pos));
  update_etre (etre);
}

static void
update_etre (type_etre etre)
{
  /*int x = etre->pos.x;
  int y = etre->pos.y;
  int w = etre->coords.w + 10;
  int h = etre->coords.h;
  if (etre->ancien_posX > x)
    {
      w += etre->ancien_posX - x;
    }
  else
    {
      w += x - etre->ancien_posX;
      x = etre->ancien_posX;
    }
  if (etre->ancien_posY > y)
    {
      h += etre->ancien_posY - y; 
    }
  else
    {
      h += y - etre->ancien_posY; 
      y = etre->ancien_posY;
    }
    SDL_UpdateRect (screen, x, y, w, h);*/
  SDL_UpdateRect (etre->screen, etre->pos.x, etre->pos.y, etre->pos.w, etre->pos.h);
  SDL_UpdateRect (etre->screen, etre->ancien_pos.x, etre->ancien_pos.y, etre->ancien_pos.w, etre->ancien_pos.h);
  //SDL_UpdateRect (screen, 0, 0, 0, 0);
}

void 
efface_totalement_etre (type_etre etre)
{
  SDL_BlitSurface (etre->fondImg, &(etre->pos), etre->screen, &(etre->pos));
  SDL_BlitSurface (etre->fondImg, &(etre->ancien_pos), etre->screen, &(etre->ancien_pos));
  if (tdj_verifie_case (etre->i, etre->j, enum_etre))
    tdj_place_case (etre->i, etre->j, etre, enum_vide);
  update_etre (etre);
}

/* Sauvegarde les tailles de la nouvelle image */
static void
actualise_taille_image (type_etre etre)
{
  SDL_Surface * image = etre->images [etre->situation].images_situation [etre->direction][etre->position];
  etre->pos.w = image->w;
  etre->pos.h = image->h;
}

/* Modifie la direction, enlève le repos */
void
modifie_direction (type_etre etre, int direction)
{
  etre->repos = 0;
  if (etre->direction == direction)	// si pas de changement de direction, on se déplace tt de suite
    return;
  
  etre->changement = 1;
  etre->direction = direction;
  etre->ancien_pos = etre->pos;
  actualise_taille_image (etre);
  if ((etre->pos.x + etre->pos.w + 2) / 50 != etre->i && 
      ! tdj_case_vide ((etre->pos.x + etre->pos.w + 2) / 50, etre->j))
    arrondi_position_x (etre);
}

// Savari : 06.64.12.70.94

/* Actualise le repos et la direction par rapport aux touches pressées (retourne 1 si une est trouvée) */
static int
recherche_touche_pressee (type_etre etre)
{
  int i;
  if (! etre->situation == mouvement)
    return 0; 
  for (i = 0; i < nbre_de_directions; i++) 
    if (etre->etat_touches [i] == SDL_KEYDOWN)
      {
	modifie_direction (etre, i);
	return 1;
      }
  etre->repos = 1;
  etre->changement = 1;
  return 0;
}

void
actualise_touches_et_actions_etre (type_etre etre, SDLKey touche, int etat) 
{
  int i;

  /* Est-ce que la touche correspond à une action de tir / pose de bombe ? */
  if (etat == SDL_KEYDOWN)
    {
      /* Si occupé, ne peut rien faire */
      if (! etre->situation == mouvement)
	return; 
      
      if (touche == etre->touches_actions [enum_action_pose_bombe])
	{
	  if (etre->info.bombe.restantes)
	    {
	      etre->changement = 1;
	      bmb_pose (&(etre->pos), etre->info.bombe.intensite, 
			etre->info.bombe.delai, &(etre->info.bombe.restantes), etre);
	    }
	  return;
	}
      else if (touche == etre->touches_actions [enum_action_tir_roquette])
	{
	  if (etre->info.roq.restantes)
	    {
	      etre_tir (etre);	// se met en position de tir
	      //roq_lance (etre->i, etre->j, etre->direction, 50, &(etre->info.roq.restantes));
	    }
	  return;
	}
    }
  else if (etat != SDL_KEYUP)	// ce n'est pas un évenement clavier
    return;
  
  /* Est-ce que la touche correspond à un mouvement ? */
  for (i = 0; i < nbre_de_directions; i++) 
    if (etre->touches_actions [i] == touche)
      {
	/* Oui, on change l'état de cette touche */
	etre->etat_touches [i] = etat;
	if (etat == SDL_KEYDOWN)	// Pressée, donc pas en repos
	  modifie_direction (etre, i);
	else	// Relachée, on reprend (si possible) une ancienne touche pressée 
	  recherche_touche_pressee (etre);
      }
}

static void
calcule_position_i (type_etre etre)
{
  etre->i = RINT (etre->pos.x / 50.0);
}

static void
calcule_position_j (type_etre etre)
{
  etre->j = RINT (etre->pos.y / 50.0);
}

static void
arrondi_position_x (type_etre etre)
{
  calcule_position_i (etre);
  if (etre->pos.x % 50 > (50 - etre->pos.w) / 2)	// à droite
    etre->pos.x = etre->i * 50 + 48 - etre->pos.w;
  else
    etre->pos.x = etre->i * 50;
}

static void
centre_position_x (type_etre etre)
{
  calcule_position_i (etre);
  etre->pos.x = etre->i * 50 +
    (50 - etre->images [etre->situation].images_situation [etre->direction][etre->position]->w) / 2;
}

static void 
arrondi_position_y (type_etre etre)
{
  calcule_position_j (etre);
  etre->pos.y = etre->j * 50;
}

void
arrondi_position (type_etre etre)
{
  arrondi_position_x (etre);
  arrondi_position_y (etre);
}

static void 
ajoute_position_x (type_etre etre, int deltaX)
{
  if (etre->info.malus)
    etre->pos.x += deltaX / 3;
  else
    etre->pos.x += deltaX;
  calcule_position_i (etre);
}

static void
ajoute_position_y (type_etre etre, int deltaY)
{
  if (etre->info.malus)
    etre->pos.y += deltaY / 3;
  else
    etre->pos.y += deltaY;
  calcule_position_j (etre);
}

static void
annule_position (type_etre etre)
{
  etre->pos.x = etre->ancien_pos.x;
  etre->pos.y = etre->ancien_pos.y;
  calcule_position_i (etre);
  calcule_position_j (etre);
}

/* Accepte (1) ou refuse (0) la nouvelle position, et positionne convenablement le joueur */
static int
valide_et_gere_deplacement (type_etre etre, int direction)
{
  int pos_modulo50 = (direction == vertical) ? etre->pos.x : etre->pos.y;
  
  if (pos_modulo50 <= 20 || pos_modulo50 >= 35)
    {
      int res;
      if (direction == vertical)
	centre_position_x (etre);
      else
	arrondi_position_y (etre);
      
      if ((res = etre->tdj_position_valide (etre)))
	{
	  if (res == 2 && direction == horizontal)
	    etre->pos.y = etre->ancien_pos.y;
	  return 1;
	}
    }
  annule_position (etre);
  if (direction == vertical)
    arrondi_position_y (etre);
  else
    arrondi_position_x (etre);
  return 0;
}


/* Idée pour le déplacement : selon la direction on modifie la position puis on vérifie 
 * que cette position est valide, sinon, on annule le déplacement.
 *  Retourne 0 s'il y a besoin de changer de direction
 */
int
deplace_etre (type_etre etre) 
{
  if (etre->repos)
    return 2;
  if (etre->changement)
    {
      etre->changement--;
      return 2;
    }
  
  if (etre->situation == mouvement) 
    {
      int res;
      //int deplacement = etre->deplacement [etre->direction][etre->position];
      int deplacement = 10;
      
      if (tdj_verifie_case (etre->i, etre->j, enum_etre))
	tdj_vide_case (etre->i, etre->j);
      
      etre->ancien_pos = etre->pos;
      etre->position = (etre->position + 1) % NBRE_MOUVEMENTS;
      actualise_taille_image (etre);  
	
      switch (etre->direction) 
	{
	case sud : 
	  ajoute_position_y (etre, +deplacement);
	  res = valide_et_gere_deplacement (etre, vertical);
	  break;
	case ouest : 
	  ajoute_position_x (etre, -deplacement);
	  res = valide_et_gere_deplacement (etre, horizontal);
	  break;
	case nord : 
	  ajoute_position_y (etre, -deplacement);
	  res = valide_et_gere_deplacement (etre, vertical);
	  break;
	case est : 
	  ajoute_position_x (etre, +deplacement);
	  res = valide_et_gere_deplacement (etre, horizontal);
	  break;
	default : ;
	}
      if (tdj_verifie_case (etre->i, etre->j, enum_vide))
	tdj_place_case (etre->i, etre->j, etre, enum_etre);
      return res;
    }
  else
    {
      etre->ancien_pos = etre->pos;
      if (++(etre->position) == etre->images [etre->situation].nbre_positions)
	{
	  etre->position = 0;
	  etre->situation = mouvement;
	  recherche_touche_pressee (etre);
	  actualise_taille_image (etre);
	  centre_position_x (etre);
	}
      else
	{
	  if (etre->situation == tir)
	    roq_lance (etre->i, etre->j, etre->direction, 50, &(etre->info.roq.restantes));
	  etre->changement = 1;
	  actualise_taille_image (etre);
	  centre_position_x (etre);
	}
      return 1;
    }
}

void
etre_modifie_score (type_etre etre, int deltaScore)
{
  etre->info.infos [enum_score] += deltaScore;
  car_affiche_nombre (etre->info.pos_affichage [enum_score].x, etre->info.pos_affichage [enum_score].y, 
		      etre->info.infos [enum_score], 0);
  anim_allume_visage ();
}

/* Retourne 1 si le joueur est tjs en vie */
int
etre_modifie_sante (type_etre etre, int deltaSante)
{
  int i = (etre->info.infos [enum_energy] += deltaSante) > 0;
  if (etre->info.pos_affichage [0].x >= 0)	// cé pas beau, mais il est tard et je suis fatigué
    car_affiche_nombre (etre->info.pos_affichage [enum_energy].x, etre->info.pos_affichage [enum_energy].y, 
			etre->info.infos [enum_energy], 1);
  return i;
}

static void
etre_meurt (type_etre etre)
{
  son_joue (etre->son_mort);
  etre->situation = meurt;
  etre->position = 0;
  etre->repos = 0;
  etre->changement = 10;
  etre->ancien_pos = etre->pos;
  actualise_taille_image (etre);
  centre_position_x (etre);
  arrondi_position_y (etre);
  anim_allume_visage ();
}

void
etre_blesse (type_etre etre, int deltaSante)
{
  if (etre->info.infos [enum_energy] < 0)
    return ;
  son_joue (etre->son_blesse);
  etre->situation = blesse;
  etre->position = 0;
  etre->repos = 0;
  etre->changement = 5;
  if (! etre_modifie_sante (etre, deltaSante))
    {
      etre_meurt (etre);
      return ;
    }
  etre->ancien_pos = etre->pos;
  actualise_taille_image (etre);
  centre_position_x (etre);
  arrondi_position_y (etre);
  anim_allume_visage ();
}

void
etre_tir (type_etre etre)
{
  etre->ancien_pos = etre->pos;
  etre->situation = tir;
  etre->changement = 3;
  etre->position = 0;
  etre->repos = 0;  
  actualise_taille_image (etre);
  centre_position_x (etre);
  arrondi_position_y (etre);
}

void 
anime_etre_intro (type_etre etre, int x, int y) 
{
  SDL_Rect dst;
  RECT_AFFECTE (dst, x, y, 50, 50);
  etre->coords.w = 50; 
  etre->coords.h = 50;
  SDL_BlitSurface (etre->images [etre->situation].images_situation [etre->direction][etre->position],
		   &(etre->coords), etre->screen, &dst);
  SDL_UpdateRect (etre->screen, x, y, 50, 50);
  SDL_Delay (450);
  etre->situation = tir;
  etre->direction = (int) (4.0 * rand () / (RAND_MAX + 1.0));
  son_joue (son_etre_mort_intro);
  for (etre->position = 0; etre->position < 2; etre->position++)
    {
      SDL_BlitSurface (etre->fondImg, &dst, etre->screen, &dst);
      SDL_BlitSurface (etre->images [etre->situation].images_situation [etre->direction][etre->position],
		       &(etre->coords), etre->screen, &dst);
      SDL_UpdateRect (etre->screen, x, y, 50, 50);
      SDL_Delay (200);
    }
  etre->situation = mouvement;
  etre->position = 0;
  etre->direction = 0;
}

type_etre
etre_recopie (type_etre etre, int posI, int posJ)
{
  type_etre nouveau = (type_etre) malloc (sizeof (struct type_etre));
  assert (nouveau != NULL);
  nouveau = memcpy (nouveau, etre, sizeof (struct type_etre));
  re_initialise_position_etre (nouveau, posI, posJ);
  return nouveau;
}

int
etre_modifie_vie (type_etre etre)
{
  int i;
  car_affiche_nombre (etre->info.pos_affichage [enum_life].x, etre->info.pos_affichage [enum_life].y, 
		      (i = --(etre->info.infos [enum_life])), 0);
  return i < 0;
}
