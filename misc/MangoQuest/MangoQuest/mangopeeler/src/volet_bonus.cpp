/*  The Blue Mango Quest : Mango Peeler
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
#include "shxedit_win32.h"
#endif
#include <stdlib.h>
#include <math.h>
#include <SDL/SDL.h>
#include <SDL/SDL_ttf.h>

#include "share.h"
#include "polices.h"
#include "volet.h"
#include "carte.h"
#include "editeur.h"
#include "ch_tout.h"

extern SDL_Surface *ecran;
extern const char *pathMondes[4];
extern SDL_Rect dest;
extern CARTE *carte;

extern POLICES *polices;
extern SDL_Surface *splash_screen;
extern int y_texte, y_decalage;
extern SDL_Color bleu;

extern SDL_Surface *i_barre_aide, *i_barre_aide_vide, *i_param,
  *i_param_vierge;

enum {
  BLOC_BONUS,

  ONGLET_BONUS,

  NUM_IMAGES_VOLETS_BON
};

const char *imagesVoletsBon[NUM_IMAGES_VOLETS_BON] = {

  SHXEDIT_DATA "interface/bloc_bonus.png",
  SHXEDIT_DATA "interface/onglet_bonus.png"
};

const char *imagesBonus[NUM_BONUS] = {
  SHXEDIT_DATA "bonus/shmixgomme.png",
  SHXEDIT_DATA "bonus/vie.png",
  SHXEDIT_DATA "bonus/bouclier.png",
  SHXEDIT_DATA "bonus/armaggedon.png",
  SHXEDIT_DATA "bonus/onde.png",
  SHXEDIT_DATA "bonus/stoptemps.png",
  SHXEDIT_DATA "bonus/ultrapoint.png",
  SHXEDIT_DATA "bonus/glacon.png",
  SHXEDIT_DATA "bonus/rapide.png",
  SHXEDIT_DATA "bonus/coupdebol.png",
  
  SHXEDIT_DATA "bonus/nuit.png",
  SHXEDIT_DATA "bonus/perdbonus.png",
  SHXEDIT_DATA "bonus/inverttouches.png",
  SHXEDIT_DATA "bonus/plafond.png",
  SHXEDIT_DATA "bonus/fog.png",
  SHXEDIT_DATA "bonus/malusmap.png",
  SHXEDIT_DATA "bonus/boitesnegatives.png",
  SHXEDIT_DATA "bonus/freezeshx.png", 
  SHXEDIT_DATA "bonus/lent.png",
  SHXEDIT_DATA "bonus/hasard.png"
};

const char *aideBonus[NUM_BONUS] = {
  "(ShmiXGum) - Parameter : time (seconds)",
  "(Life) - Parameter : no parameter",
  "(Shield) - Parameter : time (seconds)",
  "(Armaggedon) - Parameter : no parameter",
  "(ShockWave) - Parameter : range of action (in game units / 1 square = 3 units)",
  "(StopTime) - Parameter : time (seconds)",
  "(UltraPoints) - Parameter : time (seconds)",
  "(Freeze shmolluxes) - Parameter : time (seconds)",
  "(High speed) - Parameter : time (seconds)",
  "(Luck) - Parameter : no parameter",
    
  
  "(MangoQuest by night) - Parameter : time (seconds)",
  "(LooseBonus) - Parameter : no parameter",
  "(InvertKeys) - Parameter : time (seconds)",
  "(Ceiling) - Parameter : time (seconds)",
  "(Deep fog) - Parameter : time (seconds)",
  "(MalusMap) - Parameter : time (seconds)",
  "(Negative dituboxes) - Parameter : time (seconds)",
  "(Freeze) - Parameter : time (seconds)",  
  "(Low speed) - Parameter : time (seconds)",
  "(Random) - Parameter : time (seconds)"
};

const int coordBonus[NUM_BONUS][2] = {

  // +66 en y
  {740, 109}, {740, 175}, {740, 241}, {740, 307}, {740, 373}, {740, 439},
  {740, 505}, {740, 571}, {740, 637}, {740, 703},

  {884, 109}, {884, 175}, {884, 241}, {884, 307}, {884, 373}, {884, 439},
  {884, 505}, {884, 571}, {884, 637}, {884, 703}
};

int TabParamBonus[NUM_BONUS] =

  { 10, 10, 10, 10, 5, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10
};

int TabMaxBonus[NUM_BONUS] =
  { 100, 100, 100, 100, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100 ,100,
  100, 100, 100, 100, 100
};

VOLET_BONUS::VOLET_BONUS()
{
  mode = BONUS;
  itemEnCours = 0;
}

VOLET_BONUS::~VOLET_BONUS()
{
  SDL_FreeSurface(i_bonus);
  SDL_FreeSurface(i_onglet);
}

void VOLET_BONUS::chargeBase()
{
  i_bonus = charge_image(imagesVoletsBon[BLOC_BONUS]);
  i_onglet = charge_image(imagesVoletsBon[ONGLET_BONUS]);

  /* i_barre_aide = charge_image (imageBarreAide[0]); i_barre_aide_vide =
     charge_image (imageBarreAide[0]); */
}

