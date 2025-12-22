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
#include <stdio.h>
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

enum {
  BLOC_SOL,
  BLOC_MUR,
  BLOC_PLA,

  BLOC_SOL_PASSIF,
  BLOC_MUR_PASSIF,
  BLOC_PLA_PASSIF,

  ONGLET_TEXTURES,

  NUM_IMAGES_VOLETS_TEX
};

const char *imagesVoletsTex[NUM_IMAGES_VOLETS_TEX] = {
  SHXEDIT_DATA "interface/bloc_sol_actif.png",
  SHXEDIT_DATA "interface/bloc_mur_actif.png",
  SHXEDIT_DATA "interface/bloc_plafond_actif.png",

  SHXEDIT_DATA "interface/bloc_sol_passif.png",
  SHXEDIT_DATA "interface/bloc_mur_passif.png",
  SHXEDIT_DATA "interface/bloc_plafond_passif.png",

  SHXEDIT_DATA "interface/onglet_textures.png",
};

// coordonnees (X1,Y1) des vignettes de textures à droite
const int coordTextures[36][2] = {
  // sols
  {740, 87}, {812, 87}, {884, 87}, {956, 87},
  {740, 155}, {812, 155}, {884, 155}, {956, 155},
  {740, 223}, {812, 223}, {884, 223}, {956, 223},

  // plafonds
  {740, 327}, {812, 327}, {884, 327}, {956, 327},
  {740, 395}, {812, 395}, {884, 395}, {956, 395},
  {740, 463}, {812, 463}, {884, 463}, {956, 463},

  // murs
  {740, 567}, {812, 567}, {884, 567}, {956, 567},
  {740, 635}, {812, 635}, {884, 635}, {956, 635},
  {740, 703}, {812, 703}, {884, 703}, {956, 703}
};

VOLET_TEXTURES::VOLET_TEXTURES()
{
  mode = SOL;
  itemEnCours = 0;
}

VOLET_TEXTURES::~VOLET_TEXTURES()
{
  SDL_FreeSurface(i_sol);
  SDL_FreeSurface(i_mur);
  SDL_FreeSurface(i_pla);

  SDL_FreeSurface(i_sol_passif);
  SDL_FreeSurface(i_mur_passif);
  SDL_FreeSurface(i_pla_passif);

}

void VOLET_TEXTURES::chargeBase()
{
  // polices->texte_splash (0, 135, y_texte, ecran);

  SDL_UpdateRect(ecran, 112, 208, splash_screen->w, splash_screen->h);

  i_sol = charge_image(imagesVoletsTex[BLOC_SOL]);
  i_mur = charge_image(imagesVoletsTex[BLOC_MUR]);
  i_pla = charge_image(imagesVoletsTex[BLOC_PLA]);

  i_sol_passif = charge_image(imagesVoletsTex[BLOC_SOL_PASSIF]);
  i_mur_passif = charge_image(imagesVoletsTex[BLOC_MUR_PASSIF]);
  i_pla_passif = charge_image(imagesVoletsTex[BLOC_PLA_PASSIF]);

  i_onglet = charge_image(imagesVoletsTex[ONGLET_TEXTURES]);
}

void VOLET_TEXTURES::chargeApercus()
{
  int compteur = 0;
  char *chemins_apercus_mur[N_THUMBS], *chemins_apercus_sol[N_THUMBS],
    *chemins_apercus_pla[N_THUMBS];

  // polices->texte_splash(APERCUS, 135,y_texte, ecran);
  // SDL_UpdateRect(ecran, 112,208,splash_screen->w,splash_screen->h);

  // construction des noms de chemin pour le chargement
  for (compteur = 0; compteur < N_THUMBS; compteur++)
  {

    chemins_apercus_mur[compteur] = new char[255];

    sprintf(chemins_apercus_mur[compteur],
            SHXMAN_DATA "textures/%s/mur%02d.png", pathMondes[carte->monde],
            compteur);

    chemins_apercus_sol[compteur] = new char[255];

    sprintf(chemins_apercus_sol[compteur],
            SHXMAN_DATA "textures/%s/sol%02d.png", pathMondes[carte->monde],
            compteur);

    chemins_apercus_pla[compteur] = new char[255];

    sprintf(chemins_apercus_pla[compteur],
            SHXMAN_DATA "textures/%s/pla%02d.png", pathMondes[carte->monde],
            compteur);
  }

  // chargement des "thumbs"
  for (compteur = 0; compteur < N_THUMBS; compteur++)
  {

    i_apercus_tex_mur[compteur] =
      chargeStretch(chemins_apercus_mur[compteur], 50, 50);
    i_apercus_tex_sol[compteur] =
      chargeStretch(chemins_apercus_sol[compteur], 50, 50);
    i_apercus_tex_pla[compteur] =
      chargeStretch(chemins_apercus_pla[compteur], 50, 50);

    delete[]chemins_apercus_mur[compteur];
    delete[]chemins_apercus_sol[compteur];
    delete[]chemins_apercus_pla[compteur];
  }

  // y_texte+=y_decalage;
}

