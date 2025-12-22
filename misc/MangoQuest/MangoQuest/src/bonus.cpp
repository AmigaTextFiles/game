/*  The Blue Mango Quest
 *  Copyright (c) Clément 'phneutre' Bourdarias (code)
 *                   email: phneutre@users.sourceforge.net
 *                Guillaume 'GuBuG' Burlet (graphics)
 *                   email: gubug@users.sourceforge.net
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Library General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#ifdef WIN32
#include <windows.h>
#endif

#include <GL/gl.h>
#include <GL/glu.h>
#include <math.h>
#include <stdlib.h>
#include <SDL/SDL.h>

#ifdef HAVE_SDL_MIXER
# include <SDL/SDL_mixer.h>
#endif

#include "timers.h"
#include "world_geometry.h"
#include "hut.h"
#include "bonus.h"
#include "mango.h"
#include "world_building.h"
#include "texture.h"
#include "world_geometry.h"
#include "sector.h"
#include "map.h"
#include "hud.h"
#include "draw_scene_gl.h"
#include "sounds.h"

#define MAX_LIVES 5

extern options_t *options;

const char hasardTable[20] = {
  0/*shmixgum*/,0 /*life*/ ,1,1,0/*onde*/,1,1,1,1,0/*luck*/,1,1,1,1,1,1,1,1,1,0/*random*/
};

const char luckTable[20] = {
  1/*shmixgum*/,0 /*life*/ ,1,1,0/*onde*/,1,1,1,1,0 /*luck*/,0,0,0,0,0,0,0,0,0,0/*random*/
};

const char *textureBonus[NUM_BONUS] = {

  SHXMAN_DATA "textures/bonus/shmixgomme.png",
  SHXMAN_DATA "textures/bonus/vie.png",
  SHXMAN_DATA "textures/bonus/bouclier.png",
  SHXMAN_DATA "textures/bonus/armaggedon.png",
  SHXMAN_DATA "textures/bonus/onde.png",
  SHXMAN_DATA "textures/bonus/stoptemps.png",
  SHXMAN_DATA "textures/bonus/ultrapoint.png",
  SHXMAN_DATA "textures/bonus/glacon.png",
  SHXMAN_DATA "textures/bonus/rapide.png",
  SHXMAN_DATA "textures/bonus/coupdebol.png",
  
  SHXMAN_DATA "textures/bonus/nuit.png",
  SHXMAN_DATA "textures/bonus/perdbonus.png",
  SHXMAN_DATA "textures/bonus/inverttouches.png",
  SHXMAN_DATA "textures/bonus/plafond.png",
  SHXMAN_DATA "textures/bonus/fog.png",
  SHXMAN_DATA "textures/bonus/malusmap.png",
  SHXMAN_DATA "textures/bonus/boitesnegatives.png",
  SHXMAN_DATA "textures/bonus/freezeshx.png", 
  SHXMAN_DATA "textures/bonus/lent.png",
  SHXMAN_DATA "textures/bonus/hasard.png"
};

const char *textureDituboite = SHXMAN_DATA "textures/bonus/tunasbox.png";

const char *sound_names[NUM_BONUS] = {

  SHXMAN_DATA "sounds/bonus/shmixgum.wav",
  SHXMAN_DATA "sounds/bonus/life.wav",
  SHXMAN_DATA "sounds/bonus/shield.wav",
  SHXMAN_DATA "sounds/bonus/armaggedon.wav",
  SHXMAN_DATA "sounds/bonus/shockwave.wav",
  SHXMAN_DATA "sounds/bonus/stoptime.wav",
  SHXMAN_DATA "sounds/bonus/ultrapoints.wav",
  SHXMAN_DATA "sounds/bonus/freeze.wav",
  SHXMAN_DATA "sounds/bonus/highspeed.wav",
  SHXMAN_DATA "sounds/bonus/luck.wav",

  SHXMAN_DATA "sounds/bonus/night.wav",
  SHXMAN_DATA "sounds/bonus/loosebonus.wav",
  SHXMAN_DATA "sounds/bonus/invertkeys.wav",
  SHXMAN_DATA "sounds/bonus/ceiling.wav",
  SHXMAN_DATA "sounds/bonus/fog.wav",
  SHXMAN_DATA "sounds/bonus/malusmap.wav",
  SHXMAN_DATA "sounds/bonus/negative.wav",
  SHXMAN_DATA "sounds/bonus/freezeshx.wav",
  SHXMAN_DATA "sounds/bonus/lowspeed.wav",
  SHXMAN_DATA "sounds/bonus/hazard.wav"

};

