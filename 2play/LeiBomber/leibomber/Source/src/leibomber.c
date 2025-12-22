#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_thread.h>
#include <assert.h>
#include <time.h>

#include "gst_etre.h"
#include "gst_bombe.h"
#include "gst_obstacle.h"
#include "gst_tab_jeu.h"
#include "gst_roquette.h"
#include "gst_sons.h"
#include "gst_caracteres.h"
#include "gst_anim.h"
#include "gst_dialogue.h"
#include "gst_monstre.h"
#include "gst_configure.h"
#include "gst_divers.h"

#define J1_INTRO_Y 185
#define J2_INTRO_Y 475
#define PLAYER1_I 1
#define PLAYER1_J 2
#define PLAYER2_I NBRE_CASE_X - 2
#define PLAYER2_J NBRE_CASE_Y - 3

SDL_Surface * screen, * fondImg;
int affichage_a_actualiser = 0;

void initialise_screen ()
{
  int i, j;
  SDL_Rect src;
  SDL_Rect dst;
  SDL_Surface * flat1 = img_secure_load ("./Images/fond/flat1.gif");
  SDL_Surface * flat2 = img_secure_load ("./Images/fond/flat2.gif");
  SDL_Surface * flat3 = img_secure_load ("./Images/fond/flat3.gif");
  SDL_Surface * nova = img_secure_load ("./Images/fond/nova2.gif");
  SDL_Surface * leila = img_secure_load ("./Images/fond/leibomber.gif");
  SDL_Surface * gold = img_secure_load ("./Images/fond/panneau_droite.gif");
  
  SDL_SetAlpha (flat2, SDL_SRCALPHA, 40);
  SDL_SetAlpha (flat3, SDL_SRCALPHA, 40);
  
  sdl_rect_affecte (&src, 0, 0, 50, 50);
  for (i = 0; i < NBRE_CASE_X; i++)
    for (j = 0; j < NBRE_CASE_Y; j++)
      {
	sdl_rect_affecte (&dst, i * 50, j * 50, 50, 50);
	SDL_BlitSurface (flat1, &src, fondImg, &dst);
	SDL_BlitSurface (flat1, &src, screen, &dst);
	if (! (i % 2) && ! (j % 2))
	  {
	    SDL_Surface * tmp = (i % 4 || j % 4)  ? flat2 : flat3;
	    SDL_BlitSurface (tmp, &src, fondImg, &dst);
	    SDL_BlitSurface (tmp, &src, screen, &dst);
	  }
      }
    

  /* Panneau d'info */
  RECT_AFFECTE (src, 0, 0, 150, 600);
  RECT_AFFECTE (dst, 850, 50, 150, 600);
  SDL_BlitSurface (gold, &src, fondImg, &dst);
  SDL_BlitSurface (gold, &src, screen, &dst);
  
  /* Etoile du fond du titre */
  RECT_AFFECTE (src, 0, 0, 150, 50);
  RECT_AFFECTE (dst, 850, 0, 150, 50);
  SDL_BlitSurface (nova, &src, fondImg, &dst);
  SDL_BlitSurface (nova, &src, screen, &dst);

  /* Titre */
  SDL_SetColorKey (leila, SDL_SRCCOLORKEY, SDL_MapRGB (leila->format, 0, 255, 255));
  RECT_AFFECTE (src, 0, 0, 150, 23);
  RECT_AFFECTE (dst, 850, 26, 150, 23);
  SDL_BlitSurface (leila, &src, fondImg, &dst);
  SDL_BlitSurface (leila, &src, screen, &dst);

  SDL_FreeSurface (nova);
  SDL_FreeSurface (leila);
  SDL_FreeSurface (flat1);
  SDL_FreeSurface (flat2);
  SDL_FreeSurface (flat3);
  SDL_FreeSurface (gold);
}

void
intro_affiche_info (int deltaY)
{
  char * txt [] = { "Energy : ", "Score : ", "Life :" };
  int posX [3] = { 860, 860, 860 };
  int posY [3] = { 155, 197, 239 };
  if (deltaY > 0)
    {
      int i;
      for (i = 0; i < 3; i++)
	posY [i] += deltaY;
    }
  car_fondu_texte (3, posX, posY, txt, 160);
}

