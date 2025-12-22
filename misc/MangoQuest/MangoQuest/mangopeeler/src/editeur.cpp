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

#include "geom.h"
#include "portals.h"
#include "bonus.h"
#include "secteur.h"
#include "labyr.h"
#include "config_file.h"

SDL_Surface *i_cadre, *i_barre, *i_support_message, *i_support_message_vide;
SDL_Surface *splash_screen;

SDL_Rect dest;

int compteur;
int fin;
char plein_ecran;
extern SDL_Surface *ecran;

CLIQUE_ET_GLISSE *clique;
POLICES *polices;

CARTE *carte;

VOLET *pVolet;
VOLET_TEXTURES *pVTex;
VOLET_BONUS *pVBon;
VOLET_SPECIAL *pVSpe;

LABYRINTHE *labyr;

SDL_Color bleu = { 20, 20, 35, 0 };

const char *pathMondes[4] = {
  "indus",
  "caraibes",
  "mines",
  "inconnu"
};

int fichier_existe(char *fichier)
{
  FILE *testFichier;

  if (!(testFichier = fopen(fichier, "rb")))
  {
    return 0;
  }
  else
  {
    fclose(testFichier);
    return 1;
  }
}

void charge_tout(int tailleMap, int mondeMap, char *fichierMap)
{
  fin = compteur = plein_ecran = 0;
  int testFichier = 0;

  polices = new POLICES;
  carte = new CARTE();

  // si le fichier n'existe pas deja, on cree la carte
  if (!(testFichier = fichier_existe(fichierMap)))
  {
    printf("Creating a new map\n");
    carte->nouvelleCarte(tailleMap, mondeMap, fichierMap);
  }

  // sinon on la charge
  else
  {
    printf("Loading an existing map.\n");
    carte->charger(fichierMap);
  }

  clique = new CLIQUE_ET_GLISSE(carte->taille);

  affiche_image_splash();

  polices->texte_splash(CHARGE_CADRE, ecran);
  charge_cadre();

  polices->texte_splash(CHARGE_TEXTURES, ecran);
  carte->chargeBitmaps(splash_screen, polices);
  polices->texte_splash(CHARGE_GRILLE, ecran);
  carte->chargeGrille(splash_screen, polices);

  if (carte->chargee)
  {
    carte->concretiseCarte();
  }

  pVTex = new VOLET_TEXTURES;
  pVBon = new VOLET_BONUS;
  pVSpe = new VOLET_SPECIAL;

  polices->texte_splash(CHARGE_VOLET_TEX, ecran);
  pVTex->charge();
  polices->texte_splash(CHARGE_VOLET_BON, ecran);
  pVBon->charge();
  polices->texte_splash(CHARGE_VOLET_SPECIAL, ecran);
  pVSpe->charge();

  pVolet = pVTex;

  polices->texte_splash(FIN, ecran);
  read_config_file();

  affiche_interface(1);
}

void detruit_tout()
{
  delete clique;
  delete polices;
  delete carte;
  SDL_FreeSurface(i_cadre);
  SDL_FreeSurface(i_support_message);
  SDL_FreeSurface(i_barre);
  SDL_FreeSurface(splash_screen);}

void toggle_plein_ecran()
{
  int balnave = 0;

  if (!(plein_ecran))
  {
    ecran = SDL_SetVideoMode(1024, 768, 16, SDL_HWSURFACE | SDL_FULLSCREEN);
    plein_ecran = 1;
    balnave = 1;
    affiche_interface(0);
    SDL_UpdateRect(ecran, 0, 0, 0, 0);
  }

  if ((plein_ecran) && (!(balnave)))
  {
    ecran = SDL_SetVideoMode(1024, 768, 16, SDL_HWSURFACE);
    plein_ecran = 0;
    affiche_interface(0);
    SDL_UpdateRect(ecran, 0, 0, 0, 0);
  }

}

void affiche_interface(int avec_splash)
{

  dest.x = 0;                   // bare d etat en haut
  dest.y = 0;
  dest.w = i_barre->w;
  dest.h = i_barre->h;
  SDL_BlitSurface(i_barre, NULL, ecran, &dest);

  dest.x = 0;                   // cadre 
  dest.y = 22;
  dest.w = i_cadre->w;
  dest.h = i_cadre->h;
  SDL_BlitSurface(i_cadre, NULL, ecran, &dest);

  if (avec_splash)
  {
    fauxSplash();
  }

  SDL_UpdateRect(ecran, 0, 0, 0, 0);

  pVolet->selectionne();

  // SDL_UpdateRect (ecran, 0, 0, 0, 0);

  // pour faire de l'effet
  if (avec_splash)
  {
    SDL_Delay(1000);

  }

  dest.x = 12;                  // grille
  dest.y = 45;
  dest.w = carte->i_grilles[SOL]->w;
  dest.h = carte->i_grilles[SOL]->h;
  SDL_BlitSurface(carte->i_grilles[SOL], NULL, ecran, &dest);

  SDL_UpdateRect(ecran, 12, 45, 700, 700);

}

