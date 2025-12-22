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

#include <assert.h>
#include <stdlib.h>
#include <SDL/SDL_gfxPrimitives.h>
#include <SDL/SDL_framerate.h>
#include "diamond_girl.h"
#include "BFont.h"

static struct map * map;
static int level;
static int cursor_x, cursor_y, cursor_put;
static int map_top_y, map_x, map_y;
static int map_width, map_height;
static int font_height;

static enum MAP_GLYPH glyphs[] = 
  {
    MAP_EMPTY,
    MAP_SAND,
    MAP_BOULDER,
    MAP_DIAMOND,
    MAP_ENEMY1,
    MAP_ENEMY2,
    MAP_BRICK,
    MAP_BRICK_EXPANDING,
    MAP_BRICK_MORPHER,
    MAP_BRICK_UNBREAKABLE,
    MAP_AMEBA,
    MAP_PLAYER,
    MAP_EXIT_LEVEL,
    MAP_SCREEN
  };
static int selected_glyph;


static void init_map(const char * map_set);
static void change_map(const char * map_set, int new_level);
static void draw_screen(const char * map_set);

void map_editor(const char * map_set)
{
  int done;
  int cursor_move_x, cursor_move_y;
  FPSmanager framerate_manager;
  int glyph_change;
  int width_change, height_change, game_speed_change;
  int time_change, ameba_time_change, time_score_change;
  int diamonds_needed_change, diamond_score_change;

  font_height = BFont_FontHeight(BFont_GetCurrentFont());

  SDL_initFramerate(&framerate_manager);
  SDL_setFramerate(&framerate_manager, 10);

  assert(map_set != NULL);

  map_top_y = font_height * 3 + 28;
  map_width = gfx(MAP_SCREEN)->w / 24;
  map_height = (gfx(MAP_SCREEN)->h - map_top_y) / 24;

  level = 1;
  map = NULL;
  selected_glyph = 0;
  init_map(map_set);
  draw_screen(map_set);

  cursor_move_x = 0;
  cursor_move_y = 0;
  cursor_put = 0;
  glyph_change = 0;
  width_change = 0;
  height_change = 0;
  game_speed_change = 0;
  time_change = 0;
  ameba_time_change = 0;
  time_score_change = 0;
  diamonds_needed_change = 0;
  diamond_score_change = 0;

  done = 0;
  while(!done)
    {
      SDL_Event event;
      int redraw;
      int process_more;

      redraw = 0;
      process_more = 1;
      while(process_more && SDL_PollEvent(&event))
	{
	  switch(event.type)
	    {
	    case SDL_QUIT:
	      done = 1;
	      break;
	    case SDL_KEYDOWN:
	      switch(event.key.keysym.sym)
		{
		case SDLK_ESCAPE:
		  done = 1;
		  break;
		case SDLK_LEFT:
		  cursor_move_x = -1;
		  process_more = 0;
		  break;
		case SDLK_RIGHT:
		  cursor_move_x = 1;
		  process_more = 0;
		  break;
		case SDLK_UP:
		  cursor_move_y = -1;
		  process_more = 0;
		  break;
		case SDLK_DOWN:
		  cursor_move_y = 1;
		  process_more = 0;
		  break;
		case SDLK_PLUS:
		  change_map(map_set, level + 1);
		  redraw = 1;
		  break;
		case SDLK_MINUS:
		  if(level > 1)
		    {
		      change_map(map_set, level - 1);
		      redraw = 1;
		    }
		  break;
		case SDLK_COMMA:
		  glyph_change = -1;
		  process_more = 0;
		  break;
		case SDLK_PERIOD:
		  glyph_change = 1;
		  process_more = 0;
		  break;
		case SDLK_w:
		  if(event.key.keysym.mod & KMOD_SHIFT)
		    width_change = 1;
		  else
		    width_change = -1;
		  process_more = 0;
		  break;
		case SDLK_h:
		  if(event.key.keysym.mod & KMOD_SHIFT)
		    height_change = 1;
		  else
		    height_change = -1;
		  process_more = 0;
		  break;
		case SDLK_SPACE:
		  cursor_put = 1;
		  process_more = 0;
		  break;
		case SDLK_t:
		  if(event.key.keysym.mod & KMOD_SHIFT)
		    time_change = 1;
		  else
		    time_change = -1;
		  process_more = 0;
		  break;
		case SDLK_a:
		  if(event.key.keysym.mod & KMOD_SHIFT)
		    ameba_time_change = 1;
		  else
		    ameba_time_change = -1;
		  process_more = 0;
		  break;
		case SDLK_c:
		  if(event.key.keysym.mod & KMOD_SHIFT)
		    time_score_change = 1;
		  else
		    time_score_change = -1;
		  process_more = 0;
		  break;
		case SDLK_d:
		  if(event.key.keysym.mod & KMOD_SHIFT)
		    diamonds_needed_change = 1;
		  else
		    diamonds_needed_change = -1;
		  process_more = 0;
		  break;
		case SDLK_e:
		  if(event.key.keysym.mod & KMOD_SHIFT)
		    game_speed_change = 1;
		  else
		    game_speed_change = -1;
		  process_more = 0;
		  break;
		case SDLK_s:
		  if(event.key.keysym.mod & KMOD_SHIFT)
		    diamond_score_change = 1;
		  else
		    diamond_score_change = -1;
		  process_more = 0;
		  break;
		case SDLK_p:
		  clear_area(0, 0, gfx(MAP_SCREEN)->w, gfx(MAP_SCREEN)->h);
		  change_map(map_set, level);
		  game(map_set, level, 1);
		  sfx_stop(SFX_AMEBA);
		  redraw = 1;
		  break;
		case SDLK_r:
		  if(event.key.keysym.mod & KMOD_SHIFT)
		    {
		      map = map_free(map);
		      init_map(map_set);
		      redraw = 1;
		      process_more = 0;
		    }
		  break;
		default:
		  break;
		}
	      break;
	    case SDL_KEYUP:
	      switch(event.key.keysym.sym)
		{
		case SDLK_LEFT:
		  cursor_move_x = 0;
		  break;
		case SDLK_RIGHT:
		  cursor_move_x = 0;
		  break;
		case SDLK_UP:
		  cursor_move_y = 0;
		  break;
		case SDLK_DOWN:
		  cursor_move_y = 0;
		  break;
		case SDLK_SPACE:
		  cursor_put = 0;
		  break;
		case SDLK_COMMA:
		case SDLK_PERIOD:
		  glyph_change = 0;
		  break;
		case SDLK_w:
		  width_change = 0;
		  break;
		case SDLK_h:
		  height_change = 0;
		  break;
		case SDLK_t:
		  time_change = 0;
		  break;
		case SDLK_a:
		  ameba_time_change = 0;
		  break;
		case SDLK_c:
		  time_score_change = 0;
		  break;
		case SDLK_d:
		  diamonds_needed_change = 0;
		  break;
		case SDLK_e:
		  game_speed_change = 0;
		  break;
		case SDLK_s:
		  diamond_score_change = 0;
		  break;
		default:
		  break;
		}
	      break;
	    }
	}
      
      if(cursor_move_x == -1 && cursor_x > 0)
	{
	  cursor_x--;
	  redraw = 1;
	}
      if(cursor_move_x == 1 && cursor_x + 1< map->width)
	{
	  cursor_x++;
	  redraw = 1;
	}
      if(cursor_move_y == -1 && cursor_y > 0)
	{
	  cursor_y--;
	  redraw = 1;
	}
      if(cursor_move_y == 1 && cursor_y + 1 < map->height)
	{
	  cursor_y++;
	  redraw = 1;
	}

      if(width_change == -1)
	{
	  if(map->width > 10)
	    {
	      char * old;
	      int old_w;

	      old = map->data;
	      old_w = map->width;
	      map->width--;

	      map->data = (char *)malloc(map->width * map->height);
	      assert(map->data != NULL);

	      for(int y = 0; y < map->height; y++)
		for(int x = 0; x < map->width; x++)
		  map->data[x + y * map->width] = old[x + y * old_w];
	      free(old);
	      redraw = 1;
	    }
	}
      else if(width_change == 1)
	{
	  if(map->width < 200)
	    {
	      char * old;
	      int old_w;

	      old = map->data;
	      old_w = map->width;
	      map->width++;

	      map->data = (char *)malloc(map->width * map->height);
	      assert(map->data != NULL);

	      for(int y = 0; y < map->height; y++)
		for(int x = 0; x < map->width; x++)
		  if(x < map->width - 1)
		    map->data[x + y * map->width] = old[x + y * old_w];
		  else
		    map->data[x + y * map->width] = MAP_SAND;
	      free(old);
	      redraw = 1;
	    }
	}

      if(height_change)
	{
	  if(map->height + height_change >= 10 && map->height + height_change <= 200)
	    {
	      char * new2;

	      new2 = (char *)realloc(map->data, map->width * (map->height + height_change));
	      assert(new2 != NULL);

	      map->data = new2;
	      map->height += height_change;

	      if(height_change > 0)
		for(int x = 0; x < map->width; x++)
		  map->data[x + (map->height - 1) * map->width] = MAP_SAND;

	      redraw = 1;
	    }
	}

      if(game_speed_change)
	{
	  if(map->game_speed + game_speed_change >= 1 && map->game_speed + game_speed_change <= 20)
	    {
	      map->game_speed += game_speed_change;
	      redraw = 1;
	    }
	}


      if(cursor_put)
	{
	  if(cursor_x != map->start_x || cursor_y != map->start_y)
	    if(cursor_x != map->exit_x || cursor_y != map->exit_y)
	      {
		if(glyphs[selected_glyph] == MAP_PLAYER)
		  { /* change start location */
		    map->data[map->start_x + map->start_y * map->width] = MAP_EMPTY;
		    map->start_x = cursor_x;
		    map->start_y = cursor_y;
		  }
		else if(glyphs[selected_glyph] == MAP_EXIT_LEVEL)
		  { /* change exit location */
		    map->data[map->exit_x + map->exit_y * map->width] = MAP_EMPTY;
		    map->exit_x = cursor_x;
		    map->exit_y = cursor_y;
		  }

		map->data[cursor_x + cursor_y * map->width] = glyphs[selected_glyph];
		redraw = 1;
	      }
	}

      if(glyph_change)
	{
	  if(selected_glyph + glyph_change >= 0 && glyphs[selected_glyph + glyph_change] != MAP_SCREEN)
	    {
	      selected_glyph += glyph_change;
	      redraw = 1;
	    }
	}

      if(time_change)
	{
	  if(map->time + time_change >= 0 && map->time + time_change <= 999)
	    {
	      map->time += time_change;
	      redraw = 1;
	    }
	}

      if(ameba_time_change)
	{
	  if(map->ameba_time + ameba_time_change >= 0 && map->ameba_time + ameba_time_change <= 999)
	    {
	      map->ameba_time += ameba_time_change;
	      redraw = 1;
	    }
	}

      if(time_score_change)
	{
	  if(map->time_score + time_score_change >= 0 && map->time_score + time_score_change <= 999)
	    {
	      map->time_score += time_score_change;
	      redraw = 1;
	    }
	}

      if(diamonds_needed_change)
	{
	  if(map->diamonds_needed + diamonds_needed_change >= 0 && map->diamonds_needed + diamonds_needed_change <= 999)
	    {
	      map->diamonds_needed += diamonds_needed_change;
	      redraw = 1;
	    }
	}

      if(diamond_score_change)
	{
	  if(map->diamond_score + diamond_score_change >= 0 && map->diamond_score + diamond_score_change <= 999)
	    {
	      map->diamond_score += diamond_score_change;
	      redraw = 1;
	    }
	}
      
      if(redraw)
	{
	  if(cursor_x < map_x || cursor_x >= map_x + map_width)
	    map_x = cursor_x - map_width / 2;
	  if(cursor_y < map_y || cursor_y >= map_y + map_height)
	    map_y = cursor_y - map_height / 2;
	  draw_screen(map_set);
	}
      SDL_framerateDelay(&framerate_manager);
    }

  change_map(map_set, level);

  if(map != NULL)
    map = map_free(map);
}