void
intro (type_etre * joueurs)
{
  car_frappe_texte (855, 120, "Player  I", 100);
  anime_etre_intro (joueurs [0], 900, J1_INTRO_Y);
  SDL_Delay (150);
  bmb_pose_intro (900, J1_INTRO_Y - 50, 250);
  SDL_Delay (10);
  bmb_pose_intro (850, J1_INTRO_Y, 250); 
  bmb_pose_intro (900, J1_INTRO_Y, 250);
  SDL_Delay (10);
  bmb_pose_intro (950, J1_INTRO_Y, 250);
  bmb_pose_intro (900, J1_INTRO_Y + 50, 250);
  bmb_pose_intro (joueurs [0]->i * 50, joueurs [0]->j * 50, 250);
  SDL_Delay (550);
  affiche_etre (joueurs [0]);
  intro_affiche_info (0);
  etre_affiche_info (joueurs [0]);
  
  car_frappe_texte (855, 400, "Player  II", 100);
  anime_etre_intro (joueurs [1], 900, J2_INTRO_Y);
  SDL_Delay (150);
  bmb_pose_intro (900, J2_INTRO_Y - 50, 250);
  bmb_pose_intro (850, J2_INTRO_Y, 250); 
  SDL_Delay (10);
  bmb_pose_intro (900, J2_INTRO_Y, 250);
  bmb_pose_intro (950, J2_INTRO_Y, 250);
  SDL_Delay (10);
  bmb_pose_intro (900, J2_INTRO_Y + 50, 250);
  bmb_pose_intro (joueurs [1]->i * 50, joueurs [1]->j * 50, 250);
  SDL_Delay (550);
  affiche_etre (joueurs [1]);
  intro_affiche_info (280);
  etre_affiche_info (joueurs [1]);
}

void
sortie_du_jeu ()
{
  config_sauve ();
  exit (EXIT_SUCCESS);
}

void
help ()
{
  char * txt1 [] = { "This  is  a  deathmatch  game",  "The  player  who  has  no",
		     "more  life  is  the  loser", " ", "I hope it will not be you !", NULL };
  char * txt2 [] = { "Leibomber  is  a  freesoftware", "using  SDL  (by  Sam Lantinga)",
		     "protected  by  the GPL Licence", "For more information contact",
		     "benoit.ligault@wanadoo.fr", NULL };
  char * txt3 [] = { "The  default  keys  are :",  "down left up right drop fire",
		     "PI : s  q  z  d  tab  left-ctrl  ", "PII : ,kpepad, 2  4  8  6  0  enter",
		     " ", "Have a good play", NULL };
  dialogue_texte (200, 150, 0, 25, txt1);
  dialogue_texte (200, 150, 0, 25, txt2);
  dialogue_texte (200, 150, 0, 25, txt3);
}

void
initialise_nouvelle_partie (type_etre * joueurs, int garde_score)
{
  int cpt;
  son_ajuste_volume (config.son_volume);		// réajuste le volume su nécessaire
  tdj_vide_et_place_piliers (config.pos_pilier);	// réinitialise le tab de jeu
  tdj_efface_panneau_de_jeu ();			// efface l'écran (sans update)
  re_initialise_position_etre (joueurs [0], PLAYER1_I, PLAYER1_J);
  re_initialise_position_etre (joueurs [1], PLAYER2_I, PLAYER2_J);
  for (cpt = 0; cpt < NBRE_JOUEURS; cpt++)
    affiche_etre (joueurs [cpt]);			// affiche les joueurs
  tdj_affiche_obstacles (0);			// affiche le tab de jeu (avec update)
  tdj_place_caisses_et_bonus (config.prct_caisse, config.prct_bonus);
  son_joue (son_glisse);
  tdj_affiche_obstacles (1);			// affiche le tab de jeu en fondu
  
  tdj_place_monstres (config.nbre_monstres);	
  for (cpt = 0; cpt < NBRE_JOUEURS; cpt++)
    {
      re_initialise_etre (joueurs [cpt], garde_score);
      etre_efface_info (joueurs [cpt]);
      etre_affiche_info (joueurs [cpt]);
    } 
}

int 
joueurs_en_vie (type_etre * joueurs)
{
  int cpt;
  for (cpt = 0; cpt < NBRE_JOUEURS; cpt++)
    if (joueurs [cpt]->info.infos [enum_energy] <= 0 && joueurs [cpt]->repos)
      break;
  if (cpt != NBRE_JOUEURS)	// Un mort sur la conscience :-(
    {
      int exaequo = 0;		// pbs : les 2 joueurs peuvent mourir en même temps...
      int gagnant = (cpt == 0 ? 1 : 0);
      char dead [30], winner [30];
      attend_action_clavier_ou_clique (0); 
      monstre_desactive_tous ();
      sprintf (dead, "Player %s  is  dead", (cpt == 0 ? "I" : "II"));
      if (joueurs [gagnant]->info.infos [enum_energy] <= 0)
	{
	  exaequo = 1;
	  sprintf (winner, "as  the  Player %s", (gagnant == 0 ? "I" : "II"));
	  etre_modifie_score (joueurs [cpt], 500);
	}
      else
	sprintf (winner, "Player %s  has 500 points  more", (gagnant == 0 ? "I" : "II"));
      dialogue_texte_arg (200, 150, 1, 25, "Very  nice  news :", " ", dead, winner, NULL);
      etre_modifie_score (joueurs [gagnant], 500);
      if (etre_modifie_vie (joueurs [cpt]))
	{
	  if (exaequo && etre_modifie_vie (joueurs [cpt]))
	    sprintf (winner, "* Player %s *", (joueurs [0]->info.infos [enum_score] >= 
					       joueurs [1]->info.infos [enum_score])
		     ? "I" : "II");
	  else
	    sprintf (winner, "* Player %s *", (gagnant == 0 ? "I" : "II"));
	  dialogue_texte_arg (200, 150, 4, 25, "The winner is :", " ", winner, "congratulations", NULL);
	  return 0;
	}
      /* On garde quand même les scores */
      initialise_nouvelle_partie (joueurs, 1);
    }
  return 1;
}