void fauxSplash()
{
  int i = 0;

  dest.x = 112;
  dest.y = 208;
  dest.w = splash_screen->w;
  dest.h = splash_screen->h;
  SDL_BlitSurface(splash_screen, NULL, ecran, &dest);

  polices->affiche_texte_ttf(VERSION, 501, 297, FONT_SPLASH_GROS, bleu,
                             ecran);

  for (i = 0; i < NUM_MESSAGES; i++)
  {
    polices->texte_splash(i, ecran);
  }

}

void loop_moi_ca()
{
//Uint8 *keys;
  SDLMod modifs;
  int flagCTRL=0;

  polices->errorMessage(" Welcome to Mango Peeler. Press F2 to save your map once you've finished");

  while (!fin)
  {
    modifs = SDL_GetModState();
    // /////////////////////////////////////////////////////////////////////
    {
      SDL_Event event;
      SDL_WaitEvent(&event);
      //while (SDL_PollEvent(&event))
      //{
        if (event.type == SDL_QUIT)
        {
          fin = 1;
        }

        if (event.type == SDL_KEYDOWN)
        {
          switch (event.key.keysym.sym)
          {
          case SDLK_ESCAPE:
            fin = 1;
            break;
          case SDLK_F12:
            SDL_SaveBMP(ecran, "capture.bmp");
            break;
          case SDLK_F1:
            toggle_plein_ecran();
            break;
          case SDLK_F2:
            carte->sauvegarder();
            break;
          case SDLK_UP:
            if (pVolet->getMode() == BONUS)
            {
              if (modifs & KMOD_SHIFT)
                pVBon->incrementeParam(SHX_INC_10);
              else
                pVBon->incrementeParam(SHX_INC_1);
            }

            if (pVolet->getMode() == SPECIAL)
            {
              if (modifs & KMOD_SHIFT)
                pVSpe->incrementeParam(SHX_INC_10);
              else
                pVSpe->incrementeParam(SHX_INC_1);
            }

            break;

          case SDLK_DOWN:
            if (pVolet->getMode() == BONUS)
            {
              if (modifs & KMOD_SHIFT)
                pVBon->incrementeParam(SHX_DEC_10);
              else
                pVBon->incrementeParam(SHX_DEC_1);
            }

            if (pVolet->getMode() == SPECIAL)
            {

              if (modifs & KMOD_SHIFT)
                pVSpe->incrementeParam(SHX_DEC_10);
              else
                pVSpe->incrementeParam(SHX_DEC_1);
            }

            break;
          default:
            break;
          }
        }

        if ((event.type == SDL_MOUSEBUTTONDOWN)
            || (event.type == SDL_MOUSEBUTTONUP))
        {

	  //if (polices->error) polices->cleanErrorMessage();

          // dans la zone du plan
          if ((event.button.x > 12) && (event.button.x < 712)
              && (event.button.y > 45) && (event.button.y < 745))
          {

            // on appuie sur le bouton
            if ((event.button.state == SDL_PRESSED)
                &&
                (!((pVolet->getMode() == SPECIAL)
                   && (pVolet->itemEnCours == LIMITE_TEMPS))))
	      {
		if (modifs & KMOD_CTRL) flagCTRL=1;
		else flagCTRL=0;
		clique->commence(&event);
	      }

          }

          // on relache le bouton
          if ((event.button.state == SDL_RELEASED) && (clique->en_cours))
          {

            // ajout de cases (clique gauche)
            if (event.button.button == 1)
            {
              clique->termineAjout(&event, pVolet->itemEnCours,
                                   pVolet->getMode(), flagCTRL);
            }
            // suppression de cases (clique droit)
            else
            {
              clique->termineEnleve(&event, pVolet->getMode(), pVolet->itemEnCours, flagCTRL);
            }

            carte->afficherGrille(pVolet->getMode());

          }
          // dans la zone des changements onglets
          if ((event.button.x > 724) && (event.button.x < 824)
              && (event.button.y > 22) && (event.button.y < 48))
          {

            pVolet = pVTex;
            pVolet->selectionne();
            carte->afficherGrille(pVolet->getMode());

          }

          if ((event.button.x > 824) && (event.button.x < 924)
              && (event.button.y > 22) && (event.button.y < 48))
          {

            pVolet = pVBon;
            pVolet->selectionne();
            carte->afficherGrille(pVolet->getMode());

          }

          if ((event.button.x > 924) && (event.button.x < 1024)
              && (event.button.y > 22) && (event.button.y < 48))
          {

            pVolet = pVSpe;
            pVolet->selectionne();
            carte->afficherGrille(pVolet->getMode());

          }

          if ((event.button.x > 724) && (event.button.x < 1024)
              && (event.button.y > 48) && (event.button.y < 768)
              && (event.button.state == SDL_PRESSED))
          {

            pVolet->changeItem(event.button.x, event.button.y);
            carte->afficherGrille(pVolet->getMode());

          }

        }

        if ((event.type == SDL_MOUSEMOTION) && (clique->en_cours)
	    && (pVolet->getMode() != SPECIAL) && (pVolet->getMode() != BONUS))
        {

          clique->rectangle(&event, ecran,
                            carte->i_grilles[pVolet->getMode()]);
        }
      //}
    }
    // ///////////////////////////////////////////////////////////////////////

  }

}
