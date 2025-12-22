/***************************************************************************
 *   Copyright (C) 2005 by Berislav Kovacki                                *
 *   beca@sezampro.yu                                                      *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

#include <SDL.h>
#include <SDL_image.h>
#include "interlogic.h"
#include "splash.h"
#include "gfx_splash.xpm"

static SDL_Surface* imgSplash = NULL;

int splash_initialize(SDL_Surface* screen)
{
  imgSplash = IMG_ReadXPMFromArray(splash_xpm);

  if (imgSplash == NULL)
    return 0;

  return -1;
}

int splash_uninitialize(SDL_Surface* screen)
{
  if (imgSplash != NULL)
  {
    SDL_FreeSurface(imgSplash);
    imgSplash = NULL;
  }

  return -1;
}

int splash_keyboard(SDL_Surface* screen, Uint8 state, SDLKey key)
{
  if (state == SDL_PRESSED)
  {
    switch (key)
    {
      case SDLK_ESCAPE:
      case SDLK_RETURN:
      case SDLK_SPACE:
        interlogic_switch_state(screen, 0);
        break;

      default:
        break;
    }
  }

  return -1;
}

int splash_render(SDL_Surface* screen)
{
  SDL_BlitSurface(imgSplash, NULL, screen, NULL);

  return -1;
}