extern game_data_t *world;
extern player_t *player;

char old_status=0;

int whichBonusActive()
{
  for (int i=0; i<NUM_BONUS; i++)
    {
      if ((i!=E_SHMIXGOMME)&&(world->tab_bonus[i]->actif)) 
	return i;
    }
  return -1;
}

void execute_bonus(int type)
{
  int parametre = get_bonus_param(player->square);
  world->map[player->square].bonus = -2;
  if (!(desactive_bonus(player->mySector, player->square)))
    fprintf(stderr,"Error: can't find bonus on square %d\n",
	    player->square);
  world->tab_bonus[type]->agir(parametre);
}

void stock_bonus(int number)
{
  world->map[player->square].bonus = -2;
  if (!(desactive_bonus(player->mySector, player->square)))
    fprintf(stderr,"Error: can't find bonus on square %d\n",
	    player->square);
  player->stockBonus[number]=1;
  player->paramStocks[number]=get_bonus_param(player->square);
}

void locate_dituboites()
{
  world->num_dituboites=0;
  for (int i = 0; i < world->size_square; i++)
  {
    if ((world->map[i].tex_sol > -1) && (world->map[i].bonus == -1)
        && (world->map[i].special == -1))
      {
	world->map[i].is_ditugomme = 1;
	world->num_dituboites++;
      }
    else
      world->map[i].is_ditugomme = 0;
  }
}

void use_stocked_bonus(int which)
{
  switch (which)
    {
    case E_ARMAGGEDON:
      if (player->stockBonus[0])
	{
	  world->tab_bonus[E_ARMAGGEDON]->agir(player->paramStocks[0]);
	  player->stockBonus[0]=0;
	}
      break;

    case E_ONDEDECHOC:
      if (player->stockBonus[1])
	{
	  world->tab_bonus[E_ONDEDECHOC]->agir(player->paramStocks[1]);
	  player->stockBonus[1]=0;
	}
      break;
    case E_RAPIDE:
      if ((player->stockBonus[2])&&(whichBonusActive()<=E_COUPDEBOL))
	{
	  if (world->current_bonus > -1) 
	    world->tab_bonus[world->current_bonus]->cancelAction();
	  world->tab_bonus[E_RAPIDE]->agir(player->paramStocks[2]);
	  player->stockBonus[2]=0;
	  world->current_bonus = E_RAPIDE;
	}
      break;
    case E_STOPTEMPS:
      if ((player->stockBonus[3])&&(whichBonusActive()<=E_COUPDEBOL))
	{
	  if (world->current_bonus > -1) 
	    world->tab_bonus[world->current_bonus]->cancelAction();
	  world->tab_bonus[E_STOPTEMPS]->agir(player->paramStocks[3]);
	  player->stockBonus[3]=0;
	  world->current_bonus = E_STOPTEMPS;
	}
      break;
    }
}

int has_player_stock()
{
  if ((player->stockBonus[0])||(player->stockBonus[1])
      || (player->stockBonus[2]) || (player->stockBonus[3]))
    return 1;
  else return 0;
}

BONUS::~BONUS()
{

}

void BONUS::construit(GLint listeType)
{
  
}

void BONUS::agir(int parametre)
{


}

void BONUS::annuleEffets()
{

}


