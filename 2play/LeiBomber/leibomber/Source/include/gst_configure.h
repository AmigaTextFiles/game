#ifndef GST_CONFIGURE_H
#define GST_CONFIGURE_H

#include <SDL.h>
#include "gst_etre.h"

#define NBRE_JOUEURS 2

#define CONFIG_SON_VOLUME_MAX SDL_MIX_MAXVOLUME
#define CONFIG_SON_VOLUME_MIN 0
#define CONFIG_SON_VOLUME_DEF SDL_MIX_MAXVOLUME

#define CONFIG_SANTE_MONSTRE_MAX 200
#define CONFIG_SANTE_MONSTRE_MIN 25
#define CONFIG_SANTE_MONSTRE_DEF 100

#define CONFIG_DELAI_JOUEURS_MAX 200
#define CONFIG_DELAI_JOUEURS_MIN 0
#define CONFIG_DELAI_JOUEURS_DEF 50

#define CONFIG_VIE_JOUEURS_MAX 50
#define CONFIG_VIE_JOUEURS_MIN 1
#define CONFIG_VIE_JOUEURS_DEF 5

#define CONFIG_SANTE_JOUEURS_MAX 200
#define CONFIG_SANTE_JOUEURS_MIN 25
#define CONFIG_SANTE_JOUEURS_DEF 100

#define CONFIG_NBRE_MONSTRES_MAX 10
#define CONFIG_NBRE_MONSTRES_MIN 0
#define CONFIG_NBRE_MONSTRES_DEF 5

#define CONFIG_PRCT_CAISSE_MAX 90
#define CONFIG_PRCT_CAISSE_MIN 0
#define CONFIG_PRCT_CAISSE_DEF 65

#define CONFIG_PRCT_BONUS_MAX 90
#define CONFIG_PRCT_BONUS_MIN 0
#define CONFIG_PRCT_BONUS_DEF 25

#define CONFIG_POS_PILIER_MAX 1
#define CONFIG_POS_PILIER_MIN 0
#define CONFIG_POS_PILIER_DEF 1

#define CONFIG_PI_DOWN SDLK_s
#define CONFIG_PI_LEFT SDLK_q
#define CONFIG_PI_UP SDLK_z
#define CONFIG_PI_RIGHT SDLK_d
#define CONFIG_PI_DROP SDLK_TAB
#define CONFIG_PI_FIRE SDLK_LCTRL

#define CONFIG_PII_DOWN SDLK_KP2
#define CONFIG_PII_LEFT SDLK_KP4
#define CONFIG_PII_UP SDLK_KP8
#define CONFIG_PII_RIGHT SDLK_KP6
#define CONFIG_PII_DROP SDLK_KP_ENTER
#define CONFIG_PII_FIRE SDLK_KP0

extern int config_delai_joueurs;
extern int config_vie_joueurs;
extern int config_sante_joueurs;
extern int config_pos_pilier;
extern int config_nbre_monstres;
extern int config_prct_caisse;
extern int config_prct_bonus;
extern int config_sante_monstre;
extern int config_son_volume;
extern int config_touches_joueurs [NBRE_JOUEURS][nbre_de_actions];

extern void config_menu_principal ();

extern void config_charge (char * nom_fichier);

extern void config_sauve (char * nom_fichier);

extern void config_restaure ();

#endif 
