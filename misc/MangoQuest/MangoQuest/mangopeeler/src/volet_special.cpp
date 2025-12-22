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
  BLOC_SPECIAL,

  ONGLET_SPECIAL,

  NUM_IMAGES_VOLET_SPEC
};

const char *imagesVoletsSpec[NUM_IMAGES_VOLET_SPEC] = {

  SHXEDIT_DATA "interface/bloc_autres.png",
  SHXEDIT_DATA "interface/onglet_autres.png"
};

const char *imagesSpecial[NUM_SPECIAL] = {
  SHXEDIT_DATA "autres/shmixman_g.png",
  SHXEDIT_DATA "autres/shmixman_d.png",
  SHXEDIT_DATA "autres/shmixman_h.png",
  SHXEDIT_DATA "autres/shmixman_b.png",

  SHXEDIT_DATA "autres/foyer.png",

  SHXEDIT_DATA "autres/telep_d1.png",
  SHXEDIT_DATA "autres/telep_d2.png",
  SHXEDIT_DATA "autres/telep_d3.png",
  SHXEDIT_DATA "autres/telep_d4.png",
  SHXEDIT_DATA "autres/telep_d5.png",

  SHXEDIT_DATA "autres/telep_a1.png",
  SHXEDIT_DATA "autres/telep_a2.png",
  SHXEDIT_DATA "autres/telep_a3.png",
  SHXEDIT_DATA "autres/telep_a4.png",
  SHXEDIT_DATA "autres/telep_a5.png",

  SHXEDIT_DATA "autres/temps.png",
  SHXEDIT_DATA "bonus/vie.png",
  SHXEDIT_DATA "autres/finish.png"

};

const char *aideSpecial[NUM_SPECIAL] = {
  "(Start position, looking left)",
  "(Start position, looking right)",
  "(Start position, looking up)",
  "(Start position, looking down)",

  "(Hut of shmollux) - Parameter : Number of Shmollux",

  "(Teleport 1 : gate 1)",
  "(Teleport 2 : gate 1)",
  "(Teleport 3 : gate 1)",
  "(Teleport 4 : gate 1)",
  "(Teleport 5 : gate 1)",

  "(Teleport 1 : gate 2)",
  "(Teleport 2 : gate 2)",
  "(Teleport 3 : gate 2)",
  "(Teleport 4 : gate 2)",
  "(Teleport 5 : gate 2)",

  "(Time limit) - Parameter : time (seconds) - no limit if 0",
  "(Lives) - Number of lives at the beginning of the map",
  "(Winning post) Place where you must go once you've eaten all dituboxes"
};

const int coordSpecial[NUM_SPECIAL][2] = {

  // +66 en y
  {739, 109}, {813, 109}, {882, 109}, {956, 109},

  {739, 193},

  {739, 276}, {739, 342}, {739, 408}, {739, 474}, {739, 540},

  {882, 276}, {882, 342}, {882, 408}, {882, 474}, {882, 540},

  {739, 622}, {882, 622},

  /* winning post */
  {882, 193}
};

const int coordSpecialRel[NUM_SPECIAL][2] = {

  {16, 61}, {90, 61}, {159, 61}, {233, 61},

  {16, 145},

  {16, 228}, {16, 294}, {16, 360}, {16, 426}, {16, 492},

  {159, 228}, {159, 294}, {159, 360}, {159, 426}, {159, 492},

  {16, 574}, {159, 574},

  /* winning post */
  {159, 145}
};

int TabParamSpecial[NUM_SPECIAL] =
  { 10, 10, 10, 10, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,3,-1 };
int TabMaxSpecial[NUM_SPECIAL] =
  { 100, 100, 100, 100, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
    600,5,100 };

VOLET_SPECIAL::VOLET_SPECIAL()
{
  mode = SPECIAL;
  itemEnCours = 0;

  TabParamSpecial[LIMITE_TEMPS] = carte->limiteTemps;
  TabParamSpecial[VIES] = carte->num_lives;
}

VOLET_SPECIAL::~VOLET_SPECIAL()
{
  SDL_FreeSurface(i_special);
  SDL_FreeSurface(i_onglet);
}