void VOLET_TEXTURES::incrusteApercus()
{
  int decalage_x, decalage_y;
  int compteur = 0;

  // remplissage des images de droite par les thumbs
  decalage_x = 16;
  decalage_y = 39;
  for (compteur = 0; compteur < N_THUMBS; compteur++)
  {
    dest.x = decalage_x;
    dest.y = decalage_y;
    dest.w = i_apercus_tex_mur[compteur]->w;
    dest.h = i_apercus_tex_mur[compteur]->h;
    SDL_BlitSurface(i_apercus_tex_mur[compteur], NULL, i_mur, &dest);
    SDL_BlitSurface(i_apercus_tex_mur[compteur], NULL, i_mur_passif, &dest);
    if ((compteur == 3) || (compteur == 7))
    {
      decalage_y += 68;
      decalage_x = 16;
    }
    else
      decalage_x += 72;
  }

  decalage_x = 16;
  decalage_y = 39;
  for (compteur = 0; compteur < N_THUMBS; compteur++)
  {
    dest.x = decalage_x;
    dest.y = decalage_y;
    dest.w = i_apercus_tex_sol[compteur]->w;
    dest.h = i_apercus_tex_sol[compteur]->h;
    SDL_BlitSurface(i_apercus_tex_sol[compteur], NULL, i_sol, &dest);
    SDL_BlitSurface(i_apercus_tex_sol[compteur], NULL, i_sol_passif, &dest);
    if ((compteur == 3) || (compteur == 7))
    {
      decalage_y += 68;
      decalage_x = 16;
    }
    else
      decalage_x += 72;
  }

  decalage_x = 16;
  decalage_y = 39;
  for (compteur = 0; compteur < N_THUMBS; compteur++)
  {
    dest.x = decalage_x;
    dest.y = decalage_y;
    dest.w = i_apercus_tex_pla[compteur]->w;
    dest.h = i_apercus_tex_pla[compteur]->h;
    SDL_BlitSurface(i_apercus_tex_pla[compteur], NULL, i_pla, &dest);
    SDL_BlitSurface(i_apercus_tex_pla[compteur], NULL, i_pla_passif, &dest);
    if ((compteur == 3) || (compteur == 7))
    {
      decalage_y += 68;
      decalage_x = 16;
    }
    else
      decalage_x += 72;
  }

  for (compteur = 0; compteur < N_THUMBS; compteur++)
  {
    SDL_FreeSurface(i_apercus_tex_mur[compteur]);
    i_apercus_tex_mur[compteur] = 0;
    SDL_FreeSurface(i_apercus_tex_sol[compteur]);
    i_apercus_tex_sol[compteur] = 0;
    SDL_FreeSurface(i_apercus_tex_pla[compteur]);
    i_apercus_tex_mur[compteur] = 0;
  }

}

