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

#include <SDL/SDL_framerate.h>
#include <SDL/SDL_gfxPrimitives.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>

#include "diamond_girl.h"
#include "BFont.h"

static void game_event(SDL_Event * event);
static void draw_game_screen(void);
static void player_movement(void);
static void process_map(void);
static void init_map(void);
static void player_death(void);
static void enemy_death(char fill, int x, int y);
static void next_level(void);
static void add_score(int score);
static void expand_ameba(int x, int y);

static struct map * map;
static int map_x, map_y, map_fine_x, map_fine_y;

static FPSmanager framerate_manager;

static enum MOVE_DIRECTION player_direction;
static int                 player_shift_move;
static int player_x, player_y;
static int anim_frame;
static int girls;
static int armour;
static int diamonds;
static int player_is_alive;
static int push_counter;
static const char * game_map_set;
static int game_level;
static int exit_open;
static int extra_life_anim;
static int morpher_is_on;
static int morpher_end_time;
static int game_time;
static int frames_per_second;
static int player_score;
static int game_quit, game_done;
static int game_speed_modifier;

static int level_start_anim_on;
static int level_start_anim_player;
static char * level_start_anim_map;

static int redraw_score;
static int redraw_borders;

static int exit_after_one_level;

static int ameba_sound;

int game(const char * map_set, int level, int return_after_one_level)
{
  int anim_timer;
  int game_timer;

  frames_per_second = 30;

  exit_after_one_level = return_after_one_level;

  SDL_initFramerate(&framerate_manager);
  SDL_setFramerate(&framerate_manager, frames_per_second);

  game_level = level;
  game_map_set = map_set;
  game_speed_modifier = 0;

  level_start_anim_on = 0;
  level_start_anim_player = 0;
  level_start_anim_map = NULL;

  map = NULL;
  map_x = 0;
  map_y = 0;
  map_fine_x = 0;
  map_fine_y = 0;

  girls = 3;
  game_quit = 0;
  game_done = 0;
  anim_timer = 0;
  game_timer = 0;
  player_score = 0;

  redraw_borders = 1;
  redraw_score = 1;

  init_map();

  while(!game_quit && !game_done)
    {
      SDL_Event event;

      while(SDL_PollEvent(&event))
	game_event(&event);


      { /* center map */
	int mmx, mmy;
		
	mmx = player_x - (gfx(MAP_SCREEN)->w / 24 - 2) / 2;
	mmy = player_y - ((gfx(MAP_SCREEN)->h - 50) / 24 - 2) / 2;
	if(map_x < mmx)
	  map_fine_x -= 4;
	else if(map_x > mmx)
	  map_fine_x += 4;
	if(map_y < mmy)
	  map_fine_y -= 4;
	else if(map_y > mmy)
	  map_fine_y += 4;

	if(map_fine_x < 0)
	  {
	    map_x++;
	    map_fine_x = 23;
	  }
	else if(map_fine_x >= 24)
	  {
	    map_x--;
	    map_fine_x = 0;
	  }
	if(map_fine_y < 0)
	  {
	    map_y++;
	    map_fine_y = 23;
	  }
	else if(map_fine_y >= 24)
	  {
	    map_y--;
	    map_fine_y = 0;
	  }
      }

      if(level_start_anim_on)
	{
	  level_start_anim_on--;
	  if(level_start_anim_on)
	    {
	      for(int i = 0; i < map->width * map->height / 100; i++)
		{
		  int x, y;
		  
		  x = get_rand(map->width);
		  y = get_rand(map->height);
		  map->data[x + y * map->width] = level_start_anim_map[x + y * map->width];
		}
	      
	      level_start_anim_player++;
	      if(level_start_anim_player > frames_per_second / 5)
		{
		  level_start_anim_player = 0;
		  if(map->data[map->start_x + map->start_y * map->width] == MAP_EMPTY)
		    map->data[map->start_x + map->start_y * map->width] = MAP_PLAYER;
		  else
		    map->data[map->start_x + map->start_y * map->width] = MAP_EMPTY;
		}
	    }
	  else
	    {
	      free(map->data);
	      map->data = level_start_anim_map;
	      level_start_anim_map = NULL;
	      map->data[map->start_x + map->start_y * map->width] = MAP_PLAYER;
	      sfx(SFX_SMALL_EXPLOSION);
	    }
	}
      else
	{
	  game_timer++;
	  if(game_timer >= map->game_speed)
	    {
	      if(player_is_alive)
		player_movement();
	      process_map();
	      game_timer = 0;
	    }
	}

      anim_timer++;
      if(anim_timer >= 3)
	{
	  anim_frame++;
	  anim_timer = 0;
	}

      if(!level_start_anim_on)
	if(player_is_alive)
	  {
	    game_time--;
	    if((game_time % frames_per_second) == 0)
	      if(game_time / frames_per_second <= 10 && game_time / frames_per_second > 0)
		sfx(SFX_TIME);
	    if(game_time <= 0)
	      {
		player_death();
	      }
	  }

      draw_game_screen();
      
      SDL_Flip(gfx(MAP_SCREEN));
      SDL_framerateDelay(&framerate_manager);
    }

  if(level_start_anim_map != NULL)
    free(level_start_anim_map);

  if(ameba_sound)
    sfx_stop(SFX_AMEBA);

  return game_quit;
}