int 
choix_new_game (int jeu_en_cours)
{
  char * txt_menu [] = { " Make  your  choice  :", "new game",  "configure", 
			 "help", "exit game", NULL };
  int res;
  do
    {
      res = dialogue_question (200, 150, 1, 10, 29, txt_menu);
      if (res == 1)
	{
	  config_menu_principal ();
	  son_ajuste_volume (config.son_volume);	// réajuste le volume si nécessaire
	}
      else if (res == 2)
	help ();	
    }
  while (res == 1 || res == 2);
  if (res == 3 || (res == -1 && ! jeu_en_cours))
    sortie_du_jeu ();
  dialogue_panneau_update ();
  return (res == 0);
}

int main (int argc, char * argv [])
{
  type_position position_infos_joueur1 [3] = { { 870, 175 }, { 870, 217 }, { 870, 259 } };
  type_position position_infos_joueur2 [3] = { { 870, 455 }, { 870, 497 }, { 870, 539 } };
  int cpt = 0;
  SDL_Event event;
  type_obstacle obstacle;
  type_etre joueurs [NBRE_JOUEURS];
  
  assert (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_AUDIO) != -1);
  atexit (SDL_Quit);
  srand (time (NULL));
  config_charge ();
  
  /* Titre de la fenêtre */
  SDL_WM_SetCaption ("Leibomber", "Leibomber");

  /* Chargement des images */
  screen = SDL_SetVideoMode (1000, 650, 16, 0);
  fondImg = SDL_AllocSurface (SDL_HWSURFACE, screen->w, screen->h, 
			      screen->format->BitsPerPixel,
			      screen->format->Rmask, screen->format->Gmask,
			      screen->format->Bmask, screen->format->Amask);
  
  initialise_screen ();
  tdj_cree (obstacle);
  
  joueurs [0] = cree_joueur (screen, fondImg, 
			     (SDLKey *) config_touches_joueurs [0],
			     "player/play", PLAYER1_I, PLAYER1_J, position_infos_joueur1);
  
  joueurs [1] = cree_joueur (screen, fondImg,
			     (SDLKey *) config_touches_joueurs [1],
			     "player2/spos", PLAYER2_I, PLAYER2_J, position_infos_joueur2);
  
  anim_cree_visage (900, 300, screen);
  son_cree (config.son_volume);
  dialogue_cree (screen, fondImg);
  monstre_cree (screen, fondImg);
  car_cree (screen, fondImg);
  bmb_cree (screen, fondImg);
  obstacle = obs_cree (screen, fondImg);
  roq_cree (screen, fondImg);
  tdj_cree (obstacle);
  SDL_UpdateRect (screen, 0, 0, 0, 0);
  tdj_vide_et_place_piliers (config.pos_pilier);
  tdj_affiche_obstacles (0);
  anim_gere_visage ();
  
  dialogue_texte_arg (200, 150, 2, 25, "Welcome  to  Leibomber", "(C) BLEC 2001", " ",
		      "The  nicest  sounds  and", "pictures  come  from  the", 
		      "gory  Doom  (ID SOFTWARE)", NULL );
  intro (joueurs);
  
  for (;;)
    {
      choix_new_game (0);
      dialogue_panneau_update ();
      /* Après le menu, on refait tout, on ne garde pas les scores */
      initialise_nouvelle_partie (joueurs, 0);
      /* Début de la grande boucle */
      while (joueurs_en_vie (joueurs)) 
	{
	  for (cpt = 0; cpt < NBRE_JOUEURS; cpt++)
	    affiche_etre (joueurs [cpt]);
	  SDL_Delay (config.delai_joueurs);
	  anim_gere_visage ();
	  // Traiter tous les événements
	  while (SDL_PollEvent (&event) > 0)
	    {
	      int key = event.key.keysym.sym;
	      if (event.type == SDL_QUIT)
		sortie_du_jeu ();
	      if (event.type == SDL_MOUSEMOTION && anim_survol_visage ())
		anim_allume_visage ();
	      if (event.type == SDL_KEYDOWN && key == SDLK_ESCAPE)
		{
		  monstre_modifie_mouvement_tous (immobilise_monstres);
		  if (choix_new_game (1))
		    {
		      monstre_desactive_tous ();
		      initialise_nouvelle_partie (joueurs, 0);
		      break;
		    }
		  tdj_affiche_obstacles (0);
		  monstre_modifie_mouvement_tous (mobilise_monstres);
		}
	      else
		for (cpt = 0; cpt < NBRE_JOUEURS; cpt++)
		  actualise_touches_et_actions_etre (joueurs [cpt], event.key.keysym.sym, event.type);
	    }
	  for (cpt = 0; cpt < NBRE_JOUEURS; cpt++)
	    deplace_etre (joueurs [cpt]);
	}
    }
  sortie_du_jeu ();
  exit (EXIT_SUCCESS);
}
