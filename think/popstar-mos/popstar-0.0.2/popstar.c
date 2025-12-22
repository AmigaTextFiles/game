/*
  popstar.c

  Pop Star
  Open Source Puzzle Game

  Concept and Coding by Bill Kendrick
  bill@newbreedsoftware.com
  http://www.newbreedsoftware.com/

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
  (See COPYING-GNU-GPL.txt)


  Music by R. Douglas Barbieri
  doug@dooglio.net
  http://music.dooglio.net/

  Music is released under the Creative Commons Attribution 3.0 Unported
  License.  (See COPYING-CC-Attrib30.txt)


  San Francisco Photograph by Daniel di Palma
  EDPalma@bellsouth.net
  http://commons.wikimedia.org/wiki/Image:Sanfrancisco10182006.jpg

  Licensed under the Creative Commons Attribution ShareAlike 2.5 License.
  (See COPYING-CC-ShareAlike25.txt)

  June 27, 2006 - September 30, 2007
*/

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include "SDL.h"
#include "SDL_image.h"
#include "SDL_mixer.h"
#include <math.h>


/* Configuration options; could be useful for platform ports: */

#define WIDTH 640 /* Screen size... */
#define HEIGHT 480
#define FPS 20 /* Frame rate */
#define MAX_STARS 16 /* Max # of stars on screen */
#define MAX_BROKENLINES 20 /* Max # of broken lines on screen */
#define POP_TIME (2 * FPS) /* How long stars take to pop */
#define LEVEL_TEXT_TIME (5 * FPS) /* How long between levels */
#define TRANSITION_THICKNESS 16 /* How many steps in level bkgd transition */

#define MAX_X_SPEED (star_width >> 2)
#define MAX_Y_SPEED (star_height >> 2)

#define BROKENLINE_LIFE 20  /* How many frames broken lines last */
#define BROKENLINE_SPEED 40  /* How fast broken lines can move */
#define BROKENLINE_SPEED_X2 (BROKENLINE_SPEED << 1)


/* Image data: */

enum {
  IMG_TITLE,
  IMG_BKGD1,
  IMG_BKGD2,
#define IMG_BKGD_max IMG_BKGD2
  IMG_STARS,
  IMG_CURSOR,
  IMG_BONUS,
  IMG_LEVEL_COMPLETE,
  IMG_LEVEL_INCOMPLETE,
  IMG_GAMEOVER,
  NUM_IMAGES
};

#define NUM_BKGD_IMGS ((IMG_BKGD_max - IMG_BKGD1) + 1)

#define IMG_PREFIX DATA_PREFIX "images/"

char * img_names[NUM_IMAGES] = {
  IMG_PREFIX "title.png",
  IMG_PREFIX "bkgd1.png",
  IMG_PREFIX "bkgd2.png",
  IMG_PREFIX "stars.png",
  IMG_PREFIX "cursor.png",
  IMG_PREFIX "bonus.png",
  IMG_PREFIX "complete.png",
  IMG_PREFIX "incomplete.png",
  IMG_PREFIX "gameover.png"
};

/* Music data: */

enum {
  MUSIC_TITLE,
  MUSIC_GAME1,
  MUSIC_GAME2,
#define MUSIC_GAME_max MUSIC_GAME2
  MUSIC_END,
  NUM_MUSICS
};

#define NUM_GAME_MUSICS ((MUSIC_GAME_max - MUSIC_GAME1) + 1)

#define MUSIC_PREFIX DATA_PREFIX "music/"

char * music_names[NUM_MUSICS] = {
  MUSIC_PREFIX "ph1lipina_sunris3.ogg",
  MUSIC_PREFIX "bull_fight.ogg",
  MUSIC_PREFIX "ethereal_jaunt.ogg",
  MUSIC_PREFIX "popstar_song2.ogg"
};

/* Sound data: */

enum {
  SND_MOVE,
  SND_SELECT,
  SND_BREAK,
  SND_POP,
  SND_BONUS,
  SND_MISSED1,
  NUM_SOUNDS
};

#define SND_PREFIX DATA_PREFIX "sounds/"

char * sound_names[NUM_SOUNDS] = {
  SND_PREFIX "move.wav",
  SND_PREFIX "select.wav",
  SND_PREFIX "line_break.wav",
  SND_PREFIX "pop.wav",
  SND_PREFIX "bonus.wav",
  SND_PREFIX "missed1.wav"
};

/* Star type: */

typedef struct star_ {
  int alive;
  int selected;
  int x, y;
  int xm, ym;
  int spin;
  int spinm;
  int color;
} star_type;

typedef struct pop_ {
  int life;
  int x, y;
  int xm, ym;
  int color;
} pop_type;

typedef struct brokenline_ {
  int life;
  int x1, y1, x2, y2;
  int x1m, y1m, x2m, y2m;
} brokenline_type;

