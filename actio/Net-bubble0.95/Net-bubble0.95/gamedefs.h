/* Définitions de macro-constantes. */

#ifndef GAMEDEFS_H
#define GAMESDEFS_H

#define SCREEN_WIDTH 640
#define SCREEN_HEIGHT 480
#define SCREEN_1P_WIDTH 256
#define SCREEN_1P_HEIGHT 422
#define BORDURE_WIDTH 5
#define TOP 40 /* Commencement en haut de la surface du jeu (1er pixel dans la surface). */
#define BOTTOM TOP+SCREEN_1P_HEIGHT-1 /* Commencement en bas de la surface du jeu (1er pixel dans la surface). */
#define LEFT (SCREEN_WIDTH-SCREEN_1P_WIDTH)/2 /* Commencement à gauche de la surface du jeu (1er pixel dans la surface). */
#define RIGHT LEFT+SCREEN_1P_WIDTH-1 /* Commencement à droite de la surface du jeu (1er pixel dans la surface). */

#define ROW_SIZE 28 /* NB: La dernière row aura 32 de hauteur (=>12*ROW_SIZE+4 avant la limite). Ceci est important pour dessiner et tester la limite. */

#define NB_BUBBLES_X 8
#define NB_BUBBLES_Y 13

#define TYPES_BUBBLES 8

#define BUBBLE_VELOCITY 12 

#define BUBBLE_SIZE 32

#define EMULATION_FRAMES_DESIREES_PAR_SECONDE 30.0 /* Pourquoi émulation ? Car on ne peut que donner l'impression qu'un nombre de frames augmentent (en augmentant l'importance des déplacements par frame) car le nombre de frames par seconde ne peut-etre changé par programmation. */

#define ROTATION_SPEED 3

#define PI (3.141592654F)

#define STICKING_TOLERANCE BUBBLE_SIZE-6

/* Il s'agit ici d'un coefficient d'adhérence des bulles entre elles.
BUBBLE_SIZE-10: très peu aimantée (slicky)
BUBBLE_SIZE-0: aimantée
BUBBLE_SIZE+10: super aimantée  
*/

#define FRAMES 40 

#define MAX_PARTICULES 300000
#define DECOMPTE 1000000

#define MAX_BULLES_TOMBANTES 100
#define MAX_BULLES_PARABOLE 100 

#define NUAGE_ROWS 4
#define NUAGES_TRANSPARENTS 1
#define TYPES_NUAGE 3

#define OFFSET_TIMES 9 

#endif /* GAMESDEFS_H */