static void draw_game_screen(void)
{
  int top_x, top_y;
  int width, height;

  if(redraw_score)
    {
      SDL_Rect r;
      int font_height;
      Uint32 clear_colour;

      clear_colour = SDL_MapRGB(gfx(MAP_SCREEN)->format, 0, 0, 0);
      font_height = BFont_FontHeight(BFont_GetCurrentFont());
      r.x = 0;
      r.y = 0;
      r.w = gfx(MAP_SCREEN)->w;
      r.h = font_height;
      SDL_FillRect(gfx(MAP_SCREEN), &r, clear_colour);
      BFont_PrintString(gfx(MAP_SCREEN), 0, 0, "Level: %d  Girls: %d  Diamonds: %d/%d  Time: %d/%d  Score: %d",
			(int) game_level, (int) girls, (int) diamonds, (int) map->diamonds_needed,
			(int) game_time / frames_per_second, (int) map->time, (int) player_score);
      //redraw_score = 0;
    }

  top_x = 24;
  top_y = 50 + 24;
  width = gfx(MAP_SCREEN)->w / 24 - 2;
  height = (gfx(MAP_SCREEN)->h - top_y) / 24;

  if(redraw_borders)
    {
      redraw_borders = 0;
      /* draw borders */
      for(int y = 0; y < height + 2; y++)
	{
	  SDL_Rect r;
	  
	  r.x = top_x - 24;
	  r.y = top_y - 24 + y * 24;
	  r.w = 24;
	  r.h = 24;
	  SDL_BlitSurface(gfx(MAP_BORDER), NULL, gfx(MAP_SCREEN), &r);
	  r.x = top_x + width * 24;
	  SDL_BlitSurface(gfx(MAP_BORDER), NULL, gfx(MAP_SCREEN), &r);
	}
      for(int x = 0; x < width; x++)
	{
	  SDL_Rect r;
	  
	  r.x = top_x + x * 24;
	  r.y = top_y - 24;
	  r.w = 24;
	  r.h = 24;
	  SDL_BlitSurface(gfx(MAP_BORDER), NULL, gfx(MAP_SCREEN), &r);
	  r.y = top_y + height * 24;
	  SDL_BlitSurface(gfx(MAP_BORDER), NULL, gfx(MAP_SCREEN), &r);
	}
    }

  draw_map(map, top_x, top_y, width, height, map_x, map_y, map_fine_x, map_fine_y, extra_life_anim, morpher_is_on == 1 ? 1 : 0, anim_frame, player_direction, armour, 0);

  if(!player_is_alive)
    {
      SDL_Rect r;
      Uint32 c;
      int h;
      
      h = BFont_FontHeight(BFont_GetCurrentFont());
      r.x = gfx(MAP_SCREEN)->w / 4;
      r.y = gfx(MAP_SCREEN)->h / 3 - (10 + h);
      r.w = gfx(MAP_SCREEN)->w / 2;
      r.h = 10 + h + h + 10;
      c = SDL_MapRGB(gfx(MAP_SCREEN)->format, 0x00, 0x00, 0x00);
      SDL_FillRect(gfx(MAP_SCREEN), &r, c);

      if(girls > 0)
	BFont_CenteredPrintString(gfx(MAP_SCREEN), gfx(MAP_SCREEN)->h / 3, "You are dead, press enter.");
      else
	BFont_CenteredPrintString(gfx(MAP_SCREEN), gfx(MAP_SCREEN)->h / 3, "Game Over! Press enter.");
    }

  if(extra_life_anim > 0)
    extra_life_anim--;
}

static void player_death(void)
{
  if(armour == 0)
    {
      sfx(SFX_EXPLOSION);
      player_is_alive = 0;
      girls--;
      for(int y = -1; y <= 1; y++)
	for(int x = -1; x <= 1; x++)
	  if(x + player_x >= 0 && x + player_x < map->width &&
	     y + player_y >= 0 && y + player_y < map->height)
	    map->data[x + player_x + (y + player_y) * map->width] = MAP_DIAMOND;
    }
  else
    armour--;
}

