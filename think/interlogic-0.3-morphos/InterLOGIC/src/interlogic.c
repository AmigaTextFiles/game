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

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdlib.h>
#include <SDL.h>
#include "interlogic.h"
#include "mainmenu.h"
#include "splash.h"
#include "password.h"
#include "levels.h"
#include "credits.h"

#ifdef __MORPHOS__
const char *version_tag = "$VER: InterLOGIC 0.3 (29.01.2006)";
#endif

#define STATE_STARTUP   0
#define STATE_SPLASH    1
#define STATE_MAINMENU  2
#define STATE_LEVELS    3
#define STATE_CREDITS   4
#define STATE_PASSWORD  5

#define SDL_PushQuitEvent() {SDL_Event event; \
            event.type = SDL_QUIT; SDL_PushEvent(&event); }

static const char _program_title[] = "InterLOGIC V0.2";

static int interlogic_state = STATE_STARTUP;

SDL_Surface* interlogic_initialize_video();
int interlogic_keyboard(SDL_Surface* screen, Uint8 state, SDLKey key);
int interlogic_process_events(SDL_Surface* screen);
int interlogic_render(SDL_Surface* screen);
int interlogic_exit_state(SDL_Surface* screen);

SDL_Surface* interlogic_initialize_video()
{
  SDL_Surface*   screen = NULL;
  SDL_VideoInfo* pSDLVideoInfo;

  pSDLVideoInfo = SDL_GetVideoInfo();

  screen = SDL_SetVideoMode(640, 480,
    pSDLVideoInfo->vfmt->BitsPerPixel,
    SDL_HWSURFACE | SDL_DOUBLEBUF);

  SDL_WM_SetCaption(_program_title, _program_title);

  return screen;
}

int interlogic_process_events(SDL_Surface* screen)
{
  SDL_Event      event;
  int bExitGame = 0;

  while (SDL_PollEvent(&event))
  {
    switch (event.type)
    {
      case SDL_KEYDOWN:
        switch (event.key.keysym.sym)
        {
          case SDLK_F4:
            SDL_WM_ToggleFullScreen(screen);
            break;

          default:
            break;
        }
      case SDL_KEYUP:
        interlogic_keyboard(screen, event.key.state,
          event.key.keysym.sym);
        break;

      case SDL_QUIT:
        bExitGame = 1;
        break;
    }
  }

  return bExitGame;
}

int interlogic_render(SDL_Surface* screen)
{
  switch (interlogic_state)
  {
    case STATE_SPLASH:   splash_render(screen);   break;
    case STATE_MAINMENU: mainmenu_render(screen); break;
    case STATE_LEVELS:   levels_render(screen);   break;
    case STATE_PASSWORD: password_render(screen); break;
    case STATE_CREDITS:  credits_render(screen);  break;
    default: return 0;
  }

  return SDL_Flip(screen);
}

int interlogic_exit_state(SDL_Surface* screen)
{
  switch (interlogic_state)
  {
    case STATE_SPLASH:   splash_uninitialize(screen);   break;
    case STATE_MAINMENU: mainmenu_uninitialize(screen); break;
    case STATE_LEVELS:   levels_uninitialize(screen);   break;
    case STATE_PASSWORD: password_uninitialize(screen); break;
    case STATE_CREDITS:  credits_uninitialize(screen);  break;
    case STATE_STARTUP: break;
    default: return 0;
  }

  return -1;
}

int interlogic_keyboard(SDL_Surface* screen, Uint8 state, SDLKey key)
{
  switch (interlogic_state)
  {
    case STATE_SPLASH:   splash_keyboard(screen, state, key);   break;
    case STATE_MAINMENU: mainmenu_keyboard(screen, state, key); break;
    case STATE_LEVELS:   levels_keyboard(screen, state, key);   break;
    case STATE_PASSWORD: password_keyboard(screen, state, key); break;
    case STATE_CREDITS:  credits_keyboard(screen, state, key);  break;
    default: return 0;
  }

  return -1;
}

int interlogic_switch_state(SDL_Surface* screen, int code)
{
  interlogic_exit_state(screen);

  switch (interlogic_state)
  {
    case STATE_STARTUP:
      interlogic_state = STATE_SPLASH;
      splash_initialize(screen);
      break;

    case STATE_SPLASH:
      interlogic_state = STATE_MAINMENU;
      mainmenu_initialize(screen);
      break;

    case STATE_MAINMENU:
      switch (code)
      {
        case 0:
          interlogic_state = STATE_LEVELS;
          levels_initialize(screen, 0);
          break;

        case 1:
          interlogic_state = STATE_PASSWORD;
          password_initialize(screen);
          break;

        case 2:
          interlogic_state = STATE_CREDITS;
          credits_initialize(screen);
          break;

        case 3:
          interlogic_state = STATE_STARTUP;
          SDL_PushQuitEvent();
          break;
      }
      break;

    case STATE_CREDITS:
      interlogic_state = STATE_MAINMENU;
      mainmenu_initialize(screen);
      break;

    case STATE_PASSWORD:
      if (code == -1)
      {
        interlogic_state = STATE_MAINMENU;
        mainmenu_initialize(screen);
      }
      else
      {
        interlogic_state = STATE_LEVELS;
        levels_initialize(screen, code);
      }
      break;

    case STATE_LEVELS:
      if (code == -1)
      {
        interlogic_state = STATE_MAINMENU;
        mainmenu_initialize(screen);
      }
      else
      {
        interlogic_state = STATE_LEVELS;
        levels_initialize(screen, code);
      }
      break;
  }

  return -1;
}

int main(int argc, char *argv[])
{
  SDL_Surface*   screen;

  if (SDL_Init(SDL_INIT_VIDEO) < 0)
  {
    SDL_Quit();
  }

  if (!(screen = interlogic_initialize_video()))
  {
    SDL_Quit();
  }

  interlogic_switch_state(screen, 0);

  while (!interlogic_process_events(screen))
  {
    interlogic_render(screen);
  }

  interlogic_exit_state(screen);

  SDL_Quit();
  return 0;
}
