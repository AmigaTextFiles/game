/*
  Diamond Girl - Game where player collects diamonds.
  Copyright (C) 2005  Joni Yrjana
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


  Complete license can be found in the LICENSE file.
*/

#include <SDL/SDL.h>
#include <assert.h>

#include "diamond_girl.h"
#include "BFont.h"

static SDL_Surface * graphic_blocks[0xff];
static BFont_Info * font;

int gfx_initialize(void)
{
  int rv;

  for(int i = 0; i < 0xff; i++)
    graphic_blocks[i] = NULL;

  if(SDL_InitSubSystem(SDL_INIT_VIDEO) == 0)
    {
      Uint32 flags;

      flags = SDL_HWSURFACE | SDL_DOUBLEBUF;
      if(fullscreen)
	flags |= SDL_FULLSCREEN;
      graphic_blocks[MAP_SCREEN] = SDL_SetVideoMode(800, 600, 0, flags);
      if(graphic_blocks[MAP_SCREEN] != NULL)
	{
	  char title[128];

	  snprintf(title, sizeof title, "Diamond Girl v%d.%d", (int) DIAMOND_GIRL_VERSION, (int) DIAMOND_GIRL_REVISION);
	  SDL_WM_SetCaption(title, NULL);

	  font = BFont_LoadFont(get_data_filename("gfx/font.png"));
	  if(font != NULL)
	    {
	      graphic_blocks[MAP_BORDER]            = SDL_LoadBMP(get_data_filename("gfx/game_border.bmp"));
	      graphic_blocks[MAP_SAND]              = SDL_LoadBMP(get_data_filename("gfx/sand.bmp"));
	      graphic_blocks[MAP_PLAYER_ARMOUR0]    = SDL_LoadBMP(get_data_filename("gfx/player-0.bmp"));
	      graphic_blocks[MAP_PLAYER_ARMOUR1]    = SDL_LoadBMP(get_data_filename("gfx/player-1.bmp"));
	      graphic_blocks[MAP_PLAYER_ARMOUR2]    = SDL_LoadBMP(get_data_filename("gfx/player-2.bmp"));
	      graphic_blocks[MAP_PLAYER_ARMOUR3]    = SDL_LoadBMP(get_data_filename("gfx/player-3.bmp"));
	      graphic_blocks[MAP_BOULDER]           = SDL_LoadBMP(get_data_filename("gfx/boulder.bmp"));
	      graphic_blocks[MAP_DIAMOND]           = SDL_LoadBMP(get_data_filename("gfx/diamond.bmp"));
	      graphic_blocks[MAP_ENEMY1]            = SDL_LoadBMP(get_data_filename("gfx/enemy1.bmp"));
	      graphic_blocks[MAP_ENEMY2]            = SDL_LoadBMP(get_data_filename("gfx/enemy2.bmp"));
	      graphic_blocks[MAP_EXIT_LEVEL]        = SDL_LoadBMP(get_data_filename("gfx/exit_level.bmp"));
	      graphic_blocks[MAP_BRICK]             = SDL_LoadBMP(get_data_filename("gfx/brick.bmp"));
	      graphic_blocks[MAP_BRICK_EXPANDING]   = SDL_LoadBMP(get_data_filename("gfx/brick_expanding.bmp"));
	      graphic_blocks[MAP_BRICK_UNBREAKABLE] = SDL_LoadBMP(get_data_filename("gfx/unbreakable_brick.bmp"));
	      graphic_blocks[MAP_BRICK_MORPHER]     = SDL_LoadBMP(get_data_filename("gfx/brick_morpher.bmp"));
	      graphic_blocks[MAP_SMOKE]             = SDL_LoadBMP(get_data_filename("gfx/smoke.bmp"));
	      graphic_blocks[MAP_EXTRA_LIFE_ANIM]   = SDL_LoadBMP(get_data_filename("gfx/extra_life_anim.bmp"));
	      graphic_blocks[MAP_AMEBA]             = SDL_LoadBMP(get_data_filename("gfx/ameba.bmp"));

	      /* convert surfaces for speed */
	      for(int i = 0; i < 0xff; i++)
		if(graphic_blocks[i] != NULL)
		  if(i != MAP_SCREEN)
		    {
		      SDL_Surface * s;
		      
		      s = SDL_ConvertSurface(graphic_blocks[i], graphic_blocks[MAP_SCREEN]->format, SDL_HWSURFACE);
		      if(s != NULL)
			{
			  SDL_FreeSurface(graphic_blocks[i]);
			  graphic_blocks[i] = s;
			}
		    }

	      rv = 1;
	    }
	  else
	    {
	      fprintf(stderr, "Failed to load font 'gfx/font.png'.\n");
	      rv = 0;
	    }
	}
      else
	{
	  fprintf(stderr, "Failed to setup screen: %s\n", SDL_GetError());
	  rv = 0;
	}
    }
  else
    {
      fprintf(stderr, "Failed to initialize SDL VIDEO: %s\n", SDL_GetError());
      rv = 0;
    }

  return rv;
}

void gfx_cleanup(void)
{
  for(int i = 0; i < 0xff; i++)
    if(graphic_blocks[i] != NULL)
      if(i != MAP_SCREEN)
	SDL_FreeSurface(graphic_blocks[i]);
  BFont_FreeFont(BFont_GetCurrentFont());
  SDL_QuitSubSystem(SDL_INIT_VIDEO);
}

SDL_Surface * gfx(enum MAP_GLYPH glyph)
{
  return graphic_blocks[glyph];
}
