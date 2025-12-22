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

#include "SDL.h"
#include "anim.h"
#include "stdlib.h"
#include "stdio.h"
#include "output.h"
#include "lib.h"
#include "audio.h"
#include "map.h"
#include "go_sdl.h"

/* types */
enum
{
  eTEXT,
  eBUTTON,
  eMAP,
  eNUMBER,
  eCHECKBOX
};

typedef struct _gui_object
{
  char exists;
  int type;

  float x,y;
  float w,h;

  void (*callback)(void *v);
  void (*callback2)(void *v, map *m);
  void *param;

  char def;
  
  char *text;

  int *number;
  bool *bool;

  map *map;

} gui_object;

#define WHITE {0xFF, 0xFF, 0xFF, 0}
#define BLACK {0x00, 0x00, 0x00, 0}

SDL_Color active_fg = BLACK;
SDL_Color active_bg = WHITE;

SDL_Color hover_fg  = WHITE;
SDL_Color hover_bg  = {0x22, 0x22, 0x22, 0};

SDL_Color default_fg = WHITE;
SDL_Color default_bg = BLACK;

SDL_Color number_hover_fg = {0xCC, 0xCC, 0xCC, 0};

SDL_Color checked_hover_bg = {0xCC, 0xCC, 0xCC, 0};
SDL_Color checked_hover_fg = BLACK;

SDL_Color checked_active_bg = {0xAA, 0xAA, 0xAA, 0};
SDL_Color checked_active_fg = BLACK;

SDL_Color checked_default_bg = WHITE;
SDL_Color checked_default_fg = {0x88, 0x88, 0x88, 0};

SDL_Color unchecked_hover_bg = {0x33, 0x33, 0x33, 0};
SDL_Color unchecked_hover_fg = WHITE;

SDL_Color unchecked_active_bg = {0x66, 0x66, 0x66, 0};
SDL_Color unchecked_active_fg = WHITE;

SDL_Color unchecked_default_bg = BLACK;
SDL_Color unchecked_default_fg = WHITE;

#define MAX_GUI_OBJECT 50

gui_object object[MAX_GUI_OBJECT];
SDL_Surface *pointer;
int px, py;
int object_p_from = -1;
int lastw;

/* used in refreshing */
int left_margin, top_margin;
int factor_h, factor_w;

int coord_x(float percent)
{
  return percent*factor_w+left_margin;
}

int coord_y(float percent)
{
  return percent*factor_h+top_margin;
}

int on_object(int x, int y, int o)
{
  if(
     x > coord_x(object[o].x)-factor_w*object[o].w/2 &&
     x < coord_x(object[o].x)+factor_w*object[o].w/2 &&
     y > coord_y(object[o].y)-factor_h*object[o].h/2 &&
     y < coord_y(object[o].y)+factor_h*object[o].h/2
     )
    return 1;
  else
    return 0;
}

int gui_load_images()
{
  pointer = image_load("gui/pointer.png", 1);
  if(pointer == NULL)
    return 0;

  return 1;
}  

void gui_unload_images()
{
  SDL_FreeSurface(pointer);
}

void gui_ShowImage(SDL_Surface *src, SDL_Surface *dest, int x, int y)
{
    SDL_Rect rect;

    /* Blit onto the screen surface.
       The surfaces should not be locked at this point.
     */
    rect.x = x;
    rect.y = y;
    rect.w = src->w;
    rect.h = src->h;

    if(SDL_BlitSurface(src, NULL, dest, &rect) == -2) {
      /* we have it back */
      if(SDL_LockSurface(src) > 0) {
	SDL_UnlockSurface(src);

	gui_unload_images();
	gui_load_images();
      }
    }
}

int gui_add_object(gui_object o)
{
  int i;
  
  for(i=0; i<MAX_GUI_OBJECT; i++)
    if(!object[i].exists) {
      object[i] = o;
      object[i].exists = 1;
      return i;
    }
  
  fprintf(stderr, "Couldn't add gui object: out of spaces\n");
  return -1;
}

