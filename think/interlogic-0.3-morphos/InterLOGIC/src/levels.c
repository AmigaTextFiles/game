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
#include "levels.h"
#include "levelinfo.h"
#include "password.h"
#include "gfx_passfont.xpm"
#include "gfx_level.xpm"
#include "gfx_player.xpm"
#include "gfx_tiles.xpm"
#include "gfx_clock.xpm"
#include "gfx_fontnum.xpm"
#include "gfx_timesup.xpm"
#include "gfx_lvlcomp.xpm"
#include "gfx_gameend.xpm"

#define CLOCK_POSITION_X 10
#define CLOCK_POSITION_Y 10
#define TIME_POSITION_X 75
#define TIME_POSITION_Y 15
#define TIMESUP_POSITION_X 200
#define TIMESUP_POSITION_Y 192
#define LEVELCOMP_POSITION_X 190
#define LEVELCOMP_POSITION_Y 180
#define PASSWORD_POSITION_X 140
#define PASSWORD_POSITION_Y 320

#define PASSFONT_TILE_W 48
#define PASSFONT_TILE_H 48

#define PASSWORD_LENGTH 8

#define PLAYER_TOP      0
#define PLAYER_LEFT     1
#define PLAYER_RIGHT    2
#define PLAYER_BOTTOM   3

#define MESSAGE_DELAY   3000

#define PLAYER_ANIM_TIME        300
#define BALL_ANIM_TIME          200

#define MAX_BALL_ANIM   15

static SDL_Surface* imgLevel    = NULL;
static SDL_Surface* imgPlayer   = NULL;
static SDL_Surface* imgTiles    = NULL;
static SDL_Surface* imgClock    = NULL;
static SDL_Surface* imgFontNum  = NULL;
static SDL_Surface* imgTimesUp  = NULL;
static SDL_Surface* imgLevelComp= NULL;
static SDL_Surface* imgGameEnd  = NULL;
static SDL_Surface* imgPassFont = NULL;

static Uint32 unLevelStart      = 0;
static Uint32 unPlayerAnim      = 0;
static Uint32 unBallAnim        = 0;
static Uint32 unLevelComp       = 0;
static Uint32 unTimesUp         = 0;

static int nCurLevel;
static level_info level_data;

static int levels_render_time(SDL_Surface* screen);
static int levels_render_tiles(SDL_Surface* screen);
static int levels_process_input();
static int levels_process_balls();
static int levels_level_complete(SDL_Surface* screen);

int levels_initialize(SDL_Surface* screen, int code)
{
  imgLevel = IMG_ReadXPMFromArray(level_xpm);
  imgPlayer = IMG_ReadXPMFromArray(player_xpm);
  imgTiles = IMG_ReadXPMFromArray(tiles_xpm);
  imgClock = IMG_ReadXPMFromArray(clock_xpm);
  imgFontNum = IMG_ReadXPMFromArray(fontnum_xpm);
  imgTimesUp = IMG_ReadXPMFromArray(timesup_xpm);
  imgGameEnd = IMG_ReadXPMFromArray(gameend_xpm);
  imgLevelComp = IMG_ReadXPMFromArray(lvlcomp_xpm);
  imgPassFont = IMG_ReadXPMFromArray(passfont_xpm);

  if (imgLevel == NULL || imgPlayer == NULL || imgTiles == NULL ||
      imgClock == NULL || imgFontNum == NULL || imgTimesUp== NULL ||
      imgGameEnd == NULL || imgLevelComp == NULL || imgPassFont == NULL)
  {
    levels_uninitialize(screen);
    return 0;
  }

  unLevelStart = SDL_GetTicks();
  nCurLevel = code;
  level_data = levels_info[nCurLevel];

  return -1;
}

int levels_uninitialize(SDL_Surface* screen)
{
  if (imgLevel != NULL)
  {
    SDL_FreeSurface(imgLevel);
    imgLevel = NULL;
  }
  if (imgPlayer != NULL)
  {
    SDL_FreeSurface(imgPlayer);
    imgPlayer = NULL;
  }
  if (imgTiles != NULL)
  {
    SDL_FreeSurface(imgTiles);
    imgTiles = NULL;
  }
  if (imgClock != NULL)
  {
    SDL_FreeSurface(imgClock);
    imgClock = NULL;
  }
  if (imgFontNum != NULL)
  {
    SDL_FreeSurface(imgFontNum);
    imgFontNum = NULL;
  }
  if (imgTimesUp != NULL)
  {
    SDL_FreeSurface(imgTimesUp);
    imgTimesUp = NULL;
  }
  if (imgGameEnd != NULL)
  {
    SDL_FreeSurface(imgGameEnd);
    imgGameEnd = NULL;
  }
  if (imgLevelComp != NULL)
  {
    SDL_FreeSurface(imgLevelComp);
    imgLevelComp = NULL;
  }

  return -1;
}

