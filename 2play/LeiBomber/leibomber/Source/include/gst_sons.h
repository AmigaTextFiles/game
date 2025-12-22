#ifndef GST_SONS_J
#define GST_SONS_J

#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>

typedef enum 
{
  son_bombe_explose = 0,
  son_bombe_pose,
  son_bonus_ramasse, son_joueur_blesse,
  son_joueur_mort, son_etre_mort_intro,
  son_roq_tir, son_roq_explose,
  son_glisse, son_choix,
  son_monstre_blesse, son_monstre_mort, 
  son_monstre_apparition, son_monstre_frotte,  
  son_tink, son_car_frappe, son_car_fondu,
  nbre_de_sons
} type_enum_sons;

extern void son_cree ();

extern void son_joue (type_enum_sons son);

/* Si le volume a été changé */
extern void son_ajuste_volume (int nouveau_volume);

#endif /* GST_SONS_J */
