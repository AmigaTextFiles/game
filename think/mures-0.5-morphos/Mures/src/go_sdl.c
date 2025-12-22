/*

Mures
Copyright (C) 2001 Adam D'Angelo

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Contact information:

Adam D'Angelo
dangelo@ntplx.net
P.O. Box 1155
Redding, CT 06875-1155
USA

*/

#include <stdlib.h>
#include <math.h>
#include "SDL.h"
#include "SDL_image.h"
#include "SDL_ttf.h"
#include "SDL_rotozoom.h"
#include "sim.h"
#include "output.h"
#include "gi_sdl.h"
#include "game_input.h"
#include "lib.h"
#include "map.h"
#include "anim.h"
#include "audio_sdl.h"
#include "game_output.h"

#define GO (*(go_sdl*)g->output)

enum
{
  MOUSE_LEFT,
  MOUSE_RIGHT,
  MOUSE_UP,
  MOUSE_DOWN,
  MOUSE_Q_LEFT,
  MOUSE_Q_RIGHT,
  MOUSE_Q_UP,
  MOUSE_Q_DOWN,
  MOUSE_50_LEFT,
  MOUSE_50_RIGHT,
  MOUSE_50_UP,
  MOUSE_50_DOWN,
  DEADMOUSE_UP,
  DEADMOUSE_DOWN,
  DEADMOUSE_LEFT,
  DEADMOUSE_RIGHT,
  CAT_LEFT,
  CAT_RIGHT,
  CAT_UP,
  CAT_DOWN,
  CAT_ATTACKING,
  CAT_EXPLOSION,
  ROCKET_0,
  ROCKET_1,
  ROCKET_2,
  ROCKET_3,
  ROCKET_0_A,
  ROCKET_1_A,
  ROCKET_2_A,
  ROCKET_3_A,
  POINTER_0,
  POINTER_1,
  POINTER_2,
  POINTER_3,
  WALLPOST,
  GRID_BOX,
  GRID_BOX_GREY,
  GENERATOR,
  PLACE_1,
  PLACE_2,
  PLACE_3,
  PLACE_4,
  MAX_ANIM
};

typedef struct _time_effect
{
  int exists;
  int time;
  direction dir;
  screen_position pos;
} time_effect;


#define MAX_DEAD_MOUSE 64

