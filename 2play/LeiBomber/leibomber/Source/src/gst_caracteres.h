#ifndef GST_CARACTERES_H
#define GST_CARACTERES_H

#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

#define PREMIER_CAR 33
#define DERNIER_CAR 95
#define NOM_BASE "car"

typedef struct type_caracteres * type_caracteres;

extern void car_cree (SDL_Surface * screen, SDL_Surface * fondImg);

/* Efface d'une largeur d'un caractère de plus que texte et écrit le texte */
/* Renvoie la position x de la fin de la ligne */
extern int car_affiche_texte (int x, int y, char * texte);

/* Renvoie la position x de la fin de la ligne */
extern int car_frappe_texte (int x, int y, char * texte, int delai);

/* Affiche un fondu d'un tableau de char *  de "numtexte" lignes */
extern void car_fondu_texte (int numtexte, int * x, int * y, char * * texte, int delai);

extern void car_affiche_nombre (int x, int y, int valeur, int prctage);

/* Efface une zone écrite composée de nbre_de_elements ou de texte */
extern void car_efface (int x, int y, int nbre_de_elements);
extern void car_efface_texte (int x, int y, char * texte);

/* Renvoie la longueur de la chaine en pixel */
extern int car_longueur_texte (char * texte);

/* Renvoie la position x où doit débuter l'affichage pour que le texte soit centré sur un panneau */
extern int car_centre_x (int x, int longueur_panneau, char * texte);

#endif /* GST_CARACTERES_H */