int levels_render(SDL_Surface* screen)
{
  int nBallsLeft, nI, nJ;
  SDL_Rect rcSrc, rcDest;

  SDL_BlitSurface(imgLevel, NULL, screen, NULL);

  nBallsLeft = levels_process_balls();

  rcSrc.y =0;
  rcSrc.h = rcSrc.w = imgTiles->h;
  rcSrc.x = level_data.player_turn * rcSrc.w;

  rcDest.h = rcDest.w = imgTiles->h;
  rcDest.x = level_data.player_x * rcDest.w;
  rcDest.y = level_data.player_y * rcDest.h;

  if (unPlayerAnim != 0)
  {
    Uint32 unDelta = SDL_GetTicks() - unPlayerAnim;

    if (unDelta > PLAYER_ANIM_TIME)
    {
      unsigned char nTemp;

      unPlayerAnim = 0;
      nTemp = level_data.level_map[level_data.player_y][level_data.player_x];

      if (nTemp != 0xFF)
      {
        switch (level_data.player_turn)
        {
          case PLAYER_TOP:
            level_data.level_map[level_data.player_y -1][level_data.player_x] = nTemp;
            break;

          case PLAYER_BOTTOM:
            level_data.level_map[level_data.player_y +1][level_data.player_x] = nTemp;
            break;

          case PLAYER_LEFT:
            level_data.level_map[level_data.player_y][level_data.player_x -1] = nTemp;
            break;

          case PLAYER_RIGHT:
            level_data.level_map[level_data.player_y][level_data.player_x +1] = nTemp;
            break;

          default:
            break;
        }
        level_data.level_map[level_data.player_y][level_data.player_x] = 0xFF;
      }
    }
    else
    {
      switch (level_data.player_turn)
      {
        case PLAYER_TOP:
          rcDest.y += (int)(((float)(PLAYER_ANIM_TIME - unDelta) / PLAYER_ANIM_TIME) * rcDest.h);
          break;

        case PLAYER_BOTTOM:
          rcDest.y -= (int)(((float)(PLAYER_ANIM_TIME - unDelta) / PLAYER_ANIM_TIME) * rcDest.h);
          break;

        case PLAYER_LEFT:
          rcDest.x += (int)(((float)(PLAYER_ANIM_TIME - unDelta) / PLAYER_ANIM_TIME) * rcDest.w);
          break;

        case PLAYER_RIGHT:
          rcDest.x -= (int)(((float)(PLAYER_ANIM_TIME - unDelta) / PLAYER_ANIM_TIME) * rcDest.w);
          break;

        default:
          break;
      }
    }
  }

  if (SDL_BlitSurface(imgPlayer, &rcSrc, screen, &rcDest) == -1)
    return 0;

  if (level_data.level_map[level_data.player_y][level_data.player_x] != 0xFF)
  {
    rcSrc.x = level_data.level_map[level_data.player_y][level_data.player_x] * imgTiles->h;

    switch (level_data.player_turn)
    {
      case PLAYER_TOP:
        rcDest.y = rcDest.y - imgTiles->h;
        break;

      case PLAYER_BOTTOM:
        rcDest.y = rcDest.y + imgTiles->h;
        break;

      case PLAYER_LEFT:
        rcDest.x = rcDest.x - imgTiles->h;
        break;

      case PLAYER_RIGHT:
        rcDest.x = rcDest.x + imgTiles->h;
        break;

      default:
        break;
    }

    if (SDL_BlitSurface(imgTiles, &rcSrc, screen, &rcDest) == -1)
      return 0;
  }

  if (unBallAnim != 0)
  {
    Uint32 unTicks = SDL_GetTicks() - unBallAnim;

    if (unTicks > BALL_ANIM_TIME)
    {
      for (nI = 0; nI < LEVEL_MAP_HEIGHT; nI++)
        for (nJ = 0; nJ < LEVEL_MAP_WIDTH; nJ++)
          if (level_data.level_map[nI][nJ] >= 9 &&
              level_data.level_map[nI][nJ] != 0xFF)
          {
            level_data.level_map[nI][nJ] = 0xFF;
          }
      unBallAnim = 0;
    }
    else if (unTicks > BALL_ANIM_TIME / 2)
    {
      for (nI = 0; nI < LEVEL_MAP_HEIGHT; nI++)
        for (nJ = 0; nJ < LEVEL_MAP_WIDTH; nJ++)
          if (level_data.level_map[nI][nJ] >= 9 &&
              level_data.level_map[nI][nJ] != 0xFF)
          {
            level_data.level_map[nI][nJ] = 10;
          }
    }
  }

  if (level_data.level_time - (SDL_GetTicks() - unLevelStart)/1000 <= 0)
  {
    unTimesUp = SDL_GetTicks();
  }


  if (!levels_render_tiles(screen))
    return 0;;

  if (nBallsLeft == 0)
  {
    if (!levels_level_complete(screen))
      return 0;

    if (unLevelComp == 0)
    {
      unLevelComp = SDL_GetTicks();
    }
    else if (SDL_GetTicks() - unLevelComp > MESSAGE_DELAY)
    {
      unLevelComp = 0;
      unTimesUp = 0;

      if (level_data.level_no == LEVEL_COUNT)
      {
        interlogic_switch_state(screen, 0);
      }
      else
      {
        interlogic_switch_state(screen, level_data.level_no);
      }
    }
  }
  else
  {
    if (unTimesUp != 0 && SDL_GetTicks() - unTimesUp >= MESSAGE_DELAY)
    {
      unTimesUp = 0;
      interlogic_switch_state(screen, level_data.level_no-1);
      return -1;
    }

    if (unTimesUp != 0)
    {
      SDL_Rect rcDest;

      rcDest.x = TIMESUP_POSITION_X;
      rcDest.y = TIMESUP_POSITION_Y;
      rcDest.w = imgTimesUp->w;
      rcDest.h = imgTimesUp->h;

      if (SDL_BlitSurface(imgTimesUp, NULL, screen, &rcDest) == -1)
        return 0;
    }
    else
    {
      if (!levels_render_time(screen))
        return 0;
    }
  }

  return levels_process_input();
}

