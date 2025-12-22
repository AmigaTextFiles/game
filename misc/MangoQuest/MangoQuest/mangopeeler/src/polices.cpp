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

#include "polices.h"

extern SDL_Surface *i_support_message, *i_support_message_vide, *ecran;

const char *chemins_fonts[NUM_POLICES] = {
  SHXEDIT_DATA "fonts/font.ttf",
  SHXEDIT_DATA "fonts/tahomabd.ttf"
};

const char *messages_splash[NUM_MESSAGES] = {
  "Loading user interface...",
  "Loading textures...",
  "Loading grid...",
  "Loading Textures panel...",
  "Loading Bonus panel...",

  "Loading Other panel...",
  "Peeling configuration file..."
};

const int coordMessagesY[NUM_MESSAGES] =

  { 340, 365, 390, 415, 440, 465, 490 };

POLICES::POLICES()
{
  if (!
      (lesPolices[FONT_SPLASH_GROS] =
       TTF_OpenFont(chemins_fonts[FONT_SPLASH_GROS], 18)))
  {
    fprintf(stderr, "Error (TTF file %s) : %s\n", chemins_fonts[FONT_SPLASH_GROS], SDL_GetError());
    exit(2);
  }
  TTF_SetFontStyle(lesPolices[FONT_SPLASH_GROS], TTF_STYLE_NORMAL);

  if (!
      (lesPolices[FONT_SPLASH_PETIT] =
       TTF_OpenFont(chemins_fonts[FONT_SPLASH_PETIT], 16)))
  {
    fprintf(stderr, "Error (TTF file %s) : %s\n", chemins_fonts[FONT_SPLASH_PETIT],SDL_GetError());
    exit(2);
  }
  TTF_SetFontStyle(lesPolices[FONT_SPLASH_PETIT], TTF_STYLE_ITALIC);

  error=0;
}

POLICES::~POLICES()
{
  TTF_CloseFont(lesPolices[FONT_SPLASH_GROS]);
  TTF_CloseFont(lesPolices[FONT_SPLASH_PETIT]);
}

SDL_Rect POLICES::affiche_texte_ttf(char *phrase, int x, int y, int police,
                                    SDL_Color couleur, SDL_Surface * ouca)
{
  SDL_Surface *texte;

  SDL_Rect dest;

  texte = TTF_RenderText_Blended(lesPolices[police], phrase, couleur);
  // SDL_SetColorKey(texte, SDL_SRCCOLORKEY, SDL_MapRGB(texte->format,
  // 255,255,255));
  // texte = TTF_RenderText_Shaded(police, phrase, black, white);
  dest.x = x;
  dest.y = y;
  dest.w = texte->w;
  dest.h = texte->h;
  SDL_BlitSurface(texte, NULL, ouca, &dest);

  return dest;
}

SDL_Rect POLICES::affiche_texte_ttf(const char *phrase, int x, int y,
                                    int police, SDL_Color couleur,
                                    SDL_Surface * ouca)
{
  SDL_Surface *texte;

  SDL_Rect dest;

  texte = TTF_RenderText_Blended(lesPolices[police], phrase, couleur);
  // SDL_SetColorKey(texte, SDL_SRCCOLORKEY, SDL_MapRGB(texte->format,
  // 255,255,255));
  // texte = TTF_RenderText_Shaded(police, phrase, black, white);
  dest.x = x;
  dest.y = y;
  dest.w = texte->w;
  dest.h = texte->h;
  SDL_BlitSurface(texte, NULL, ouca, &dest);

  return dest;
}


void POLICES::texte_splash(int lequel, SDL_Surface * ouca)
{
  SDL_Surface *texte;
  SDL_Rect dest;
  SDL_Color couleur = { 20, 20, 35, 0 };

  texte =
    TTF_RenderText_Blended(lesPolices[FONT_SPLASH_PETIT],
                           messages_splash[lequel], couleur);
  dest.x = 135;
  dest.y = coordMessagesY[lequel];
  dest.w = texte->w;
  dest.h = texte->h;
  SDL_BlitSurface(texte, NULL, ouca, &dest);
  SDL_UpdateRect(ouca, dest.x, dest.y, dest.w, dest.h);
}

void POLICES::errorMessage(char *message)
{
  SDL_Surface *texte;
  SDL_Rect dest;
  SDL_Color couleur = { 20, 20, 35, 0 };

  dest.x = 0;
  dest.y = 0;
  dest.w = i_support_message_vide->w;
  dest.h = i_support_message_vide->h;
  SDL_BlitSurface(i_support_message_vide, NULL, i_support_message, &dest);

  texte =
    TTF_RenderText_Blended(lesPolices[FONT_SPLASH_PETIT], message, couleur);
  dest.x = 12;
  dest.y = 2;
  dest.w = texte->w;
  dest.h = texte->h;
  SDL_BlitSurface(texte, NULL, i_support_message, &dest);

  dest.x = 0;
  dest.y = 22;
  dest.w = i_support_message->w;
  dest.h = i_support_message->h;
  SDL_BlitSurface(i_support_message, NULL, ecran, &dest);

  SDL_UpdateRect(ecran, dest.x, dest.y, dest.w, dest.h);

  error=1;
}

void POLICES::cleanErrorMessage ()
{
  SDL_Rect dest;
  
  dest.x = 0;
  dest.y = 22;
  dest.w = i_support_message_vide->w;
  dest.h = i_support_message_vide->h;
  SDL_BlitSurface(i_support_message_vide, NULL, ecran, &dest);
  SDL_UpdateRect(ecran, dest.x, dest.y, dest.w, dest.h);

  error=0;
}