typedef struct bonus_ {
  int life;
  int x, y;
} bonus_type;


/* Globals: */

SDL_Surface * screen;
SDL_Surface * images[NUM_IMAGES];
int star_width, star_height;
int use_sound;
Mix_Chunk * sounds[NUM_SOUNDS];
Mix_Music * musics[NUM_MUSICS];
star_type stars[MAX_STARS];
pop_type pops[MAX_STARS];
bonus_type bonuses[MAX_STARS];
brokenline_type brokenlines[MAX_BROKENLINES];
int stars_selected[MAX_STARS];
int num_stars_selected;
int cursor_star, cursor_spin, blink;
int level;
int advance_level;
int score;
int current_game_music, current_game_bkgd;


/* Local function prototypes: */

int setup(int argc, char * argv[]);
void setdown(void);
int title(void);
void init_game(void);
void init_level(void);
void add_star(void);
void add_pop(int x, int y, int xm, int ym, int color);
void add_bonus(int x, int y);
int game(void);
void pick_star(int want_angle);
int myrand(int max);
void draw_line(int x1, int y1, int x2, int y2, Uint8 r, Uint8 g, Uint8 b);
void draw_line_piece(int x, int y, Uint32 rgb);
#define myabs(x) (x < 0 ? -x : x)
#define mymax(a, b) (a > b ? a : b)
int intersect(int ax1, int ay1, int ax2, int ay2,
              int bx1, int by1, int bx2, int by2);
int inside(int x, int y);
int kill_intersections(void);
void add_line_debris(int x1, int y1, int x2, int y2);
void add_brokenline(int x1, int y1, int x2, int y2);
void select_star(void);


/* --- MAIN! --- */

int main(int argc, char * argv[])
{
  int quit, ret;
  
  if (setup(argc, argv) == 0)
  {
    quit = 0;
    
    do
    {
      quit = title();

      if (!quit)
	quit = game();
    }
    while (!quit);

    ret = 0;
  }
  else
  {
    ret = 1;
  }
 
  setdown();

  return(ret);
}


/* Title screen: */

int title(void)
{
  int quit, done;
  SDL_Event event;
  SDLKey key;

  SDL_BlitSurface(images[IMG_TITLE], NULL, screen, NULL);
  SDL_Flip(screen);

  if (use_sound)
    Mix_PlayMusic(musics[MUSIC_TITLE], -1);

  quit = 0;
  done = 0;

  do
  {
    SDL_WaitEvent(&event);

    if (event.type == SDL_QUIT)
      done = quit = 1;
    else if (event.type == SDL_KEYDOWN)
    {
      key = event.key.keysym.sym;

      if (key == SDLK_SPACE || key == SDLK_RETURN)
	done = 1;
      else if (key == SDLK_ESCAPE)
	done = quit = 1;
    }
  }
  while (!done);

  if (use_sound)
    Mix_HaltMusic();

  return(quit);
}


/* --- GAME LOOP! --- */