void VOLET_BONUS::chargeApercus()
{
  int compteur = 0;

  for (compteur = 0; compteur < NUM_BONUS; compteur++)
  {
    i_apercus_bonus[compteur] = charge_image(imagesBonus[compteur]);
  }

  // i_param = charge_image (imageParam[0]);
  // i_param_vierge = charge_image (imageParam[0]);
}

void VOLET_BONUS::incrusteApercus()
{
  int decalage_x, decalage_y;
  int compteur = 0;

  decalage_x = 16;
  decalage_y = 61;
  for (compteur = 0; compteur < NUM_BONUS; compteur++)
  {
    dest.x = decalage_x;
    dest.y = decalage_y;
    dest.w = i_apercus_bonus[compteur]->w;
    dest.h = i_apercus_bonus[compteur]->h;
    SDL_BlitSurface(i_apercus_bonus[compteur], NULL, i_bonus, &dest);
    if (compteur == 9)
    {
      decalage_y = 61;
      decalage_x += (132 + 12);
    }
    else
      decalage_y += 66;         // 58+8
  }

  for (compteur = 0; compteur < NUM_BONUS; compteur++)
  {
    SDL_FreeSurface(i_apercus_bonus[compteur]);
    i_apercus_bonus[compteur] = 0;
  }
}

void VOLET_BONUS::changeItem(Uint16 sourisX, Uint16 sourisY)
{

  int numero = 0;

  for (numero = 0; numero < NUM_BONUS; numero++)
  {
    if ((sourisX > coordBonus[numero][0])
        && (sourisX < coordBonus[numero][0] + 50)
        && (sourisY > coordBonus[numero][1])
        && (sourisY < coordBonus[numero][1] + 50))
    {

      itemEnCours = numero;
      mode = BONUS;
      break;
    }
  }

  afficheAide();
  rafraichit();
  rectangle(coordBonus[itemEnCours][0], coordBonus[itemEnCours][0] + 50,
            coordBonus[itemEnCours][1], coordBonus[itemEnCours][1] + 50);

}

void VOLET_BONUS::selectionne()
{
  dest.x = 724;
  dest.y = 22;
  dest.w = i_onglet->w;
  dest.h = i_onglet->h;
  SDL_BlitSurface(i_onglet, NULL, ecran, &dest);

  // polices->affiche_texte_ttf ("60", 110, 95,
  // FONT_SPLASH_PETIT, bleu, i_bonus);

  dest.x = 724;
  dest.y = 48;
  dest.w = i_bonus->w;
  dest.h = i_bonus->h;
  SDL_BlitSurface(i_bonus, NULL, ecran, &dest);

  // changeParam(paramBonus[itemEnCours], itemEnCours);

  ecritParamPartout();

  rectangle(coordBonus[itemEnCours][0], coordBonus[itemEnCours][0] + 50,
            coordBonus[itemEnCours][1], coordBonus[itemEnCours][1] + 50);

  SDL_UpdateRect(ecran, 724, 22, 300, 746);

  afficheAide();

}

void VOLET_BONUS::ecritParamPartout()
{
  int i = 0;

  for (i = 0; i < NUM_BONUS; i++)
  {
    if (i != VIE && i!=ARMAGGEDON && i!=PERDBONUS)
      changeParam(TabParamBonus[i], i);
  }
}