typedef struct _go_sdl
{
  int type;
  int w, h;

  int loaded_images;
  int block_size;
  int factor_h, factor_w;
  int top_margin, left_margin;
  
  anim *anim[MAX_ANIM];
  SDL_Surface *arrow_image[MAX_PLAYER][MAX_DIR][ARROW_TOUGHNESS+1];

  int rocket_last_hit[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  int rocket_last_cat[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  
  time_effect dead_mouse[MAX_DEAD_MOUSE];

  int have_bg;
  SDL_Surface *bg;
  TTF_Font *small_font;
  TTF_Font *digit_font;
  TTF_Font *clock_font;
  TTF_Font *mode_intro_font;
} go_sdl;


/* how many ms on/off during an arrow's flickering */
#define FLICKER_RATE 20
/* how many ms an arrow flickers for */
#define FLICKER_TIME 1300

SDL_Color grid_box_color = {0xFF, 0xFF, 0xFF, 0};
SDL_Color grid_box_grey_color = {0x88, 0x88, 0x88, 0};
SDL_Color battle_fence_color = { 0x00, 0x00, 0xAA, 0 };
SDL_Color puzzle_fence_color = { 0xAA, 0x00, 0x00, 0 };
SDL_Color battle_fence_post_color = { 0x00, 0x00, 0xAA, 0 };
SDL_Color puzzle_fence_post_color = { 0xAA, 0x00, 0x00, 0 };

SDL_Color generator_color = {0xCC, 0xCC, 0xCC, 0};

SDL_Color white = {0xFF, 0xFF, 0xFF, 0};
SDL_Color score_color = {0xFF, 0xFF, 0xFF, 0};

SDL_Color trans = {0, 0, 1, 0};
SDL_Color black = {0x00, 0x00, 0x00, 0};
SDL_Color percentage_bar_bg = {0x88, 0x88, 0xCC, 0};
SDL_Color percentage_bar_fg = {0x66, 0x66, 0x99, 0};

SDL_Color battle_bg_color_1 = {0x88, 0x88, 0xCC, 0};
SDL_Color battle_bg_color_2 = {0x66, 0x66, 0x99, 0};
SDL_Color puzzle_bg_color_1 = {0xCC, 0x88, 0x88, 0};
SDL_Color puzzle_bg_color_2 = {0x99, 0x66, 0x66, 0};

SDL_Color arrow_color = {0xFF, 0xFF, 0xFF};
SDL_Color box_border_color = {0xAA, 0xAA, 0xAA};
SDL_Color box_color = {0x33, 0x33, 0x33};
SDL_Color score_change_color_fg = {0x00, 0xDD, 0xDD, 0};
SDL_Color score_change_color_bg = {0x00, 0x44, 0x44, 0};

#define DARK 0x33
#define LIGHT 0xFF

SDL_Color player_sdl_color[MAX_PLAYER] = {
  {DARK, DARK, LIGHT},             /* blue   */
  {LIGHT*9/10, LIGHT*8/10, DARK},  /* yellow */
  {LIGHT, DARK, DARK},             /* red    */
  {DARK, LIGHT*9/10, DARK}         /* green  */
};

game *current_g;

typedef struct _image_info_type
{
  int id;
  char *file;
  int trans;
  int alpha;
} image_info_type;

image_info_type image_info[MAX_ANIM] = {
  { MOUSE_LEFT,     "mouse_left.ani" },
  { MOUSE_RIGHT,    "mouse_right.ani" },
  { MOUSE_UP,       "mouse_up.ani" },
  { MOUSE_DOWN,     "mouse_down.ani" },
  { MOUSE_Q_LEFT,   "mouseq_left.ani" },
  { MOUSE_Q_RIGHT,  "mouseq_right.ani" },
  { MOUSE_Q_UP,     "mouseq_up.ani" },
  { MOUSE_Q_DOWN,   "mouseq_down.ani" },
  { MOUSE_50_LEFT,  "mouse50_left.ani" },
  { MOUSE_50_RIGHT, "mouse50_right.ani" },
  { MOUSE_50_UP,    "mouse50_up.ani" },
  { MOUSE_50_DOWN,  "mouse50_down.ani" },
  { DEADMOUSE_UP,   "deadmouse_up.ani" },
  { DEADMOUSE_DOWN, "deadmouse_down.ani" },
  { DEADMOUSE_LEFT, "deadmouse_left.ani" },
  { DEADMOUSE_RIGHT,"deadmouse_right.ani" },
  { CAT_LEFT,       "cat_left.ani" },
  { CAT_RIGHT,      "cat_right.ani" },
  { CAT_UP,         "cat_up.ani" },
  { CAT_DOWN,       "cat_down.ani" },
  { CAT_ATTACKING,  "cat_attacking.ani" },
  { CAT_EXPLOSION,  "cat_explosion.ani" },
  { ROCKET_0,       "rocket0.ani" },
  { ROCKET_1,       "rocket1.ani" },
  { ROCKET_2,       "rocket2.ani" },
  { ROCKET_3,       "rocket3.ani" },
  { ROCKET_0_A,     "rocket0_a.ani" },
  { ROCKET_1_A,     "rocket1_a.ani" },
  { ROCKET_2_A,     "rocket2_a.ani" },
  { ROCKET_3_A,     "rocket3_a.ani" },
  { POINTER_0,      "pointer0.ani" },
  { POINTER_1,      "pointer1.ani"},
  { POINTER_2,      "pointer2.ani"},
  { POINTER_3,      "pointer3.ani"},
  { GENERATOR,      "generator.ani" },
  { PLACE_1,        "place1.ani" },
  { PLACE_2,        "place2.ani" },
  { PLACE_3,        "place3.ani" },
  { PLACE_4,        "place4.ani" }
};

/* where the grid starts */
#define TOP_BORDER go->factor_h*.025
#define LEFT_BORDER go->factor_w*.0125
#define BOTTOM_BORDER go->factor_h*.12
#define RIGHT_BORDER (go->factor_w - LEFT_BORDER - go->block_size*NUM_BLOCKS_X)

#define GRID_BOX_THICKNESS (block_size*5/40)

#define WALL_THICKNESS (MAX(1, (block_size*8/45+1)/2*2))

#define WALLPOST_SIZE (MAX(1, WALL_THICKNESS*2-2))

screen_position go_sdl_grid2screen(game *g, grid_int_position ongrid)
{
  screen_position temp;
  go_sdl *go = &GO;

  temp.x = ongrid.x*go->block_size+LEFT_BORDER+go->left_margin;
  temp.y = ongrid.y*go->block_size+TOP_BORDER+go->top_margin;
  return temp;
}

screen_position go_sdl_grid2screen_center(game *g, grid_int_position ongrid)
{
  screen_position temp;

  temp = go_sdl_grid2screen(g, ongrid);
  
  temp.x += GO.block_size/2;
  temp.y += GO.block_size/2;
  return temp;
}

screen_position go_sdl_gridf2screen(game *g, grid_float_position ongrid)
{
  screen_position temp;
  go_sdl *go = &GO;

  temp.x = ongrid.x*go->block_size+LEFT_BORDER+go->left_margin;
  temp.y = ongrid.y*go->block_size+TOP_BORDER+go->top_margin;
  return temp;
}


screen_position screen_pos(Uint32 x, Uint32 y)
{
  screen_position temp;
  temp.x = x;
  temp.y = y;
  return temp;
}

SDL_Color fence_post_color(map *m)
{
  if(m->type == BATTLE)
    return battle_fence_post_color;
  else
    return puzzle_fence_post_color;
}

SDL_Color fence_color(map *m)
{
  if(m->type == BATTLE)
    return battle_fence_color;
  else
    return puzzle_fence_color;
}

SDL_Color bg_color(map *m, int oe)
{
  if(m->type == BATTLE) {
    if(oe)
      return battle_bg_color_1;
    else
      return battle_bg_color_2;
  }
  else {
    if(oe)
      return puzzle_bg_color_1;
    else
      return puzzle_bg_color_2;
  }
}

SDL_Surface *make_surface(int w, int h, bool tr)
{
  SDL_Surface *s;
  Uint32 flags = SDL_HWSURFACE;
  
  if(tr)
    flags |= SDL_SRCCOLORKEY;
  
  s = SDL_CreateRGBSurface(SDL_HWSURFACE|SDL_SRCCOLORKEY, w, h, BPP, 0, 0, 0, 0);

  if(s == NULL) {
    fprintf(stderr, "Couldn't make surface with width %d, height %d\n", w, h);
    exit(1);
  }

  SDL_SetColorKey(s, SDL_SRCCOLORKEY|SDL_RLEACCEL, SDL_MapRGB(s->format, trans.r, trans.g, trans.b));
  
  return s;
}

anim *make_grid_box(int block_size, SDL_Color c)
{
  int x, y, w, h;
  SDL_Surface *s;

  s = make_surface(block_size, block_size, 1);
  
  color_rect(s, 0, 0, block_size, block_size, trans);
  
  x = 0;
  y = 0;
  w = block_size*2/5;
  h = GRID_BOX_THICKNESS;
  
  color_rect(s, x, y, w, h, c);

  x = block_size*3/5;
  color_rect(s, x, y, w, h, c);
  x = 0;

  y = block_size-GRID_BOX_THICKNESS;
  color_rect(s, x, y, w, h, c);

  x = block_size*3/5;
  color_rect(s, x, y, w, h, c);

  x = 0;
  y = 0;
  w = GRID_BOX_THICKNESS;
  h = block_size*2/5;
  color_rect(s, x, y, w, h, c);

  y = block_size*3/5;
  color_rect(s, x, y, w, h, c);
  y = 0;
  
  x = block_size - GRID_BOX_THICKNESS;
  color_rect(s, x, y, w, h, c);

  y = block_size*3/5;
  color_rect(s, x, y, w, h, c);

  return make_anim_from_s(s);
}

void arrow_rect(SDL_Surface *s, direction dir, SDL_Rect rect, SDL_Color c, int block_size)
{
  int temp;
  if(dir==DOWN) {
    rect.y = block_size-rect.y-rect.h;
  }
  if(dir==RIGHT || dir==LEFT) {
    temp = rect.x;
    rect.x = rect.y;
    rect.y = temp;
    
    temp = rect.w;
    rect.w = rect.h;
    rect.h = temp;
  }
  if(dir==RIGHT) {
    rect.x = block_size-rect.x-rect.w;
  }
  color_rect(s, rect.x, rect.y, rect.w, rect.h, c);
}

SDL_Surface *make_arrow(int block_size, direction dir, int health, SDL_Color c)
{
  int i;
  int w;
  int thisw;
  int h,hbox,btop;
  SDL_Surface *s;
  SDL_Rect rect;
  
#define SHRINK_FACTOR 5
#define BOX_SHRINK_FACTOR 1/10
  
  s = make_surface(block_size, block_size, 1);

  rect.x = rect.y = 0;
  rect.w = rect.h = block_size;

  arrow_rect(s, dir, rect, trans, block_size);

  rect.x = rect.y = block_size*BOX_SHRINK_FACTOR*(ARROW_TOUGHNESS-1-health);
  rect.w = rect.h = block_size-block_size*2*BOX_SHRINK_FACTOR*(ARROW_TOUGHNESS-1-health);

  arrow_rect(s, dir, rect, c, block_size);

  w = 3;
  h = block_size*8/14*(health+SHRINK_FACTOR)/(SHRINK_FACTOR+1);
  hbox = block_size/4*(health+SHRINK_FACTOR)/(SHRINK_FACTOR+1);
  btop = (block_size-h-hbox)/2;

  for(i=0; i<h; i++) {
    thisw = w/3 /2*2;
    /*    if(i==h-1)
	  thisw-=2;*/
    rect.x = block_size/2-thisw/2;
    rect.y = i+btop;
    rect.w = thisw;
    rect.h = 1;
    
    arrow_rect(s, dir, rect, arrow_color, block_size);
    w += 3;
  }
  
  rect.y = rect.h + rect.y;
  rect.h = hbox;
  rect.x = block_size*3/8;
  rect.w = block_size/4;
  
  arrow_rect(s, dir, rect, arrow_color, block_size);

  return s;
}

anim *make_wallpost(int block_size, map *m)
{
  int i;
  SDL_Surface *s;
  
  s = make_surface(WALLPOST_SIZE, WALLPOST_SIZE, 1);
  
  color_rect(s, 0, 0, WALLPOST_SIZE, WALLPOST_SIZE, trans);
  
  for(i=0; i<WALLPOST_SIZE/2; i++)
    color_rect(s, WALLPOST_SIZE/2-i-1, i, i*2+2, 1, fence_post_color(m));
  
  for(i=0; i<=WALLPOST_SIZE/2; i++)
    color_rect(s, i, WALLPOST_SIZE/2+i, (WALLPOST_SIZE/2-i)*2, 1, fence_post_color(m));

  return make_anim_from_s(s);
}

int load_images(game *g)
{
  int i,j,k;
  char buff[100];
  go_sdl *go = &GO;

  printf("Loading digit font...\n");
  go->digit_font = TTF_OpenFont("images/cmtt10.ttf", max2(3, go->block_size*14/10));

  if(go->digit_font == NULL) {
    fprintf(stderr, "Couldn't load digit font.\n");
    return 0;
  }

  printf("Loading clock font...\n");
  go->clock_font = TTF_OpenFont("images/cmr10.ttf", max2(3, go->block_size*14/10));

  if(go->clock_font == NULL) {
    fprintf(stderr, "Couldn't load clock font.\n");
    return 0;
  }
  
  printf("Loading mode intro font...\n");
  go->mode_intro_font = TTF_OpenFont("images/cmtt10.ttf", max2(3, go->block_size*8/10));

  if(go->mode_intro_font == NULL) {
    fprintf(stderr, "Couldn't load mode intro font.\n");
    return 0;
  }

  printf("Loading small font...\n");
  go->small_font = TTF_OpenFont("images/cmtt10.ttf", max2(3, go->block_size*4/10));

  if(go->small_font == NULL) {
    fprintf(stderr, "Couldn't load small font :%s.\n", TTF_GetError());
    exit(1);
  }
  
  printf("Generating necessary images...\n");

  go->anim[WALLPOST] = make_wallpost(go->block_size, &g->sim.map);
  go->anim[GRID_BOX] = make_grid_box(go->block_size, grid_box_color);
  go->anim[GRID_BOX_GREY] = make_grid_box(go->block_size, grid_box_grey_color);

  /* create arrows */
  for(i=0; i<MAX_PLAYER; i++)
    for(j=0; j<MAX_DIR; j++)
      for(k=0; k<ARROW_TOUGHNESS; k++) {
	go->arrow_image[i][j][k] = make_arrow(go->block_size, j, k, player_sdl_color[i]);
      }

  printf("Loading game animations...\n");
  
  for(i=0; i<MAX_ANIM; i++) {
    for(j=0; j<MAX_ANIM; j++)
      if(image_info[j].id == i)
	break;

    if(j!=MAX_ANIM) { /* if there is something to load for it */
      sprintf(&buff[0], "images/%s", image_info[j].file);
      
      go->anim[i] = anim_load(buff, ((float)go->block_size)/44);

      if(go->anim[i]==NULL) {
	printf("Couldn't load %s\n", buff);
	return 0;
      }
    }
  }
  
  printf("Done loading animations.\n");

  go->loaded_images = 1;

  return 1;
}

void unload_images(go_sdl *go)
{
  int i,j,k;

  printf("Unloading digit font...\n");
  TTF_CloseFont(go->digit_font);

  printf("Unloading clock font...\n");
  TTF_CloseFont(go->clock_font);

  printf("Unloading mode intro font...\n");
  TTF_CloseFont(go->mode_intro_font);

  printf("Unloading small font...\n");
  TTF_CloseFont(go->small_font);

  printf("Unloading game animations...\n");

  for(i=0; i<MAX_ANIM; i++)
    anim_close(go->anim[i]);
  
  for(i=0; i<MAX_PLAYER; i++)
    for(j=0; j<MAX_DIR; j++)
      for(k=0; k<ARROW_TOUGHNESS; k++)
	SDL_FreeSurface(go->arrow_image[i][j][k]);
  
}

void changed_size(game *g)
{
  printf("Detected size change.\n");
  
  if(GO.loaded_images)
    unload_images(&GO);
  
  if(!load_images(g)) {
    fprintf(stderr, "Couldn't load images, quitting.\n");
    exit(1);
  }
  
  game_input_changed_output(g);
}

anim *dead_mouse_anim(go_sdl *go, direction dir)
{
  switch(dir) {
  case UP: return go->anim[DEADMOUSE_UP]; break;
  case DOWN: return go->anim[DEADMOUSE_DOWN]; break;
  case LEFT: return go->anim[DEADMOUSE_LEFT]; break;
  case RIGHT: return go->anim[DEADMOUSE_RIGHT]; break;
  default: return NULL; break;
  }
}

void add_dead_mouse(game *g, direction dir, screen_position pos)
{
  int i;
  go_sdl *go = &GO;

  for(i=0; i<MAX_DEAD_MOUSE; i++)
    if(!go->dead_mouse[i].exists || g->sim.elapsed-go->dead_mouse[i].time > dead_mouse_anim(go, dir)->length) {
      go->dead_mouse[i].exists = 1;
      go->dead_mouse[i].time   = g->sim.elapsed;
      go->dead_mouse[i].dir    = dir;
      go->dead_mouse[i].pos    = pos;
      return;
    }

  /* ran out */
}

void go_sdl_handle_event(game *g, int event, float x, float y, direction dir)
{
  sound_handle_event(g, event, x, y, dir);
  
  switch(event) {
  case GET_MOUSE:
  case GET_MOUSE_50:
  case GET_MOUSE_Q:
    GO.rocket_last_hit[(int)x][(int)y] = g->sim.elapsed;
    break;
  case GET_CAT:
    GO.rocket_last_cat[(int)x][(int)y] = g->sim.elapsed;
    break;
  case MOUSE_DEATH:
    add_dead_mouse(g, dir, go_sdl_gridf2screen(g, grid_float_pos(x, y)));
    break;
  }
}

char *mode_string(qmouse_type mode)
{
  switch(mode) {
  case Q_MOUSE_MANIA: return "Mouse Mania!"; break;
  case Q_CAT_MANIA: return "Cat Mania!"; break;
  case Q_SPEED_UP: return "Speed Up!"; break;
  case Q_SLOW_DOWN: return "Slow Down!"; break;
  case Q_MOUSE_MONOPOLY: return "Mouse Monopoly!"; break;
  case Q_CAT_ATTACK: return "Cat Attack!"; break;
  case Q_EVERYBODY_MOVE: return "Everybody Move!"; break;
  case Q_PLACE_ARROWS_AGAIN: return "Place Arrows Again!"; break;
  default:
    fprintf(stderr, "Didn't know what to say for mode %d\n", mode);
    return "Error";
    break;
  }
}


anim* creature_anim(go_sdl *go, int type, int dir)
{
  switch(type) {
  case cat:
    switch(dir) {
    case LEFT: return go->anim[CAT_LEFT];
    case RIGHT: return go->anim[CAT_RIGHT];
    case UP: return go->anim[CAT_UP];
    case DOWN: return go->anim[CAT_DOWN];
    default: return go->anim[CAT_LEFT];
    }
    break;
  case mouse:
    switch(dir) {
    case LEFT: return go->anim[MOUSE_LEFT];
    case RIGHT: return go->anim[MOUSE_RIGHT];
    case UP: return go->anim[MOUSE_UP];
    case DOWN: return go->anim[MOUSE_DOWN];
    default: return go->anim[MOUSE_LEFT];
    }
    break;
  case mouse50:
    switch(dir) {
    case LEFT: return go->anim[MOUSE_50_LEFT];
    case RIGHT: return go->anim[MOUSE_50_RIGHT];
    case UP: return go->anim[MOUSE_50_UP];
    case DOWN: return go->anim[MOUSE_50_DOWN];
    default: return go->anim[MOUSE_50_LEFT];
    }
    break;
  case mouseq:
    switch(dir) {
    case LEFT: return go->anim[MOUSE_Q_LEFT];
    case RIGHT: return go->anim[MOUSE_Q_RIGHT];
    case UP: return go->anim[MOUSE_Q_UP];
    case DOWN: return go->anim[MOUSE_Q_DOWN];
    default: return go->anim[MOUSE_Q_LEFT];
    }
    break;
  default:
    fprintf(stderr, "Don't know how to render creature of type %d\n", type);
    return go->anim[MOUSE_LEFT];
    break;
  }
}


anim* player_rocket_anim(go_sdl *go, int player, int active)
{
  int num=0;
  if(active)
    switch(player) {
    case 0: num = ROCKET_0_A; break;
    case 1: num = ROCKET_1_A; break;
    case 2: num = ROCKET_2_A; break;
    case 3: num = ROCKET_3_A; break;
    default:
      fprintf(stderr, "No active rocket anim for player %d.\n", player);
      return go->anim[0];
      break;
    }
  else
    switch(player) {
    case 0: num = ROCKET_0; break;
    case 1: num = ROCKET_1; break;
    case 2: num = ROCKET_2; break;
    case 3: num = ROCKET_3; break;
    default:
      fprintf(stderr, "No rocket anim for player %d.\n", player);
      return go->anim[0];
      break;
    }

  return go->anim[num];
}

anim *player_pointer_anim(go_sdl *go, int player)
{
  int num;
  switch(player) {
  case 0: num = POINTER_0; break;
  case 1: num = POINTER_1; break;
  case 2: num = POINTER_2; break;
  case 3: num = POINTER_3; break;
  default:
    fprintf(stderr, "No pointer anim for player %d.\n", player);
    return go->anim[0];
    break;
  }
  return go->anim[num];
}

void clearbg(go_sdl *go)
{
  if(!go->have_bg)
    fprintf(stderr, "Warning: trying to clear bg when there is none.\n");

  fprintf(stderr, "Clearing background.\n");

  SDL_FreeSurface(go->bg);
  go->have_bg = 0;
}

void game_lost_surfaces(game *g)
{
  unload_images(&GO);
  load_images(g);
  clearbg(&GO);
}

void center_image(go_sdl *go, SDL_Surface *src, SDL_Surface *dest, screen_position top_left)
{
  screen_position pos = top_left;
  
  pos.x += go->block_size/2;
  pos.y += go->block_size/2;
  pos.x -= src->w/2;
  pos.y -= src->h/2;
  
  image_show(src, dest, pos);
}

void center_rocket(SDL_Surface *out, go_sdl *go, sim *s, int player, screen_position top_left, int active, int time)
{
  int i, count=0, place, right, left;
  SDL_Rect src, dest;

  for(i=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists)
      if(s->player[i].team_leader == s->player[player].team_leader)
	count++;

  for(i=0, place=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists)
      if(s->player[i].team_leader == s->player[player].team_leader) {
	dest.x = top_left.x;
	dest.y = top_left.y;
	
	/* center */
	dest.x += go->block_size/2;
	dest.y += go->block_size/2;
	dest.x -= anim_current_surface(player_rocket_anim(go, i, active), time)->w/2;
	dest.y -= anim_current_surface(player_rocket_anim(go, i, active), time)->h/2;
	
	left = dest.x;
	
	src.y=0;
	
	src.h = anim_current_surface(player_rocket_anim(go, i, active), time)->h;
	dest.h = src.h;

	src.x = anim_current_surface(player_rocket_anim(go, i, active), time)->w*place/count;
	dest.x = src.x + left;
	
	right = dest.x + anim_current_surface(player_rocket_anim(go, i, active), time)->w*(place+1)/count;
	dest.w = right-left;
	src.w = dest.w;

	SDL_BlitSurface(anim_current_surface(player_rocket_anim(go, i, active), time), &src, out, &dest);
	place++;
      }
}

void draw_map_bg(SDL_Surface *s, map *m, int block_size, int topx, int topy, int lighter)
{
  int odd;
  int x, y;
  SDL_Color color;
  SDL_Color checker_one = bg_color(m, 0);
  SDL_Color checker_two = bg_color(m, 1);

  odd=0;

  if(lighter) {
    checker_one.r = (checker_one.r*3+0xFF)/4;
    checker_one.g = (checker_one.g*3+0xFF)/4;
    checker_one.b = (checker_one.b*3+0xFF)/4;
    checker_two.r = (checker_two.r*3+0xFF)/4;
    checker_two.g = (checker_two.g*3+0xFF)/4;
    checker_two.b = (checker_two.b*3+0xFF)/4;
  }

  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++) {
      
      odd = (x%2+y%2)%2;
      if(odd)
	color = checker_one;
      else
	color = checker_two;
      if(m->hole[x][y])
	color = black;
      
      color_rect(s, topx+block_size*x, topy+block_size*y, block_size, block_size, color);
    }
}

void makebg(game *g, int w, int h)
{
  screen_position p;

  if(GO.have_bg)
    clearbg(&GO);
  
  printf("Pre-rendering background.\n");
  
  GO.bg = SDL_CreateRGBSurface(SDL_HWSURFACE, w, h, BPP, 0, 0, 0, 0);
  
  /* blackness */
  color_rect(GO.bg, 0, 0, w, h, black);
  
  p = go_sdl_grid2screen(g, grid_int_pos(0,0));
  
  draw_map_bg(GO.bg, &g->sim.map, GO.block_size, p.x, p.y, 0);
  
  printf("done.\n");
  
  GO.have_bg = 1;
}

void go_sdl_bigchange(game *g)
{
  makebg(g, GO.w, GO.h);
}

void go_sdl_exit(game *g)
{
  printf("Shutting down SDL game output.\n");
  if(GO.have_bg)
    clearbg(&GO);
  unload_images(&GO);
  
  free(&GO);
}

SDL_Color half_color(SDL_Color c)
{
  c.r/=2;
  c.g/=2;
  c.b/=2;
  return c;
}

void draw_map_walls(SDL_Surface *out, map *m, int block_size, int topx, int topy, SDL_Surface *wallpost)
{
  int x, y;
  
  /* vertical walls */
  for(x=0; x<NUM_BLOCKS_X+1; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      if(m->vwall[x%NUM_BLOCKS_X][y]) {
	color_rect(out, topx+x*block_size-WALL_THICKNESS/2, topy+y*block_size, WALL_THICKNESS, block_size, fence_color(m));
	image_show(wallpost, out, screen_pos(topx+block_size*x - wallpost->w/2, topy+block_size*y - wallpost->h/2));
	image_show(wallpost, out, screen_pos(topx+block_size*x - wallpost->w/2, topy+block_size*y + block_size - wallpost->h/2));
      }

  /* horiz walls */
  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y+1; y++)
      if(m->hwall[x][y%NUM_BLOCKS_Y]) {
	color_rect(out, topx+x*block_size, topy+y*block_size-WALL_THICKNESS/2, block_size, WALL_THICKNESS, fence_color(m));
	image_show(wallpost, out, screen_pos(topx+x*block_size - wallpost->w/2, topy+y*block_size - wallpost->h/2));
	image_show(wallpost, out, screen_pos(topx+x*block_size + block_size - wallpost->w/2, topy+y*block_size - wallpost->h/2));
      }
}

void map_output(map *m, int block_size, SDL_Surface *out, int lighter)
{
  anim *wallpost;
  int x, y, i;
  /*  char buff[10];*/

  /* blackness */
  color_rect(out, 0, 0, out->w, out->h, trans);

  /* checkerboard */
  draw_map_bg(out, m, block_size, WALLPOST_SIZE/2, WALLPOST_SIZE/2, lighter);

  /* generators */
  for(i=0; i<m->max_generator; i++)
    color_rect(out, m->generator[i].pos.x*block_size+WALLPOST_SIZE/2+block_size/6, m->generator[i].pos.y*block_size+WALLPOST_SIZE/2+block_size/6, (block_size*2+2)/3, (block_size*2+2)/3, generator_color);

  /* rocket colors */
  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      if(m->rocket[x][y] >= 0)
	color_rect(out, x*block_size+WALLPOST_SIZE/2+block_size/6, y*block_size+WALLPOST_SIZE/2+block_size/6, (block_size*2+2)/3, (block_size*2+2)/3, player_sdl_color[m->rocket[x][y]]);
  
  /* walls */
  wallpost = make_wallpost(block_size, m);
  
  draw_map_walls(out, m, block_size, WALLPOST_SIZE/2, WALLPOST_SIZE/2, anim_first_surface(wallpost));
  
  anim_close(wallpost);
  

  /*
  sprintf(&buff[0], "%d", m->max_player);
  center_text(out, 10, 15, &buff[0], white, black);
  */
}

void draw_scorebox(SDL_Surface *out, go_sdl *go, sim *s, int score, int x, int y, int place, SDL_Color color)
{
  SDL_Rect rect;
  char buff[10];
  anim *temp;
  SDL_Surface *ts;
  
#define SCORE_BOX_THICKNESS (go->block_size*13/100)
#define SCORE_BOX_WIDTH (go->factor_w/MAX_PLAYER*7/10)
#define SCORE_BOX_HEIGHT (BOTTOM_BORDER)

  rect.x = x;
  rect.y = y;
  rect.w = SCORE_BOX_WIDTH;
  rect.h = SCORE_BOX_HEIGHT;
  
  color_rect(out, rect.x, rect.y, rect.w, rect.h, color);
  
  rect.x += SCORE_BOX_THICKNESS;
  rect.y += SCORE_BOX_THICKNESS;
  rect.w -= SCORE_BOX_THICKNESS*2;
  rect.h -= SCORE_BOX_THICKNESS*2;
  
  color_rect(out, rect.x, rect.y, rect.w, rect.h, black);
  
  sprintf(&buff[0], "%03d", score);
  
  ts = render_text(go->digit_font, &buff[0], score_color, black);
  
  image_show(ts, out, screen_pos(rect.x + go->block_size/10, rect.y+rect.h/2-(ts->h)/2 + go->block_size/10));
  
  SDL_FreeSurface(ts);
  
  /* places */
  
  temp = NULL;
  
  switch(place) {
  case 1: temp = go->anim[PLACE_1]; break;
  case 2: temp = go->anim[PLACE_2]; break;
  case 3: temp = go->anim[PLACE_3]; break;
  case 4: temp = go->anim[PLACE_4]; break;
  default: return; break;
  }
  
  if(s->state != NOT_STARTED)
    if(temp != NULL)
      anim_show(temp, out, screen_pos(rect.x+rect.w+SCORE_BOX_THICKNESS, rect.y-SCORE_BOX_THICKNESS), s->elapsed);
  
}

screen_position center(go_sdl *go, screen_position pos)
{
  pos.x += go->block_size/2;
  pos.y += go->block_size/2;
  return pos;
}

void go_sdl_refresh(game *g, SDL_Surface *out)
{
  int i,j,x,y;
  int x2,y2;

  static int last_time=0;
  int diff;
  
  SDL_Rect rect;
  screen_position p;
  float per;
  sim *s = &g->sim;
  go_sdl *go = &GO;
  SDL_Surface *temp;
  char buff[100];
  char *text;
  int temp_int;
  int bar_height;
  int d;
  int first_count;
  vector v;

  sound_refresh(g);


  current_g = g;
  
  if(GO.w != out->w || GO.h != out->h) {
    GO.w = out->w;
    GO.h = out->h;
    GO.factor_h = min2(out->w*3/4, out->h);
    GO.top_margin = (out->h-GO.factor_h)/2;
    
    GO.factor_w = GO.factor_h*4/3;
    GO.left_margin = (out->w-GO.factor_w)/2;

    GO.block_size = max2(1, (GO.factor_h-TOP_BORDER-BOTTOM_BORDER)/NUM_BLOCKS_Y*985/1000);

    printf("Block size is %d\n", GO.block_size);

    changed_size(g);
    
    makebg(g, GO.w, GO.h);
  }
  
  if(!GO.have_bg)
    makebg(g, out->w, out->h);

  /* background - checkerboard, etc. */
  image_show(GO.bg, out, screen_pos(0, 0));

  /* arrows */
  for(i=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists)
      for(j=0; j<MAX_ARROW; j++)
	if(s->player[i].arrow[j].exists)
	  if(s->player[i].arrow[j].time_left > FLICKER_TIME || s->player[i].arrow[j].time_left/FLICKER_RATE%2==0)
	    image_show(GO.arrow_image[i][s->player[i].arrow[j].dir][s->player[i].arrow[j].health], out, go_sdl_grid2screen(g, s->player[i].arrow[j].pos));

  /* grid boxes */
  if(s->mode != MODE_INTRO && s->state != POST_GAME)
    for(i=0; i<MAX_PLAYER; i++)
      if(gi_sdl_player_exists(g, i))
	anim_show(GO.anim[free_for_arrow(s, gi_sdl_player_grid_pos(g, i), -1)?GRID_BOX:GRID_BOX_GREY], out, go_sdl_grid2screen(g, gi_sdl_player_grid_pos(g, i)), s->elapsed);

  /* walls */

  p = go_sdl_grid2screen(g, grid_int_pos(0, 0));

  draw_map_walls(out, &g->sim.map, GO.block_size, p.x, p.y, anim_first_surface(GO.anim[WALLPOST]));

  /* generators */
  for(i=0; i<s->map.max_generator; i++)
    anim_show(GO.anim[GENERATOR], out, center(go, go_sdl_grid2screen(g, s->map.generator[i].pos)), s->elapsed);

  /* creatures */
  for(i=0; i<MAX_CREATURE; i++)
    if(s->creature[i].exists) {
      p = center(go, go_sdl_gridf2screen(g, s->creature[i].pos));
      anim_show(creature_anim(go, s->creature[i].type, s->creature[i].dir), out, p, p.x+p.y);
    }

  /* floaters */
  for(i=0; i<MAX_CREATURE; i++)
    if(s->floater[i].exists)
      anim_show(creature_anim(go, s->floater[i].type, s->floater[i].old_dir), out, center(go, go_sdl_gridf2screen(g, s->floater[i].pos)), 0);

  first_count = 0;

  for(i=0; i<MAX_PLAYER; i++)
    if(s->player[i].exists && s->player[i].team_leader == i)
      if(player_rank(g, i) == 1)
	first_count++;

  /* rockets */
  if(s->mode != EVERYBODY_MOVE) {
    for(x=0; x<NUM_BLOCKS_X; x++)
      for(y=0; y<NUM_BLOCKS_Y; y++) {
	  if(sim_rocket_owner(s, x, y) >= 0) {

	    if(s->type == BATTLE)
	      if(first_count==1)
		if(player_rank(g, s->player[sim_rocket_owner(s, x, y)].team_leader)==1)
		  anim_show(GO.anim[PLACE_1], out, go_sdl_grid2screen(g, grid_int_pos(x+1, y)), s->elapsed);

	    center_rocket(out, go, s, sim_rocket_owner(s, x, y), go_sdl_grid2screen(g, grid_int_pos(x, y)), GO.rocket_last_hit[x][y] <= s->elapsed && GO.rocket_last_hit[x][y] > s->elapsed - player_rocket_anim(go, sim_rocket_owner(s, x, y), 1)->length, s->elapsed - GO.rocket_last_hit[x][y]);
	    
	    if(GO.rocket_last_cat[x][y] <= s->elapsed && GO.rocket_last_cat[x][y] > ((int)s->elapsed) - GO.anim[CAT_EXPLOSION]->length) {
	      anim_show(GO.anim[CAT_EXPLOSION], out, center(go, go_sdl_grid2screen(g, grid_int_pos(x, y))), s->elapsed - GO.rocket_last_cat[x][y]);
	    }

	}
      }
  }
  else {
    per = 1-((float)s->mode_timer)/EVERYBODY_MOVE_L;
    per = ((pow((per-.5)*2, 3)/2)+.5 + 3*per)/4;

    for(i=0; i<MAX_PLAYER; i++)
      for(x=0; x<NUM_BLOCKS_X; x++)
	for(y=0; y<NUM_BLOCKS_Y; y++)
	  for(x2=0; x2<NUM_BLOCKS_X; x2++)
	    for(y2=0; y2<NUM_BLOCKS_Y; y2++)
	      if(sim_rocket_owner(s, x, y) == i && sim_last_rocket_owner(s, x2, y2) == i)
		center_rocket(out, go, s, i, go_sdl_gridf2screen(g, grid_float_pos(x2*(1-per) + x*per, y2*(1-per) + y*per)), 0, 0);
  }

  /* dead mice */
  for(i=0; i<MAX_DEAD_MOUSE; i++)
    if(GO.dead_mouse[i].exists && s->elapsed - GO.dead_mouse[i].time < dead_mouse_anim(go, GO.dead_mouse[i].dir)->length)
      anim_show(dead_mouse_anim(go, GO.dead_mouse[i].dir), out, center(go, GO.dead_mouse[i].pos), s->elapsed - GO.dead_mouse[i].time);


  /* cat attack */
  if(s->mode == CAT_ATTACK)
    for(x=0; x<NUM_BLOCKS_X; x++)
      for(y=0; y<NUM_BLOCKS_Y; y++)
	if(sim_rocket_owner(s, x, y) >= 0 && s->player[sim_rocket_owner(s, x, y)].team_leader != s->mode_player)
	  anim_show(GO.anim[CAT_ATTACKING], out, center(go, go_sdl_grid2screen(g, grid_int_pos(x, y))), s->elapsed);

  /* score changes */

  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      if(s->score_change_timer[x][y] > 0) {
	p = go_sdl_grid2screen(g, grid_int_pos(x, y));
	
	sprintf(&buff[0], s->score_change[x][y] > 0 ? "+%d":"%d", s->score_change[x][y]);
	
	temp = render_text(GO.digit_font, &buff[0], score_change_color_bg, score_change_color_bg);
	
	SDL_SetAlpha(temp, SDL_SRCALPHA, pow(((float)s->score_change_timer[x][y]/SCORE_CHANGE_L), .5)*255);
	
	image_show(temp, out, screen_pos(p.x + GO.block_size/2 - temp->w/2 + 1, p.y - temp->h/2 - TTF_FontDescent(GO.digit_font) + 1));
	SDL_FreeSurface(temp);
	
	temp = render_text(GO.digit_font, &buff[0], score_change_color_fg, score_change_color_fg);

	SDL_SetAlpha(temp, SDL_SRCALPHA, pow(((float)s->score_change_timer[x][y]/SCORE_CHANGE_L), .5)*255);
	
	image_show(temp, out, screen_pos(p.x + GO.block_size/2 - temp->w/2, p.y - temp->h/2 - TTF_FontDescent(GO.digit_font)));
	SDL_FreeSurface(temp);
	
      }

  /* interface stuff */

  /* score */

  if(s->type == BATTLE) {
    for(i=0; i<MAX_PLAYER; i++)
      if(s->player[i].exists) {
	draw_scorebox(out, go, s,
		      s->player[s->player[i].team_leader].score,
		      GO.factor_w*5/6*i/MAX_PLAYER + GO.left_margin + LEFT_BORDER,
		      GO.factor_h - BOTTOM_BORDER + GO.top_margin,
		      player_rank(g, s->player[i].team_leader),
		      player_sdl_color[i]);
      }
  }
  else
    draw_scorebox(out, go, s, s->player[0].score, GO.left_margin + LEFT_BORDER, GO.factor_h - BOTTOM_BORDER + GO.top_margin, -1, player_sdl_color[0]);


  /* free arrows for puzzle mode */

  if(s->type == PUZZLE) {

    temp = render_text(GO.small_font, "Available", white, black);
    image_show(temp, out, screen_pos(GO.left_margin + GO.factor_w - temp->w/2 - RIGHT_BORDER/2, GO.top_margin));
    y = GO.top_margin + temp->h*2;
    
    SDL_FreeSurface(temp);
    
    for(d=0; d<MAX_DIR; d++)
      for(i=0; i<s->map.max_arrow[d] - arrow_dir_count(s, d); i++) {
	image_show(GO.arrow_image[0][d][ARROW_TOUGHNESS-1], out, screen_pos(GO.factor_w + GO.left_margin - RIGHT_BORDER/2 - GO.arrow_image[0][0][0]->w/2, y));
	y += GO.arrow_image[0][0][0]->h*5/4;
      }
  }

  /* clock */
  
  sprintf(&buff[0], "%01d:%02d", s->clock/1000/60%10, s->clock/1000%60);
  
  temp = render_text(GO.clock_font, &buff[0], white, black);
  
  image_show(temp, out, screen_pos(GO.left_margin + GO.factor_w - temp->w, GO.top_margin + GO.factor_h - temp->h/* - TTF_FontDescent(GO.clock_font)*/));
  SDL_FreeSurface(temp);
  
  /* clock percentage bar */
  
  if(g->type == BATTLE) {
    
    bar_height = (GO.factor_h - TOP_BORDER - BOTTOM_BORDER)*9/10;
    temp_int = bar_height*s->clock/1000/BATTLE_LENGTH;
    
    rect.w = RIGHT_BORDER/3;
    rect.x = GO.left_margin + GO.factor_w - RIGHT_BORDER/2 - rect.w/2;
    
    rect.y = GO.top_margin + GO.factor_h - BOTTOM_BORDER - bar_height - (GO.factor_h - BOTTOM_BORDER - bar_height)/2;
    rect.h = bar_height;
    
    color_rect(out, rect.x, rect.y, rect.w, rect.h, box_border_color);
    
    rect.h -= temp_int-1;
    
    if(rect.h-2 > 0)
      color_rect(out, rect.x+1, rect.y+1, rect.w-2, rect.h-2, percentage_bar_bg);
    
    rect.y = GO.top_margin + GO.factor_h - BOTTOM_BORDER - temp_int - (GO.factor_h - BOTTOM_BORDER - bar_height)/2;
    rect.h = temp_int;
    
    if(rect.h-2 > 0)
      color_rect(out, rect.x+1, rect.y+1, rect.w-2, rect.h-2, percentage_bar_fg);
  }
  

  if(s->state == POST_GAME && s->type == PUZZLE && s->player[0].score < map_creature_count(&s->map, mouse)) {
  }
  else {
  
    if(s->mode == MODE_INTRO || s->state == POST_GAME) {
      /* mode intro box */
      p = go_sdl_gridf2screen(g, grid_float_pos(0.5, 3.5));
    
      rect.x = p.x;
      rect.w = GO.block_size*11;

      rect.y = p.y;
      rect.h = GO.block_size*2;

      color_rect(out, rect.x, rect.y, rect.w, rect.h, box_border_color);

      rect.x += 2;
      rect.w -= 2*2;
      rect.y += 2;
      rect.h -= 2*2;

      i = sim_winner(s);

      if(s->state == POST_GAME && i>=0)
	color_rect(out, rect.x, rect.y, rect.w, rect.h, half_color(player_sdl_color[i]));
      else
	color_rect(out, rect.x, rect.y, rect.w, rect.h, box_color);

      if(s->state == POST_GAME) {

	if(s->type == PUZZLE) {
	  if(s->player[0].score < map_creature_count(&s->map, mouse)) {
	    /* TODO: fix this */
	    return;
	    text = "You lost.";
	  }
	  else
	    text = "Success!";
	}
	else {
	  if(i>=0)
	    text = "Winner!";
	  else
	    text = "Tie!";
	}
      }
      else
	text = mode_string(s->next_mode);

      temp = render_text(GO.mode_intro_font, text, white, box_color);

      if(temp != NULL) {
	image_show(temp, out, screen_pos(rect.x + rect.w/2 - temp->w/2, rect.y + rect.h/2 - temp->h/2/* - TTF_FontDescent(GO.mode_intro_font)*/));
	SDL_FreeSurface(temp);
      }
    }
    else {
      /* pointers */

      for(i=0; i<MAX_PLAYER; i++) {
	if(gi_sdl_player_exists(g, i)) {
	  v = gi_sdl_player_pointer(g, i);
	  anim_show(player_pointer_anim(go, i), out, go_sdl_gridf2screen(g, grid_float_pos(v.x*NUM_BLOCKS_X, v.y*NUM_BLOCKS_Y)), s->elapsed);
	}
      }
    }
  }

  /* debug info */
  /*
    temp = render_text(GO.small_font, game_type_to_s(g->type), white, black);
    image_show(temp, out, screen_pos(0, 0));
    SDL_FreeSurface(temp);
  */
  
  /* fps */
  diff = SDL_GetTicks() - last_time;
  last_time = SDL_GetTicks();
  
  sprintf(&buff[0], "%.1f fps", ((float)1000)/diff);
  
  temp = render_text(GO.small_font, &buff[0], white, black);
  image_show(temp, out, screen_pos(20, 0));
  SDL_FreeSurface(temp);

}

/* to be called after map is loaded */
void go_sdl_init(game *g)
{
  int x,y;
  int i;
  
  printf("Initializing SDL output for new game...\n");

  /* set our functions so we're called */

  game_output_handle_event = go_sdl_handle_event;
  game_output_refresh      = go_sdl_refresh;
  game_output_bigchange    = go_sdl_bigchange;
  game_output_exit         = go_sdl_exit;

  g->output = malloc(sizeof(go_sdl));
  
  GO.type = SDL;

  GO.loaded_images = 0;
  
  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++) {
      GO.rocket_last_hit[x][y] = -10000;
      GO.rocket_last_cat[x][y] = -10000;
    }
  
  /* to prevent division by zero in grid2screen before a real size is gotten*/
  GO.w = GO.h = 1;
  GO.block_size = 1;
  GO.have_bg = 0;
  
  for(i=0; i<MAX_DEAD_MOUSE; i++)
    GO.dead_mouse[i].exists = 0;
}


