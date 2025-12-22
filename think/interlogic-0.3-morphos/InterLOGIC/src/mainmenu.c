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
#include "mainmenu.h"
#include "gfx_mainmenu.xpm"
#include "gfx_menuglow.xpm"

#define MAINMENU_OPTIONCOUNT 4

static SDL_Rect _rcMenuOptionSrc[MAINMENU_OPTIONCOUNT] =
{
  {0,   0, 390, 45},
  {0,  60, 390, 60},
  {0, 120, 390, 60},
  {0, 180, 390, 60}
};

static SDL_Rect _rcMenuOptionDest[MAINMENU_OPTIONCOUNT] =
{
  {130, 180, 390, 45},
  {130, 240, 390, 60},
  {130, 300, 390, 60},
  {130, 360, 390, 60}
};

static int nSelMenuItem = 0;
static SDL_Surface* imgMainMenu = NULL;
static SDL_Surface* imgMenuGlow = NULL;

int mainmenu_initialize(SDL_Surface* screen)
{
  nSelMenuItem = 0;

  imgMainMenu = IMG_ReadXPMFromArray(mainmenu_xpm);
  imgMenuGlow = IMG_ReadXPMFromArray(menuglow_xpm);

  if (imgMainMenu == NULL || imgMenuGlow == NULL)
  {
    mainmenu_uninitialize(screen);
    return 0;
  }

  return -1;
}

int mainmenu_uninitialize(SDL_Surface* screen)
{
  if (imgMenuGlow != NULL)
  {
    SDL_FreeSurface(imgMenuGlow);
    imgMenuGlow = NULL;
  }

  if (imgMainMenu != NULL)
  {
    SDL_FreeSurface(imgMainMenu);
    imgMainMenu = NULL;
  }

  return -1;
}

int mainmenu_render(SDL_Surface* screen)
{
  SDL_BlitSurface(imgMainMenu, NULL, screen, NULL);
  SDL_BlitSurface(imgMenuGlow, &_rcMenuOptionSrc[nSelMenuItem],
    screen, &_rcMenuOptionDest[nSelMenuItem]);

  return -1;
}

int mainmenu_keyboard(SDL_Surface* screen, Uint8 state, SDLKey key)
{
  if (state == SDL_PRESSED)
  {
    switch (key)
    {
      case SDLK_UP:
        nSelMenuItem--;
        if (nSelMenuItem < 0)
          nSelMenuItem = MAINMENU_OPTIONCOUNT -1;
        break;

      case SDLK_DOWN:
        nSelMenuItem++;
        if (nSelMenuItem >= MAINMENU_OPTIONCOUNT)
          nSelMenuItem = 0;
        break;

      case SDLK_RETURN:
        interlogic_switch_state(screen, nSelMenuItem);
        break;

      case SDLK_ESCAPE:
        interlogic_switch_state(screen,
          MAINMENU_EXITGAME);
        break;

      default:
        break;
    }
  }

  return -1;
}
