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

extern SDL_Surface *i_cadre, *i_barre, *i_support_message, *i_support_message_vide;
extern SDL_Rect dest;

extern SDL_Surface *ecran;
extern POLICES *polices;
extern SDL_Surface *splash_screen;
int y_texte, y_decalage;
extern SDL_Color bleu;

enum {
  P_HAUT,
  P_DROITE_CADRE,
  P_SPLASH_SCREEN,
  P_MESSAGE,

  NUM_IMAGES
};

const char *nomsImages[NUM_IMAGES] = {
  SHXEDIT_DATA "interface/barre_haut.png",
  SHXEDIT_DATA "interface/cadre.png",
  SHXEDIT_DATA "splash.png",
  SHXEDIT_DATA "interface/emplacement_erreurs.png"
};

CODE_RETOUR chargeInterface()
{

  y_texte = 340;
  y_decalage = 25;

  affiche_image_splash();
  charge_cadre();
  return OK;
}

void affiche_image_splash()
{
  splash_screen = charge_image(nomsImages[P_SPLASH_SCREEN]);
  dest.x = 112;
  dest.y = 208;
  dest.w = splash_screen->w;
  dest.h = splash_screen->h;
  SDL_BlitSurface(splash_screen, NULL, ecran, &dest);

  polices->affiche_texte_ttf(VERSION, 501, 297, FONT_SPLASH_GROS, bleu,
                             ecran);

  SDL_UpdateRect(ecran, 0, 0, 0, 0);

}

void charge_cadre()
{
  SDL_UpdateRect(ecran, 112, 208, splash_screen->w, splash_screen->h);

  i_cadre = charge_image(nomsImages[P_DROITE_CADRE]);
  i_barre = charge_image(nomsImages[P_HAUT]);
  i_support_message = charge_image(nomsImages[P_MESSAGE]);
  i_support_message_vide = charge_image(nomsImages[P_MESSAGE]);

  y_texte += y_decalage;

}