int levels_keyboard(SDL_Surface* screen, Uint8 state, SDLKey key)
{
  if (state == SDL_PRESSED)
  {
    switch (key)
    {
      case SDLK_ESCAPE:
        interlogic_switch_state(screen, -1);
        break;

      case SDLK_F1:
        interlogic_switch_state(screen, level_data.level_no-1);
        break;

      default:
        break;
    }
  }

  return -1;
}

static int levels_render_time(SDL_Surface* screen)
{
  SDL_Rect rcDest, rcSrc;
  int nInd, nNum;
  Uint32 unSec;

  unSec = level_data.level_time - ((SDL_GetTicks() - unLevelStart) / 1000);

  rcDest.x = CLOCK_POSITION_X;
  rcDest.y = CLOCK_POSITION_Y;
  rcDest.w = imgClock->w;
  rcDest.h = imgClock->h;
  SDL_BlitSurface(imgClock, NULL, screen, &rcDest);

  rcDest.y = TIME_POSITION_Y;
  rcDest.x = TIME_POSITION_X + (imgFontNum->w/10)*3;
  rcDest.h = imgFontNum->h;
  rcDest.w = imgFontNum->w / 10;

  rcSrc.y = 0;
  rcSrc.h = imgFontNum->h;
  rcSrc.w = imgFontNum->w / 10;

  for (nInd = 0; nInd < 3; nInd++)
  {
    nNum = unSec % 10;

    rcSrc.x = (imgFontNum->w / 10) * nNum;
    rcDest.x -= imgFontNum->w / 10;
    if (SDL_BlitSurface(imgFontNum, &rcSrc,
        screen, &rcDest) == -1)
      return 0;

    unSec /= 10;
  }

  return -1;
}