void VOLET_SPECIAL::chargeBase()
{
  i_special = charge_image(imagesVoletsSpec[BLOC_SPECIAL]);
  i_onglet = charge_image(imagesVoletsSpec[ONGLET_SPECIAL]);

  /* i_barre_aide = charge_image (imageBarreAide[0]); i_barre_aide_vide =
     charge_image (imageBarreAide[0]); */
}

void VOLET_SPECIAL::chargeApercus()
{
  int compteur = 0;

  for (compteur = 0; compteur < NUM_SPECIAL; compteur++)
  {
    i_apercus_special[compteur] = charge_image(imagesSpecial[compteur]);
  }

//  i_param = charge_image (imageParam[0]);
//  i_param_vierge = charge_image (imageParam[0]);
}

void VOLET_SPECIAL::incrusteApercus()
{
  // int
  // decalage_x, decalage_y;
  int compteur = 0;

  // decalage_x = 16;
  // decalage_y = 61;
  for (compteur = 0; compteur < NUM_SPECIAL; compteur++)
  {
    dest.x = coordSpecialRel[compteur][0];
    dest.y = coordSpecialRel[compteur][1];
    dest.w = i_apercus_special[compteur]->w;
    dest.h = i_apercus_special[compteur]->h;
    SDL_BlitSurface(i_apercus_special[compteur], NULL, i_special, &dest);

    /* if (compteur == 9) { decalage_y = 58; decalage_x += (132 + 12); } else
       decalage_y += 66; // 58+8 */
  }

  for (compteur = 0; compteur < NUM_SPECIAL; compteur++)
  {
    SDL_FreeSurface(i_apercus_special[compteur]);
    i_apercus_special[compteur] = 0;
  }
}

void VOLET_SPECIAL::changeItem(Uint16 sourisX, Uint16 sourisY)
{

  int numero = 0;

  for (numero = 0; numero < NUM_SPECIAL; numero++)
  {
    if ((sourisX > coordSpecial[numero][0])
        && (sourisX < coordSpecial[numero][0] + 50)
        && (sourisY > coordSpecial[numero][1])
        && (sourisY < coordSpecial[numero][1] + 50))
    {

      itemEnCours = numero;
      mode = SPECIAL;
      break;
    }
  }

  afficheAide();
  rafraichit();
  rectangle(coordSpecial[itemEnCours][0], coordSpecial[itemEnCours][0] + 50,
            coordSpecial[itemEnCours][1], coordSpecial[itemEnCours][1] + 50);

}

void VOLET_SPECIAL::selectionne()
{
  dest.x = 724;
  dest.y = 22;
  dest.w = i_onglet->w;
  dest.h = i_onglet->h;
  SDL_BlitSurface(i_onglet, NULL, ecran, &dest);

  // polices->affiche_texte_ttf ("60", 110, 95,
  // FONT_SPLASH_PETIT, bleu, i_special);

  dest.x = 724;
  dest.y = 48;
  dest.w = i_special->w;
  dest.h = i_special->h;
  SDL_BlitSurface(i_special, NULL, ecran, &dest);

  // changeParam(paramSpecial[itemEnCours], itemEnCours);

  ecritParamPartout();

  rectangle(coordSpecial[itemEnCours][0], coordSpecial[itemEnCours][0] + 50,
            coordSpecial[itemEnCours][1], coordSpecial[itemEnCours][1] + 50);

  SDL_UpdateRect(ecran, 724, 22, 300, 746);

  afficheAide();

}

void VOLET_SPECIAL::ecritParamPartout()
{
  int i = 0;

  for (i = 0; i < NUM_SPECIAL; i++)
  {
    if ((i == FOYER) || (i == LIMITE_TEMPS) || (i == VIES))
      changeParam(TabParamSpecial[i], i);
  }
}

void VOLET_SPECIAL::rafraichit()
{
  dest.x = 724;
  dest.y = 48;
  dest.w = i_special->w;
  dest.h = i_special->h;
  SDL_BlitSurface(i_special, NULL, ecran, &dest);

  // changeParam(paramSpecial[itemEnCours], itemEnCours);
  ecritParamPartout();

  SDL_UpdateRect(ecran, 724, 22, 300, 746);
}