static void enemy_death(char fill, int x, int y)
{
  sfx(SFX_EXPLOSION);
  for(int iy = -1; iy <= 1; iy++)
    for(int ix = -1; ix <= 1; ix++)
      if(ix + x >= 0 && ix + x < map->width &&
	 iy + y >= 0 && iy + y < map->height)
	{
	  if(map->data[ix + x + (iy + y) * map->width] == MAP_PLAYER)
	    {
	      armour = 0;
	      player_death();
	    }

	  if(map->data[ix + x + (iy + y) * map->width] != MAP_BRICK_UNBREAKABLE)
	    {	    
	      map->data[ix + x + (iy + y) * map->width] = fill;
	      map->processed[ix + x + (iy + y) * map->width] = 1;
	    }
	}
}

static void game_event(SDL_Event * event)
{
  switch(event->type)
    {
    case SDL_QUIT:
      game_quit = 1;
      break;
    case SDL_KEYDOWN:
      if(player_is_alive)
	{
	  if(event->key.keysym.sym == SDLK_ESCAPE)
	    {
	      armour = 0;
	      player_death();
	    }
	  else if(event->key.keysym.sym == SDLK_LSHIFT || event->key.keysym.sym == SDLK_RSHIFT)
	    {
	      player_shift_move = 1;
	    }
	  else if(event->key.keysym.sym == SDLK_DOWN)
	    {
	      player_direction = MOVE_DOWN;
	    }
	  else if(event->key.keysym.sym == SDLK_UP)
	    {
	      player_direction = MOVE_UP;
	    }
	  else if(event->key.keysym.sym == SDLK_LEFT)
	    {
	      player_direction = MOVE_LEFT;
	    }
	  else if(event->key.keysym.sym == SDLK_RIGHT)
	    {
	      player_direction = MOVE_RIGHT;
	    }
	  else if(event->key.keysym.sym == SDLK_F1)
	    {
	      Uint32 c;
	      int done;
	      const char * help[] =
		{
		  "Controls:",
		  "",
		  " F1 - pause and this help",
		  " F10 - toggle windowed/fullscreen",
		  " ESC - suicide",
		  " CURSOR keys - move",
		  " SHIFT+CURSOR keys - don't move, manipulate only",
		  "",
		  "If you press ESC after dying, you will return to the main menu.",
		  "",
		  "Press <enter> to exit this help.",
		  NULL
		};
	      int i, y, font_height, width;
	      SDL_Rect r;

	      font_height = BFont_FontHeight(BFont_GetCurrentFont());

	      i = 0;
	      width = 0;
	      while(help[i] != NULL)
		{
		  int w;

		  w = BFont_TextWidth(help[i]);
		  if(w > width)
		    width = w;
		  i++;
		}

	      width += 30;
	      r.w = width;
	      r.h = (i + 2) * font_height;
	      r.x = (gfx(MAP_SCREEN)->w - width) / 2;
	      r.y = (gfx(MAP_SCREEN)->h - r.h) / 2;

	      c = SDL_MapRGB(gfx(MAP_SCREEN)->format, 0, 0, 0);
	      SDL_FillRect(gfx(MAP_SCREEN), &r, c);

	      y = r.y + font_height;
	      i = 0;
	      while(help[i] != NULL)
		{
		  BFont_PutString(gfx(MAP_SCREEN), r.x + 15, y, help[i]);
		  y += font_height;
		  i++;
		}

	      SDL_Flip(gfx(MAP_SCREEN));

	      done = 0;
	      while(!done)
		{
		  SDL_Event tmp_event;

		  SDL_WaitEvent(&tmp_event);
		  if(tmp_event.type == SDL_QUIT)
		    {
		      game_quit = 1;
		      done = 1;
		    }
		  else if(tmp_event.type == SDL_KEYDOWN && tmp_event.key.keysym.sym == SDLK_RETURN)
		    {
		      done = 1;
		    }
		}
	    }
	  else if(event->key.keysym.sym == SDLK_F10)
	    {
	      if(fullscreen)
		fullscreen = 0;
	      else
		fullscreen = 1;
	      gfx_cleanup();
	      gfx_initialize();
	      redraw_score = 1;
	      redraw_borders = 1;
	    }
	}
      else
	{
	  if(event->key.keysym.sym == SDLK_ESCAPE)
	    {
	      game_done = 1;
	      if(!exit_after_one_level)
		highscore_new(player_score, game_level);
	    }
	}

      break;
    case SDL_KEYUP:
      if(player_is_alive)
	{
	  if(event->key.keysym.sym == SDLK_LSHIFT || event->key.keysym.sym == SDLK_RSHIFT)
	    {
	      player_shift_move = 0;
	    }
	  else if(event->key.keysym.sym == SDLK_DOWN)
	    {
	      if(player_direction == MOVE_DOWN)
		player_direction = MOVE_NONE;
	    }
	  else if(event->key.keysym.sym == SDLK_UP)
	    {
	      if(player_direction == MOVE_UP)
		player_direction = MOVE_NONE;
	    }
	  else if(event->key.keysym.sym == SDLK_LEFT)
	    {
	      if(player_direction == MOVE_LEFT)
		player_direction = MOVE_NONE;
	    }
	  else if(event->key.keysym.sym == SDLK_RIGHT)
	    {
	      if(player_direction == MOVE_RIGHT)
		player_direction = MOVE_NONE;
	    }
	}
      else
	{
	  if(event->key.keysym.sym == SDLK_RETURN)
	    {
	      if(girls > 0)
		{
		  init_map();
		}
	      else
		{
		  game_done = 1;
		  if(!exit_after_one_level)
		    highscore_new(player_score, game_level);
		}
	    }
	}
      break;
    }
}