void BONUS::affiche(float x, float y, float z, char with_rotat, char with_updown)
{
  glPushMatrix();
  glEnable(GL_TEXTURE_2D);

  glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);
  if (with_updown)
    glTranslatef(x, -z, y+world->bonus_updown);
  else glTranslatef(x, -z, y);

  if (with_rotat)
    glRotatef(world->bonus_rotat, 0.0f, 0.0f, 1.0f);

  glBindTexture(GL_TEXTURE_2D, texture);

  glCallList(liste);
  glDisable(GL_TEXTURE_2D);
  glPopMatrix();
}


char BONUS::updateTimer()
{
  if (timer->update_temps()) {
    hud_new_message("Bonus's effect is finished");
    printf("Bonus's effect is finished\n");
    annuleEffets();
    actif=0;
    return 0;
  }

  else return 1;
}

void BONUS::cancelAction()
{
  hud_new_message("The bonus is no longer active (by cancel)");
  printf("The bonus is no longer active (by cancel)\n");
  annuleEffets();
  actif=0;
}

void BONUS::setUpTimer(int parametre)
{
  timer->resetTemps();
  timer->setAlarm(parametre);
}

void BONUS::load_datas()
{
  LoadTexture(textureBonus[name], &texture);

#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    sound = Mix_LoadWAV(sound_names[name]);
    if (sound == NULL) {
      fprintf(stderr, "Couldn't load: %s\n", SDL_GetError());
      exit(1);
    }
  }
#endif

}

void DITUBOITE::agir(int parametre)
{
  player->score+=valeur;
}

void DITUBOITE::construit(GLint typeListe)
{
  liste = typeListe;
  LoadTexture(textureDituboite, &texture);

#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    sound = Mix_LoadWAV(sound_names[E_VIE]);
    if (sound == NULL) {
      fprintf(stderr, "Couldn't load: %s\n", SDL_GetError());
      exit(1);
    }
  }
#endif
}

void DITUBOITE::annuleEffets()
{
}


void B_VIE::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  if (player->num_lives < MAX_LIVES) player->num_lives++;
  player->score += 25;
  hud_new_message("You received a new life");
}

void B_VIE::construit(GLint typeListe)
{ 
  name = E_VIE;
  liste = typeListe;
  load_datas();
}

void B_VIE::annuleEffets()
{
}

void B_HASARD::agir(int parametre)
{
  int theChoice=0, i=0, numChoices=0, compteur=0, theChosen=0;

  for (i=0; i<NUM_BONUS; i++) {
    if (hasardTable[i]) numChoices++;
  }

#if defined(WIN32) || defined(__MORPHOS__)
  theChoice = rand() % numChoices +1;
#else
  theChoice = random() % numChoices +1;
#endif

  for (i=0; i < NUM_BONUS; i++) {
    if (hasardTable[i]) compteur++;
    if (compteur == theChoice) {theChosen=i ; i=NUM_BONUS;}
  }

  printf("...and the winner is... bonus %d!\n",theChosen);
  if ((theChosen > 0)&&(world->current_bonus > -1)) 
    world->tab_bonus[world->current_bonus]->cancelAction();
  world->tab_bonus[theChosen]->agir(parametre);
}

void B_HASARD::construit(GLint typeListe)
{
  name = E_HASARD;
  liste = typeListe;
  LoadTexture(textureBonus[E_HASARD], &texture);

}

void B_HASARD::annuleEffets()
{
}

void B_NUIT::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_AMBIANT, sound, parametre-1);
#endif
  }
  printf("Good Night!\n");
  hud_new_message("Good Night!");
  actif=1;
  player->score += 125;

  for (int i=0; i<4; i++)
    world->mat_amb_diff[i]-=0.80;
  setUpTimer(parametre);
}

void B_NUIT::construit(GLint typeListe)
{
  name = E_NUIT;
  liste = typeListe;
  timer = new CHRONOMETRE;
  load_datas();

}

void B_NUIT::annuleEffets()
{
  for (int i=0; i<4; i++)
    world->mat_amb_diff[i]+=0.80;

#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    if (options->use_sound) {
      Mix_HaltChannel(1);
    }
  }