static int levels_render_tiles(SDL_Surface* screen)
{
  SDL_Rect rcSrc, rcDest;
  int nI, nJ;

  rcSrc.y = 0;
  rcSrc.h = rcSrc.w = imgTiles->h;
  rcDest.h = rcDest.w = imgTiles->h;

  for (nI = 0; nI < LEVEL_MAP_WIDTH; nI++)
  {
    for (nJ = 0; nJ < LEVEL_MAP_HEIGHT; nJ++)
    {
      if (level_data.level_map[nJ][nI] != 0xFF &&
          !(level_data.player_x == nI &&
            level_data.player_y == nJ))
      {
        rcSrc.x = level_data.level_map[nJ][nI] * rcSrc.w;

        rcDest.x = nI * rcSrc.w;
        rcDest.y = nJ * rcSrc.h;

        if (SDL_BlitSurface(imgTiles, &rcSrc, screen, &rcDest) != 0)
          return 0;
      }
    }
  }

  return -1;
}

static int levels_process_input()
{
  Uint8* pkeyState;

  if (unPlayerAnim != 0 || unBallAnim != 0 ||
      unTimesUp != 0 || unLevelComp != 0)
    return -1;

  pkeyState = SDL_GetKeyState(NULL);

  if (pkeyState[SDLK_UP])
  {
    level_data.player_turn = PLAYER_TOP;

    if (level_data.player_y >= 1)
    {
      if (level_data.level_map[level_data.player_y -1][level_data.player_x] == 0xFF)
      {
        level_data.player_y--;
        unPlayerAnim = SDL_GetTicks();
      }
      else if (level_data.level_map[level_data.player_y -1][level_data.player_x] >= 5 &&
               level_data.level_map[level_data.player_y -1][level_data.player_x] != 0xFF)
      {
        if (level_data.player_y -2 >= 0)
        {
          if (level_data.level_map[level_data.player_y -2][level_data.player_x] == 0xFF)
          {
            level_data.player_y--;
            unPlayerAnim = SDL_GetTicks();
          }
        }
      }
    }
  }
  else if (pkeyState[SDLK_LEFT])
  {
    level_data.player_turn = PLAYER_LEFT;

    if (level_data.player_x >= 1)
    {
      if (level_data.level_map[level_data.player_y][level_data.player_x -1] == 0xFF)
      {
        level_data.player_x--;
        unPlayerAnim = SDL_GetTicks();
      }
      else if (level_data.level_map[level_data.player_y][level_data.player_x-1] >= 5 &&
               level_data.level_map[level_data.player_y][level_data.player_x-1] != 0xFF)
      {
        if (level_data.player_x -2 >= 0)
        {
          if (level_data.level_map[level_data.player_y][level_data.player_x -2] == 0xFF)
          {
            level_data.player_x--;
            unPlayerAnim = SDL_GetTicks();
          }
        }
      }
    }
  }
  else if (pkeyState[SDLK_RIGHT])
  {
    level_data.player_turn = PLAYER_RIGHT;

    if (level_data.player_x < LEVEL_MAP_WIDTH - 1)
    {
      if (level_data.level_map[level_data.player_y][level_data.player_x +1] == 0xFF)
      {
        level_data.player_x++;
        unPlayerAnim = SDL_GetTicks();
      }
      else if (level_data.level_map[level_data.player_y][level_data.player_x +1] >= 5 &&
               level_data.level_map[level_data.player_y][level_data.player_x +1] != 0xFF)
      {
        if (level_data.player_x +2 < LEVEL_MAP_WIDTH)
        {
          if (level_data.level_map[level_data.player_y][level_data.player_x +2] == 0xFF)
          {
            level_data.player_x++;
            unPlayerAnim = SDL_GetTicks();
          }
        }
      }
    }
  }
  else if (pkeyState[SDLK_DOWN])
  {
    level_data.player_turn = PLAYER_BOTTOM;

    if (level_data.player_y < LEVEL_MAP_HEIGHT - 1)
    {
      if (level_data.level_map[level_data.player_y +1][level_data.player_x] == 0xFF)
      {
        level_data.player_y++;
        unPlayerAnim = SDL_GetTicks();
      }
      else if (level_data.level_map[level_data.player_y +1][level_data.player_x] >= 5 &&
               level_data.level_map[level_data.player_y +1][level_data.player_x] != 0xFF)
      {
        if (level_data.player_y +2 < LEVEL_MAP_HEIGHT)
        {
          if (level_data.level_map[level_data.player_y +2][level_data.player_x] == 0xFF)
          {
            level_data.player_y++;
            unPlayerAnim = SDL_GetTicks();
          }
        }
      }
    }
  }

  return -1;
}

