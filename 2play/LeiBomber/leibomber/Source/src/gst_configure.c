#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <assert.h>
#include <math.h>

#include "gst_configure.h"
#include "gst_dialogue.h"

typedef int (* type_fct) (void);

struct type_config config = { CONFIG_DELAI_JOUEURS_DEF, CONFIG_VIE_JOUEURS_DEF,
			      CONFIG_SANTE_JOUEURS_DEF, CONFIG_POS_PILIER_DEF,
			      CONFIG_NBRE_MONSTRES_DEF, CONFIG_PRCT_CAISSE_DEF,
			      CONFIG_PRCT_BONUS_DEF, CONFIG_SANTE_MONSTRE_DEF,
			      CONFIG_SON_VOLUME_DEF };

int config_touches_joueurs [NBRE_JOUEURS][nbre_de_actions] = {
  { CONFIG_PI_DOWN, CONFIG_PI_LEFT, CONFIG_PI_UP, CONFIG_PI_RIGHT, CONFIG_PI_DROP, CONFIG_PI_FIRE },
  { CONFIG_PII_DOWN, CONFIG_PII_LEFT, CONFIG_PII_UP, CONFIG_PII_RIGHT, CONFIG_PII_DROP, CONFIG_PII_FIRE } };
  
typedef struct type_modif_param type_modif_param;
struct type_modif_param
{
  char * titre;
  int * valeur;
  int min, max;
  type_saisie saisie;
};

static char * tab_modif_template [5];
static char old_value [30];
static char between [40];

static char *
config_fait_old_value (int valeur, type_saisie saisie)
{
  if (saisie == saisie_key)
    sprintf (old_value, "Old  key  :  %s", SDL_GetKeyName (valeur));
  else
    sprintf (old_value, "Old  value  :  %d", valeur);
  return old_value;
}

static char *
config_fait_between (int min, int max)
{
  if (min == -1)
    sprintf (between, "Hit de key !");
  else
    sprintf (between, "Value  between  %d and %d :", min, max);
  return between;
}

static char * *
config_tab_modif_template (char * titre, int valeur, int min, int max, type_saisie saisie)
{
  tab_modif_template [0] = titre;
  tab_modif_template [1] = "-*-";
  tab_modif_template [2] = config_fait_old_value (valeur, saisie);
  tab_modif_template [3] = config_fait_between (min, max);
  tab_modif_template [4] = NULL;
  return tab_modif_template;
}

/* Retourne 1 si la valeur a été modifiée, -1 sinon (sortie par escape)
 * Nota : la valeur max détermine le nombre de caractères à accepter.
 * Si "chiffre" == 1, la saisie concerne des nombres.
 */
static int
config_modif_template (char * titre, int * valeur, int min, int max, type_saisie saisie)
{
  char * res_txt;
  int res_int;
  
  do
    {
      res_txt = dialogue_saisie (200, 150, 1, 0, 25, saisie, log10 (max) + 1, 
				 config_tab_modif_template (titre, *valeur, min, max, saisie));
      if (res_txt == NULL)
	return -1;
      res_int = atoi (res_txt);
      free (res_txt);
    }
  while (saisie != saisie_key && (res_int < min || res_int > max));
  *valeur = res_int;
  return 1;
}

static int
config_modif_template_param (type_modif_param param)
{
  return config_modif_template (param.titre, param.valeur, param.min, param.max, param.saisie);
}

/* Permet de créer soit un menu de choix ouvrant sur un sous-menu (dans ce cas, remplir "tab_fct") 
 * soit un menu ouvrant sur des modifications (dans ce cas, "tab_fct" = NULL, et remplir
 * "modif_param" qui contient les paramètres pour la saisie de la nouvelle valeur).
 */
static int
config_choix_template (char * * texte, type_fct * tab_fct, type_modif_param * modif_param)
{
  int res, cpt;
  do
    {
      int ecart_titre = 9;
      int ecart_lignes = 29;
      for (cpt = 0; texte [cpt] != NULL; cpt++)
	{
	  if (cpt > 4)
	    {
	      ecart_titre--;
	      ecart_lignes -= 3;
	    }
	}
      res = dialogue_question (200, 150, 1, ecart_titre, ecart_lignes, texte);
      
      if (res == -1)
	return -1;
      
      if (tab_fct != NULL)
	res = tab_fct [res] ();
      else
	{
	  config_modif_template_param (modif_param [res]);
	  res = -1;
	}
    }
  while (res == -1);
  return 1;
}