int game(void)
{
  int quit, done;
  int i;
  SDL_Event event;
  int img;
  int num_stars_left;
  Uint32 timenow, timethen;
  SDLKey key;
  SDL_Rect src, dest;

  quit = 0;
  done = 0;
  cursor_spin = 0;
  blink = 0;
  advance_level = 0;

  init_game();
  init_level();

  do
  {
    timethen = SDL_GetTicks();

    
    /* HANDLE EVENTS: */
    
    while (SDL_PollEvent(&event) > 0)
    {
      if (event.type == SDL_QUIT)
	done = quit = 1;
      else if (event.type == SDL_KEYDOWN)
      {
	key = event.key.keysym.sym;

	/* Up/Down/Left/Right moves cursor: */
	
	if (key == SDLK_LEFT)
	  pick_star(0);
	else if (key == SDLK_RIGHT)
	  pick_star(180);
	else if (key == SDLK_UP)
	  pick_star(90);
	else if (key == SDLK_DOWN)
	  pick_star(-90);
	else if ((key == SDLK_SPACE || key == SDLK_RETURN) &&
		 advance_level == 0)
          select_star();
	else if (key == SDLK_ESCAPE)
	{
	  /* Escape aborts & returns to title: */
		
	  done = 1;
	}
      }
      else if (event.type == SDL_MOUSEBUTTONDOWN)
      {
        for (i = 0; i < MAX_STARS; i++)
        {
          if (stars[i].alive &&
              (stars[i].x >> 4) >= event.button.x - (star_width >> 1) &&
              (stars[i].y >> 4) >= event.button.y - (star_height >> 1) &&
              (stars[i].x >> 4) < event.button.x + (star_width >> 1) &&
              (stars[i].y >> 4) < event.button.y + (star_height >> 1))
          {
            cursor_star = i;
          }
        }

        select_star();
      }
    }
    

    /* Move all of the stars: */

    num_stars_left = 0;
    
    for (i = 0; i < MAX_STARS; i++)
    {
      if (stars[i].alive)
      {
	/* Keep track of how many stars are left: */

	num_stars_left++;
	
	
	/* Move the stars around the screen: */
	      
	stars[i].x += stars[i].xm;
	stars[i].y += stars[i].ym;


	/* Keep them in-bounds; bounce them, if necessary: */
	
	if ((stars[i].x >> 4) < star_width / 2)
	{
	  stars[i].x = (star_width / 2) << 4;
	  stars[i].xm = -stars[i].xm;
	}
	else if ((stars[i].x >> 4) > WIDTH - (star_width / 2))
	{
	  stars[i].x = (WIDTH - (star_width / 2)) << 4;
	  stars[i].xm = -stars[i].xm;
	}

	if ((stars[i].y >> 4) < star_height / 2)
	{
	  stars[i].y = (star_height / 2) << 4;
	  stars[i].ym = -stars[i].ym;
	}
	else if ((stars[i].y >> 4) > HEIGHT - (star_height / 2))
	{
	  stars[i].y = (HEIGHT - (star_height / 2)) << 4;
	  stars[i].ym = -stars[i].ym;
	}


	/* Unselected stars spin wildly: */
	
	if (stars[i].selected == 0)
	{
	  stars[i].spin += stars[i].spinm;
          if (stars[i].spin < 0)
	    stars[i].spin = 31;
	  else if (stars[i].spin >= 32)
	    stars[i].spin = 0;
	}
      }
    }


    /* Switch to next level if there aren't enough stars left to make a poly: */

    if (num_stars_left < 3 && advance_level == 0)
    {
      advance_level = LEVEL_TEXT_TIME;
   
      if (use_sound)
        Mix_PlayChannel(-1, sounds[SND_MISSED1], 0);
    }
    
    
    /* Move pops and bonuses: */

    for (i = 0; i < MAX_STARS; i++)
    {
      if (pops[i].life > 0)
      {
	pops[i].life--;
	pops[i].x = pops[i].x + pops[i].xm;
	pops[i].y = pops[i].y + pops[i].ym;
      }
      
      if (bonuses[i].life > 0)
      {
	bonuses[i].life--;
	bonuses[i].y--;
      }
    }


    /* Move broken line debris: */

    for (i = 0; i < MAX_BROKENLINES; i++)
    {
      if (brokenlines[i].life > 0)
      {
        brokenlines[i].life--;
        brokenlines[i].x1 += brokenlines[i].x1m;
        brokenlines[i].y1 += brokenlines[i].y1m;
        brokenlines[i].x2 += brokenlines[i].x2m;
        brokenlines[i].y2 += brokenlines[i].y2m;
      }
    }



    /* Advance to next level, after end-of-level counter is done: */

    if (advance_level > 0)
    {
      advance_level--;

      if (advance_level == 0)
      {
        level++;
        init_level();
      }
    }


    kill_intersections();


    /* Keep animating spinning cursor, and flashing blinking objects... */
    
    cursor_spin = (cursor_spin + 1) % 20;
    blink = !blink;


    /* DRAW THE SCREEN: */

    /* Clear the screen (redraw background) */
    
    SDL_BlitSurface(images[current_game_bkgd], NULL, screen, NULL);


    /* Draw any lines between connected stars: */
    
    for (i = 0; i < num_stars_selected - 1; i++)
    {
      draw_line(stars[stars_selected[i]].x, stars[stars_selected[i]].y,
		stars[stars_selected[i + 1]].x, stars[stars_selected[i + 1]].y,
                255, 255, 255);
    }


    /* Draw a flashing line between the star under the cursor, and
       the last selected star: */

    if (/* blink && */
	num_stars_selected > 0 &&
        cursor_star != stars_selected[num_stars_selected - 1])
    {
      draw_line(stars[stars_selected[num_stars_selected - 1]].x,
		stars[stars_selected[num_stars_selected - 1]].y,
		stars[cursor_star].x,
		stars[cursor_star].y,
                (255 * blink), (255 * blink), (255 * blink));
    }


    /* Draw the stars: */
    
    for (i = 0; i < MAX_STARS; i++)
    {
      if (stars[i].alive &&
          (advance_level == 0 || blink))
      {
	/* Draw the cursor under the selected star: */
	/* (Unless there are not enough to make a poly */
	      
	if (cursor_star == i && advance_level == 0)
	{
	  src.x = (cursor_spin >> 2) * star_width;
	  src.y = 0;
	  src.w = star_width;
	  src.h = star_height;
	  
	  dest.x = (stars[i].x >> 4) - (star_width >> 1);
	  dest.y = (stars[i].y >> 4) - (star_height >> 1);
	
	  SDL_BlitSurface(images[IMG_CURSOR], &src, screen, &dest);
	}


	/* Draw the star in the appopriate color and at the proper angle: */
	
	src.x = ((stars[i].spin >> 2) % 4) * star_width;
	src.y = ((((stars[i].spin >> 2) / 4) + (stars[i].color * 2)) *
		 star_height);
	src.w = star_width;
	src.h = star_height;

	dest.x = (stars[i].x >> 4) - (star_width >> 1);
	dest.y = (stars[i].y >> 4) - (star_height >> 1);
	
	SDL_BlitSurface(images[IMG_STARS], &src, screen, &dest);
      }
    }


    /* Draw pops: */

    for (i = 0; i < MAX_STARS; i++)
    {
      if (pops[i].life > 0)
      {
	int x, y, cx, cy, xx, yy, mult;

	mult = POP_TIME - pops[i].life + 1;

	cx = pops[i].x;
	cy = pops[i].y;
	
	for (y = 0; y < star_height; y++)
	{
	  for (x = 0; x < star_width; x++)
	  {
	    src.x = (((stars[i].spin >> 2) % 4) * star_width) + x;
	    src.y = ((((stars[i].spin >> 2) / 4) + (stars[i].color * 2)) *
		     star_height) + y;

	    if (mult < POP_TIME / 2)
	    {
	      src.w = 2;
	      src.h = 2;
	    }
	    else
	    {
	      src.w = 1;
	      src.h = 1;
	    }

	    xx = x - (star_width >> 1);
	    yy = y - (star_height >> 1);
	    
	    dest.x = cx + (xx * mult);
	    dest.y = cy + (yy * mult);

	    SDL_BlitSurface(images[IMG_STARS], &src, screen, &dest);
	  }
	}
      }
    }


    /* Draw bonuses: */

    for (i = 0; i < MAX_STARS; i++)
    {
      if (bonuses[i].life > 0)
      {
	dest.x = bonuses[i].x - (images[IMG_BONUS]->w >> 1);
	dest.y = bonuses[i].y - (images[IMG_BONUS]->h >> 1);

	SDL_BlitSurface(images[IMG_BONUS], NULL, screen, &dest);
      }
    }


    /* Draw broken line debris: */

    for (i = 0; i < MAX_BROKENLINES; i++)
    {
      if (brokenlines[i].life > 0)
      {
        draw_line(brokenlines[i].x1, brokenlines[i].y1,
                  brokenlines[i].x2, brokenlines[i].y2,
                  255, myrand(256), 0);
      }
    }


    /* Show end-of-level notice: */

    if (advance_level > 0)
    {
      if (num_stars_left == 0)
        img = IMG_LEVEL_COMPLETE;
      else
        img = IMG_LEVEL_INCOMPLETE;
	
      dest.x = (WIDTH - images[img]->w) / 2;
      dest.y = (HEIGHT - images[img]->h) / 2;

      SDL_BlitSurface(images[img], NULL, screen, &dest);
    }
    
    
    /* Flip the screen! */
    
    SDL_Flip(screen);


    /* THROTTLE FOR FRAMERATE: */

    timenow = SDL_GetTicks();
    if (timenow - timethen < (1000 / FPS))
      SDL_Delay(timethen + (1000 / FPS) - timenow);
  }
  while (!done);
  
  if (use_sound)
    Mix_HaltMusic();

  return(quit);
}