static void init_map(void)
{
  sfx_music(MUSIC_START, 0);

  if(map != NULL)
    map = map_free(map);

  if(game_map_set == NULL)
    map = map_random(game_level);
  else
    {
      char fn[1024];

      snprintf(fn, sizeof fn, "maps/%s/%d", game_map_set, (int) game_level);
      map = map_load(fn);
      if(map == NULL)
	{ /* after last map, cycle to first */
	  snprintf(fn, sizeof fn, "maps/%s/%d", game_map_set, (int) 1);
	  map = map_load(fn);
	  if(map != NULL)
	    {
	      game_level = 1;
	      game_speed_modifier--;
	    }
	}
    }

  if(map != NULL)
    {
      int ameba;

      ameba = 0;
      for(int i = 0; i < map->width * map->height && !ameba; i++)
	if(map->data[i] == MAP_AMEBA)
	  ameba = 1;

      if(ameba)
	{
	  if(!ameba_sound)
	    {
	      sfx(SFX_AMEBA);
	      ameba_sound = 1;
	    }
	}
      else
	{
	  if(ameba_sound)
	    {
	      sfx_stop(SFX_AMEBA);
	      ameba_sound = 0;
	    }
	}

      player_x = map->start_x;
      player_y = map->start_y;
      player_direction = MOVE_NONE;
      player_shift_move = 0;
      anim_frame = 0;
      player_is_alive = 1;
      armour = 3;
      push_counter = 0;
      diamonds = 0;
      exit_open = 0;
      extra_life_anim = 0;
      morpher_is_on = 0;
      morpher_end_time = 0;
      game_time = map->time * frames_per_second;
      level_start_anim_map = map->data;
      map->data = (char *)malloc(map->width * map->height);
      if(map->data != NULL)
	{
	  level_start_anim_on = frames_per_second * 5;
	  level_start_anim_player = 0;
	  for(int i = 0; i < map->width * map->height; i++)
	    map->data[i] = MAP_BRICK;
	  map->data[map->start_x + map->start_y * map->width] = MAP_EMPTY;
	}
      else
	level_start_anim_on = 0;
    }
  else
    {
      fprintf(stderr, "Failed to load map, unable to start/continue game.\n");
      game_done = 1;
    }

  if(map != NULL)
    {
      if(map->game_speed + game_speed_modifier >= 1)
	map->game_speed += game_speed_modifier;
      else
	map->game_speed = 1;
    }
}

