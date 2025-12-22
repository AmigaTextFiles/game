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
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include <SDL/SDL_framerate.h>
#include <SDL/SDL_gfxPrimitives.h>
#include <sys/types.h>
#include <dirent.h>
#include <ctype.h>
#include "diamond_girl.h"
#include "BFont.h"

static int title_screen_selection;

static void draw_title_screen(void);
static void title_screen_event(SDL_Event * event, int homedir_ok);

unsigned int get_rand(unsigned int max)
{
  return (unsigned int)(float) max * (float) rand() / (float) (RAND_MAX + 1.0f);
}

static int quit;

static char * credits;
static SDL_Surface * credits_surface;
static size_t credits_pos;
static char * default_credits = "Diamond Girl - Created by Joni Yrjana                                                     ";
static int help_screen, help_screen_timer;
static int anim_frame, anim_timer;
static int highscores_first;

static int redraw_title;
static int redraw_help;
static int redraw_menu;
static int redraw_highscores;

static char ** map_names;
static int     map_selection;

static int qsort_string_compare(const char ** a, const char ** b)
{
  return strcmp(*a, *b);
}


void main_menu(int homedir_ok)
{
  FPSmanager framerate_manager;

  SDL_initFramerate(&framerate_manager);
  SDL_setFramerate(&framerate_manager, 50);

  quit = 0;
  title_screen_selection = 0;
  help_screen = 0;
  help_screen_timer = 0;
  anim_frame = 0;
  anim_timer = 0;
  highscores_first = 0;

  redraw_title = 1;
  redraw_help = help_screen + 1;
  redraw_menu = 1;
  redraw_highscores = 1;

  map_names = NULL;
  map_selection = -1; /* random maps */

  { /* read credits */
    FILE * fp;

    credits = NULL;
    fp = fopen("CREDITS", "r");
    if(fp != NULL)
      {
	int f;
	struct stat sb;

	f = fileno(fp);
	if(fstat(f, &sb) == 0)
	  {
	    /* calculate linefeeds */
	    int c;
	    int lf;
	    const char * lf_text = "      ";

	    lf = 0;
	    do
	      {
		c = fgetc(fp);
		if(c == '\n')
		  lf++;
	      } while(c != EOF);
		  
	    rewind(fp);

	    credits = (char *)malloc(strlen(lf_text) * 10 + sb.st_size + lf * strlen(lf_text) + 1);
	    assert(credits != NULL);

	    { /* read the credits file and replace linefeeds with lf_text */
	      char * p;

	      p = credits;
	      for(int i = 0; i < 10; i++)
		{
		  memcpy(p, lf_text, strlen(lf_text));
		  p += strlen(lf_text);
		}

	      do
		{
		  c = fgetc(fp);
		  if(c != EOF)
		    {
		      if(c == '\n')
			{
			  memcpy(p, lf_text, strlen(lf_text));
			  p += strlen(lf_text);
			}
		      else
			{
			  *p = c;
			  p++;
			}
		    }
		} while(c != EOF);
	      *p = '\0';
	    }
	  }
	else
	  {
	    fprintf(stderr, "Failed to stat 'CREDITS': %s\n", strerror(errno)); 
	  }
	fclose(fp);
      }
    else
      {
	fprintf(stderr, "Failed to open 'CREDITS': %s\n", strerror(errno));
      }
	
    if(credits == NULL)
      credits = strdup(default_credits);
  }

  assert(credits != NULL);
  credits_surface = NULL;

  { /* read map names */
    DIR * d;

    d = opendir("maps");
    if(d != NULL)
      {
	struct dirent * e;
	size_t s;

	s = 0;
	do
	  {
	    e = readdir(d);
	    if(e != NULL)
	      {
		if(isalnum(e->d_name[0]))
		  {
		    char ** tmp;

		    tmp = (char **)realloc(map_names, sizeof(char *) * (s + 1 + 1));
		    if(tmp != NULL)
		      {
			map_names = tmp;
			map_names[s] = strdup(e->d_name);
			if(map_names[s] == NULL)
			  {
			    fprintf(stderr, "Failed to allocate memory for predefined map names: %s\n", strerror(errno));
			    e = NULL;
			  }
			s++;
			map_names[s] = NULL;
		      }
		    else
		      {
			fprintf(stderr, "Failed to allocate memory for predefined map names: %s\n", strerror(errno));
			e = NULL;
		      }
		  }
	      }
	  }
	while(e != NULL);
	closedir(d);
      }
    else
      fprintf(stderr, "Failed to open directory 'maps/': %s\n", strerror(errno));
  }
  
  if(map_names != NULL)
    {
      size_t n;
      
      n = 0;
      while(map_names[n] != NULL)
	n++;

      qsort(map_names, n, sizeof(char *), (int(*)(const void *, const void *)) qsort_string_compare);

      if(map_names[0] != NULL)
	map_selection = 0;
    }
  else
    fprintf(stderr, "Warning, no predefined maps available.\n");

  if(map_selection >= 0)
    highscores_load(homedir_ok, map_names[map_selection]);
  else
    highscores_load(homedir_ok, NULL);

  clear_area(0, 0, gfx(MAP_SCREEN)->w, gfx(MAP_SCREEN)->h);

  sfx_music(MUSIC_TITLE, 1);

  while(!quit)
    {
      SDL_Event event;

      while(SDL_PollEvent(&event))
	title_screen_event(&event, homedir_ok);

      if(!quit)
	{
	  draw_title_screen();
	  SDL_Flip(gfx(MAP_SCREEN));
	  SDL_framerateDelay(&framerate_manager);
	}
    }

  if(map_selection >= 0)
    highscores_save(homedir_ok, map_names[map_selection]);
  else
    highscores_save(homedir_ok, NULL);
}

