#ifndef DOOM_H
#define DOOM_H

#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

#include "gst_directions.h"
#include "gst_sons.h"

#define NBRE_MOUVEMENTS 4
#define NBRE_ETRE_INFO 3	// santé, vie, score

enum 
{
  enum_energy = 0, 
  enum_score, enum_life, 
  nbre_de_info
};

typedef enum
{
  mouvement = 0,
  tir, blesse, meurt,
  nbre_de_situations
} type_situations;

typedef enum
{
  enum_action_pose_bombe = nbre_de_directions,
  enum_action_tir_roquette,
  nbre_de_actions
} type_enum_actions;

typedef struct type_arme_joueur type_arme_joueur;
struct type_arme_joueur 
{
  int restantes;  
  int intensite;
  int delai;
};

/* Structure contenant toutes les images pour une situation donnée */
typedef struct type_tab_images_situation type_tab_images_situation;
struct type_tab_images_situation
{
  /* Pour chaque situation il y a nbre_positions positions  */
  int nbre_positions;
  /* associées à une image */
  SDL_Surface * * images_situation [nbre_de_directions];
};

typedef struct type_info_joueur type_info_joueur;
struct type_info_joueur 
{
  type_arme_joueur bombe;	// données concernant la pose de bombes
  type_arme_joueur roq;		// données concernant le tir de roquettes
  int infos [nbre_de_info];	
  int malus;	// tant que > 0, tout est ralenti
  type_position pos_affichage [nbre_de_info];	// position des infos affichées à l'écran  
};

typedef struct type_etre * type_etre;
/* Fonction (du module gst_tab_jeu de préférence) gérant les croisements 
 * et leurs conséquences sur l'être : par ex, si c'est un joueur, il ramassera les bonus,
 * si c'est un monstre, il les détruira, etc...
 * Renvoie 1 si la nouvelle position est libre, 0 sinon.
 */
typedef int (* type_tdj_position_valide) (type_etre etre);	

struct type_etre 
{
  SDL_Rect pos;	// = position et taille de l'image à un instant t donné 
  SDL_Rect ancien_pos;	// = pos à t - 1
  SDL_Rect coords; // = { 0, 0, ?, ? }
  int i, j;	// position dans le tableau à t
  SDL_Surface * screen, * fondImg;
  SDLKey * touches_actions; // [nbre_de_actions];	// touches dirigeant l'être
  int etat_touches [nbre_de_actions];		// chaque touche peut-être KEYDOWN ou KEYUP
  type_directions direction;	
  type_situations situation;	
  int position;		       
  int changement;	// après un changement (de situation, de position ou de direction), on ne se déplace pas
  int repos;		// en cas de repos et de non changement, on n'affiche plus le joueur
  /* Englobe toutes les images de toutes les situations */
  type_tab_images_situation images [nbre_de_situations];
  type_info_joueur info;
  type_tdj_position_valide tdj_position_valide;
  type_enum_sons son_blesse, son_mort;
};

/* Pour chacune des directions, indiquer : 
 *  - les touches correspondantes, 
 *  - les deplacements entre les 4 positions de mouvement,
 *  - le début du nom du fichier (ex : player/play)
 * Attention : il t a impérativement 4 positions de mvt, 2 de tir, 1 de heurt, 5 de mort
 */
extern type_etre
cree_joueur (SDL_Surface * screen, SDL_Surface * fondImg,
	     SDLKey mes_touches [nbre_de_actions], 
	     char * debut_nom_fichier, int posI, int posJ, type_position * pos_affichage);	     

/* A considérer comme protected ! */
extern type_etre
cree_etre (SDL_Surface * screen, SDL_Surface * fondImg,
	   SDLKey mes_touches [nbre_de_actions], 
	   char * debut_nom_fichier, int posI, int posJ, type_position * pos_affichage);
	   

/* Pret pour un nouveau départ */
extern void re_initialise_etre (type_etre etre, int garde_score);
extern void re_initialise_position_etre (type_etre etre, int posI, int posJ);

/* A considérer comme protected ! efface et update */
extern void efface_totalement_etre (type_etre etre);

/* Le nouvel être ne partage que les touches et les images avec l'original *
 * Il est placé à de nouvelles coodronnées (posI, posJ) */
extern type_etre etre_recopie (type_etre etre, int posI, int posJ);

/* Les deux opposés */
extern void etre_affiche_info (type_etre etre);
extern void etre_efface_info (type_etre etre);

extern void affiche_etre (type_etre etre);

/* Gere l'état et ses conséquences (changement de direction par ex) de la touche passée en paramètre */
extern void actualise_touches_et_actions_etre (type_etre etre, SDLKey touche, int etat);

extern void ajoute_position (type_etre etre, int deltaX, int deltaY);

extern void modifie_position (type_etre etre);

extern void modifie_direction (type_etre etre, int direction);

extern int deplace_etre (type_etre etre);

extern void arrondi_position (type_etre etre);

extern void etre_modifie_score (type_etre etre, int deltaScore);

/* Retourne 1 si tjrs en vie */
extern int etre_modifie_sante (type_etre etre, int deltaSante);

extern int etre_modifie_vie (type_etre etre);

extern void etre_blesse (type_etre etre, int deltaSante);

extern void etre_tir (type_etre etre);

extern void anime_etre_intro (type_etre etre, int x, int y);

#endif /* DOOM_H */