#endif

}

void B_GLACON::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  int i=0;
  actif=1;
  player->score += 25;
  for (i=0; i<world->num_huts; i++) 
    change_hut_status(&world->huts[i],ETAT_FREEZE);

  old_status = player->status;
  player->status = ETAT_POURSUIVANT;

  for (i=0; i<4; i++)
    if (i!=2) world->mat_amb_diff[i]-=0.55;

  hud_new_message("You picked the FREEZE bonus");
  setUpTimer(parametre);
}

void B_GLACON::construit(GLint typeListe)
{
  name = E_GLACON;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_GLACON::annuleEffets()
{
  int i=0;
  for (i=0; i< world->num_huts; i++) 
    change_hut_status(&world->huts[i],ETAT_FONCTIONNE);

  player->status = old_status;

  for (i=0; i<4; i++)
    if (i!=2) world->mat_amb_diff[i]+=0.55;
}

void B_COUPDEBOL::agir(int parametre)
{
  int theChoice=0, i=0, numChoices=0, compteur=0, theChosen=0;

  for (i=0; i<NUM_BONUS; i++) {
    if (luckTable[i]) numChoices++;
  }

#if defined(WIN32) || defined(__MORPHOS__)
  theChoice = rand() % numChoices +1;
#else
  theChoice = random() % numChoices +1;
#endif

  for (i=0; i < NUM_BONUS; i++) {
    if (luckTable[i]) compteur++;
    if (compteur == theChoice) {theChosen=i ; i=NUM_BONUS;}
  }

  printf("Lucky man ! We give you bonus %d.\n",theChoice);
  player->score += 50;
  world->tab_bonus[theChoice]->agir(parametre);

}

void B_COUPDEBOL::construit(GLint typeListe)
{
  name = E_COUPDEBOL;
  liste = typeListe;
  LoadTexture(textureBonus[E_COUPDEBOL], &texture);
}

void B_COUPDEBOL::annuleEffets()
{
}

void B_ONDEDECHOC::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  player->score += 25;
  for (int i=0; i < world->num_huts; i++)
    {
      shockWave(&world->huts[i],parametre);
    }
  hud_new_message("You used the ShockWave");
}

void B_ONDEDECHOC::construit(GLint typeListe)
{
  name = E_ONDEDECHOC;
  liste = typeListe;
  load_datas();
}

void B_ONDEDECHOC::annuleEffets()
{
}

void B_SHMIXGOMME::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  actif=1;
  player->score += 50;
  player->status = ETAT_POURSUIVANT;
  old_status = ETAT_POURSUIVANT;
  hud_new_message("You picked a ShmixGum!");
  setUpTimer(parametre);
}

void B_SHMIXGOMME::construit(GLint typeListe)
{
  name = E_SHMIXGOMME;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_SHMIXGOMME::annuleEffets()
{
  /* don't erase the ability to eat shmollux when freeze is active */
  if (whichBonusActive() != E_GLACON) 
    player->status = ETAT_POURSUIVI;
  old_status = ETAT_POURSUIVI;
}

void B_BOUCLIER::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  actif=1;
  player->score += 25;
  player->highlander=1;
  hud_new_message("You picked the Shield");
  setUpTimer(parametre);
}

void B_BOUCLIER::construit(GLint typeListe)
{
  name = E_BOUCLIER;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_BOUCLIER::annuleEffets()
{
  player->highlander=0;
}

void B_PERDBONUS::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  player->score += 150;
  for (int i=0; i<4; i++)
    {
      player->stockBonus[i]=0;
    }
  hud_new_message("You have lost all your stocks");
}

void B_PERDBONUS::construit(GLint typeListe)
{
  name = E_PERDBONUS;
  liste = typeListe;
  load_datas();
}

void B_PERDBONUS::annuleEffets()
{
}

