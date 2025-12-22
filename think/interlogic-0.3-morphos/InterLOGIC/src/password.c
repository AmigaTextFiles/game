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
#include <string.h>
#include "interlogic.h"
#include "password.h"
#include "gfx_passback.xpm"
#include "gfx_passfont.xpm"

#define PASSWORD_LEFT 140
#define PASSWORD_TOP  310

#define FONT_TILE_WIDTH  48
#define FONT_TILE_HEIGHT 48

#define PASSWORD_MAX    8
#define PASSWORD_COUNT 29

static const char _passwords[PASSWORD_COUNT][PASSWORD_MAX+1] =
  {
    "ANOTHERI",
    "THERAPYQ",
    "SPACEMAN",
    "TWEEDSTR",
    "RAZORSHR",
    "SKEELOOW",
    "AZAZELDV",
    "SCAPGOAT",
    "SNAKEPIT",
    "VERSIONX",
    "MITNIKEV",
    "FANTSBAG",
    "SCOOOPEX",
    "BOOOOGUS",
    "APLHNULL",
    "FOOLEVEL",
    "LOSTIESW",
    "FEMTEXTH",
    "CRATORPA",
    "SPLISKIN",
    "WILDWRLD",
    "BRAINSAW",
    "CRYSTLSP",
    "NIRVANAF",
    "CLSTOEND",
    "REELCLOS",
    "JUSTWOLV",
    "PRENDLVL",
    "THENDLVL"
  };

static char password[PASSWORD_MAX+1];

static SDL_Surface* imgPassBack = NULL;
static SDL_Surface* imgPassFont = NULL;

int password_initialize(SDL_Surface* screen)
{
  password[0] = '\0';

  imgPassBack = IMG_ReadXPMFromArray(passback_xpm);
  imgPassFont = IMG_ReadXPMFromArray(passfont_xpm);

  if (imgPassBack == NULL || imgPassFont == NULL)
  {
    password_uninitialize(screen);
    return 0;
  }

  return -1;
}

int password_uninitialize(SDL_Surface* screen)
{
  if (imgPassBack != NULL)
  {
    SDL_FreeSurface(imgPassBack);
    imgPassBack = NULL;
  }

  if (imgPassFont != NULL)
  {
    SDL_FreeSurface(imgPassFont);
    imgPassFont = NULL;
  }

  return -1;
}

int password_render(SDL_Surface* screen)
{
  SDL_Rect rcSrc, rcDest;
  int ind;

  SDL_BlitSurface(imgPassBack, NULL, screen, NULL);

  for (ind = 0; ind < strlen(password); ind++)
  {
    rcDest.y = PASSWORD_TOP;
    rcDest.x = PASSWORD_LEFT + ind * FONT_TILE_WIDTH;

    rcSrc.x = ((password[ind] - 'A') % 6) * FONT_TILE_WIDTH;
    rcSrc.y = ((password[ind] - 'A') / 6) * FONT_TILE_HEIGHT;
    rcSrc.w = FONT_TILE_WIDTH;
    rcSrc.h = FONT_TILE_HEIGHT;

    SDL_BlitSurface(imgPassFont, &rcSrc, screen, &rcDest);
  }

  return -1;
}

int password_keyboard(SDL_Surface* screen, Uint8 state, SDLKey key)
{
  int ind;

  if (state == SDL_PRESSED)
  {
    if (key >= SDLK_a && key <= SDLK_z)
    {
      int len = strlen(password);

      if (len < PASSWORD_MAX)
      {
        password[len] = 'A' + key - SDLK_a;
        password[len+1] = '\0';
      }
    }
    else
    {
      switch (key)
      {
        case SDLK_BACKSPACE:
          if (strlen(password) > 0)
          {
            password[strlen(password)-1] = '\0';
          }
          break;

        case SDLK_RETURN:
          for (ind = 0; ind < PASSWORD_COUNT; ind++)
          {
            if (strcmp(password, _passwords[ind]) == 0)
            {
              interlogic_switch_state(screen, ind+1);
            }
          }
          break;

        case SDLK_ESCAPE:
          interlogic_switch_state(screen, -1);
          break;

        default:
          break;
      }
    }
  }

  return -1;
}

const char* password_get_level_password(int level)
{
  if (level > PASSWORD_COUNT -1)
    return NULL;

  return _passwords[level];
}
