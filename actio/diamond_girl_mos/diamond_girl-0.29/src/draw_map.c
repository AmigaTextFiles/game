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

#include "diamond_girl.h"

void draw_map(struct map * map, int top_x, int top_y, int width, int height, int map_x, int map_y, int map_fine_x, int map_fine_y,
	      int extra_life_anim, int morpher_is_on, int anim_frame, int player_direction, int armour, int in_editor)
{ /* draw map */
  Uint32 c_black, c_illegal;

  {
    SDL_Rect r;

    r.x = top_x;
    r.y = top_y;
    r.w = width * 24;
    r.h = height * 24;
    SDL_SetClipRect(gfx(MAP_SCREEN), &r);
  }

  c_black = SDL_MapRGB(gfx(MAP_SCREEN)->format, 0, 0, 0);
  c_illegal = SDL_MapRGB(gfx(MAP_SCREEN)->format, 0x80, 0x40, 0x40);

  for(int y = 0 - 1; y < height; y++)
    for(int x = 0 - 1; x < width; x++)
      {
	SDL_Rect r;
	char m;

	r.x = top_x + x * 24 + map_fine_x;
	r.y = top_y + y * 24 + map_fine_y;
	r.w = 24;
	r.h = 24;
	if(map_x + x >= 0 && map_x + x < map->width && 
	   map_y + y >= 0 && map_y + y < map->height)
	  m = map->data[map_x + x + (map_y + y) * map->width];
	else
	  m = MAP_ILLEGAL;

	switch((enum MAP_GLYPH) m)
	  {
	  case MAP_SMOKE2:
	    {
	      SDL_Rect er;

	      er.x = 0;
	      er.y = 0;
	      er.w = 24;
	      er.h = 24;
	      SDL_BlitSurface(gfx(MAP_SMOKE), &er, gfx(MAP_SCREEN), &r);
	    }
	    break;
	  case MAP_SMOKE1:
	    {
	      SDL_Rect er;

	      er.x = 24;
	      er.y = 0;
	      er.w = 24;
	      er.h = 24;
	      SDL_BlitSurface(gfx(MAP_SMOKE), &er, gfx(MAP_SCREEN), &r);
	    }
	    break;
	  case MAP_EXTRA_LIFE_ANIM:
	  case MAP_SMOKE:
	  case MAP_SCREEN:
	  case MAP_PLAYER_ARMOUR0:
	  case MAP_PLAYER_ARMOUR1:
	  case MAP_PLAYER_ARMOUR2:
	  case MAP_PLAYER_ARMOUR3:
	    break;
	  case MAP_BORDER:
	  case MAP_BRICK:
	    SDL_BlitSurface(gfx(MAP_BRICK), NULL, gfx(MAP_SCREEN), &r);
	    break;
	  case MAP_BRICK_MORPHER:
	    if(in_editor)
	      SDL_BlitSurface(gfx(MAP_BRICK_MORPHER), NULL, gfx(MAP_SCREEN), &r);
	    else
	      {
		if(morpher_is_on)
		  {
		    SDL_Rect br;
		    
		    br.x = anim_frame % 24;
		    br.y = 0;
		    br.w = 24;
		    br.h = 24;
		    SDL_BlitSurface(gfx(MAP_BRICK_MORPHER), &br, gfx(MAP_SCREEN), &r);
		  }
		else
		  {
		    SDL_BlitSurface(gfx(MAP_BRICK), NULL, gfx(MAP_SCREEN), &r);
		  }
	      }
	    break;
	  case MAP_BRICK_EXPANDING:
	    if(in_editor)
	      SDL_BlitSurface(gfx(MAP_BRICK_EXPANDING), NULL, gfx(MAP_SCREEN), &r);
	    else
	      SDL_BlitSurface(gfx(MAP_BRICK), NULL, gfx(MAP_SCREEN), &r);
	    break;
	  case MAP_BRICK_UNBREAKABLE:
	    SDL_BlitSurface(gfx(MAP_BRICK_UNBREAKABLE), NULL, gfx(MAP_SCREEN), &r);
	    break;
	  case MAP_EMPTY:
	    if(extra_life_anim > 0)
	      {
		SDL_Rect er;
		
		er.x = anim_frame % 24;
		er.y = 0;
		er.w = 24;
		er.h = 24;
		SDL_BlitSurface(gfx(MAP_EXTRA_LIFE_ANIM), &er, gfx(MAP_SCREEN), &r);
	      }
	    else
	      SDL_FillRect(gfx(MAP_SCREEN), &r, c_black);
	    break;
	  case MAP_ILLEGAL:
	    SDL_FillRect(gfx(MAP_SCREEN), &r, c_illegal);
	    break;
	  case MAP_SAND:
	    SDL_BlitSurface(gfx(MAP_SAND), NULL, gfx(MAP_SCREEN), &r);
	    break;
	  case MAP_BOULDER:
	  case MAP_BOULDER_FALLING:
	    SDL_BlitSurface(gfx(MAP_BOULDER), NULL, gfx(MAP_SCREEN), &r);
	    break;
	  case MAP_DIAMOND:
	  case MAP_DIAMOND_FALLING:
	    SDL_BlitSurface(gfx(MAP_DIAMOND), NULL, gfx(MAP_SCREEN), &r);
	    break;
	  case MAP_PLAYER:
	    {
	      SDL_Rect pr;
	      enum MAP_GLYPH g;

	      pr.w = 24;
	      pr.h = 24;
	      switch(player_direction)
		{
		case MOVE_NONE:
		  pr.x = 4 * 24;
		  pr.y = 0;
		  break;
		case MOVE_UP:
		  pr.x = 0;
		  pr.y = (anim_frame % 3) * 24;
		  break;
		case MOVE_DOWN:
		  pr.x = 2 * 24;
		  pr.y = (anim_frame % 3) * 24;
		  break;
		case MOVE_LEFT:
		  pr.x = 3 * 24;
		  pr.y = (anim_frame % 3) * 24;
		  break;
		case MOVE_RIGHT:
		  pr.x = 1 * 24;
		  pr.y = (anim_frame % 3) * 24;
		  break;
		}
	      if(armour == 0)
		g = MAP_PLAYER_ARMOUR0;
	      else if(armour == 1)
		g = MAP_PLAYER_ARMOUR1;
	      else if(armour == 2)
		g = MAP_PLAYER_ARMOUR2;
	      else //if(armour == 3)
		g = MAP_PLAYER_ARMOUR3;
	      SDL_BlitSurface(gfx(g), &pr, gfx(MAP_SCREEN), &r);
	    }
	    break;
	  case MAP_AMEBA:
	    {
	      SDL_Rect er;

	      er.x = (anim_frame % 4) * 24;
	      er.y = 0;
	      er.w = 24;
	      er.h = 24;
	      SDL_BlitSurface(gfx(MAP_AMEBA), &er, gfx(MAP_SCREEN), &r);
	    }
	    break;
	  case MAP_ENEMY1:
	    {
	      SDL_Rect er;

	      er.x = (anim_frame % 3) * 24;
	      er.y = 0;
	      er.w = 24;
	      er.h = 24;
	      SDL_BlitSurface(gfx(MAP_ENEMY1), &er, gfx(MAP_SCREEN), &r);
	    }
	    break;
	  case MAP_ENEMY2:
	    {
	      SDL_Rect er;

	      er.x = (anim_frame % 4) * 24;
	      er.y = 0;
	      er.w = 24;
	      er.h = 24;
	      SDL_BlitSurface(gfx(MAP_ENEMY2), &er, gfx(MAP_SCREEN), &r);
	    }
	    break;
	  case MAP_EXIT_LEVEL:
	    {
	      SDL_Rect er;

	      er.x = (anim_frame % 3) * 24;
	      er.y = 0;
	      er.w = 24;
	      er.h = 24;
	      SDL_BlitSurface(gfx(MAP_EXIT_LEVEL), &er, gfx(MAP_SCREEN), &r);
	    }
	    break;
	  }
      }
  SDL_SetClipRect(gfx(MAP_SCREEN), NULL);
}
