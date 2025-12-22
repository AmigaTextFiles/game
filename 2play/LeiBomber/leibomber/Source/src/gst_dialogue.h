#ifndef GST_DIALOGUE_H
#define GST_DIALOGUE_H

#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <stdarg.h> 

#define ACCES_DIALOGUE "./Images/dialogue/"
#define PANNEAU_DIALOGUE "dialogue3.gif"
#define CHOIX_DIALOGUE "choix .gif"
#define CHIFFRE_CHOIX 5
#define NBRE_CHOIX 2
#define FLAMMES_DIALOGUE "f .gif"
#define CHIFFRE_FLAMMES 1
#define NBRE_FLAMMES 4
#define DELAI_FLAMMES 150

#define ECART_MARGE_Y 10	// écart Y entre le haut du panneau et la première ligne
#define ECART_MARGE_X 30	// écart X entre la gauche du panneau et le début des lignes
#define ECART_CHOIX_MARGE_X 50	// marge X des choix du menu

#define DIALOGUE_TEXTE_DELAI_FRAPPE 40
#define DIALOGUE_SAISIE_DELAI_FRAPPE 25

typedef enum
{
  saisie_key = 0,	// saisie d'une touche
  saisie_num,		// saisie de chiffres
  saisie_alphanum	// saisie lettres et chiffres
} type_saisie;

/* Notice du'utilisation :
 * _ une fois, au début du programme, lancer "dialogue_cree"
 * _ le panneau est placé en (x, y)
 * _ le tableau de char * se termine par NULL
 * _ indiquer l'espacement entre chaque ligne
 */
extern void dialogue_cree (SDL_Surface * screen, SDL_Surface * fondImg);

/* Affiche le texte sur le panneau placé en (x, y) 
 * Les "frappe" premières lignes seront frappées, toutes sont centrées.
 */
extern void dialogue_texte (int x, int y, int frappe, int ecart_lignes, char * * texte);

/* Pose la question *texte et renvoie lequel des choix suivants a été séléctionné,
 * et -1 si sortie par escape.
 * La première ligne constitue le titre du dialogue.
 */
extern int dialogue_question (int x, int y, int frappe, int ecart_titre, 
			      int ecart_lignes, char * * texte);

/* Attend la saisie "nbre_car" composants, renvoie NULL si la sortie s'est effectuée avec ESCAPE.
 * Si la saisie est "chiffre" ou "key" (une seule touche) le résultat est exploitable avec "atoi"
 * La première ligne constitue le titre.
 * Après utilisation, il est utile de libérer la zone mémoire renvoyée par un "free".
 */
extern char * dialogue_saisie (int x, int y, int frappe, int ecart_titre, int ecart_lignes,
			       type_saisie saisie, int nbre_car, char * * texte);

extern void attend_action_clavier_ou_clique (int clique_dans_le_panneau);

/* A utiliser lorsqu'on quitte un dialogue définitivement, sans continuer sur un autre */
extern void dialogue_panneau_update ();

extern void dialogue_texte_arg (int x, int y, int frappe, int ecart_lignes, char * premier, ...);

#endif /* GST_DIALOGUE_H */