/* Select the star at the cursor: */

void select_star(void)
{
  int i;
  int got_bonus;


  /* Space/Enter selects current star: */

  if (stars[cursor_star].selected == 0)
  {
    /* Selecting a new star... */
  
    stars_selected[num_stars_selected] = cursor_star;
    num_stars_selected++;
    stars[cursor_star].selected = 1;

    if (use_sound)
      Mix_PlayChannel(-1, sounds[SND_SELECT], 0);
  }
  else if (cursor_star == stars_selected[0] &&
	   num_stars_selected >= 3)
  {
    /* If we select the first star again, and make a polygon! */

    stars[cursor_star].selected = 1;

    if (kill_intersections() == 0)
    {
      /* Remove any stars within, for bonus! */

      got_bonus = 0;

      for (i = 0; i < MAX_STARS; i++)
      {
	if (stars[i].alive == 1 && stars[i].selected == 0 &&
	    inside(stars[i].x, stars[i].y))
	{
	  stars[i].alive = 0;
	  stars[i].selected = 0;

	  add_bonus(stars[i].x >> 4, stars[i].y >> 4);
	  add_pop(stars[i].x >> 4, stars[i].y >> 4,
		  stars[i].xm >> 4, stars[i].ym >> 4,
		  stars[i].color);

	  got_bonus = 1;
	}
      }

      /* Remove the stars that formed the polygon: */
	  
      for (i = 0; i < num_stars_selected; i++)
      {
	stars[stars_selected[i]].alive = 0;
	stars[stars_selected[i]].selected = 0;

	add_pop(stars[stars_selected[i]].x >> 4,
		stars[stars_selected[i]].y >> 4,
		stars[stars_selected[i]].xm >> 4,
		stars[stars_selected[i]].ym >> 4,
		stars[stars_selected[i]].color);

	stars_selected[i] = -1;
      }
      num_stars_selected = 0;


      /* Play sound: */

      if (use_sound)
      {
        Mix_PlayChannel(-1, sounds[SND_POP], 0);

        if (got_bonus)
          Mix_PlayChannel(-1, sounds[SND_BONUS], 0);
      }
    

      /* Try to select another floating star: */
    
      cursor_star = -1;
      for (i = 0; i < MAX_STARS && cursor_star == -1; i++)
      {
	if (stars[i].alive)
	  cursor_star = i;
      }


      /* No more to select?  Advance to next level! */
    
      if (cursor_star == -1)
	advance_level = LEVEL_TEXT_TIME;
    }
  }
}

