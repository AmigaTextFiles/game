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
#include "SDL.h"
#include "SDL_image.h"
#include "SDL_rotozoom.h"
#include "anim.h"

void (*lost_surface_callback)(void *p);
void *lost_surface_arg;

SDL_Surface *image_load(char *datafile, int transparent)
{
  SDL_Surface *image, *surface;
  
  image = IMG_Load(datafile);
  if(image == NULL) {
    fprintf(stderr, "Couldn't load image %s: %s\n", datafile, IMG_GetError());
    return(NULL);
  }

  if(transparent) {
    /* Assuming 8-bit BMP image */
    /* use top left pixel as transparent */
    SDL_SetColorKey(image, (SDL_SRCCOLORKEY|SDL_RLEACCEL), *(Uint8 *)image->pixels);
  }
  surface = SDL_DisplayFormat(image);
  SDL_FreeSurface(image);
  return(surface);
}

void blit_image(SDL_Surface *src, SDL_Surface *dest, int x, int y)
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
	
	if(lost_surface_callback != NULL)
	  lost_surface_callback(lost_surface_arg);
	/*	  game_lost_surfaces(current_g);*/
	
      }
    }
}

void image_show(SDL_Surface *src, SDL_Surface *dest, screen_position p)
{
  blit_image(src, dest, p.x, p.y);
}

void frame_show(frame *f, SDL_Surface *out, screen_position p)
{
  p.x -= f->cx;
  p.y -= f->cy;
  image_show(f->s, out, p);
}

frame *frame_load(char *file, float factor)
{
  SDL_Surface *s, *s2;
  
  frame *f = malloc(sizeof(frame));
  
  /*  printf("Loading frame from %s\n", file);*/
  
  s = image_load(file, 0);
  
  if(s == NULL) {
    fprintf(stderr, "Couldn't load %s\n", file);
    free(f);
    return NULL;
  }
  
  s2 = zoomSurface(s, factor, factor, 0);
  
  SDL_FreeSurface(s);
  
  SDL_SetColorKey(s2, (SDL_SRCCOLORKEY|SDL_RLEACCEL), *(Uint32 *)s2->pixels);
  
  f->s = SDL_DisplayFormat(s2);
  SDL_FreeSurface(s2);
  
  f->cx = f->s->w/2;
  f->cy = f->s->h/2;
  f->length = 0;
  f->next = NULL;
  
  return f;
}

void frame_close(frame *f)
{
  SDL_FreeSurface(f->s);
  free(f);
}

anim *anim_load(char *file, float factor)
{
  anim *a = malloc(sizeof(anim));

  FILE *in = fopen(file, "r");
  int fl;
  char buff[256], buff2[256];
  int x, y;
  frame *last_frame = NULL;
  frame *temp_frame;
  int framecount=0;

  if(in == NULL) {
    fprintf(stderr, "Couldn't open %s.\n", file);
    return NULL;
  }
  
  printf("Loading animation %s\n", file);

  a->first_frame = NULL;
  a->length = 0;

  while(1) {
    
    framecount++;

    if(fscanf(in, " %d ", &fl) < 1) {
      break;
    }

    a->length += fl;
  
    if(fscanf(in, " %s ", &buff[0]) < 1) {
      fprintf(stderr, "Couldn't read a filename from %s for frame %d\n", file, framecount);
      break;
    }

    sprintf(&buff2[0], "images/%s", &buff[0]);
    
    temp_frame = frame_load(&buff2[0], factor);
    
    if(temp_frame == NULL) {
      fprintf(stderr, "Couldn't load \"%s\" referenced in %s.\n", &buff[0], file);
      return NULL;
    }

    temp_frame->length = fl;

    if(fscanf(in, " center %d %d ", &x, &y) == 2) {
      temp_frame->cx = x;
      temp_frame->cy = y;
    }
    
    if(fscanf(in, " alpha %d ", &x) == 1)
      SDL_SetAlpha(temp_frame->s, SDL_SRCALPHA|SDL_RLEACCEL, x);
    
    if(last_frame == NULL) {
      a->first_frame = temp_frame;
      last_frame = a->first_frame;
    }
    else {
      last_frame->next = temp_frame;
      last_frame = last_frame->next;
    }
  }

  if(a->first_frame == NULL)
    return NULL;

  if(last_frame == NULL)
    return NULL;
  
  last_frame->next = a->first_frame;

  return a;
}

frame *make_frame_from_s(SDL_Surface *s)
{
  frame *f = malloc(sizeof(frame));
  f->s = s;
  f->next = NULL;
  f->cx = 0;
  f->cy = 0;
  return f;
}

anim *make_anim_from_s(SDL_Surface *s)
{
  anim *a = malloc(sizeof(anim));

  a->first_frame = make_frame_from_s(s);
  a->first_frame->length = 10;
  a->length = 10;
  a->first_frame->next = a->first_frame;

  return a;
}

void close_all_frames(frame *first, frame *f)
{
  if(f->next != first)
    close_all_frames(first, f->next);

  frame_close(f);
}

void anim_close(anim *a)
{
  close_all_frames(a->first_frame, a->first_frame);
  free(a);
}

frame *anim_current_frame(anim *a, int time)
{
  frame *f = a->first_frame;
  
  time %= a->length;

  while((time-=f->length) > 0) {
    f = f->next;
  }

  return f;
}

void anim_show(anim *a, SDL_Surface *out, screen_position p, int time)
{
  frame_show(anim_current_frame(a, time), out, p);
}

SDL_Surface *anim_current_surface(anim *a, int time)
{
  return anim_current_frame(a, time)->s;
}

SDL_Surface *anim_first_surface(anim *a)
{
  return a->first_frame->s;
}


