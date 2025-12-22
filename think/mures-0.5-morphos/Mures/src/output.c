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
#include "SDL_image.h"
#include "SDL_ttf.h"
#include "root.h"
#include "game_output.h"
#include "output.h"
#include "audio.h"
#include "gui.h"
#include "main.h"

SDL_Surface *screen;

int fullscreen;

TTF_Font *menu_font;
SDL_Color black_bg = {0x00, 0x00, 0x00, 0};

SDL_Surface *render_text(TTF_Font *font, char *text, SDL_Color fg, SDL_Color bg)
{
  SDL_Surface *s;
  
  if(fg.r == bg.r && fg.b == bg.b && fg.g == bg.g)
    s = TTF_RenderText_Solid(font, text, fg);
  else {
    s = TTF_RenderText_Shaded(font, text, fg, bg);
    SDL_SetColorKey(s, SDL_SRCCOLORKEY|SDL_RLEACCEL, SDL_MapRGB(s->format, bg.r, bg.g, bg.b));
  }
  
  return s;
}

int output_screen_w()
{
  return screen->w;
}

int output_screen_h()
{
  return screen->h;
}

void output_refresh(root_type *r)
{
  if(r->state == GAME) {
    if(!r->game.option.daemon) {
      game_output_refresh(&r->game, screen);
      if(*((int *)r->game.output) == SDL)
	SDL_Flip(screen);
      else {
	/*	printf("flipping...\n");*/
	SDL_GL_SwapBuffers();
	/*	printf("done flipping.\n");*/
      }
    }
  }
  else {
    gui_background(screen);
    
    gui_refresh(screen);
    
    SDL_Flip(screen);
  }
}

void output_toggle_fs()
{
  fullscreen = !fullscreen;
  SDL_WM_ToggleFullScreen(screen);
}

void set_mode(int width, int height, int use_opengl)
{
#ifdef __MORPHOS__
  int options = SDL_DOUBLEBUF | SDL_HWSURFACE;
#else
  int options = SDL_DOUBLEBUF | SDL_HWSURFACE | SDL_ANYFORMAT;
#endif

  if(fullscreen)
    options |= SDL_FULLSCREEN;
  else
    options |= SDL_RESIZABLE;
  
  if(use_opengl)
    options |= SDL_OPENGLBLIT;
  
  screen = SDL_SetVideoMode(width, height, BPP, options);
  
  if (screen == NULL) {
    fprintf(stderr, "Couldn't set %dx%d video mode: %s\n", SCREEN_WIDTH, SCREEN_HEIGHT, SDL_GetError());
    exit(2);
  }
  else
    printf("Screen allocated.\n");
}

void change_screen(int new_width, int new_height, int use_opengl)
{
  set_mode(new_width, new_height, use_opengl);
  
  printf("Changing to %dx%d\n", new_width, new_height);
}

void output_resize_command(root_type *r, int width, int height)
{
  set_mode(width, height, (r->state==GAME && *((int *)r->game.output) == GL) ? 1:0);
}


int output_init(int fs)
{
  fullscreen = fs;
  
  set_mode(SCREEN_WIDTH, SCREEN_HEIGHT, 0);
  
  if(TTF_Init() != 0) {
    fprintf(stderr, "Font init failed.\n");
    return 0;
  }
  
  menu_font = TTF_OpenFont("images/cmtt10.ttf", 30);
  
  if(menu_font == NULL) {
    fprintf(stderr, "Font load failed.\n");
    return 0;
  }
  
  SDL_ShowCursor(0);
  
  /* images are loaded by set_mode */
  
  if(!audio_init())
    fprintf(stderr, "Audio init failed.\n");
  
  if(!gui_init()) {
    fprintf(stderr, "Gui init failed.\n");
    return 0;
  }
  
  return 1;
}

int output_exit(root_type *r)
{
  TTF_CloseFont(menu_font);
  TTF_Quit();

  gui_exit();

  audio_exit();
  return 1;
}

void color_rect(SDL_Surface *dest, int x, int y, int w, int h, SDL_Color c)
{
  SDL_Rect rect;
  rect.x = x;
  rect.y = y;
  rect.w = w;
  rect.h = h;
  SDL_FillRect(dest, &rect, SDL_MapRGB(dest->format, c.r, c.g, c.b));
}  

void center_text(SDL_Surface *out, int x, int y, char *text, SDL_Color fg, SDL_Color bg)
{
  SDL_Surface *s;
  SDL_Rect rect;
  int temp;

  /* some strange bug in sdl_ttf? */
  temp = fg.r;
  fg.b = fg.r;
  fg.r = temp;

  temp = bg.r;
  bg.b = bg.r;
  bg.r = temp;

  s = render_text(menu_font, text, fg, bg);
  
  rect.x = x - s->w/2;
  rect.y = y - s->h/2;
  rect.w = s->w;
  rect.h = s->h;
  
  SDL_BlitSurface(s, NULL, out, &rect);

  SDL_FreeSurface(s);
}  

void output_screenshot()
{
  char *l = "shot.bmp";
  SDL_SaveBMP(screen, l);
  printf("Screenshot saved to %s.\n", l);
}