static void init_map(const char * map_set)
{
  char fn[1024];

  if(map != NULL)
    map = map_free(map);

  snprintf(fn, sizeof fn, "maps/%s/%d", map_set, (int) level);
  map = map_load(fn);
  if(map == NULL)
    {
      map = (struct map *)malloc(sizeof(struct map));
      assert(map != NULL);
      map->width = 40;
      map->height = 20;
      map->start_x = 1;
      map->start_y = 1;
      map->exit_x = 2;
      map->exit_y = 1;
      map->diamonds_needed = 0;
      map->diamond_score = 0;
      map->time_score = 0;
      map->data = (char *)malloc(map->width * map->height);
      assert(map->data != NULL);
      for(int i = 0; i < map->width * map->height; i++)
	map->data[i] = MAP_SAND;
      for(int x = 0; x < map->width; x++)
	{
	  map->data[x] = MAP_BRICK_UNBREAKABLE;
	  map->data[x + (map->height - 1) * map->width] = MAP_BRICK_UNBREAKABLE;
	}
      for(int y = 0; y < map->height; y++)
	{
	  map->data[y * map->width] = MAP_BRICK_UNBREAKABLE;
	  map->data[map->width - 1 + y * map->width] = MAP_BRICK_UNBREAKABLE;
	}
      map->processed = NULL;
      map->move_directions = NULL;
      map->time = 0;
      map->ameba_time = 0;
      map->game_speed = 3;
    }

  map->data[map->start_x + map->start_y * map->width] = MAP_PLAYER;
  map->data[map->exit_x + map->exit_y * map->width] = MAP_EXIT_LEVEL;

  cursor_x = 0;
  cursor_y = 0;
  map_x = 0;
  map_y = 0;
}