void VOLET_TEXTURES::rafraichit()
{
  SDL_Surface *lesBlocs[3];

  switch (mode)
  {
  case SOL:
    lesBlocs[0] = i_sol;
    lesBlocs[1] = i_pla_passif;
    lesBlocs[2] = i_mur_passif;
    break;

  case PLAFOND:
    lesBlocs[0] = i_sol_passif;
    lesBlocs[1] = i_pla;
    lesBlocs[2] = i_mur_passif;
    break;

  case MUR:
    lesBlocs[0] = i_sol_passif;
    lesBlocs[1] = i_pla_passif;
    lesBlocs[2] = i_mur;
    break;
  }

  dest.x = 724;
  dest.y = 22;

  dest.w = i_onglet->w;
  dest.h = i_onglet->h;
  SDL_BlitSurface(i_onglet, NULL, ecran, &dest);

  dest.x = 724;
  dest.y = 48;
  dest.w = i_sol->w;
  dest.h = i_sol->h;
  SDL_BlitSurface(lesBlocs[0], NULL, ecran, &dest);

  dest.y = 288;
  dest.w = i_pla->w;
  dest.h = i_pla->h;
  SDL_BlitSurface(lesBlocs[1], NULL, ecran, &dest);

  dest.x = 724;
  dest.y = 528;
  dest.w = i_mur->w;
  dest.h = i_mur->h;
  SDL_BlitSurface(lesBlocs[2], NULL, ecran, &dest);

  SDL_UpdateRect(ecran, 724, 48, 300, 240);
  SDL_UpdateRect(ecran, 724, 288, 300, 240);
  SDL_UpdateRect(ecran, 724, 528, 300, 240);

}

void VOLET_TEXTURES::changeItem(Uint16 sourisX, Uint16 sourisY)
{
  int numero = 0;

  if (sourisY < 288)
  {
    for (numero = 0; numero < 12; numero++)
    {
      if ((sourisX > coordTextures[numero][0])
          && (sourisX < coordTextures[numero][0] + 50)
          && (sourisY > coordTextures[numero][1])
          && (sourisY < coordTextures[numero][1] + 50))
      {

        itemEnCours = numero;
        mode = SOL;
        break;
      }
    }
  }

  else if ((sourisY >= 288) && (sourisY < 528))
  {
    for (numero = 12; numero < 24; numero++)
    {
      if ((sourisX > coordTextures[numero][0])
          && (sourisX < coordTextures[numero][0] + 50)
          && (sourisY > coordTextures[numero][1])
          && (sourisY < coordTextures[numero][1] + 50))
      {

        itemEnCours = numero;
        mode = PLAFOND;
        break;
      }
    }
  }

  else if (sourisY >= 528)
  {
    for (numero = 24; numero < 36; numero++)
    {
      if ((sourisX > coordTextures[numero][0])
          && (sourisX < coordTextures[numero][0] + 50)
          && (sourisY > coordTextures[numero][1])
          && (sourisY < coordTextures[numero][1] + 50))
      {

        itemEnCours = numero;
        mode = MUR;
        break;
      }
    }
  }

  rafraichit();
  rectangle(coordTextures[itemEnCours][0], coordTextures[itemEnCours][0] + 50,
            coordTextures[itemEnCours][1],
            coordTextures[itemEnCours][1] + 50);
}

void VOLET_TEXTURES::selectionne()
{

  SDL_Surface *lesBlocs[3];

  switch (mode)
  {
  case SOL:
    lesBlocs[0] = i_sol;
    lesBlocs[1] = i_pla_passif;
    lesBlocs[2] = i_mur_passif;
    break;

  case PLAFOND:
    lesBlocs[0] = i_sol_passif;
    lesBlocs[1] = i_pla;
    lesBlocs[2] = i_mur_passif;
    break;

  case MUR:
    lesBlocs[0] = i_sol_passif;
    lesBlocs[1] = i_pla_passif;
    lesBlocs[2] = i_mur;
    break;
  }

  dest.x = 724;
  dest.y = 22;

  dest.w = i_onglet->w;
  dest.h = i_onglet->h;
  SDL_BlitSurface(i_onglet, NULL, ecran, &dest);

  dest.x = 724;
  dest.y = 48;
  dest.w = i_sol->w;
  dest.h = i_sol->h;
  SDL_BlitSurface(lesBlocs[0], NULL, ecran, &dest);

  dest.y = 288;
  dest.w = i_pla->w;
  dest.h = i_pla->h;
  SDL_BlitSurface(lesBlocs[1], NULL, ecran, &dest);

  dest.x = 724;
  dest.y = 528;
  dest.w = i_mur->w;
  dest.h = i_mur->h;
  SDL_BlitSurface(lesBlocs[2], NULL, ecran, &dest);

  rectangle(coordTextures[itemEnCours][0], coordTextures[itemEnCours][0] + 50,
            coordTextures[itemEnCours][1],
            coordTextures[itemEnCours][1] + 50);

  SDL_UpdateRect(ecran, 724, 22, 300, 746);

  effaceAide();
}

void VOLET_TEXTURES::afficheAide()
{

}