/* Draw a line between two x/y positions (in "<< 4" fixed point space!) */

void draw_line(int x1, int y1, int x2, int y2, Uint8 r, Uint8 g, Uint8 b)
{
  int dx, dy, y;
  Uint32 rgb;
  float m, bi; /* FIXME: Literally... use fixed point math ;^) */

  rgb = SDL_MapRGB(screen->format, r, g, b);

  x1 >>= 4;
  y1 >>= 4;
  x2 >>= 4;
  y2 >>= 4;

  dx = x2 - x1;
  dy = y2 - y1;

  if (dx != 0)
  {
    m = ((float) dy) / ((float) dx);
    bi = y1 - m * x1;;

    if (x2 >= x1)
      dx = 1;
    else
      dx = -1;

    while (x1 != x2)
    {
      y1 = m * x1 + bi;
      y2 = m * (x1 + dx) + bi;

      if (y1 > y2)
      {
	y = y1;
	y1 = y2;
	y2 = y;
      }

      for (y = y1; y <= y2; y++)
        draw_line_piece(x1, y, rgb);

      x1 = x1 + dx;
    }
  }
  else
  {
    if (y1 > y2)
    {
      y = y1;
      y1 = y2;
      y2 = y;
    }

    for (y = y1; y <= y2; y++)
      draw_line_piece(x1, y, rgb);
  }
}


/* Draw a piece of a line: */

void draw_line_piece(int x, int y, Uint32 rgb)
{
  SDL_Rect rect;

  rect.x = x;
  rect.y = y;
  rect.w = 2;
  rect.h = 2;

  SDL_FillRect(screen, &rect, rgb);
}


/* Select the nearest star in the direction the user pointed w/ arrow keys: */

#define PI 3.1415926

void pick_star(int want_angle)
{
  int i, next_star;
  int x1, y1, x2, y2;
  int dist, best_dist;
  int this_angle, angle_diff;

  next_star = -1;
  best_dist = INT_MAX;

  for (i = 0; i < MAX_STARS; i++)
  {
    /* Check all live stars (not already selected by the cursor) */
	  
    if (stars[i].alive && i != cursor_star &&
	(stars[i].selected == 0 ||
	 (num_stars_selected >= 3 && stars_selected[0] == i)))
    {
      /* If it's in the right direction... */

      x1 = stars[i].x;
      y1 = stars[i].y;
      x2 = stars[cursor_star].x;
      y2 = stars[cursor_star].y;
      
      this_angle = atan2(y2 - y1, x2 - x1) * 180 / PI;

      angle_diff = (this_angle - want_angle);
      if (angle_diff < 0)
	angle_diff += 360;

      if (angle_diff >= (360 - 45) || angle_diff <= 45)
      {
	/* Determine its distance (in "<< 4" fixed-point space): */
	
	dist = sqrt(((x1 - x2) * (x1 - x2)) + ((y1 - y2) * (y1 - y2)));


	/* If it's the closest so far, make it our candidate: */
	
	if (dist < best_dist)
	{
	  best_dist = dist;
	  next_star = i;
	}
      }
    }
  }


  /* If we found a close one, select it! */

  if (next_star != -1)
  {
    cursor_star = next_star;

    if (use_sound)
      Mix_PlayChannel(-1, sounds[SND_MOVE], 0);
  }
}


/* Init a new game: */

void init_game(void)
{
  level = 1;
  score = 0;
  current_game_music = -1;
  current_game_bkgd = -1;
}


/* Init a new level: */