int gui_handle_event(SDL_Event e)
{
  int i;

  switch(e.type) {
  case SDL_MOUSEMOTION:
    px = e.motion.x;
    py = e.motion.y;
    break;
  case SDL_MOUSEBUTTONDOWN:
    for(i=0; i<MAX_GUI_OBJECT; i++)
      if(object[i].exists)
	if(object[i].type == eBUTTON || object[i].type == eNUMBER || object[i].type == eCHECKBOX || object[i].type == eMAP)
	  if(on_object(px, py, i)) {
	    play_sound("sounds/get_mouse.wav");
	    object_p_from = i;
	    break;
	  }
    break;
  case SDL_MOUSEBUTTONUP:
    if(object_p_from >=0) {
      if(on_object(px, py, object_p_from)) {
	if(object[object_p_from].type == eMAP) {
	  if(object[object_p_from].callback2 != NULL) {
	    object[object_p_from].callback2(object[object_p_from].param, object[object_p_from].map);
	  }
	}
	else {
	  if(object[object_p_from].callback != NULL) {
	    object[object_p_from].callback(object[object_p_from].param);
	  }
	}
	if(object[object_p_from].type == eCHECKBOX) {
	  (*object[object_p_from].bool) = ((*object[object_p_from].bool)+1)%2;
	}
      }
    }
    object_p_from = -1;

    break;
  case SDL_KEYUP:
    break;
  default:
    break;
  }
  return 1;
}

void gui_background(SDL_Surface *out)
{
  SDL_Rect rect;

  rect.x = 0;
  rect.y = 0;
  rect.w = out->w;
  rect.h = out->h;
  SDL_FillRect(out, &rect, SDL_MapRGB(out->format, 0, 0, 0));
}

void gui_refresh(SDL_Surface *out)
{
  int i;
  int have_something;
  SDL_Rect rect;
  SDL_Color fg, bg;
  char buff[10];
  int width;
  SDL_Surface *s;
  
  factor_h = min2(out->w*3/4, out->h);
  top_margin = (out->h-factor_h)/2;
  
  factor_w = factor_h*4/3;
  left_margin = (out->w-factor_w)/2;
  
  lastw = out->w;
  
  for(i=0; i<MAX_GUI_OBJECT; i++)
    if(object[i].exists) {

      fg = default_fg;
      bg = default_bg;

      switch(object[i].type) {
      case eBUTTON:
	rect.x = coord_x(object[i].x)-factor_w*object[i].w/2;
	rect.w = factor_w*object[i].w;
	rect.y = coord_y(object[i].y)-factor_h*object[i].h/2;
	rect.h = factor_h*object[i].h;

	if(on_object(px, py, i)) {
	  if(object_p_from==i) {
	    bg = active_bg;
	    fg = active_fg;
	  }
	  else if(object_p_from == -1) {
	    bg = hover_bg;
	    fg = hover_fg;
	  }
	}

	SDL_FillRect(out, &rect, SDL_MapRGB(out->format, fg.r, fg.g, fg.b));
	rect.x++;
	rect.y++;
	rect.w-=2;
	rect.h-=2;
	SDL_FillRect(out, &rect, SDL_MapRGB(out->format, bg.r, bg.g, bg.b));
	/* fall through */
      case eTEXT:
	center_text(out, coord_x(object[i].x), coord_y(object[i].y), object[i].text, fg, bg);
	break;

      case eCHECKBOX:
	rect.x = coord_x(object[i].x)-factor_w*object[i].w/2;
	rect.w = factor_w*object[i].w;
	rect.y = coord_y(object[i].y)-factor_h*object[i].h/2;
	rect.h = factor_h*object[i].h;

	if(*object[i].bool) {
	  fg = checked_default_fg;
	  bg = checked_default_bg;
	}

	if(on_object(px, py, i)) {
	  if(*object[i].bool) {
	    if(object_p_from==i) {
	      bg = checked_active_bg;
	      fg = checked_active_fg;
	    }
	    else if(object_p_from == -1) {
	      bg = checked_hover_bg;
	      fg = checked_hover_fg;
	    }
	  }
	  else {
	    if(object_p_from==i) {
	      bg = unchecked_active_bg;
	      fg = unchecked_active_fg;
	    }
	    else if(object_p_from == -1) {
	      bg = unchecked_hover_bg;
	      fg = unchecked_hover_fg;
	    }
	  }
	}

	SDL_FillRect(out, &rect, SDL_MapRGB(out->format, fg.r, fg.g, fg.b));
	rect.x++;
	rect.y++;
	rect.w-=2;
	rect.h-=2;
	SDL_FillRect(out, &rect, SDL_MapRGB(out->format, bg.r, bg.g, bg.b));

	center_text(out, coord_x(object[i].x), coord_y(object[i].y-.1), object[i].text, default_fg, bg);
	break;

      case eMAP:
	width = object[i].w*factor_w;

	s = SDL_CreateRGBSurface(SDL_HWSURFACE, width, width*NUM_BLOCKS_Y/NUM_BLOCKS_X, BPP, 0, 0, 0, 0);
	if(s==NULL) {
	  fprintf(stderr, "Couldn't create surface for map preview. (2)\n");
	  break;
	}
	
	map_output(object[i].map, width/NUM_BLOCKS_X*95/100, s, on_object(px, py, i));

	gui_ShowImage(s, out, coord_x(object[i].x)-factor_w*object[i].w/2, coord_y(object[i].y)-factor_h*object[i].h/2);

	SDL_FreeSurface(s);

	break;
      case eNUMBER:
	if(on_object(px, py, i)) {
	  if(object_p_from==i) {
	    fg = number_hover_fg;
	  }
	  else if(object_p_from == -1) {
	    fg = number_hover_fg;
	  }
	}

	sprintf(&buff[0], "%d", *object[i].number);
	center_text(out, coord_x(object[i].x), coord_y(object[i].y), &buff[0], fg, bg);
	break;
      default:
	fprintf(stderr, "Error: Unknown object type: %d\n", object[i].type);
	break;
      }
    }
  
  
  have_something = 0;
  for(i=0; i<MAX_GUI_OBJECT; i++)
    if(object[i].exists) {
      have_something = 1;
      break;
    }
  
  if(have_something)
    gui_ShowImage(pointer, out, px, py);
}

