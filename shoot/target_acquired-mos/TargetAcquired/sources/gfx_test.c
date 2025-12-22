/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/
#include <stdlib.h>
#include <SDL.h>
#include "ta.h"
#include "modern.h"

#define NUM_SCENES 37

void draw_gfx_test(SDL_Surface *where, int scene)
{
  char msg[80];
  if (scene < 6) {
    sprintf(msg, "Target Acquired: Background Test #%i", scene+1);
    draw_graphic(gfx+scene, 0, 0, where);
    cwriteXE(8, msg, where);
  } else if (scene < 36) {	
    graphic *this_spr = gfx+scene;
    clear_graphic(where);
    sprintf(msg, "Target Acquired: Sprite Test #%i", scene-5);
    cwriteXE(8, msg, where);
    draw_graphic(this_spr, 320-this_spr->surface->w/2, 200-this_spr->surface->h/2, where);
  } else {
    switch (scene) {
    case 36:   /* Fonts test */
      clear_graphic(where);
      cwriteXE(8, "Target Acquired: Font Test", where);
      cwriteXE(176, "!\"#$%&'()*+,-./0123456789:;<=>?@", where);
      cwriteXE(192, "ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`", where);
      cwriteXE(208, "abcdefghijklmnopqrstuvwxyz{|}~", where);
      break;
    default:
      clear_graphic(where);
      cwriteXE(8, "Can't happen!  Test sequence is borked", where);
      sprintf(msg, "Tried to display scene #%i", scene);
      cwriteXE(28, msg, where);
      break;
    }
  }
  cwriteXE(360, "Use left or right arrows to change demo", where);
  cwriteXE(376, "Press ESC to exit", where);
}

int handle_event_gfx_test(SDL_Event *event, int scene)
{
  if (event->type == SDL_KEYDOWN) {
    switch (event->key.keysym.sym) {
    case SDLK_ESCAPE:
      return -1;
      break;
    case SDLK_KP6:
    case SDLK_RIGHT:
      ++scene;
      if (scene >= NUM_SCENES) scene = 0;
      break;
    case SDLK_KP4:
    case SDLK_LEFT:
      --scene;
      if (scene < 0) scene = NUM_SCENES-1;
      break;
    default:
      handle_event_top(event);
    }
  } else {
    handle_event_top(event);
  }
  return scene;
}

void do_graphics_test()
{
  int scene = 0;
  while (scene >= 0) {
    SDL_Event event;
    while (SDL_PollEvent(&event) && scene >= 0) {
      scene = handle_event_gfx_test(&event, scene);
    }
    draw_gfx_test(screen, scene);
    SDL_Flip(screen);
  }
}