void clear_area(int x, int y, int w, int h)
{
  SDL_Rect r;
  Uint32 c;

  c = SDL_MapRGB(gfx(MAP_SCREEN)->format, 0, 0, 0);
  r.x = x;
  r.y = y;
  r.w = w;
  r.h = h;
  SDL_FillRect(gfx(MAP_SCREEN), &r, c);
}

static void draw_title_screen(void)
{
  int font_height, y;

  anim_timer++;
  if(anim_timer >= 10)
    {
      anim_frame++;
      if(anim_frame >= 0xffff)
	anim_frame = 0;
      anim_timer = 0;
    }

  font_height = BFont_FontHeight(BFont_GetCurrentFont());
  y = 0;

  if(redraw_title)
    { /* title */
      clear_area(0, y, gfx(MAP_SCREEN)->w, font_height);
      BFont_CenteredPrintString(gfx(MAP_SCREEN), y, "DIAMOND GIRL v%d.%d", (int) DIAMOND_GIRL_VERSION, (int) DIAMOND_GIRL_REVISION);
      redraw_title = 0;
    }
  y += font_height * 2;

  if(redraw_help != help_screen)
    { /* help/instructions */
      redraw_help = help_screen;

      clear_area(gfx(MAP_SCREEN)->w / 2, y, gfx(MAP_SCREEN)->w / 2, gfx(MAP_SCREEN)->h - font_height * (3 + 2) - y);
      switch(help_screen)
	{
	case 0: /* description */
	case 2: /* hints */
	  {
	    const char * description[] =
	      {
		"Welcome to Diamond Girl.",
		"",
		"Collect diamonds to open exit",
		"  to the next level.",
		"",
		"Touching any of the 'animals' will kill you.",
		"Falling boulders and diamonds",
		"  will also kill you.",
		"",
		"Controls:",
		" * cursor keys to move",
		" * shift+cursor keys to manipulate grid",
		"   without moving",
		" * escape key to quit",
		" * F1 for ingame help and pause",
		" * F10 toggle windowed/fullscreen",
		NULL
	      };
	    const char * hints[] =
	      {
		"Hints:",
		"",
		"You can push boulders left and right",
		"  if there is empty space behind them.",
		"",
		"Pushing speeds up a bit after first step.",
		"",
		"Drop boulders or diamonds on top of",
		"  animals to kill them.",
		"Watch out for the explosion!",
		"",
		"Each butterfly explodes into nine diamonds,",
		"  and bugs don't leave anything behind.",
		"",
		"You will get extra girl every 200 score.",
		NULL
	      };
	    const char ** text;
	    int i, x;

	    i = 0;
	    x = gfx(MAP_SCREEN)->w / 2;
	    if(help_screen == 0)
	      text = description;
	    else // if(help_screen == 2)
	      text = hints;
	    while(text[i] != NULL)
	      {
		BFont_PutString(gfx(MAP_SCREEN), x, y, text[i]);
		y += font_height;
		i++;
	      }
	  }
	  break;
	case 1: /* game graphics and explanations of them */
	  {
	    SDL_Rect r1, r2;
	    struct
	    {
	      enum MAP_GLYPH glyph;
	      int            glyph_anim_len;
	      int            glyph_anim_offset;
	      int            glyph_anim_multiplier;
	      const char *   explanation;
	    } explanations[] = 
	      {
		{ MAP_PLAYER_ARMOUR3,    1,  4 * 24,  0, "You." },
		{ MAP_DIAMOND,           1,       0,  0, "A diamond, collect." },
		{ MAP_BOULDER,           1,       0,  0, "A boulder." },
		{ MAP_SAND,              1,       0,  0, "Sand." },
		{ MAP_EXTRA_LIFE_ANIM,  24,       0,  1, "For few seconds, empty space looks like" },
		{ MAP_EXTRA_LIFE_ANIM,  24,       0,  1, "  this when you get extra girl." },
		{ MAP_BRICK,             1,       0,  0, "A brick wall." },
		{ MAP_BRICK_MORPHER,    24,       0,  1, "A morphing wall, turns diamonds into" },
		{ MAP_BRICK_MORPHER,    24,       0,  1, "  boulders and boulders into diamonds." },
		{ MAP_BRICK_UNBREAKABLE, 1,       0,  0, "Unbreakable brick wall." },
		{ MAP_AMEBA,             4,       0, 24, "Ameba." },
		{ MAP_EXIT_LEVEL,        3,       0, 24, "Exit to the next level." },
		{ MAP_ENEMY1,            3,       0, 24, "A radioactive bug, avoid." },
		{ MAP_ENEMY2,            4,       0, 24, "A radioactive butterfly, avoid." },
		{ MAP_SCREEN,            0,       0,  0, NULL }
	      };
	    int i;
	    
	    i = 0;
	    while(explanations[i].explanation != NULL)
	      {
		r1.x = gfx(MAP_SCREEN)->w / 2;
		r1.y = y + font_height;
		r1.w = 24;
		r1.h = 24;
		
		r2.x = explanations[i].glyph_anim_offset + (anim_frame % explanations[i].glyph_anim_len) * explanations[i].glyph_anim_multiplier;
		r2.y = 0;
		r2.w = 24;
		r2.h = 24;
		
		if(font_height > 26)
		  y += font_height;
		else
		  y += 26;
		
		SDL_BlitSurface(gfx(explanations[i].glyph), &r2, gfx(MAP_SCREEN), &r1);
		BFont_PutString(gfx(MAP_SCREEN), gfx(MAP_SCREEN)->w / 2 + 30, y, explanations[i].explanation);
		
		i++;
	      }
	    redraw_help = help_screen - 1;
	  }
	  break;
	}
    }

  help_screen_timer++;
  if(help_screen_timer >= 50 * 12)
    {
      help_screen++;
      if(help_screen >= 3)
	help_screen = 0;
      help_screen_timer = 0;
    }


  if(redraw_menu)
    { /* menu */
      int x;
      char * m;
      
      redraw_menu = 0;
      x = gfx(MAP_SCREEN)->w / 2;
      y = gfx(MAP_SCREEN)->h - font_height * (3 + 2);
      clear_area(0, y, gfx(MAP_SCREEN)->w, font_height * 3);

      BFont_PrintString(gfx(MAP_SCREEN), 10, y, "UP/DOWN change selection, ENTER choose");
      BFont_PrintString(gfx(MAP_SCREEN), 10, y + font_height, "LEFT/RIGHT change map set, ESC exit");
      vlineRGBA(gfx(MAP_SCREEN), x - 2, y, y + font_height * 3, 0x00, 0xff, 0x00, 0xff);
      vlineRGBA(gfx(MAP_SCREEN), gfx(MAP_SCREEN)->w - 2, y, y + font_height * 3, 0x00, 0xff, 0x00, 0xff);
      hlineRGBA(gfx(MAP_SCREEN), x - 2, gfx(MAP_SCREEN)->w - 2, y, 0x00, 0xff, 0x00, 0xff);
      hlineRGBA(gfx(MAP_SCREEN), x - 2, gfx(MAP_SCREEN)->w - 2, y + font_height * 3, 0x00, 0xff, 0x00, 0xff);

      if(map_selection < 0)
	m = "random maps";
      else
	m = map_names[map_selection];

      BFont_PrintString(gfx(MAP_SCREEN), x, y + title_screen_selection * font_height, "->");
      x += BFont_TextWidth("->");
      BFont_PrintString(gfx(MAP_SCREEN), x, y, "New game: %s", m);
      y += font_height;
      
      if(map_selection < 0)
	m = "N/A";
      BFont_PrintString(gfx(MAP_SCREEN), x, y, "Map Editor: %s", m);
      y += font_height;
      
      BFont_PrintString(gfx(MAP_SCREEN), x, y, "Quit");
      y += font_height;
    }
  

  /* credits */
  if(credits_surface == NULL)
    {
      SDL_Surface * tmp;
      
      tmp = BFont_CreateSurface(credits);
      if(tmp != NULL)
	{
	  credits_surface = SDL_ConvertSurface(tmp, gfx(MAP_SCREEN)->format, SDL_HWSURFACE);
	  if(credits_surface != NULL)
	    SDL_FreeSurface(tmp);
	  else
	    credits_surface = tmp;
	}
    }


  if(credits_surface != NULL)
    {
      SDL_Rect sr, dr;

      dr.x = gfx(MAP_SCREEN)->w / 8;
      dr.y = gfx(MAP_SCREEN)->h - font_height;
      dr.w = gfx(MAP_SCREEN)->w - dr.x * 2;
      dr.h = credits_surface->h;

      sr.x = credits_pos;
      sr.y = 0;
      sr.w = dr.w;
      sr.h = credits_surface->h;

      clear_area(dr.x, dr.y, dr.w, dr.h);
      
      SDL_BlitSurface(credits_surface, &sr, gfx(MAP_SCREEN), &dr);

      credits_pos++;
      if(credits_pos >= (size_t) credits_surface->w)
	credits_pos = 0;
    }


  if(redraw_highscores)
    { /* highscore list */
      size_t size, amount;
      struct highscore_entry ** entries;
     
      redraw_highscores = 0;
      y = font_height * 2;
      amount = 20;
      clear_area(0, y, gfx(MAP_SCREEN)->w / 2, (1 + amount + 1) * font_height);
      BFont_PrintString(gfx(MAP_SCREEN), 10, y, "Highscores %d -> %d:  (PageUp/Down)", highscores_first + 1, highscores_first + amount);
      y += font_height;
      hlineRGBA(gfx(MAP_SCREEN), 0, gfx(MAP_SCREEN)->w / 2 - 20, y, 0x00, 0xff, 0x00, 0xff);
      vlineRGBA(gfx(MAP_SCREEN), 40, y, y + (amount + 1) * font_height, 0x00, 0xff, 0x00, 0xff);
      vlineRGBA(gfx(MAP_SCREEN), 130, y, y + (amount + 1) * font_height, 0x00, 0xff, 0x00, 0xff);
      vlineRGBA(gfx(MAP_SCREEN), 190, y, y + (amount + 1) * font_height, 0x00, 0xff, 0x00, 0xff);
      BFont_PrintString(gfx(MAP_SCREEN), 10, y, " #");
      BFont_PrintString(gfx(MAP_SCREEN), 40, y, " Score");
      BFont_PrintString(gfx(MAP_SCREEN), 130, y, " Level");
      BFont_PrintString(gfx(MAP_SCREEN), 190, y, " Timestamp");
      y += font_height;
      hlineRGBA(gfx(MAP_SCREEN), 0, gfx(MAP_SCREEN)->w / 2 - 20, y, 0x00, 0xff, 0x00, 0xff);
      entries = highscores_get(&size);
      for(size_t i = highscores_first; i < highscores_first + amount && i < size; i++)
	{
	  char buf[256];
	  struct tm * tm;
	  
	  BFont_PrintString(gfx(MAP_SCREEN), 10, y, "%3d", (int) i + 1);
	  BFont_PrintString(gfx(MAP_SCREEN), 40, y, " %6d", (int) entries[i]->score);
	  BFont_PrintString(gfx(MAP_SCREEN), 130, y, " %3d", (int) entries[i]->level);
	  
	  tm = localtime(&entries[i]->timestamp);
	  strftime(buf, sizeof buf, "%Y-%m-%d %H:%M:%S", tm);
	  BFont_PrintString(gfx(MAP_SCREEN), 190, y, " %s", buf);
	  
	  y += font_height;
	}
    }
}