void gui_remove_object(int i)
{
  if(object[i].exists) {

    object[i].exists = 0;
  }
}

void gui_clear()
{
  int i;
  for(i=0; i<MAX_GUI_OBJECT; i++)
    gui_remove_object(i);
}

int gui_add_map(float x, float y, float w, map *map_p, void (*callback2)(void *v, map *m), void *param)
{
  gui_object o;
  o.x = x;
  o.y = y;
  o.w = w;
  o.h = w*NUM_BLOCKS_Y*factor_w/factor_h/NUM_BLOCKS_X;
  o.map = map_p;
  o.callback2 = callback2;
  o.param = param;
  o.type = eMAP;

  return gui_add_object(o);
}

int gui_add_text(float x, float y, char *text)
{
  gui_object o;
  o.x = x;
  o.y = y;
  o.text = text;
  o.type = eTEXT;

  return gui_add_object(o);
}

int gui_add_button(float x, float y, float w, float h, char *text, void (*callback)(void *v), void *param)
{
  gui_object o;
  o.x = x;
  o.y = y;
  o.w = w;
  o.h = h;
  o.text = text;
  o.type = eBUTTON;
  o.callback = callback;
  o.param = param;

  return gui_add_object(o);
}

int gui_add_checkbox(float x, float y, bool *bool, char *text, void (*callback)(void *v), void *param)
{
  gui_object o;
  o.x = x;
  o.y = y;
  o.w = .05;
  o.h = .05;
  o.bool = bool;
  o.text = text;
  o.type = eCHECKBOX;
  o.callback = callback;
  o.param = param;
  
  return gui_add_object(o);
}

int gui_add_number(float x, float y, int *number, void (*callback)(void *v), void *param)
{
  gui_object o;

  o.x = x;
  o.y = y;
  o.w = .1;
  o.h = .1;

  o.number = number;

  o.type = eNUMBER;
  o.callback = callback;
  o.param = param;

  return gui_add_object(o);
}

int gui_init()
{
  int i;

  printf("Initializing gui...\n");

  if(!gui_load_images()) {
    fprintf(stderr, "Error loading gui images.\n");
    return 0;
  }

  for(i=0; i<MAX_GUI_OBJECT; i++)
    object[i].exists = 0;

  return 1;
}

void gui_exit()
{
  printf("Freeing gui resources.\n");
  gui_unload_images();
}

