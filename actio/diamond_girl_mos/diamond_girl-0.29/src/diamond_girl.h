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

#ifndef DIAMOND_GIRL_H
#define DIAMOND_GIRL_H

#include <SDL/SDL.h>
#include <time.h>

#include "version.h"

enum MOVE_DIRECTION { MOVE_NONE, MOVE_UP, MOVE_DOWN, MOVE_LEFT, MOVE_RIGHT };

enum MAP_GLYPH
{
  MAP_SCREEN,
  MAP_EMPTY,
  MAP_BORDER,
  MAP_ILLEGAL,
  MAP_SAND,
  MAP_PLAYER,
  MAP_PLAYER_ARMOUR0,
  MAP_PLAYER_ARMOUR1,
  MAP_PLAYER_ARMOUR2,
  MAP_PLAYER_ARMOUR3,
  MAP_BOULDER,
  MAP_BOULDER_FALLING,
  MAP_DIAMOND,
  MAP_DIAMOND_FALLING,
  MAP_ENEMY1,
  MAP_ENEMY2,
  MAP_SMOKE,
  MAP_SMOKE1,
  MAP_SMOKE2,
  MAP_EXIT_LEVEL,
  MAP_EXTRA_LIFE_ANIM,
  MAP_BRICK,
  MAP_BRICK_EXPANDING,
  MAP_BRICK_UNBREAKABLE,
  MAP_BRICK_MORPHER,
  MAP_AMEBA
};

enum SFX
  {
    SFX_BOULDER_FALL,
    SFX_BOULDER_MOVE,
    SFX_DIAMOND_FALL,
    SFX_DIAMOND_COLLECT,
    SFX_MOVE_EMPTY,
    SFX_MOVE_SAND,
    SFX_AMEBA,
    SFX_EXPLOSION,
    SFX_SMALL_EXPLOSION,
    SFX_TIME,
    SFX_SIZEOF_
  };

enum MUSIC
  {
    MUSIC_TITLE,
    MUSIC_START,
    MUSIC_SIZEOF_
  };

struct map
{
  int width, height;
  int start_x, start_y;
  int exit_x, exit_y;
  int diamonds_needed;
  int diamond_score;
  int time_score;
  char * data;
  char * processed;
  enum MOVE_DIRECTION * move_directions;
  int time;
  int ameba_time;
  int game_speed;
};


struct highscore_entry
{
  time_t timestamp;
  int    score;
  int    level;
};

extern int fullscreen;

/* gfx functions */
extern int           gfx_initialize(void);
extern void          gfx_cleanup(void);
extern SDL_Surface * gfx(enum MAP_GLYPH);

/* sfx functions */
extern void sfx_initialize(void);
extern void sfx_cleanup(void);
extern void sfx(enum SFX sfx_id);
extern void sfx_stop(enum SFX sfx_id);
extern void sfx_music(enum MUSIC music_id, int loop_forever);
extern void sfx_music_stop(void);

/* main functions */
extern void main_menu(int homedir_ok);
extern int game(const char * map_set, int level, int return_after_one_level);
extern void map_editor(const char * map_set);

/* map functions */
extern struct map * map_random(int level);
extern struct map * map_load(const char * filename);
extern void         map_save(struct map * map, const char * filename);
extern struct map * map_free(struct map * map);

/* highscore functions */
extern void highscores_load(int do_load, const char * map_set);
extern void highscores_save(int do_save, const char * map_set);
extern void highscore_new(int score, int level);
extern struct highscore_entry ** highscores_get(size_t * size_ptr);

/* utility functions */
extern unsigned int get_rand(unsigned int max);
extern const char * get_save_filename(const char * name);
extern const char * get_data_filename(const char * name);
extern void clear_area(int x, int y, int w, int h);
extern void draw_map(struct map * map, int top_x, int top_y, int width, int height, int map_x, int map_y, int map_fine_x, int map_fine_y,
		     int extra_life_anim, int morpher_is_on, int anim_frame, int player_direction, int armour, int in_editor);


#if defined(__amigaos4__) || defined(__MORPHOS__)
# if !defined(AMIGA)
#  define AMIGA
# endif
#endif

#endif