static void player_movement(void)
{
  int new_x, new_y;

  if(player_direction != MOVE_NONE)
    {
      map->data[player_x + player_y * map->width] = MAP_EMPTY;
    }

  new_x = player_x;
  new_y = player_y;

  switch(player_direction)
    {
    case MOVE_NONE:
      break;
    case MOVE_UP:
      if(player_y > 0)
	new_y--;
      break;
    case MOVE_DOWN:
      if(player_y < map->height - 1)
	new_y++;
      break;
    case MOVE_LEFT:
      if(player_x > 0)
	new_x--;
      break;
    case MOVE_RIGHT:
      if(player_x < map->width - 1)
	new_x++;
      break;
    }

  if(player_direction != MOVE_NONE)
    {
      int pushing;

      pushing = 0;
      switch(map->data[new_x + new_y * map->width])
	{
	case MAP_EXIT_LEVEL:
	  next_level();
	  break;
	case MAP_DIAMOND:
	case MAP_DIAMOND_FALLING:
	  diamonds++;
	  add_score(map->diamond_score);
	  sfx(SFX_DIAMOND_COLLECT);
	  if(!exit_open && diamonds >= map->diamonds_needed)
	    {
	      exit_open = 1;
	      map->data[map->exit_x + map->exit_y * map->width] = MAP_EXIT_LEVEL;
	      sfx(SFX_SMALL_EXPLOSION);
	    }
	  if(player_shift_move)
	    {
	      map->data[new_x + new_y * map->width] = MAP_EMPTY;
	      map->processed[new_x + new_y * map->width] = 1;
	    }
	  else
	    {
	      player_x = new_x;
	      player_y = new_y;
	    }
	  break;
	case MAP_EMPTY:
	case MAP_SAND:
	  if(map->data[new_x + new_y * map->width] == MAP_EMPTY)
	    sfx(SFX_MOVE_EMPTY);
	  else if(map->data[new_x + new_y * map->width] == MAP_SAND)
	    sfx(SFX_MOVE_SAND);
	  if(player_shift_move)
	    {
	      map->data[new_x + new_y * map->width] = MAP_EMPTY;
	      map->processed[new_x + new_y * map->width] = 1;
	    }
	  else
	    {
	      player_x = new_x;
	      player_y = new_y;
	    }
	  break;
	case MAP_BOULDER:
	case MAP_BOULDER_FALLING:
	  if(player_direction == MOVE_LEFT || player_direction == MOVE_RIGHT)
	    {
	      int behind_x;
	      
	      pushing = 1;
	      behind_x = new_x + (new_x - player_x);
	      push_counter++;
	      if(map->data[behind_x + new_y * map->width] == MAP_EMPTY)
		if(push_counter > 3)
		  { /* do the push */
		    sfx(SFX_BOULDER_MOVE);
		    map->data[behind_x + new_y * map->width] = MAP_BOULDER;
		    map->processed[behind_x + new_y * map->width] = 1;
		    if(player_shift_move)
		      {
			map->data[new_x + new_y * map->width] = MAP_EMPTY;
			map->processed[new_x + new_y * map->width] = 1;
		      }
		    else
		      {
			player_x = new_x;
			player_y = new_y;
		      }
		    push_counter = 1;
		  }
	    }
	  break;
	}

      if(!pushing)
	push_counter = 0;

      map->data[player_x + player_y * map->width] = MAP_PLAYER;
    }
}