void init_level(void)
{
  int i, y;
  int level_music, level_bkgd;
  SDL_Rect rect;


  /* Clear out all stars, pops, bonuses and the star selection: */
  
  for (i = 0; i < MAX_STARS; i++)
  {
    stars[i].alive = 0;
    stars_selected[i] = -1;
    pops[i].life = 0;
    bonuses[i].life = 0;
  }
  
  num_stars_selected = 0;


  /* Clear out broken line debris: */

  for (i = 0; i < MAX_BROKENLINES; i++)
    brokenlines[i].life = 0;


  /* Select the first star: */

  cursor_star = 0;


  /* Add some stars (the higher the level, the more stars) */
  
  for (i = 0; i < (level * 2) + 1 && i < MAX_STARS; i++)
  {
    add_star();
  }


  /* Play appropriate music for this level: */

  if (use_sound)
  {
    level_music = MUSIC_GAME1 + ((level - 1) / 4); /* FIXME */
    if (level_music >= MUSIC_GAME1 + NUM_GAME_MUSICS)
      level_music = MUSIC_GAME1 + NUM_GAME_MUSICS - 1;

    if (level_music != current_game_music)
    {
      Mix_HaltMusic();
      Mix_PlayMusic(musics[level_music], -1);
      current_game_music = level_music;
    }
  }


  /* Pick appropriate background image for this level: */

  level_bkgd = IMG_BKGD1 + ((level - 1) / 4); /* FIXME */
  if (level_bkgd >= IMG_BKGD1 + NUM_BKGD_IMGS)
    level_bkgd = IMG_BKGD1 + NUM_BKGD_IMGS - 1;

  if (level_bkgd != current_game_bkgd)
  {
    /* Transition effect! */

    /* (Erase to black) */

    for (y = 0; y < TRANSITION_THICKNESS; y++)
    {
      for (i = y; i < screen->h; i = i + TRANSITION_THICKNESS)
      {
        rect.x = 0;
        rect.y = i;
        rect.w = screen->w;
        rect.h = 1;

        SDL_FillRect(screen, &rect, SDL_MapRGB(screen->format, 0, 0, 0));
      }

      SDL_Flip(screen);

      SDL_Delay(1000 / FPS);
    }


    /* (Bring in new level background) */

    for (y = 0; y < TRANSITION_THICKNESS; y++)
    {
      for (i = y; i < screen->h; i = i + TRANSITION_THICKNESS)
      {
        rect.x = 0;
        rect.y = i;
        rect.w = screen->w;
        rect.h = 1;

        SDL_BlitSurface(images[level_bkgd], &rect, screen, &rect);
      }

      SDL_Flip(screen);

      SDL_Delay(1000 / FPS);
    }

    current_game_bkgd = level_bkgd;
  }
}


/* Add a new star: */

void add_star(void)
{
  int i, found;
  int side;
  int speedx, speedy;


  /* Find a slot to store a new star: */

  found = -1;
  for (i = 0; i < MAX_STARS && found == -1; i++)
  {
    if (stars[i].alive == 0)
      found = i;
  }

  if (found != -1)
  {
    /* Activate the star: */

    stars[found].alive = 1;
    stars[found].selected = 0;


    /* Pick random speeds, based on the level: */

    do
    {
      speedx = (myrand(level * 7) - (level * 3)) << 2;
      speedy = (myrand(level * 7) - (level * 3)) << 2;
    }
    while (speedx > MAX_X_SPEED << 4 || speedy > MAX_Y_SPEED << 4);


    /* Pick a random side for the star to appear on: */

    side = myrand(4);

    if (side == 0 || side == 2)
    {
      /* Top or bottom: */

      stars[found].x = myrand(WIDTH) << 4;
      stars[found].xm = speedx;

      if (side == 0)
      {
        stars[found].y = (-star_height) << 4;
        stars[found].ym = myabs(speedy);
      }
      else
      {
	stars[found].y = (HEIGHT + star_height) << 4;
	stars[found].ym = -myabs(speedy);
      }
    }
    else
    {
      /* Right or left: */

      stars[found].y = myrand(HEIGHT) << 4;
      stars[found].ym = speedy;

      if (side == 1)
      {
        stars[found].x = (-star_width) << 4;
        stars[found].xm = myabs(speedx);
      }
      else
      {
	stars[found].x = (WIDTH + star_width) << 4;
	stars[found].xm = -myabs(speedx);
      }
    }
   

    /* Start with a random spin and color: */

    stars[found].spin = myrand(8);
    stars[found].color = myrand(4);


    /* Pick a random (non-stationary) spin speed and direction: */

    do
    {
      stars[found].spinm = myrand(9) - 4;
    }
    while (stars[found].spinm == 0);
  }
}


/* Add a new pop: */

void add_pop(int x, int y, int xm, int ym, int color)
{
  int i, found;


  /* Find a slot to store a new pop: */

  found = -1;
  for (i = 0; i < MAX_STARS && found == -1; i++)
  {
    if (pops[i].life == 0)
      found = i;
  }

  if (found != -1)
  {
    /* Activate the pop: */

    pops[found].life = POP_TIME;
    pops[found].x = x;
    pops[found].y = y;
    pops[found].xm = xm;
    pops[found].ym = ym;
    pops[found].color = color;
  }
}


