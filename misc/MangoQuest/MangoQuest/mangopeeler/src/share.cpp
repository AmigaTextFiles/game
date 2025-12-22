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
#include "version.h"
#endif
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <SDL/SDL.h>
#include <SDL/SDL_ttf.h>
#include <SDL/SDL_image.h>

#include "share.h"
#include "SDLStretch.h"

/* 
+-----------------------------------------------------------------
| Nom : charge_image
| Arguments : pointeur sur caractere : le chemin du fichier 
| Retour : pointeur sur SDL_Surface : la surface créée
| Fonction : charge un fichier .bmp, en fait une SDL_Surface 
|            convertie au format d'affichage courant
+------------------------------------------------------------------ */

SDL_Surface *charge_image(const char *chemin)
{
  SDL_Surface *temporaire;
  SDL_Surface *image;

  if (!(temporaire = IMG_Load(chemin)))
  {
    fprintf(stderr, "Erreur fatale -> %s\n", SDL_GetError());
    exit(0);
    return NULL;
  }

  if (!(image = SDL_DisplayFormat(temporaire)))
  {
    fprintf(stderr, "Erreur fatale -> %s\n", SDL_GetError());
    exit(0);
    return NULL;

  }

  SDL_FreeSurface(temporaire);

  return image;
}

SDL_Surface *chargeStretch(const char *chemin, int xVoulu, int yVoulu)
{
  SDL_Surface *temporaire;
  SDL_Surface *temporaire2;
  SDL_Surface *image;

  if (!(temporaire = IMG_Load(chemin)))
  {
    fprintf(stderr, "Erreur fatale -> %s\n", SDL_GetError());
    exit(0);
    return NULL;
  }

  if (!(temporaire2 = SDL_DisplayFormat(temporaire)))
  {
    fprintf(stderr, "Erreur fatale -> %s\n", SDL_GetError());
    exit(0);
    return NULL;

  }

  image =
    SDL_AllocSurface(SDL_SWSURFACE, xVoulu, yVoulu,
                     temporaire2->format->BitsPerPixel, 0, 0, 0, 0);

  SDL_StretchSurface(image, 0, 0, xVoulu - 1, yVoulu, temporaire2, 0, 0,
                     temporaire2->w, temporaire2->h);

  SDL_FreeSurface(temporaire);
  SDL_FreeSurface(temporaire2);

  return image;
}