static void process_map(void)
{ /* process map */
  memset(map->processed, 0, map->width * map->height);

  for(int y = 0; y < map->height; y++)
    for(int x = 0; x < map->width; x++)
      if(!map->processed[x + y * map->width])
	{
	  int check_for_player_kill;

	  map->processed[x + y * map->width] = 1;
	  check_for_player_kill = 0;
	  switch((enum MAP_GLYPH) map->data[x + y * map->width])
	    {
	    case MAP_SCREEN:
	    case MAP_EMPTY:
	    case MAP_BORDER:
	    case MAP_ILLEGAL:
	    case MAP_SAND:
	    case MAP_SMOKE:
	    case MAP_EXIT_LEVEL:
	    case MAP_EXTRA_LIFE_ANIM:
	    case MAP_BRICK:
	    case MAP_BRICK_UNBREAKABLE:
	    case MAP_BRICK_MORPHER:
	    case MAP_PLAYER_ARMOUR0:
	    case MAP_PLAYER_ARMOUR1:
	    case MAP_PLAYER_ARMOUR2:
	    case MAP_PLAYER_ARMOUR3:
	      break;
	    case MAP_BRICK_EXPANDING:
	      if(x > 0 && map->data[x - 1 + y * map->width] == MAP_EMPTY)
		{
		  map->data[x - 1 + y * map->width] = MAP_BRICK_EXPANDING;
		  map->processed[x - 1 + y * map->width] = 1;
		  sfx(SFX_BOULDER_MOVE);
		}
	      else if(x + 1 < map->width && map->data[x + 1 + y * map->width] == MAP_EMPTY)
		{
		  map->data[x + 1 + y * map->width] = MAP_BRICK_EXPANDING;
		  map->processed[x + 1 + y * map->width] = 1;
		  sfx(SFX_BOULDER_MOVE);
		}
	      break;
	    case MAP_SMOKE2:
	      map->data[x + y * map->width] = MAP_SMOKE1;
	      break;
	    case MAP_SMOKE1:
	      map->data[x + y * map->width] = MAP_EMPTY;
	      break;
	    case MAP_ENEMY1:
	      {
		enum MOVE_DIRECTION current_direction;
		int nx, ny, do_move;
		
		check_for_player_kill = 1;

		current_direction = map->move_directions[x + y * map->width];

		/* try to turn left */
		switch(current_direction)
		  {
		  case MOVE_NONE:
		    break;
		  case MOVE_UP:
		    current_direction = MOVE_LEFT;
		    break;
		  case MOVE_RIGHT:
		    current_direction = MOVE_UP;
		    break;
		  case MOVE_DOWN:
		    current_direction = MOVE_RIGHT;
		    break;
		  case MOVE_LEFT:
		    current_direction = MOVE_DOWN;
		    break;
		  }

		nx = x;
		ny = y;
		do_move = 0;
		for(int i = 0; i < 2 && !do_move; i++)
		  switch(current_direction)
		    {
		    case MOVE_NONE:
		      current_direction = MOVE_UP;
		      i = 2;
		      break;
		    case MOVE_UP:
		      if(y > 0 && map->data[x + (y - 1) * map->width] == MAP_EMPTY)
			{
			  ny--;
			  do_move = 1;
			}
		      else
			current_direction = MOVE_RIGHT;
		      break;
		    case MOVE_RIGHT:
		      if(x < map->width - 1 && map->data[x + 1 + y * map->width] == MAP_EMPTY)
			{
			  nx++;
			  do_move = 1;
			}
		      else
			current_direction = MOVE_DOWN;
		      break;
		    case MOVE_DOWN:
		      if(y < map->height - 1 && map->data[x + (y + 1) * map->width] == MAP_EMPTY)
			{
			  ny++;
			  do_move = 1;
			}
		      else
			current_direction = MOVE_LEFT;
		      break;
		    case MOVE_LEFT:
		      if(x > 0 && map->data[x - 1 + y * map->width] == MAP_EMPTY)
			{
			  nx--;
			  do_move = 1;
			}
		      else
			current_direction = MOVE_UP;
		      break;
		    }

		map->data[x + y * map->width] = MAP_EMPTY;
		map->data[nx + ny * map->width] = MAP_ENEMY1;
		map->processed[nx + ny * map->width] = 1;
		map->move_directions[nx + ny * map->width] = current_direction;
	      }
	      break;
	    case MAP_ENEMY2:
	      {
		enum MOVE_DIRECTION current_direction;
		int nx, ny, do_move;

		check_for_player_kill = 1;

		current_direction = map->move_directions[x + y * map->width];

		/* try to turn right */
		switch(current_direction)
		  {
		  case MOVE_NONE:
		    current_direction = MOVE_DOWN;
		    break;
		  case MOVE_UP:
		    current_direction = MOVE_RIGHT;
		    break;
		  case MOVE_RIGHT:
		    current_direction = MOVE_DOWN;
		    break;
		  case MOVE_DOWN:
		    current_direction = MOVE_LEFT;
		    break;
		  case MOVE_LEFT:
		    current_direction = MOVE_UP;
		    break;
		  }

		nx = x;
		ny = y;
		do_move = 0;
		for(int i = 0; i < 2 && !do_move; i++)
		  switch(current_direction)
		    {
		    case MOVE_NONE:
		      current_direction = MOVE_UP;
		      break;
		    case MOVE_UP:
		      if(y > 0 && map->data[x + (y - 1) * map->width] == MAP_EMPTY)
			{
			  ny--;
			  do_move = 1;
			}
		      else
			current_direction = MOVE_LEFT;
		      break;
		    case MOVE_RIGHT:
		      if(x < map->width - 1 && map->data[x + 1 + y * map->width] == MAP_EMPTY)
			{
			  nx++;
			  do_move = 1;
			}
		      else
			current_direction = MOVE_UP;
		      break;
		    case MOVE_DOWN:
		      if(y < map->height - 1 && map->data[x + (y + 1) * map->width] == MAP_EMPTY)
			{
			  ny++;
			  do_move = 1;
			}
		      else
			current_direction = MOVE_RIGHT;
		      break;
		    case MOVE_LEFT:
		      if(x > 0 && map->data[x - 1 + y * map->width] == MAP_EMPTY)
			{
			  nx--;
			  do_move = 1;
			}
		      else
			current_direction = MOVE_DOWN;
		      break;
		    }

		map->data[x + y * map->width] = MAP_EMPTY;
		map->data[nx + ny * map->width] = MAP_ENEMY2;
		map->processed[nx + ny * map->width] = 1;
		map->move_directions[nx + ny * map->width] = current_direction;
	      }
	      break;
	    case MAP_BOULDER:
	    case MAP_DIAMOND:
	      if(y < map->height - 1)
		{
		  int fall;
		  char type;

		  type = map->data[x + y * map->width];

		  fall = 0;
		  if(map->data[x + (y + 1) * map->width] == MAP_EMPTY)
		    fall = map->width;
		  else if(map->data[x + (y + 1) * map->width] == MAP_BOULDER || map->data[x + (y + 1) * map->width] == MAP_DIAMOND ||
			  map->data[x + (y + 1) * map->width] == MAP_BRICK)
		    {
		      if(x > 0                   && map->data[x - 1 + y * map->width] == MAP_EMPTY && map->data[x - 1 + (y + 1) * map->width] == MAP_EMPTY)
			fall = -1;
		      else if(x < map->width - 1 && map->data[x + 1 + y * map->width] == MAP_EMPTY && map->data[x + 1 + (y + 1) * map->width] == MAP_EMPTY)
			fall = 1;
		    }

		  if(fall)
		    {
		      int bx, by;

		      bx = x;
		      by = y;
		      if(fall == 1 || fall == -1)
			{
			  map->data[x + y * map->width] = MAP_EMPTY;
			  bx += fall;
			}
		      if(type == MAP_BOULDER)
			map->data[bx + by * map->width] = MAP_BOULDER_FALLING;
		      else if(type == MAP_DIAMOND)
			map->data[bx + by * map->width] = MAP_DIAMOND_FALLING;
		      else
			{
			  assert(0);
			}
		      map->processed[bx + by * map->width] = 1;
		    }
		}
	      break;
	    case MAP_BOULDER_FALLING:
	    case MAP_DIAMOND_FALLING:
	      {
		int cont_falling;

		cont_falling = 0;
		if(y < map->height - 1)
		  {
		    switch(map->data[x + (y + 1) * map->width])
		      {
		      case MAP_EMPTY:
			cont_falling = 1;
			break;
		      case MAP_PLAYER:
			armour = 0;
			player_death();
			break;
		      case MAP_ENEMY1:
			enemy_death(MAP_SMOKE2, x, y + 1);
			break;
		      case MAP_ENEMY2:
			enemy_death(MAP_DIAMOND, x, y + 1);
			break;
		      case MAP_BRICK_MORPHER:
			if(morpher_is_on == 0)
			  {
			    morpher_is_on = 1;
			    morpher_end_time = game_time - 30 * frames_per_second;
			  }
			if(morpher_is_on == 1)
			  {
			    if(y < map->height - 2)
			      if(map->data[x + (y + 2) * map->width] == MAP_EMPTY)
				{
				  enum MAP_GLYPH g;
				  
				  if(map->data[x + y * map->width] == MAP_DIAMOND_FALLING)
				    g = MAP_BOULDER;
				  else
				    g = MAP_DIAMOND;

				  map->data[x + (y + 2) * map->width] = g;
				  map->processed[x + (y + 2) * map->width] = 1;
				  sfx(SFX_DIAMOND_COLLECT);
				}
			    map->data[x + y * map->width] = MAP_EMPTY;
			  }
			break;
		      }
		  }

		{
		  char type;

		  type = map->data[x + y * map->width];

		  if(cont_falling)
		    {
		      map->data[x + (y + 1) * map->width] = type;
		      map->processed[x + (y + 1) * map->width] = 1;
		      map->data[x + y * map->width] = MAP_EMPTY;
		    }
		  else
		    {
		      if(type == MAP_BOULDER_FALLING)
			{
			  map->data[x + y * map->width] = MAP_BOULDER;
			  map->processed[x + y * map->width] = 1;
			  sfx(SFX_BOULDER_FALL);
			}
		      else if(type == MAP_DIAMOND_FALLING)
			{
			  map->data[x + y * map->width] = MAP_DIAMOND;
			  map->processed[x + y * map->width] = 1;
			  sfx(SFX_DIAMOND_FALL);
			}
		    }
		}
	      }
	      break;
	    case MAP_PLAYER:
	      break;
	    case MAP_AMEBA:
	      {
		int dx, dy;

		dx = -1;
		dy = -1;
		if(x > 0 && (map->data[x - 1 + y * map->width] == MAP_ENEMY1 || map->data[x - 1 + y * map->width] == MAP_ENEMY2))
		  {
		    dx = x - 1;
		    dy = y;
		  }
		else if(x < map->width - 1 && (map->data[x + 1 + y * map->width] == MAP_ENEMY1 || map->data[x + 1 + y * map->width] == MAP_ENEMY2))
		  {
		    dx = x + 1;
		    dy = y;
		  }
		else if(y > 0 && (map->data[x + (y - 1) * map->width] == MAP_ENEMY1 || map->data[x + (y - 1) * map->width] == MAP_ENEMY2))
		  {
		    dx = x;
		    dy = y - 1;
		  }
		else if(y < map->height - 1 && (map->data[x + (y + 1) * map->width] == MAP_ENEMY1 || map->data[x + (y + 1) * map->width] == MAP_ENEMY2))
		  {
		    dx = x;
		    dy = y + 1;
		  }

		if(dx != -1)
		  {
		    if(map->data[dx + dy * map->width] == MAP_ENEMY1)
		      enemy_death(MAP_SMOKE2, dx, dy);
		    else if(map->data[dx + dy * map->width] == MAP_ENEMY2)
		      enemy_death(MAP_DIAMOND, dx, dy);
		  }
	      }
	      if(map->data[x + y * map->width] == MAP_AMEBA)
		{
		  int r;
		  
		  r = get_rand(200);
		  if(r < 5)
		    expand_ameba(x - 1, y);
		  else if(r < 10)
		    expand_ameba(x + 1, y);
		  else if(r < 15)
		    expand_ameba(x, y - 1);
		  else if(r < 20)
		    expand_ameba(x, y + 1);
		}
	      break;
	    }

	  if(check_for_player_kill)
	    {
	      if(x > 0 && map->data[x - 1 + y * map->width] == MAP_PLAYER)
		player_death();
	      else if(x < map->width - 1 && map->data[x + 1 + y * map->width] == MAP_PLAYER)
		player_death();
	      else if(y > 0 && map->data[x + (y - 1) * map->width] == MAP_PLAYER)
		player_death();
	      else if(y < map->height - 1 && map->data[x + (y + 1) * map->width] == MAP_PLAYER)
		player_death();
	    }
	}

  if(map->ameba_time > 0)
    {
      if(map->ameba_time == game_time / frames_per_second)
	{ /* turn ameba into diamonds or boulders */
	  enum MAP_GLYPH g;

	  sfx_stop(SFX_AMEBA);
	  ameba_sound = 0;

	  g = MAP_DIAMOND;
	  for(int y = 0; y < map->height && g == MAP_DIAMOND; y++)
	    for(int x = 0; x < map->width && g == MAP_DIAMOND; x++)
	      if(map->data[x + y * map->width] == MAP_AMEBA)
		{
		  if(x > 0 && (map->data[x - 1 + y * map->width] == MAP_EMPTY || map->data[x - 1 + y * map->width] == MAP_SAND))
		    g = MAP_BOULDER;
		  else if(x < map->width - 1 && (map->data[x + 1 + y * map->width] == MAP_EMPTY || map->data[x + 1 + y * map->width] == MAP_SAND))
		    g = MAP_BOULDER;
		  else if(y > 0 && (map->data[x + (y - 1) * map->width] == MAP_EMPTY || map->data[x + (y - 1) * map->width] == MAP_SAND))
		    g = MAP_BOULDER;
		  else if(y < map->height - 1 && (map->data[x + (y + 1) * map->width] == MAP_EMPTY || map->data[x + (y + 1) * map->width] == MAP_SAND))
		    g = MAP_BOULDER;
		}

	  for(int y = 0; y < map->height; y++)
	    for(int x = 0; x < map->width; x++)
	      if(map->data[x + y * map->width] == MAP_AMEBA)
		map->data[x + y * map->width] = g;
	}
    }
  
  if(morpher_is_on == 1)
    if(game_time <= morpher_end_time)
      morpher_is_on = 2;
}