void B_ARMAGGEDON::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  hud_new_message("You have used your Armaggedon!");
  all_shmol_go_home();
  hut_t *hut;
  //player->score += 50;
  for (int i=0; i<world->num_huts; i++)
    {
      hut = &world->huts[i];
      //change_shmol_status(hut, ETAT_MORT);
      if (player->square == hut->square) {
	change_hut_status(hut, ETAT_DETRUIT);
	player->score-=50;
	hud_new_message("You have destroyed a ShmolluX hut!!");
	printf("Shmollux's home (square %d) destroyed !\n", hut->square);
      }
    }
}

void B_ARMAGGEDON::construit(GLint typeListe)
{
  name = E_ARMAGGEDON;
  liste = typeListe;
  load_datas();
}

void B_ARMAGGEDON::annuleEffets()
{
}

void B_RAPIDE::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_AMBIANT, sound, parametre-1);
  }
#endif

  actif=1;
  player->score += 50;
  player->rotat_speed[0]=VITESSE_ROTAT_MARCHE*2; 
  player->rotat_speed[1]=VITESSE_ROTAT_COURSE*2;
  player->trans_speed[0]=VITESSE_TRANS_MARCHE*2; 
  player->trans_speed[1]=VITESSE_TRANS_COURSE*2;

  hud_new_message("You have used your Speed bonus");
  setUpTimer(parametre);
}

void B_RAPIDE::construit(GLint typeListe)
{
  name = E_RAPIDE;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_RAPIDE::annuleEffets()
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_HaltChannel(CHANNEL_AMBIANT);
  }
#endif

  player->rotat_speed[0]=VITESSE_ROTAT_MARCHE; 
  player->rotat_speed[1]=VITESSE_ROTAT_COURSE;
  player->trans_speed[0]=VITESSE_TRANS_MARCHE; 
  player->trans_speed[1]=VITESSE_TRANS_COURSE;
}

void B_LENT::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  printf("Loooow speed\n");
  actif=1;
  player->score += (10*parametre);
  //player->rotat_speed[0]=VITESSE_ROTAT_MARCHE/2; 
  //player->rotat_speed[1]=VITESSE_ROTAT_MARCHE/2;
  player->trans_speed[0]=VITESSE_TRANS_MARCHE/2; 
  player->trans_speed[1]=VITESSE_TRANS_MARCHE/2;
  hud_new_message("You picked the LowSpeed malus");
  setUpTimer(parametre);
}

void B_LENT::construit(GLint typeListe)
{
  name = E_LENT;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_LENT::annuleEffets()
{
  //player->rotat_speed[0]=VITESSE_ROTAT_MARCHE; 
  //player->rotat_speed[1]=VITESSE_ROTAT_COURSE;
  player->trans_speed[0]=VITESSE_TRANS_MARCHE; 
  player->trans_speed[1]=VITESSE_TRANS_COURSE;
}

void B_STOPTEMPS::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_AMBIANT, sound, parametre-1);
  }
#endif

  actif=1;
  player->score -= 50;
  world->game_timer->togglePaused();
  hud_new_message("You have used the StopTime bonus");
  setUpTimer(parametre);
}

void B_STOPTEMPS::construit(GLint typeListe)
{
  name = E_STOPTEMPS;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_STOPTEMPS::annuleEffets()
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_HaltChannel(CHANNEL_AMBIANT);
  }
#endif

  world->game_timer->togglePaused();
}

void B_ULTRAPOINTS::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  actif=1;
  player->score += 25;
  world->dituboite->valeur=10;
  hud_new_message("You picked the HyperPoints bonus");
  setUpTimer(parametre);
}

void B_ULTRAPOINTS::construit(GLint typeListe)
{
  name = E_ULTRAPOINTS;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_ULTRAPOINTS::annuleEffets()
{
  world->dituboite->valeur=1;
}

void B_INVERTTOUCHES::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  actif=1;
  player->score += 100;
  player->theKeys[KEY_UP] = SDLK_DOWN;
  player->theKeys[KEY_DOWN] = SDLK_UP;
  player->theKeys[KEY_LEFT] = SDLK_RIGHT;
  player->theKeys[KEY_RIGHT] = SDLK_LEFT;
  hud_new_message("You picked the InvertKeys malus");
  setUpTimer(parametre);
}

