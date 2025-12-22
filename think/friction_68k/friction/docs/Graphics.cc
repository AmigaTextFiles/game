/*
 *  No Friction - roll-a-ball-puzzle-game
 *  Copyright (C) 2005  Andreas Remar
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

#include "Graphics.h"

#include <stdlib.h>

Graphics::Graphics(GameLogic *g)
{
  gameLogic = g;

  screen = SDL_SetVideoMode(640, 480, 32, SDL_DOUBLEBUF );

  if(screen == NULL)
    {
      printf("Failed to initialize video screen.\n");
      exit(-2);
    }

  SDL_WM_SetCaption("No Friction", "No Friction");
  SDL_ShowCursor(false == true);

  background_tile[0] = SDL_LoadBMP("gfx/tile_0.bmp");
  background_tile[1] = SDL_LoadBMP("gfx/tile_1.bmp");
  background_tile[2] = SDL_LoadBMP("gfx/tile_2.bmp");
  background_tile[3] = SDL_LoadBMP("gfx/tile_3.bmp");
  background_tile[4] = SDL_LoadBMP("gfx/goal.bmp");
  block              = SDL_LoadBMP("gfx/block.bmp");
  block_special[0]   = SDL_LoadBMP("gfx/block_special_0.bmp");
  block_special[1]   = SDL_LoadBMP("gfx/block_special_1.bmp");
  block_special[2]   = SDL_LoadBMP("gfx/block_special_2.bmp");
  block_special[3]   = SDL_LoadBMP("gfx/block_special_3.bmp");
  block_special[4]   = SDL_LoadBMP("gfx/block_special_4.bmp");
  broken             = SDL_LoadBMP("gfx/block_cracked.bmp");
  dot                = SDL_LoadBMP("gfx/dot_0.bmp");
  trap               = SDL_LoadBMP("gfx/spike.bmp");
  ball[0]            = SDL_LoadBMP("gfx/ball_lr_0.bmp");
  ball[1]            = SDL_LoadBMP("gfx/ball_lr_1.bmp");
  ball[2]            = SDL_LoadBMP("gfx/ball_lr_2.bmp");
  ball[3]            = SDL_LoadBMP("gfx/ball_lr_3.bmp");
  ball[4]            = SDL_LoadBMP("gfx/ball_ud_0.bmp");
  ball[5]            = SDL_LoadBMP("gfx/ball_ud_1.bmp");
  ball[6]            = SDL_LoadBMP("gfx/ball_ud_2.bmp");
  ball[7]            = SDL_LoadBMP("gfx/ball_ud_3.bmp");
  force              = SDL_LoadBMP("gfx/spike_blue.bmp");
  moving_trap        = SDL_LoadBMP("gfx/spike_red.bmp");
  death[0]           = SDL_LoadBMP("gfx/death_0.bmp");
  death[1]           = SDL_LoadBMP("gfx/death_1.bmp");
  death[2]           = SDL_LoadBMP("gfx/death_2.bmp");
  death[3]           = SDL_LoadBMP("gfx/death_3.bmp");
  death[4]           = SDL_LoadBMP("gfx/death_4.bmp");
  death[5]           = SDL_LoadBMP("gfx/death_5.bmp");
  death[6]           = SDL_LoadBMP("gfx/death_6.bmp");
  death[7]           = SDL_LoadBMP("gfx/death_7.bmp");
  death[8]           = SDL_LoadBMP("gfx/death_8.bmp");
  helptext[0]        = SDL_LoadBMP("gfx/helptext_0.bmp");
  helptext[1]        = SDL_LoadBMP("gfx/helptext_2.bmp");
  arrow[0]           = SDL_LoadBMP("gfx/arrow_0.bmp");
  arrow[1]           = SDL_LoadBMP("gfx/arrow_1.bmp");
  arrow[2]           = SDL_LoadBMP("gfx/arrow_2.bmp");
  arrow[3]           = SDL_LoadBMP("gfx/arrow_3.bmp");
  code[0]            = SDL_LoadBMP("gfx/code_3.bmp");
  code[1]            = SDL_LoadBMP("gfx/code_2.bmp");
  code[2]            = SDL_LoadBMP("gfx/code_1.bmp");
  code[3]            = SDL_LoadBMP("gfx/code_0.bmp");
  force_field[0]     = SDL_LoadBMP("gfx/barrier0.bmp");
  force_field[1]     = SDL_LoadBMP("gfx/barrier1.bmp");
  force_field[2]     = SDL_LoadBMP("gfx/barrier2.bmp");
  force_field[3]     = SDL_LoadBMP("gfx/barrier3.bmp");
  force_field[4]     = SDL_LoadBMP("gfx/barrier4.bmp");
  force_field[5]     = SDL_LoadBMP("gfx/barrier5.bmp");
  force_field[6]     = SDL_LoadBMP("gfx/barrier6.bmp");
  force_field[7]     = SDL_LoadBMP("gfx/barrier7.bmp");
  logo               = SDL_LoadBMP("gfx/logo.bmp");

  ball_anim = 0;
  next_ball_update = SDL_GetTicks() + BALL_ANIM_SPEED;

  SDL_SetColorKey(dot, SDL_SRCCOLORKEY | SDL_RLEACCEL, 
  		  SDL_MapRGB(screen->format, 0, 0, 0));  
  SDL_SetColorKey(trap, SDL_SRCCOLORKEY | SDL_RLEACCEL, 
  		  SDL_MapRGB(screen->format, 0, 0, 0));  
  SDL_SetColorKey(force, SDL_SRCCOLORKEY | SDL_RLEACCEL, 
  		  SDL_MapRGB(screen->format, 0, 0, 0));  
  SDL_SetColorKey(moving_trap, SDL_SRCCOLORKEY | SDL_RLEACCEL, 
  		  SDL_MapRGB(screen->format, 0, 0, 0));  
  for(int i = 0;i < 8;i++)
    {
       SDL_SetColorKey(ball[i], SDL_SRCCOLORKEY | SDL_RLEACCEL, 
		      SDL_MapRGB(screen->format, 0, 0, 0));  
       SDL_SetColorKey(force_field[i], SDL_SRCCOLORKEY | SDL_RLEACCEL, 
		      SDL_MapRGB(screen->format, 0, 0, 0));  
    }
  for(int i = 0;i < 9;i++)
    SDL_SetColorKey(death[i], SDL_SRCCOLORKEY | SDL_RLEACCEL,
                    SDL_MapRGB(screen->format, 0, 0, 0));

  for(int i = 0;i < 4;i++)
    {
      SDL_SetColorKey(arrow[i], SDL_SRCCOLORKEY | SDL_RLEACCEL,
		      SDL_MapRGB(screen->format, 0, 0, 0));
      SDL_SetColorKey(code[i], SDL_SRCCOLORKEY | SDL_RLEACCEL,
		      SDL_MapRGB(screen->format, 0, 0, 0));
    }

  SDL_SetColorKey(helptext[0], SDL_SRCCOLORKEY | SDL_RLEACCEL,
		  SDL_MapRGB(screen->format, 0, 0, 0));
  SDL_SetColorKey(helptext[1], SDL_SRCCOLORKEY | SDL_RLEACCEL,
		  SDL_MapRGB(screen->format, 0, 0, 0));
}

void
Graphics::frameCount()
{
  static int time = SDL_GetTicks();
  static int frames = 0;

  frames++;
  if(SDL_GetTicks() - time > 1000)
    {
      time = SDL_GetTicks();
      printf("FPS: %d\n", frames);
      frames = 0;
    }
}

void
Graphics::render()
{
  static bool first = true;
  bool redraw = false;

  if(gameLogic->toggleFullScreen)
    {
      if(gameLogic->fullScreen == true)
	{
	  screen = SDL_SetVideoMode(640, 480, 32, SDL_DOUBLEBUF
				    | SDL_FULLSCREEN);
	}
      else
	{
	  screen = SDL_SetVideoMode(640, 480, 32, SDL_DOUBLEBUF);
	}
      gameLogic->toggleFullScreen = false;

      redraw = true;
    }

  // frameCount();

  SDL_Rect rect;
  SDL_Rect update[20*15];
  SDL_Rect ball_posits[20];
  int update_counter = 0;

  Level *l = gameLogic->getLevel();

  char c, c2;

  if(l->redraw || redraw)
    {
      for(int y = 0;y < 15;y++)
	{
	  rect.y = y * 32;
	  for(int x = 0;x < 20;x++)
	    {
	      rect.x = x * 32;
	      c = l->background[y * 20 + x];
	      if(c >= 'a' && c <= 'e')
		SDL_BlitSurface(background_tile[c - 'a'], NULL, screen, &rect);
	      
	      c = l->foreground[y * 20 + x];
	      switch(c)
		{
		case 'b':
		  SDL_BlitSurface(block, NULL, screen, &rect);
		  break;
		  
		case 'c':
		  SDL_BlitSurface(broken, NULL, screen, &rect);
		  break;
		  
		case 'd':
#define OFFSET_DOT 11
		  rect.x += OFFSET_DOT;
		  rect.y += OFFSET_DOT;
		  SDL_BlitSurface(dot, NULL, screen, &rect);
		  rect.x -= OFFSET_DOT;
		  rect.y -= OFFSET_DOT;
		  break;
		  
		case 'e':
#define OFFSET_TRAP 2
		  rect.x += OFFSET_TRAP;
		  rect.y += OFFSET_TRAP;
		  SDL_BlitSurface(trap, NULL, screen, &rect);
		  rect.x -= OFFSET_TRAP;
		  rect.y -= OFFSET_TRAP;
		  break;
		  
		case 'f':
		case 'g':
		case 'h':
		case 'i':
		case 'j':
		  SDL_BlitSurface(block_special[c - 'f'], NULL, screen, &rect);
		  break;
		  
		case 'l':
		  rect.x += OFFSET_TRAP;
		  rect.y += OFFSET_TRAP;
		  SDL_BlitSurface(moving_trap, NULL, screen, &rect);
		  rect.x -= OFFSET_TRAP;
		  rect.y -= OFFSET_TRAP;
		  break;

		case 'm':
		case 'n':
		case 'o':
		case 'p':
		  SDL_BlitSurface(arrow[c - 'm'], NULL, screen, &rect);
		  break;

		default:
		  break;
		}
	    }

	  /* If level is 0 (starting screen) draw some extra dots */
	  if(l->currentLevel() == 0)
	    {
#define NUM_DOTS 39
	      SDL_Rect r[NUM_DOTS];

	      /* F */
	      r[0].x = 32*2 - 5; r[0].y = OFFSET_DOT;
	      r[1].x = 32*1 + OFFSET_DOT; r[1].y = 32 - 5;
	      r[2].x = 32*2 - 5; r[2].y = 32 + OFFSET_DOT;
	      r[3].x = 32*1 + OFFSET_DOT; r[3].y = 32*2 - 5;

	      /* R */
	      r[4].x = 32*4 - 5; r[4].y = OFFSET_DOT;
	      r[5].x = 32*3 + OFFSET_DOT; r[5].y = 32 - 5;
	      r[6].x = 32*4 + OFFSET_DOT; r[6].y = 32 - 5;
	      r[7].x = 32*4 - 5; r[7].y = 32 + OFFSET_DOT;
	      r[8].x = 32*3 + OFFSET_DOT; r[8].y = 32*2 - 5;
	      r[9].x = 32*4 + OFFSET_DOT; r[9].y = 32*2 - 5;

	      /* I */
	      r[10].x = 32*5 + OFFSET_DOT; r[10].y = 32 - 5;
	      r[11].x = 32*5 + OFFSET_DOT; r[11].y = 32*2 - 5;

	      /* C */
	      r[12].x = 32*6 + OFFSET_DOT; r[12].y = 32 - 5;
	      r[13].x = 32*6 + OFFSET_DOT; r[13].y = 32*2 - 5;
	      r[14].x = 32*7 - 5; r[14].y = OFFSET_DOT;
	      r[15].x = 32*7 - 5; r[15].y = 32*2 + OFFSET_DOT;

	      /* T */
	      r[16].x = 32*9 - 5; r[16].y = OFFSET_DOT;
	      r[17].x = 32*9 - 5; r[17].y = 32 - 5;
	      r[18].x = 32*9 - 5; r[18].y = 32 + OFFSET_DOT;
	      r[19].x = 32*9 - 5; r[19].y = 32*2 - 5;
	      r[20].x = 32*9 - 5; r[20].y = 32*2 + OFFSET_DOT;

	      /* I */
	      r[21].x = 32*10 + OFFSET_DOT; r[21].y = 32 - 5;
	      r[22].x = 32*10 + OFFSET_DOT; r[22].y = 32*2 - 5;

	      /* O */
	      r[23].x = 32*11 + OFFSET_DOT; r[23].y = 32 - 5;
	      r[24].x = 32*11 + OFFSET_DOT; r[24].y = 32*2 - 5;
	      r[25].x = 32*12 + OFFSET_DOT; r[25].y = 32 - 5;
	      r[26].x = 32*12 + OFFSET_DOT; r[26].y = 32*2 - 5;
	      r[27].x = 32*12 - 5; r[27].y = OFFSET_DOT;
	      r[28].x = 32*12 - 5; r[28].y = 32*2 + OFFSET_DOT;

	      /* N */
	      r[29].x = 32*13 + OFFSET_DOT; r[29].y = 32 - 5;
	      r[30].x = 32*13 + OFFSET_DOT; r[30].y = 32*2 - 5;
	      r[31].x = 32*15 - 5; r[31].y = OFFSET_DOT;
	      r[32].x = 32*15 - 5; r[32].y = 32 - 5;
	      r[33].x = 32*15 - 5; r[33].y = 32 + OFFSET_DOT;
	      r[34].x = 32*15 - 5; r[34].y = 32*2 - 5;
	      r[35].x = 32*15 - 5; r[35].y = 32*2 + OFFSET_DOT;
	      r[36].x = 32*14 - 5; r[36].y = 32 - 5;
	      r[37].x = 32*14 + 2; r[37].y = 32 + OFFSET_DOT;
	      r[38].x = 32*14 + OFFSET_DOT; r[38].y = 32*2 - 5;

	      for(int i = 0;i < NUM_DOTS;i++)
		{
		  r[i].y += 32*9;
		  SDL_BlitSurface(dot, NULL, screen, &r[i]);
		}
	    }
	}

      /* Draw text that says "Level: 1-1" and so on.. */
      int lev = l->currentLevel();
      if(((lev/10) > 0 && (lev/10) < 5 && (lev%10) > 0 && (lev%10) < 6)
	 || lev == 51
	 || lev == 37)
	{
	  char buf[200];
	  sprintf(buf, "gfx/level%d.bmp", lev);
	  SDL_Surface *level_text = SDL_LoadBMP(buf);
	  SDL_SetColorKey(level_text, SDL_SRCCOLORKEY, 
			  SDL_MapRGB(screen->format, 0, 0, 0));  
	  rect.x = 640 - 83;
	  rect.y = 480 - 20;
	  SDL_BlitSurface(level_text, NULL, screen, &rect);
	}
    }

  /* Draw balls */
  for(int j = 0;j < l->ball_counter;j++)
    {
          rect.x = (int)l->balls[j]->subx;
          rect.y = (int)l->balls[j]->suby;

          int block_x, block_y;

          block_x = rect.x / 32;
          block_y = rect.y / 32;

          SDL_Rect bg;

          bg.x = block_x * 32;
          bg.y = block_y * 32;


          for(int i = 0;i < 5;i++)
	    {
	      switch(i)
	        {
    	        case 0:
	          break;
	        case 1:
	          block_y--;
	          break;
	        case 2:
	          block_y++;
	          block_x--;
	          break;
	        case 3:
	          block_x+=2;
	          break;
	        case 4:
	          block_x--;
	          block_y++;
	          break;
	        }
	  
	      if(block_x >= 0 && block_x <= 19 && block_y >= 0 && block_y <= 14)
	        {
	          c = l->background[block_y * 20 + block_x];
	          c2 = l->foreground[block_y * 20 + block_x];
	          if(c >= 'a' && c <= 'e' && c2 == 'a')
		    {
		      bg.x = block_x * 32;
		      bg.y = block_y * 32;
		      SDL_BlitSurface(background_tile[c - 'a'], NULL,
			    	      screen, &bg);
		    }
                  else if(c >= 'a' && c <= 'e' && c2 == 'e')
                    {
		      bg.x = block_x * 32;
		      bg.y = block_y * 32;
		      SDL_BlitSurface(background_tile[c - 'a'], NULL,
			    	      screen, &bg);
		      bg.x += OFFSET_TRAP;
		      bg.y += OFFSET_TRAP;
		      SDL_BlitSurface(trap, NULL, screen, &bg);
		      bg.x -= OFFSET_TRAP;
		      bg.y -= OFFSET_TRAP;
                    }
	        }
	    }

          ball_posits[j].x = rect.x;
          ball_posits[j].y = rect.y;

          block_x--;
          if(block_x < 0)
            block_x = 0;
          block_y -= 2;
          if(block_y < 0)
            block_y = 0;
          bg.x = block_x * 32;
          bg.y = block_y * 32;
          bg.w = bg.h = 32*3;

	  if(bg.x + bg.w > 640)
	    bg.w = 640 - bg.x;

	  if(bg.y + bg.h > 480)
	    bg.h = 480 - bg.y;

          update[update_counter].x = bg.x;
          update[update_counter].y = bg.y;
          update[update_counter].w = bg.w;
          update[update_counter].h = bg.h;
          update_counter++;
    }

  /* Draw force fields */
  for(int j = 0;j < l->force_field_counter;j++)
    {
      if(l->force_fields[j]->redraw)
	{
	  SDL_Rect bg;
	  int block_x = l->force_fields[j]->block_x;
	  int block_y = l->force_fields[j]->block_y;
	  bg.x = block_x * 32;
	  bg.y = block_y * 32;
	  int counter = l->force_fields[j]->animation_counter;

	  if(block_x >= 0 && block_x <= 19 && block_y >= 0 && block_y <= 14)
	    {
	      c = l->background[block_y * 20 + block_x];
	      if(c >= 'a' && c <= 'e')
		{
		  SDL_BlitSurface(background_tile[c - 'a'], NULL,
				  screen, &bg);
		}

	      if(l->force_fields[j]->remove == false)
		{
		  SDL_BlitSurface(force_field[counter], NULL, screen, &bg);
		}
	      l->force_fields[j]->redraw = false;

	      update[update_counter].x = bg.x;
	      update[update_counter].y = bg.y;
	      update[update_counter].w = bg.w;
	      update[update_counter].h = bg.h;
	      update_counter++;
	    }
	}
    }

  /* Draw moving traps */
  for(int j = 0;j < l->trap_counter;j++)
    {
      rect.x = (int)l->traps[j]->subx;
      rect.y = (int)l->traps[j]->suby;

      int block_x = rect.x / 32;
      int block_y = rect.y / 32;

      SDL_Rect bg;

      bg.x = block_x * 32;
      bg.y = block_y * 32;

      for(int i = 0;i < 3;i++)
	{
	  switch(i)
	    {
	    case 0:
	      break;
	    case 1:
	      block_x--;
	      break;
	    case 2:
	      block_x+=2;
	      break;
	    }

	  if(block_x >= 0 && block_x <= 19 && block_y >= 0 && block_y <= 14)
	    {
	      c = l->background[block_y * 20 + block_x];
	      c2 = l->foreground[block_y * 20 + block_x];
	      if(c >= 'a' && c <= 'e' && c2 == 'a')
		{
		  bg.x = block_x * 32;
		  bg.y = block_y * 32;
		  SDL_BlitSurface(background_tile[c - 'a'], NULL,
				  screen, &bg);
		}
	      /* if the trap moves over a dot, redraw it */
	      else if(c >= 'a' && c <= 'e' && c2 == 'd')
		{
		  bg.x = block_x * 32;
		  bg.y = block_y * 32;
		  SDL_BlitSurface(background_tile[c - 'a'], NULL,
				  screen, &bg);
		  bg.x += OFFSET_DOT;
		  bg.y += OFFSET_DOT;
		  SDL_BlitSurface(dot, NULL, screen, &bg);
		  bg.x -= OFFSET_DOT;
		  bg.y -= OFFSET_DOT;
		}
	      /* if the trap moves over a force field, redraw it */
	      else if(c >= 'a' && c <= 'e' && c2 == 'k')
		{

		  for(int k = 0;k < l->force_field_counter;k++)
		    {
		      if(l->force_fields[k]->block_x == block_x
			 && l->force_fields[k]->block_y == block_y)
			{
			  l->force_fields[k]->redraw = true;
			}
		    }
		}
	    }
	}

      block_x-=2;
      bg.x = block_x * 32;
      bg.y = block_y * 32;
      bg.w = 32*3;
      bg.h = 32;

      update[update_counter].x = bg.x;
      update[update_counter].y = bg.y;
      update[update_counter].w = bg.w;
      update[update_counter].h = bg.h;
      update_counter++;

    }

  SDL_Rect r;
  for(int i = 0;i < l->trap_counter;i++)
    {
      r.x = (int)l->traps[i]->subx;
      r.y = (int)l->traps[i]->suby;
      SDL_BlitSurface(moving_trap, NULL, screen, &r);
    }

  for(int i = 0;i < l->ball_counter;i++)
    {
      if(l->balls[i]->play_dead == false)
        {
          SDL_BlitSurface(ball[l->balls[i]->anim_counter], NULL,
		          screen, &ball_posits[i]);
        }
      else
        {
          SDL_BlitSurface(death[l->balls[i]->anim_counter], NULL,
		          screen, &ball_posits[i]);
        }
    }

  if(l->redraw || redraw)
    {
      SDL_Rect pos;
      pos.x = 0;
      pos.y = 448;
      if(l->currentLevel() == 0)
	{
	  SDL_BlitSurface(helptext[1], NULL, screen, &pos);
	  pos.x = 640 - logo->w;
	  pos.y = 480 - logo->h;
	  SDL_BlitSurface(logo, NULL, screen, &pos);
	}
      else
	SDL_BlitSurface(helptext[0], NULL, screen, &pos);

      int current = l->currentLevel();
      if(current % 10 == 6)
	{
	  pos.x = 157;
	  pos.y = 5*32 + 10;
	  SDL_BlitSurface(code[(current / 10) - 1], NULL, screen, &pos);
	}
    }


  if(l->redraw || redraw)
    {
      SDL_UpdateRect(screen, 0, 0, 0, 0);
      l->redraw = false;
    }
  else
    {
      SDL_UpdateRects(screen, update_counter, update);
    }

}