static void title_screen_event(SDL_Event * event, int homedir_ok)
{
  switch(event->type)
    {
    case SDL_QUIT:
      quit = 1;
      break;
    case SDL_KEYDOWN:
      if(event->key.keysym.sym == SDLK_ESCAPE)
	{
	  quit = 1;
	}
      else if(event->key.keysym.sym == SDLK_RETURN || event->key.keysym.sym == SDLK_KP_ENTER)
	{
	  char * map_set;
	  
	  if(map_selection == -1)
	    map_set = NULL;
	  else
	    map_set = map_names[map_selection];

	  switch(title_screen_selection)
	    {
	    case 0: /* new game */
	      {
		clear_area(0, 0, gfx(MAP_SCREEN)->w, gfx(MAP_SCREEN)->h);
		quit = game(map_set, 1, 0);
		sfx_music(MUSIC_TITLE, 1);
		clear_area(0, 0, gfx(MAP_SCREEN)->w, gfx(MAP_SCREEN)->h);
		redraw_title = 1;
		redraw_help = help_screen + 1;
		redraw_menu = 1;
		redraw_highscores = 1;
	      }
	      break;
	    case 1: /* map editor */
	      if(map_set != NULL)
		{
		  clear_area(0, 0, gfx(MAP_SCREEN)->w, gfx(MAP_SCREEN)->h);
		  sfx_music_stop();
		  map_editor(map_set);
		  sfx_music(MUSIC_TITLE, 1);
		  clear_area(0, 0, gfx(MAP_SCREEN)->w, gfx(MAP_SCREEN)->h);
		  redraw_title = 1;
		  redraw_help = help_screen + 1;
		  redraw_menu = 1;
		  redraw_highscores = 1;
		}
	      break;
	    case 2: /* quit */
	      quit = 1;
	      break;
	    }
	}
      else if(event->key.keysym.sym == SDLK_DOWN)
	{
	  if(title_screen_selection < 2)
	    {
	      title_screen_selection++;
	      redraw_menu = 1;
	    }
	}
      else if(event->key.keysym.sym == SDLK_UP)
	{
	  if(title_screen_selection > 0)
	    {
	      title_screen_selection--;
	      redraw_menu = 1;
	    }
	}
      else if(event->key.keysym.sym == SDLK_LEFT)
	{
	  if(map_selection > -1)
	    {
	      if(map_selection >= 0)
		highscores_save(homedir_ok, map_names[map_selection]);
	      else
		highscores_save(homedir_ok, NULL);

	      map_selection--;
	      redraw_menu = 1;
	      redraw_highscores = 1;
	      highscores_first = 0;

	      if(map_selection >= 0)
		highscores_load(homedir_ok, map_names[map_selection]);
	      else
		highscores_load(homedir_ok, NULL);
	    }
	}
      else if(event->key.keysym.sym == SDLK_RIGHT)
	{
	  if(map_names != NULL && map_names[map_selection + 1] != NULL)
	    {
	      if(map_selection >= 0)
		highscores_save(homedir_ok, map_names[map_selection]);
	      else
		highscores_save(homedir_ok, NULL);
	      
	      map_selection++;
	      redraw_menu = 1;
	      redraw_highscores = 1;
	      highscores_first = 0;

	      if(map_selection >= 0)
		highscores_load(homedir_ok, map_names[map_selection]);
	      else
		highscores_load(homedir_ok, NULL);
	    }
	}
      else if(event->key.keysym.sym == SDLK_PAGEUP)
	{
	  if(highscores_first > 0)
	    highscores_first -= 20;
	  if(highscores_first < 0)
	    highscores_first = 0;
	  redraw_highscores = 1;
	}
      else if(event->key.keysym.sym == SDLK_PAGEDOWN)
	{
	  size_t size;

	  highscores_get(&size);
	  if(highscores_first + 20 < (int) size)
	    highscores_first += 20;
	  redraw_highscores = 1;
	}
      else if(event->key.keysym.sym == SDLK_F10)
	{
	  if(fullscreen)
	    fullscreen = 0;
	  else
	    fullscreen = 1;
	  gfx_cleanup();
	  gfx_initialize();
	  redraw_title = 1;
	  redraw_help = help_screen + 1;
	  redraw_menu = 1;
	  redraw_highscores = 1;
	}
      break;
    }
}