void B_INVERTTOUCHES::construit(GLint typeListe)
{
  name = E_INVERTTOUCHES;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_INVERTTOUCHES::annuleEffets()
{
  player->theKeys[KEY_UP] = SDLK_UP;
  player->theKeys[KEY_DOWN] = SDLK_DOWN;
  player->theKeys[KEY_LEFT] = SDLK_LEFT;
  player->theKeys[KEY_RIGHT] = SDLK_RIGHT;
}

void B_PLAFOND::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  actif=1;
  player->elevation = AU_PLAFOND;
  player->score += 75;
  hud_new_message("You picked the Ceiling malus");
  setUpTimer(parametre);
}

void B_PLAFOND::construit(GLint typeListe)
{
  name = E_PLAFOND;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_PLAFOND::annuleEffets()
{
  player->elevation = AU_SOL;
}

void B_FOG::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_AMBIANT, sound, parametre-1);
  }
#endif

  actif=1;
  player->score += 50;

  GLfloat color[4]={0.5f,0.5f,0.5f,1.0f};
  glFogfv(GL_FOG_COLOR, color);
  glFogf(GL_FOG_START, 0.0);
  glFogf(GL_FOG_END, 10.0);
  glFogi(GL_FOG_MODE, GL_LINEAR);
  glFogf(GL_FOG_DENSITY, 1.0);
  glClearColor(0.5f,0.5f,0.5f,1.0f);
  glEnable(GL_FOG);

  glEnable(GL_FOG);
  hud_new_message("You picked the Fog malus");
  setUpTimer(parametre);
}

void B_FOG::construit(GLint typeListe)
{
  name = E_FOG;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_FOG::annuleEffets()
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_HaltChannel(CHANNEL_AMBIANT);
  }
#endif

  reset_fog_state();
}

void B_MALUSMAP::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  actif=1;
  player->score += 150;
  player->sees_minimap=0;
  hud_new_message("You picked the MalusMap");
  setUpTimer(parametre);
}

void B_MALUSMAP::construit(GLint typeListe)
{
  name = E_MALUSMAP;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_MALUSMAP::annuleEffets()
{
  player->sees_minimap=1;
}

void B_ANTIBOITES::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  actif=1;
  //player->score += 10;
  world->dituboite->valeur = -world->dituboite->valeur;
  hud_new_message("You picked the AntiBoxes malus");
  setUpTimer(parametre);
}

void B_ANTIBOITES::construit(GLint typeListe)
{
  name = E_ANTIBOITES;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_ANTIBOITES::annuleEffets()
{
  world->dituboite->valeur = -world->dituboite->valeur;
}

void B_FREEZESHX::agir(int parametre)
{
#ifdef HAVE_SDL_MIXER
  if (options->use_sound) {
    Mix_PlayChannel(CHANNEL_BONUS, sound, 0);
  }
#endif

  player->score += (20*parametre);
  actif=1;
  //player->rotat_speed[0]=0; player->rotat_speed[1]=0;
  player->trans_speed[0]=0; player->trans_speed[1]=0;
  hud_new_message("You are frozen");
  setUpTimer(parametre);

}

void B_FREEZESHX::construit(GLint typeListe)
{
  name = E_FREEZESHX;
  liste = typeListe;
  load_datas();
  timer = new CHRONOMETRE;
}

void B_FREEZESHX::annuleEffets()
{
  //player->rotat_speed[0]=VITESSE_ROTAT_MARCHE; 
  //player->rotat_speed[1]=VITESSE_ROTAT_COURSE;
  player->trans_speed[0]=VITESSE_TRANS_MARCHE; 
  player->trans_speed[1]=VITESSE_TRANS_COURSE;
}