/* Add a new bonus: */

void add_bonus(int x, int y)
{
  int i, found;


  /* Find a slot to store a new pop: */

  found = -1;
  for (i = 0; i < MAX_STARS && found == -1; i++)
  {
    if (bonuses[i].life == 0)
      found = i;
  }

  if (found != -1)
  {
    /* Activate the bonus: */

    bonuses[found].life = POP_TIME;
    bonuses[found].x = x;
    bonuses[found].y = y;
  }
}


/* Set up the app! */

int setup(int argc, char * argv[])
{
  int i;
  int err;
  SDL_Surface * tmp_surf;

  /* FIXME: Check cmd-line args */

  err = 0;


  /* Init SDL video and sound, and mixer... */
  
  if (SDL_Init(SDL_INIT_VIDEO) < 0)
  {
    fprintf(stderr, "Error init'ing video: %s\n", SDL_GetError());
    err = 1;
  }

  if (err == 1 || SDL_Init(SDL_INIT_AUDIO) < 0)
  {
    fprintf(stderr, "Warning: Error init'ing sound: %s\n", SDL_GetError());
    use_sound = 0;
  }
  else
    use_sound = 1;

  if (use_sound)
  {
    if (Mix_OpenAudio(44100, AUDIO_S16SYS, 2, 2048) < 0)
    {
      fprintf(stderr, "Warning: Error opening sound: %s\n", SDL_GetError());
      use_sound = 0;
    }
  }


  /* Open a display or window: */
  
  /* if (err == 0 && use_fullscreen) */ /* FIXME: Handle this */

  /* if (err == 0 && use_fullscreen == 0) */
  {
    screen = SDL_SetVideoMode(WIDTH, HEIGHT, 16, SDL_SWSURFACE);
  }

  if (screen == NULL)
  {
    fprintf(stderr, "Error opening screen: %s\n", SDL_GetError());
    err = 1;
  }
  

  /* Load all images: */
  
  for (i = 0; i < NUM_IMAGES && !err; i++)
  {
    tmp_surf = IMG_Load(img_names[i]);
    if (tmp_surf == NULL)
    {
      err = 1;
      images[i] = NULL;
      fprintf(stderr, "Error loading %s: %s\n", img_names[i], SDL_GetError());
    }
    else
    {
      images[i] = SDL_DisplayFormatAlpha(tmp_surf);
      SDL_FreeSurface(tmp_surf);

      if (images[i] == NULL)
      {
	err = 1;
	fprintf(stderr, "Error converting %s: %s\n",
	        img_names[i], SDL_GetError());
      }
    }
  }


  /* Determine width/height of stars (they're on a 4x8 panel) */

  if (images[IMG_STARS] != NULL)
  {
    star_width = images[IMG_STARS]->w / 4;
    star_height = images[IMG_STARS]->h / 8;
  }

  
  /* Load all sounds: */
  
  for (i = 0; i < NUM_SOUNDS && !err; i++)
  {
    sounds[i] = Mix_LoadWAV(sound_names[i]);
  }


  /* Load all musics: */
  
  for (i = 0; i < NUM_MUSICS && !err; i++)
  {
    musics[i] = Mix_LoadMUS(music_names[i]);
  }


  /* Seed the random number generator: */
  
  srand(SDL_GetTicks()); // was time(NULL)

  return(err);
}


/* Shut down! */

void setdown(void)
{
  int i;


  /* Free all images: */
  
  for (i = 0; i < NUM_IMAGES; i++)
  {
    if (images[i] != NULL)
    {
      SDL_FreeSurface(images[i]);
      images[i] = NULL;
    }
  }


  /* Free all music: */

  if (use_sound)
  {
    for (i = 0; i < NUM_SOUNDS; i++)
    {
      if (sounds[i] != NULL)
      {
        Mix_FreeChunk(sounds[i]);
        sounds[i] = NULL;
      }
    }

    for (i = 0; i < NUM_MUSICS; i++)
    {
      if (musics[i] != NULL)
      {
        Mix_FreeMusic(musics[i]);
        musics[i] = NULL;
      }
    }
  }


  /* Quit! */
  
  SDL_Quit();
}


/* Random number: */

int myrand(int max)
{
  return (rand() % max);
}


/* Segment intersection: */

/* Base on: http://groups.google.com/group/comp.graphics.algorithms/tree/browse_frm/thread/3821038110407e69/121714cbcbad8da7?rnum=1&_done=%2Fgroup%2Fcomp.graphics.algorithms%2Fbrowse_frm%2Fthread%2F3821038110407e69%2F121714cbcbad8da7%3Ftvc%3D1%26#doc_863c869641ad19a2 */

