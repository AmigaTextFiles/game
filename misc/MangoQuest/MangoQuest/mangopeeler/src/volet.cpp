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
#include "sge_draw.h"

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

SDL_Surface *i_barre_aide = 0, *i_barre_aide_vide = 0, *i_param =
  0, *i_param_vierge = 0;

const char *imageParam[1] = {
  SHXEDIT_DATA "interface/emplacement_param.png"
};

const char *imageBarreAide[1] = {
  SHXEDIT_DATA "interface/barre_bas.png"
};

VOLET::VOLET()
{
  itemEnCours = 0;
}

void VOLET::rectangle(int x1, int x2, int y1, int y2)
{
  sge_Rect(ecran, x1 - 4, y1 - 4, x2 + 3, y2 + 3, 255, 10, 10);
  sge_Rect(ecran, x1 - 3, y1 - 3, x2 + 2, y2 + 2, 255, 10, 10);
  sge_Rect(ecran, x1 - 2, y1 - 2, x2 + 1, y2 + 1, 255, 10, 10);
  sge_Rect(ecran, x1 - 1, y1 - 1, x2, y2, 255, 10, 10);

}

void VOLET::charge()
{
  chargeBase();
  chargeApercus();
  incrusteApercus();

  if (!(i_barre_aide))
    i_barre_aide = charge_image(imageBarreAide[0]);
  if (!(i_barre_aide_vide))
    i_barre_aide_vide = charge_image(imageBarreAide[0]);
  if (!(i_param))
    i_param = charge_image(imageParam[0]);
  if (!(i_param_vierge))
    i_param_vierge = charge_image(imageParam[0]);
}

void VOLET::changeItem(Uint16 sourisX, Uint16 sourisY)
{
}
void VOLET::selectionne()
{
}

void VOLET::chargeBase()
{
}
void VOLET::chargeApercus()
{
}
void VOLET::incrusteApercus()
{
}

void VOLET::afficheAide()
{
}

VOLET::~VOLET()
{
}

void VOLET::rafraichit()
{

}

void VOLET::effaceAide()
{
  // ecrasement de i_barre_aide
  dest.x = 0;
  dest.y = 0;
  dest.w = i_barre_aide_vide->w;
  dest.h = i_barre_aide_vide->h;
  SDL_BlitSurface(i_barre_aide_vide, NULL, i_barre_aide, &dest);

  dest.x = 0;
  dest.y = 768 - i_barre_aide_vide->h + 1;

  SDL_BlitSurface(i_barre_aide, NULL, ecran, &dest);

  SDL_UpdateRect(ecran, dest.x, dest.y, dest.w, dest.h);
}