static int
config_sous_menu_player ()
{
  char * texte_menu [] = { "Players config", "Life", "Velocity", "Energy", NULL };
  type_modif_param param [] = { { "Number  of  lifes", &config.vie_joueurs, 
				  CONFIG_VIE_JOUEURS_MIN, CONFIG_VIE_JOUEURS_MAX, saisie_num },
			        { "Players  velocity", &config.delai_joueurs, 
				  CONFIG_DELAI_JOUEURS_MIN, CONFIG_DELAI_JOUEURS_MAX, saisie_num },
				{ "Players  enery", &config.sante_joueurs, 
				  CONFIG_SANTE_JOUEURS_MIN, CONFIG_SANTE_JOUEURS_MAX, saisie_num } };
  return config_choix_template (texte_menu, NULL, param);
}

static int
config_sous_menu_keys_players (int num)
{
  int i;
  type_modif_param param [] = {  { "Down", NULL, -1, 1, saisie_key },
				 { "Left", NULL, -1, 1, saisie_key },
				 { "Up", NULL, -1, 1, saisie_key },
				 { "Right", NULL, -1, 1, saisie_key },
				 { "Drop bomb", NULL, -1, 1, saisie_key },
				 { "Fire", NULL, -1, 1, saisie_key } };
  char * texte_menu [] = { "Player II  keys", "Down", "Left", "Up", "Right", "Drop bomb", "Fire", NULL };
  
  for (i = 0; i < nbre_de_actions; i++)
    param [i].valeur = &(config_touches_joueurs [num][i]);
  
  if (! num)
    texte_menu [0] = "PLayer  I  keys";
  return config_choix_template (texte_menu, NULL, param);
}

static int
config_sous_menu_keys_playerI ()
{
  return config_sous_menu_keys_players (0);
}

static int
config_sous_menu_keys_playerII ()
{
  return config_sous_menu_keys_players (1);
}

static int
config_sous_menu_keys ()
{
  char * texte_menu [] = { "Keys config", "Player I", "Player II", NULL };
  type_fct param [] = { config_sous_menu_keys_playerI, config_sous_menu_keys_playerII };
  return config_choix_template (texte_menu, param, NULL);
}

static int
config_sous_menu_playground ()
{
  char * texte_menu [] = { "Misc config", "Pillar position", "Prct of case", "Prct of bonus", NULL };
  type_modif_param param [] =  { { "Pillar position", &config.pos_pilier, 
				   CONFIG_POS_PILIER_MIN, CONFIG_POS_PILIER_MAX, saisie_num },
				 { "Prct of case", &config.prct_caisse, 
				   CONFIG_PRCT_CAISSE_MIN, CONFIG_PRCT_CAISSE_MAX, saisie_num },
				 { "Prct if bonus", &config.prct_bonus, 
				   CONFIG_PRCT_BONUS_MIN, CONFIG_PRCT_BONUS_MAX, saisie_num } };
  return config_choix_template (texte_menu, NULL, param);
}

static int
config_sous_menu_misc ()
{
  char * texte_menu [] = { "Misc config", "Monster energy", "Sound volume", NULL };
  type_modif_param param [] = { { "Monster energy", &config.sante_monstre, 
				  CONFIG_SANTE_MONSTRE_MIN, CONFIG_SANTE_MONSTRE_MAX, saisie_num },
			        { "Sound volume", &config.son_volume, 
				  CONFIG_SON_VOLUME_MIN, CONFIG_SON_VOLUME_MAX, saisie_num } };
  return config_choix_template (texte_menu, NULL,param);
}

void
config_menu_principal ()
{
  char * texte_menu [] = { " Main  config", "Players", "Keys", "Misc", "Playground", NULL };
  type_fct param [] = { config_sous_menu_player, config_sous_menu_keys,
			config_sous_menu_misc, config_sous_menu_playground };
  config_choix_template (texte_menu, param, NULL);
}

void
config_sauve ()
{
  FILE * file = fopen (CONFIG_NOM_FICHIER, "w");
  assert (file != NULL);
  assert (fwrite (&config, sizeof (struct type_config), 1, file) == 1);
  assert (fwrite (&config_touches_joueurs, sizeof (config_touches_joueurs), 1, file) == 1);
  fclose (file);
}

void
config_charge ()
{
  FILE * file = fopen (CONFIG_NOM_FICHIER, "r");
  if (file != NULL)
    {
      assert (fread (&config, sizeof (struct type_config), 1, file) == 1);
      assert (fread (&config_touches_joueurs, sizeof (config_touches_joueurs), 1, file) == 1);
      fclose (file); 
    }
}