static void next_level(void)
{
  int done;

  while(game_time > 0)
    {
      anim_frame++;
      game_time -= frames_per_second;
      add_score(map->time_score);
      sfx(SFX_TIME);
      if(game_time < 0)
	game_time = 0;
      draw_game_screen();
      SDL_Flip(gfx(MAP_SCREEN));
      SDL_framerateDelay(&framerate_manager);
    }

  draw_game_screen();

  {
    SDL_Rect r;
    Uint32 c;
    int h;

    h = BFont_FontHeight(BFont_GetCurrentFont());
    r.x = gfx(MAP_SCREEN)->w / 4;
    r.y = gfx(MAP_SCREEN)->h / 3 - (10 + h);
    r.w = gfx(MAP_SCREEN)->w / 2;
    r.h = 10 + h + h + 10;
    c = SDL_MapRGB(gfx(MAP_SCREEN)->format, 0x00, 0x00, 0x00);
    SDL_FillRect(gfx(MAP_SCREEN), &r, c);
  }

  BFont_CenteredPrintString(gfx(MAP_SCREEN), gfx(MAP_SCREEN)->h / 3, "Level completed, press enter.");
  SDL_Flip(gfx(MAP_SCREEN));
  
  done = 0;
  while(!done)
    {
      SDL_Event event;

      if(SDL_WaitEvent(&event))
	{
	  if(event.type == SDL_QUIT)
	    {
	      game_quit = 1;
	      game_done = 1;
	      done = 1;
	    }
	  else if(event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE)
	    {
	      game_done = 1;
	      done = 1;
	      if(!exit_after_one_level)
		highscore_new(player_score, game_level);
	    }
	  else if(event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_RETURN)
	    {
	      done = 1;
	      if(!exit_after_one_level)
		{	      
		  game_level++;
		  init_map();
		}
	      else
		game_done = 1;
	    }
	}
      else
	{
	  game_done = 1;
	  done = 1;
	}
    }
}


static void add_score(int score)
{
  int elifescore;

  elifescore = 200;
  if(player_score / elifescore < (player_score + score) / elifescore)
    { /* extra naked girl */
      girls++;
      extra_life_anim = frames_per_second * 5;
    }

  player_score += score;
}

static void expand_ameba(int x, int y)
{
  if(x >= 0 && x < map->width && y >= 0 && y < map->height)
    if(map->data[x + y * map->width] == MAP_EMPTY ||
       map->data[x + y * map->width] == MAP_SAND)
      {
	map->data[x + y * map->width] = MAP_AMEBA;
	map->processed[x + y * map->width] = 1;
      }
}