static void change_map(const char * map_set, int new_level)
{
  if(map != NULL)
    {
      char fn[1024];
      
      snprintf(fn, sizeof fn, "maps/%s/%d", map_set, (int) level);
      map_save(map, fn);
    }

  if(new_level != level)
    {
      if(map != NULL)
	map = map_free(map);
      level = new_level;
      init_map(map_set);
    }
}


static void draw_screen(const char * map_set)
{
  clear_area(0, 0, gfx(MAP_SCREEN)->w, gfx(MAP_SCREEN)->h);
  draw_map(map, 0, map_top_y, map_width, map_height, map_x, map_y, 0, 0, 0, 0, 0, 0, 3, 1);
  { /* draw cursor */
    int cx, cy;

    cx = (cursor_x - map_x) * 24;
    cy = map_top_y + (cursor_y - map_y) * 24;
    hlineRGBA(gfx(MAP_SCREEN), cx, cx + 23, cy, 0x00, 0xff, 0x00, 0xff);
    hlineRGBA(gfx(MAP_SCREEN), cx, cx + 23, cy + 23, 0x00, 0xff, 0x00, 0xff);
    vlineRGBA(gfx(MAP_SCREEN), cx, cy, cy + 23, 0x00, 0xff, 0x00, 0xff);
    vlineRGBA(gfx(MAP_SCREEN), cx + 23, cy, cy + 23, 0x00, 0xff, 0x00, 0xff);
  }

  {
    int y;

    y = 0;
    BFont_PrintString(gfx(MAP_SCREEN), 0, y, "MapSet: '%s'  Level[+-]: %-3d   [W]idth: %-3d  [H]eight: %-3d  [T]ime: %-4d  GameSp[e]ed: %-2d",
		      map_set, (int) level, (int) map->width, (int) map->height, (int) map->time, (int) map->game_speed);
    y += font_height;
    BFont_PrintString(gfx(MAP_SCREEN), 0, y, "[A]mebaTime: %-4d  [D]iamondsNeeded: %-4d  Diamond[S]core: %-4d  TimeS[c]ore: %-4d",
		      (int) map->ameba_time, (int) map->diamonds_needed, (int) map->diamond_score, (int) map->time_score);
    y += font_height;

    {
      SDL_Rect dr, sr;
      Uint32 c_black;
      
      c_black = SDL_MapRGB(gfx(MAP_SCREEN)->format, 0, 0, 0);

      dr.x = 2;
      dr.y = y;
      dr.w = 24;
      dr.h = 24;
      
      sr.x = 0;
      sr.y = 0;
      sr.w = 24;
      sr.h = 24;
      
      for(int i = 0; glyphs[i] != MAP_SCREEN; i++)
	{
	  if(selected_glyph == i)
	    {
	      hlineRGBA(gfx(MAP_SCREEN), dr.x - 1, dr.x + 24, dr.y - 1, 0x00, 0xff, 0x00, 0xff);
	      hlineRGBA(gfx(MAP_SCREEN), dr.x - 1, dr.x + 24, dr.y + 24, 0x00, 0xff, 0x00, 0xff);
	      vlineRGBA(gfx(MAP_SCREEN), dr.x - 1, dr.y - 1, dr.y + 24, 0x00, 0xff, 0x00, 0xff);
	      vlineRGBA(gfx(MAP_SCREEN), dr.x + 24, dr.y - 1, dr.y + 24, 0x00, 0xff, 0x00, 0xff);
	    }

	  if(glyphs[i] == MAP_EMPTY)
	    {
	      SDL_FillRect(gfx(MAP_SCREEN), &dr, c_black);
	    }
	  else if(glyphs[i] == MAP_PLAYER)
	    {
	      SDL_Rect pr;

	      pr.x = 4 * 24;
	      pr.y = 0;
	      pr.w = 24;
	      pr.h = 24;
	      SDL_BlitSurface(gfx(MAP_PLAYER_ARMOUR3), &pr, gfx(MAP_SCREEN), &dr);
	    }
	  else
	    SDL_BlitSurface(gfx(glyphs[i]), &sr, gfx(MAP_SCREEN), &dr);
	  dr.x += 28;
	}

      {
	const char * name;

	switch(glyphs[selected_glyph])
	  {
	  case MAP_EMPTY: name = "empty"; break;
	  case MAP_SAND: name = "sand"; break;
	  case MAP_PLAYER: name = "start location"; break;
	  case MAP_BOULDER: name = "boulder"; break;
	  case MAP_DIAMOND: name = "diamond"; break;
	  case MAP_ENEMY1: name = "enemy1"; break;
	  case MAP_ENEMY2: name = "enemy2"; break;
	  case MAP_EXIT_LEVEL: name = "exit location"; break;
	  case MAP_BRICK: name = "brick"; break;
	  case MAP_BRICK_EXPANDING: name = "expanding brick"; break;
	  case MAP_BRICK_MORPHER: name = "morphing brick"; break;
	  case MAP_BRICK_UNBREAKABLE: name = "unbreakable brick"; break;
	  case MAP_AMEBA: name = "ameba"; break;
	  default:
	    name = NULL;
	  }
	BFont_PrintString(gfx(MAP_SCREEN), dr.x, dr.y, "Selected[,.]: %s", name);
      }
      y += 28;
    }

    BFont_PrintString(gfx(MAP_SCREEN), 0, y, "p - PlayTest  R - RevertMap");
  }
  SDL_Flip(gfx(MAP_SCREEN));
}
