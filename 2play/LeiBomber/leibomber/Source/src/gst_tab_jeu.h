#ifndef GST_TAB_JEU
#define GST_TAB_JEU

#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <assert.h>

#include "gst_etre.h"
#include "gst_bombe.h"
#include "gst_obstacle.h"
#include "gst_roquette.h"
#include "gst_monstre.h"

#define NBRE_CASE_X 17
#define NBRE_CASE_Y 13
#define BLESSURE_MONSTRE -20
#define BLESSURE_ROQUETTE -15

typedef enum
{
  enum_vide = 0,
  enum_etre, enum_obstacle, enum_bombe, 
  enum_roquette, enum_monstre,
  nbre_de_elements
} type_enum_elements;

typedef struct type_case type_case;

struct type_case 
{
  type_enum_elements enum_element;
  void * element;
};

typedef struct type_bonus type_bonus;

struct type_bonus 
{
  int nbre_caisses_restantes;
  type_enum_obstacles * repartition_bonus;  
};

#define TYPE_TDJ_CASE_AFFECTE(CASE, TYPE, INFO) \
  {  (CASE).type = TYPE; \
     (CASE).info = INFO; \
  }

/* Chaque case du tableau peut contenir un élément type référencé par *info */
typedef struct type_tdj_case type_tdj_case;

struct type_tdj_case 
{
  int type;
  void * info;
};

typedef struct type_tab_jeu * type_tab_jeu;

struct type_tab_jeu
{
  int pos_pilier;
  type_bonus bonus;
  type_obstacle obstacle;
  type_tdj_case tab [NBRE_CASE_X][NBRE_CASE_Y];
};

/* La variable est globale pour permettre à tout les modules d'utiliser directement tdj */
extern type_tab_jeu tdj;

/* Initialise la variable globale.
 *  pos_pilier = 0 -> les piliers sont sur les rangs pairs, = 1 -> rangs impairs.
 */
extern void tdj_cree (type_obstacle obstacle);

extern void tdj_vide_et_place_piliers (int type_pilier);

extern void tdj_place_caisses_et_bonus (int prcentage_caisse, int prcentage_bonus);

extern void tdj_place_monstres (int nbre);

/* Pour ces 2 fonctions, il faut s'assurer avant que la case était vide */
/* Place cet élément (info, type) dans la case convenant */
extern void tdj_place (void * info, int type);
/* Place cet élément (info, type) dans la case (i, j) qu'on évite de recalculer */
extern void tdj_place_case (int i, int j, void * info, int type);

/* Vide la case */
extern void tdj_vide_case (int i, int j);
extern void tdj_vide (void * info);

/* Vérifie que cet élément est dans la case */
extern int tdj_verifie_case (int i, int j, int type);

/* Retourne 1 si la case est vide */
extern int tdj_case_vide (int i, int j);

/* Affiche et update */
extern void tdj_affiche_obstacles (int avec_alpha);
/* Efface mais n'update pas */
extern void tdj_efface_panneau_de_jeu ();
extern void tdj_update ();
/* Renvoie 1 si l'être à le droit de se déplacer dans cette direction et gère les conséquences */
extern int tdj_position_etre_valide (type_etre etre);

extern int tdj_position_monstre_valide (type_etre etre);

/* Renvoie 1 si la roq à le droit de se déplacer */
extern int tdj_position_roquette_valide (type_roquette roquette);

/* Vérifie qu'une explosion peut avoir lieu et agit en conséquence */
extern int tdj_choc_valide_et_gere (int i, int j);

#endif /* GST_TAB_JEU */
