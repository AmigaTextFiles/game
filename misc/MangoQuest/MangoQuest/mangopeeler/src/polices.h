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

#ifndef _POLICES_H_
#define _POLICES_H_

enum {
  FONT_SPLASH_GROS,
  FONT_SPLASH_PETIT,

  NUM_POLICES
};

enum {
  CHARGE_CADRE,
  CHARGE_TEXTURES,
  CHARGE_GRILLE,
  CHARGE_VOLET_TEX,
  CHARGE_VOLET_BON,

  CHARGE_VOLET_SPECIAL,
  FIN,

  NUM_MESSAGES
};

class POLICES {
public:
  POLICES();
  ~POLICES();

  SDL_Rect affiche_texte_ttf(char *phrase, int x, int y, int police,
                             SDL_Color couleur, SDL_Surface * ecran);

  SDL_Rect affiche_texte_ttf(const char *phrase, int x, int y, int police,
                             SDL_Color couleur, SDL_Surface * ecran);

  void texte_splash(int lequel, SDL_Surface * ouca);
  void errorMessage(char *message);
  void cleanErrorMessage ();

  TTF_Font *lesPolices[NUM_POLICES];

  char error;
};

#endif
