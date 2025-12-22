#ifndef GST_MONSTRE_H
#define GST_MONSTRE_H

#include "gst_etre.h"

#define CHEMIN_MONSTRE "./troo/troo"
#define MONSTRE_MOBILE 1
#define MONSTRE_IMMOBILE 2

typedef enum 
{
  immobilise_monstres,
  mobilise_monstres
} type_mouvement_monstres;

/* Initialiser une fois au début du programme */
extern void monstre_cree (SDL_Surface * screen, SDL_Surface * fondImg);

/* Positionne un monstre à (i, j) de vitesse delai et qui essaira de changer de dierction environ
 * tous les cpt mouvements.
 */
extern void monstre_active (int i, int j, int delai, int cpt);

/* Elimine tous les monstres */
extern void monstre_desactive_tous ();

extern void monstre_modifie_mouvement_tous (type_mouvement_monstres mvt);

#endif /* GST_MONSTRE_H */