void VOLET_BONUS::rafraichit()
{
  dest.x = 724;
  dest.y = 48;
  dest.w = i_bonus->w;
  dest.h = i_bonus->h;
  SDL_BlitSurface(i_bonus, NULL, ecran, &dest);

  // changeParam(paramBonus[itemEnCours], itemEnCours);
  ecritParamPartout();

  SDL_UpdateRect(ecran, 724, 22, 300, 746);
}

void VOLET_BONUS::incrementeParam(unsigned short int facon)
{
  char *texte;
  texte = new char[5];
  if (itemEnCours != VIE && itemEnCours!=ARMAGGEDON && itemEnCours!=PERDBONUS)
  {

  switch (facon)
  {
  case SHX_INC_1:
    if (TabParamBonus[itemEnCours] < TabMaxBonus[itemEnCours])
      TabParamBonus[itemEnCours]++;
    break;
  case SHX_DEC_1:
    if (TabParamBonus[itemEnCours] > 0)
      TabParamBonus[itemEnCours]--;
    break;
  case SHX_INC_10:
    if (TabParamBonus[itemEnCours] < TabMaxBonus[itemEnCours] - 10)
      TabParamBonus[itemEnCours] += 10;
    else
      TabParamBonus[itemEnCours] = TabMaxBonus[itemEnCours];
    break;
  case SHX_DEC_10:
    if (TabParamBonus[itemEnCours] > 10)
      TabParamBonus[itemEnCours] -= 10;
    else
      TabParamBonus[itemEnCours] = 0;
    break;
  }

  sprintf(texte, "%d", TabParamBonus[itemEnCours]);

  // ecrasement de i_param
  dest.x = 0;
  dest.y = 0;
  dest.w = i_param_vierge->w;
  dest.h = i_param_vierge->h;
  SDL_BlitSurface(i_param_vierge, NULL, i_param, &dest);

  dest.x = coordBonus[itemEnCours][0] + 53;
  dest.y = coordBonus[itemEnCours][1] - 4;

  polices->affiche_texte_ttf(texte, 38, 35, FONT_SPLASH_PETIT, bleu, i_param);

  SDL_BlitSurface(i_param, NULL, ecran, &dest);

  rectangle(coordBonus[itemEnCours][0], coordBonus[itemEnCours][0] + 50,
            coordBonus[itemEnCours][1], coordBonus[itemEnCours][1] + 50);

  SDL_UpdateRect(ecran, dest.x, dest.y, dest.w, dest.h);
  }

  delete[]texte;
}

void VOLET_BONUS::changeParam(int valeur, int lequel)
{
  char *texte;
  texte = new char[5];

  sprintf(texte, "%d", valeur);

  TabParamBonus[lequel] = valeur;

  // ecrasement de i_param
  dest.x = 0;
  dest.y = 0;
  dest.w = i_param_vierge->w;
  dest.h = i_param_vierge->h;
  SDL_BlitSurface(i_param_vierge, NULL, i_param, &dest);

  dest.x = coordBonus[lequel][0] + 53;
  dest.y = coordBonus[lequel][1] - 4;

  polices->affiche_texte_ttf(texte, 38, 35, FONT_SPLASH_PETIT, bleu, i_param);

  SDL_BlitSurface(i_param, NULL, ecran, &dest);
  SDL_UpdateRect(ecran, dest.x, dest.y, dest.w, dest.h);

  delete[]texte;
}

void VOLET_BONUS::afficheAide()
{
  // ecrasement de i_barre_aide
  dest.x = 0;
  dest.y = 0;
  dest.w = i_barre_aide_vide->w;
  dest.h = i_barre_aide_vide->h;
  SDL_BlitSurface(i_barre_aide_vide, NULL, i_barre_aide, &dest);

  dest.x = 0;
  dest.y = 768 - i_barre_aide_vide->h + 1;

  polices->affiche_texte_ttf(aideBonus[itemEnCours], 5, 2, FONT_SPLASH_PETIT,
                             bleu, i_barre_aide);

  SDL_BlitSurface(i_barre_aide, NULL, ecran, &dest);

  SDL_UpdateRect(ecran, dest.x, dest.y, dest.w, dest.h);

}