void VOLET_SPECIAL::incrementeParam(unsigned short int facon)
{
  char *texte;

  if ((itemEnCours == FOYER) || (itemEnCours == LIMITE_TEMPS) || (itemEnCours == VIES))
  {

    texte = new char[5];

    switch (facon)
    {
    case SHX_INC_1:
      if (TabParamSpecial[itemEnCours] < TabMaxSpecial[itemEnCours])
        TabParamSpecial[itemEnCours]++;
      break;
    case SHX_DEC_1:
      if (itemEnCours == VIES) {
	if (TabParamSpecial[itemEnCours] > 1)
	  TabParamSpecial[itemEnCours]--;
      }
      else {
	if (TabParamSpecial[itemEnCours] > 0)
	  TabParamSpecial[itemEnCours]--;
      }
      break;
    case SHX_INC_10:
      if (TabParamSpecial[itemEnCours] < TabMaxSpecial[itemEnCours] - 10)
        TabParamSpecial[itemEnCours] += 10;
      else
        TabParamSpecial[itemEnCours] = TabMaxSpecial[itemEnCours];
      break;
    case SHX_DEC_10:
      if (TabParamSpecial[itemEnCours] > 10)
        TabParamSpecial[itemEnCours] -= 10;
      else {
        if (itemEnCours == VIES) TabParamSpecial[itemEnCours] = 1;
	else TabParamSpecial[itemEnCours] = 0;
      }
      break;
    }

    // il faut mettre a jour la valeur de la limite dans CARTE
    if (itemEnCours == LIMITE_TEMPS)
      carte->limiteTemps = TabParamSpecial[itemEnCours];

    if (itemEnCours == VIES)
      carte->num_lives = TabParamSpecial[itemEnCours];

    sprintf(texte, "%d", TabParamSpecial[itemEnCours]);

    dest.x = 0;
    dest.y = 0;
    dest.w = i_param_vierge->w;
    dest.h = i_param_vierge->h;
    SDL_BlitSurface(i_param_vierge, NULL, i_param, &dest);

    dest.x = coordSpecial[itemEnCours][0] + 53;
    dest.y = coordSpecial[itemEnCours][1] - 4;

    polices->affiche_texte_ttf(texte, 38, 35, FONT_SPLASH_PETIT, bleu,
                               i_param);

    SDL_BlitSurface(i_param, NULL, ecran, &dest);

    rectangle(coordSpecial[itemEnCours][0], coordSpecial[itemEnCours][0] + 50,
              coordSpecial[itemEnCours][1],
              coordSpecial[itemEnCours][1] + 50);

    SDL_UpdateRect(ecran, dest.x, dest.y, dest.w, dest.h);

    delete[]texte;
  }
}

void VOLET_SPECIAL::changeParam(int valeur, int lequel)
{
  // SDL_Rect dest2;
  char *texte;
  texte = new char[5];

  sprintf(texte, "%d", valeur);

  TabParamSpecial[lequel] = valeur;

  // ecrasement de i_param
  dest.x = 0;
  dest.y = 0;
  dest.w = i_param_vierge->w;
  dest.h = i_param_vierge->h;
  SDL_BlitSurface(i_param_vierge, NULL, i_param, &dest);

  dest.x = coordSpecial[lequel][0] + 53;
  dest.y = coordSpecial[lequel][1] - 4;

  polices->affiche_texte_ttf(texte, 38, 35, FONT_SPLASH_PETIT, bleu, i_param);

  SDL_BlitSurface(i_param, NULL, ecran, &dest);

  /* rectangle (coordSpecial[lequel][0], coordSpecial[lequel][0] + 50,
     coordSpecial[lequel][1], coordSpecial[lequel][1] + 50); */

  SDL_UpdateRect(ecran, dest.x, dest.y, dest.w, dest.h);

  delete[]texte;
}

void VOLET_SPECIAL::afficheAide()
{
  // ecrasement de i_barre_aide
  dest.x = 0;
  dest.y = 0;
  dest.w = i_barre_aide_vide->w;
  dest.h = i_barre_aide_vide->h;
  SDL_BlitSurface(i_barre_aide_vide, NULL, i_barre_aide, &dest);

  dest.x = 0;
  dest.y = 768 - i_barre_aide_vide->h + 1;

  polices->affiche_texte_ttf(aideSpecial[itemEnCours], 5, 2,
                             FONT_SPLASH_PETIT, bleu, i_barre_aide);

  SDL_BlitSurface(i_barre_aide, NULL, ecran, &dest);

  SDL_UpdateRect(ecran, dest.x, dest.y, dest.w, dest.h);

}
