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
#include "credits.h"
#include "gfx_credits.xpm"

static SDL_Surface* imgCredits = NULL;

int credits_initialize(SDL_Surface* screen)
{
  imgCredits = IMG_ReadXPMFromArray(credits_xpm);

  if (imgCredits == NULL)
    return 0;

  return -1;
}

int credits_uninitialize(SDL_Surface* screen)
{
  if (imgCredits != NULL)
  {
    SDL_FreeSurface(imgCredits);
    imgCredits = NULL;
  }

  return -1;
}

int credits_render(SDL_Surface* screen)
{
  SDL_BlitSurface(imgCredits, NULL, screen, NULL);

  return -1;
}

int credits_keyboard(SDL_Surface* screen, Uint8 state, SDLKey key)
{
  if (state == SDL_PRESSED)
  {
    switch (key)
    {
      case SDLK_ESCAPE:
      case SDLK_SPACE:
      case SDLK_RETURN:
        interlogic_switch_state(screen, 0);
        break;

      default:
        break;
    }
  }

  return -1;
}