static int levels_process_balls()
{
  int nX, nY, nRes;
  int naXAnim[MAX_BALL_ANIM];
  int naYAnim[MAX_BALL_ANIM];
  int nCurAnim = 0, nOldAnim = 0;

  for (nY = 0; nY < LEVEL_MAP_HEIGHT; nY++)
  {
    for (nX = 0; nX < LEVEL_MAP_WIDTH; nX++)
    {
      nOldAnim = nCurAnim;

      if (level_data.level_map[nY][nX] >= 5 &&
          level_data.level_map[nY][nX] <= 8)
      {
        if (nY < LEVEL_MAP_HEIGHT -1)
        {
          if (level_data.level_map[nY +1][nX] == level_data.level_map[nY][nX])
          {
            naXAnim[nCurAnim] = nX;
            naYAnim[nCurAnim] = nY+1;
            nCurAnim++;
          }
        }
        if (nX < LEVEL_MAP_WIDTH -1)
        {
          if (level_data.level_map[nY][nX +1] == level_data.level_map[nY][nX])
          {
            naXAnim[nCurAnim] = nX+1;
            naYAnim[nCurAnim] = nY;
            nCurAnim++;
          }
        }
        if (nX -1 >= 0)
        {
          if (level_data.level_map[nY][nX -1] == level_data.level_map[nY][nX])
          {
            naXAnim[nCurAnim] = nX-1;
            naYAnim[nCurAnim] = nY;
            nCurAnim++;
          }
        }
        if (nY -1 >= 0)
        {
          if (level_data.level_map[nY -1][nX] == level_data.level_map[nY][nX])
          {
            naXAnim[nCurAnim] = nX;
            naYAnim[nCurAnim] = nY-1;
            nCurAnim++;
          }
        }

        if (nOldAnim != nCurAnim)
        {
          naXAnim[nCurAnim] = nX;
          naYAnim[nCurAnim] = nY;
          nCurAnim++;
        }
      }
    }
  }

  if (nCurAnim > 0)
  {
    for (nX = 0; nX < nCurAnim; nX++)
      level_data.level_map[naYAnim[nX]][naXAnim[nX]] = 9;
      unBallAnim = SDL_GetTicks();
  }

  nRes = 0;
  for (nY = 0; nY < LEVEL_MAP_HEIGHT; nY++)
  {
    for (nX = 0; nX < LEVEL_MAP_WIDTH; nX++)
    {
      if (level_data.level_map[nY][nX] >= 5 &&
          level_data.level_map[nY][nX] <= 8)
        nRes++;
    }
  }

  return nRes;
}

static int levels_level_complete(SDL_Surface* screen)
{
  if (level_data.level_no < LEVEL_COUNT)
  {
    SDL_Rect rcDest, rcSrc;
    int nInd, nPassChar;

    const char* password = password_get_level_password(level_data.level_no -1);

    rcDest.x = LEVELCOMP_POSITION_X;
    rcDest.y = LEVELCOMP_POSITION_Y;
    rcDest.w = imgLevelComp->w;
    rcDest.h = imgLevelComp->h;

    if (SDL_BlitSurface(imgLevelComp, NULL, screen, &rcDest) == -1)
      return 0;

    rcDest.x = PASSWORD_POSITION_X;
    rcDest.y = PASSWORD_POSITION_Y;
    rcDest.w = rcSrc.w = PASSFONT_TILE_W;
    rcDest.h = rcSrc.h = PASSFONT_TILE_H;

    for (nInd = 0; nInd < PASSWORD_LENGTH; nInd++)
    {
      nPassChar = password[nInd] - 'A';

      rcSrc.x = PASSFONT_TILE_W * (nPassChar % 6);
      rcSrc.y = PASSFONT_TILE_H * (nPassChar / 6);

      if (SDL_BlitSurface(imgPassFont, &rcSrc, screen, &rcDest) == -1)
        return 0;

      rcDest.x += PASSFONT_TILE_W;
    }
  }
  else
  {
    SDL_Rect rcDest;

    rcDest.w = imgGameEnd->w;
    rcDest.h = imgGameEnd->h;
    rcDest.x = LEVELCOMP_POSITION_X;
    rcDest.y = LEVELCOMP_POSITION_Y;

    if (SDL_BlitSurface(imgGameEnd, NULL, screen, &rcDest) == -1)
      return 0;
  }

  return -1;
}