int intersect(int ax1, int ay1, int ax2, int ay2,
              int bx1, int by1, int bx2, int by2)
{
  int dpx, dpy, qax, qay, qbx, qby, d, la, lb;

  dpx = bx1 - ax1;
  dpy = by1 - ay1;

  qax = ax2 - ax1;
  qay = ay2 - ay1;

  qbx = bx2 - bx1;
  qby = by2 - by1;


  /* Instead of dividing la and lb by d and testing
     for 0 <= la <= 1 and 0 <= lb <= 1, the abs() tests below are faster
     and work with integers: */

  d = qay * qbx - qby * qax;

  la = (qbx * dpy - qby * dpx);
  lb = (qax * dpy - qay * dpx);

  if (myabs(la) < myabs(d) && myabs(lb) < myabs(d))
    return(1);
  else
    return(0);
}


/* Is a star inside the polygon formed by the selected stars? */

/* Based on: http://astronomy.swin.edu.au/~pbourke/geometry/insidepoly/
   (Solution 1 (2D), pnpoly() by Randolph Franklin) */

int inside(int x, int y)
{
  int i, j, c;
  int xpi, ypi, xpj, ypj;
  c = 0;

  for (i = 0, j = num_stars_selected - 1; i < num_stars_selected; j = i++)
  {
    xpi = stars[stars_selected[i]].x;
    ypi = stars[stars_selected[i]].y;
    xpj = stars[stars_selected[j]].x;
    ypj = stars[stars_selected[j]].y;

    if ((((ypi <= y) && (y < ypj)) || ((ypj <= y) && (y < ypi))) &&
        (x < (xpj - xpi) * (y - ypi) / (ypj - ypi) + xpi))
    {
      c = !c;
    }
  }

  return(c);
}

/* Check for any line intersections, and kill those lines: */

int kill_intersections(void)
{
  int i, j, k;
  int x1, y1, x2, y2;
  int u1, v1, u2, v2;
  int killed_any;

  killed_any = 0;

  for (i = 0; i < num_stars_selected - 1; i++)
  {
    x1 = stars[stars_selected[i]].x;
    y1 = stars[stars_selected[i]].y;
    x2 = stars[stars_selected[i + 1]].x;
    y2 = stars[stars_selected[i + 1]].y;

    for (j = 0; j < num_stars_selected - 1; j++)
    {
      if (j != i)
      {
        u1 = stars[stars_selected[j]].x;
        v1 = stars[stars_selected[j]].y;
        u2 = stars[stars_selected[j + 1]].x;
        v2 = stars[stars_selected[j + 1]].y;
      
        if (intersect(x1, y1, x2, y2, u1, v1, u2, v2))
        {
          /* Unselect the stars that caused an intersection: */

          stars[stars_selected[j]].selected = 0;
          stars[stars_selected[j + 1]].selected = 0;

          killed_any = 1;


          /* And remove them from the selection list: */

          for (k = j; k < num_stars_selected - 2; k++)
            stars_selected[k] = stars_selected[k + 2];

          num_stars_selected = num_stars_selected - 2;


          /* Advance in the loop, too: */

          j = j + 2;


          /* Break the line */

          add_line_debris(x1, y1, x2, y2);
          add_line_debris(u1, v1, u2, v2);
        }
      }
    }
  }

  if (use_sound)
    if (killed_any)
      Mix_PlayChannel(-1, sounds[SND_BREAK], 0);

  return(killed_any);
}


/* Break a line into pieces when they intersect: */

void add_line_debris(int x1, int y1, int x2, int y2)
{
  int i, n;

  n = myrand(6) + 4;

  for (i = 0; i < n; i++)
  {
    if (myrand(10) > 2)
    {
      add_brokenline((((x2 - x1) * i) / n) + x1,
                     (((y2 - y1) * i) / n) + y1,
                     (((x2 - x1) * (i + 1)) / n) + x1,
                     (((y2 - y1) * (i + 1)) / n) + y1);
    }
  }
}


/* Add individual broken line pieces: */

void add_brokenline(int x1, int y1, int x2, int y2)
{
  int i, found;

  found = -1;

  for (i = 0; i < MAX_BROKENLINES && found == -1; i++)
  {
    if (brokenlines[i].life == 0)
      found = i;
  }

  if (found == -1)
    found = myrand(MAX_BROKENLINES);

  brokenlines[found].life = BROKENLINE_LIFE;

  brokenlines[found].x1 = x1;
  brokenlines[found].y1 = y1;

  brokenlines[found].x1m = myrand(BROKENLINE_SPEED_X2) - BROKENLINE_SPEED;
  brokenlines[found].y1m = myrand(BROKENLINE_SPEED_X2) - BROKENLINE_SPEED;

  brokenlines[found].x2 = x2;
  brokenlines[found].y2 = y2;

  brokenlines[found].x2m = myrand(BROKENLINE_SPEED_X2) - BROKENLINE_SPEED;
  brokenlines[found].y2m = myrand(BROKENLINE_SPEED_X2) - BROKENLINE_SPEED;
}

