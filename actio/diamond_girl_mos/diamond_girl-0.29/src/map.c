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

#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <errno.h>
#include "diamond_girl.h"

struct map * map_random(int level)
{
  struct map * map;
  int diamonds;

  srand(level + 1);

  map = (struct map *)malloc(sizeof(struct map));
  assert(map != NULL);
  map->width = 40;
  map->height = 20;

  map->diamond_score = level;
  if(map->diamond_score > 20)
    map->diamond_score = 20;
  map->time_score = level;
  if(map->time_score > 50)
    map->time_score = 50;

  map->data = (char *)malloc(map->width * map->height);
  assert(map->data != NULL);
  map->processed = (char *)malloc(map->width * map->height);
  assert(map->processed != NULL);
  map->move_directions = (enum MOVE_DIRECTION *)malloc(map->width * map->height * sizeof(enum MOVE_DIRECTION));
  assert(map->move_directions != NULL);
  for(int y = 0; y < map->height; y++)
    for(int x = 0; x < map->width; x++)
      map->move_directions[x + y * map->width] = MOVE_NONE;
  diamonds = 0;
  for(int y = 0; y < map->height; y++)
    for(int x = 0; x < map->width; x++)
      {
	int r;

	r = get_rand(100);
	if(r > 90)
	  map->data[x + y * map->width] = MAP_BOULDER;
	else if(r > 85)
	  {
	    map->data[x + y * map->width] = MAP_DIAMOND;
	    diamonds++;
	  }
	else if(r > 84)
	  {
	    map->data[x + y * map->width] = MAP_ENEMY1;
	  }
	else if(r > 82)
	  {
	    map->data[x + y * map->width] = MAP_ENEMY2;
	  }
	else if(r > 81)
	  {
	    map->data[x + y * map->width] = MAP_EMPTY;
	  }
	else if(level > 2 && r > 80)
	  {
	    map->data[x + y * map->width] = MAP_BRICK;
	  }
	else if(level > 3 && r > 79)
	  {
	    map->data[x + y * map->width] = MAP_BRICK_UNBREAKABLE;
	  }
	else
	  map->data[x + y * map->width] = MAP_SAND;
      }

  map->diamonds_needed = diamonds / 2 + level * 2;
  if(map->diamonds_needed > diamonds)
    map->diamonds_needed = diamonds;

  map->start_x = 0;
  map->start_y = 0;
 
  do
    {
      map->exit_x = get_rand(map->width);
      map->exit_y = get_rand(map->height);
    } while(map->exit_x == map->start_x && map->exit_y == map->start_y);

  map->data[map->start_x + map->start_y * map->width] = MAP_PLAYER;
  map->data[map->exit_x + map->exit_y * map->width] = MAP_BRICK;

  map->time = 100 - level;
  map->ameba_time = map->time / 10;
  if(map->time < 10)
    map->time = 10;
  map->game_speed = 3;

  return map;
}

struct map * map_free(struct map * map)
{
  if(map != NULL)
    {
      if(map->data != NULL)
	free(map->data);
      if(map->processed != NULL)
	free(map->processed);
      if(map->move_directions != NULL)
	free(map->move_directions);
    }
  return NULL;
}

struct map * map_load(const char * filename)
{
  FILE * fp;
  struct map * map;

  fp = fopen(filename, "r");
  if(fp != NULL)
    {
      map = (struct map *)malloc(sizeof(struct map));
      if(map != NULL)
	{
	  int file_done;
	  int in_data, data_line;
	  enum MAP_GLYPH ascii_glyphs[0xff];
	  char start, end;

	  for(int i = 0; i < 0xff; i++)
	    ascii_glyphs[i] = MAP_BORDER;

	  map->width = -1;
	  map->height = -1;
	  map->start_x = -1;
	  map->start_y = -1;
	  map->exit_x = -1;
	  map->exit_y = -1;
	  map->diamonds_needed = -1;
	  map->diamond_score = -1;
	  map->time_score = -1;
	  map->data = NULL;
	  map->processed = NULL;
	  map->move_directions = NULL;
	  map->time = -1;
	  map->ameba_time = -1;
	  map->game_speed = -1;

	  start = '\0';
	  end = '\0';

	  file_done = 0;
	  in_data = 0;
	  data_line = 0;
	  while(!file_done)
	    {
	      char linebuf[1024];
	      
	      if(fgets(linebuf, sizeof linebuf, fp) != NULL)
		{
		  char * lf;

		  lf = strchr(linebuf, '\n');
		  if(lf != NULL)
		    *lf = '\0';
		  if(!in_data)
		    {
		      char var[128];
		      char *val;
		      int i;

		      for(i = 0; linebuf[i] != '\0' && linebuf[i] != '='; i++)
			var[i] = linebuf[i];
		      var[i] = '\0';
		      i++;
		      val = &linebuf[i];

		      if(!strcmp(var, "TIME"))
			{
			  map->time = strtoul(val, NULL, 0);
			}
		      else if(!strcmp(var, "GAME_SPEED"))
			{
			  map->game_speed = strtoul(val, NULL, 0);
			}
		      else if(!strcmp(var, "AMEBA_TIME"))
			{
			  map->ameba_time = strtoul(val, NULL, 0);
			}
		      else if(!strcmp(var, "DIAMONDS_NEEDED"))
			{
			  map->diamonds_needed = strtoul(val, NULL, 0);
			}
		      else if(!strcmp(var, "DIAMOND_SCORE"))
			{
			  map->diamond_score = strtoul(val, NULL, 0);
			}
		      else if(!strcmp(var, "TIME_SCORE"))
			{
			  map->time_score = strtoul(val, NULL, 0);
			}
		      else if(!strcmp(var, "WIDTH"))
			{
			  map->width = strtoul(val, NULL, 0);
			}
		      else if(!strcmp(var, "HEIGHT"))
			{
			  map->height = strtoul(val, NULL, 0);
			}
		      else if(!strcmp(var, "DIAMOND"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_DIAMOND;
			}
		      else if(!strcmp(var, "SAND"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_SAND;
			}
		      else if(!strcmp(var, "BOULDER"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_BOULDER;
			}
		      else if(!strcmp(var, "BRICK"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_BRICK;
			}
		      else if(!strcmp(var, "BRICK_EXPANDING"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_BRICK_EXPANDING;
			}
		      else if(!strcmp(var, "BRICK_MORPHER"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_BRICK_MORPHER;
			}
		      else if(!strcmp(var, "BRICK_UNBREAKABLE"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_BRICK_UNBREAKABLE;
			}
		      else if(!strcmp(var, "AMEBA"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_AMEBA;
			}
		      else if(!strcmp(var, "EMPTY"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_EMPTY;
			}
		      else if(!strcmp(var, "ENEMY1"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_ENEMY1;
			}
		      else if(!strcmp(var, "ENEMY2"))
			{
			  ascii_glyphs[(int) val[0]] = MAP_ENEMY2;
			}
		      else if(!strcmp(var, "START"))
			{
			  start = val[0];
			}
		      else if(!strcmp(var, "END"))
			{
			  end = val[0];
			}
		      else if(!strcmp(var, "DATA"))
			{
			  in_data = 1;
			  map->data = (char *)malloc(map->width * map->height);
			  if(map->data == NULL)
			    fprintf(stderr, "Failed to allocate memory for map '%s': %s\n", filename, strerror(errno));
			  map->processed = (char *)malloc(map->width * map->height);
			  if(map->processed == NULL)
			    fprintf(stderr, "Failed to allocate memory for map '%s': %s\n", filename, strerror(errno));
			  map->move_directions = (enum MOVE_DIRECTION *)malloc(map->width * map->height * sizeof(enum MOVE_DIRECTION));
			  if(map->move_directions == NULL)
			    fprintf(stderr, "Failed to allocate memory for map '%s': %s\n", filename, strerror(errno));
			  if(map->data == NULL || map->processed == NULL || map->move_directions == NULL)
			    {
			      map = map_free(map);
			      file_done = 1;
			    }
			}
		    }
		  else
		    {
		      if((int) strlen(linebuf) == map->width)
			{
			  if(data_line < map->height)
			    {
			      for(int i = 0; map != NULL && i < map->width; i++)
				{
				  if(linebuf[i] == start)
				    {
				      map->start_x = i;
				      map->start_y = data_line;
				    }
				  else if(linebuf[i] == end)
				    {
				      map->exit_x = i;
				      map->exit_y = data_line;
				    }
				  else
				    {
				      if(ascii_glyphs[(int) linebuf[i]] == MAP_BORDER)
					{
					  fprintf(stderr, "Failed to load map '%s', illegal character '%c' at %d, linebuf='%s'\n", filename, linebuf[i], (int) i, linebuf);
					  map = map_free(map);
					  file_done = 1;
					}
				      map->data[i + data_line * map->width] = ascii_glyphs[(int) linebuf[i]];
				    }
				}
			      data_line++;
			    }
			  else
			    {
			      fprintf(stderr, "Failed to load map '%s': too many mapdata rows.\n", filename);
			      map = map_free(map);
			      file_done = 1;
			    }
			}
		    }
		}
	      else
		{
		  file_done = 1;
		  if(feof(fp))
		    {
		      if(data_line < map->height)
			{
			  fprintf(stderr, "Failed to load map '%s': missing %d lines of mapdata\n", filename, (int) map->height - data_line);
			  map = map_free(map);
			}
		      if(map != NULL && map->data == NULL)
			{
			  fprintf(stderr, "Failed to load map '%s': missing data\n", filename);
			  map = map_free(map);
			}
		      if(map != NULL && map->width == -1)
			{
			  fprintf(stderr, "Failed to load map '%s': missing width\n", filename);
			  map = map_free(map);
			}
		      if(map != NULL && map->height == -1)
			{
			  fprintf(stderr, "Failed to load map '%s': missing height\n", filename);
			  map = map_free(map);
			}
		      if(map != NULL && map->start_x == -1)
			{
			  fprintf(stderr, "Failed to load map '%s': missing start location\n", filename);
			  map = map_free(map);
			}
		      if(map != NULL && map->exit_x == -1)
			{
			  fprintf(stderr, "Failed to load map '%s': missing end location\n", filename);
			  map = map_free(map);
			}
		      if(map != NULL && map->diamonds_needed == -1)
			{
			  fprintf(stderr, "Failed to load map '%s': missing diamonds needed\n", filename);
			  map = map_free(map);
			}
		      if(map != NULL && map->time == -1)
			{
			  fprintf(stderr, "Failed to load map '%s': missing time\n", filename);
			  map = map_free(map);
			}		      
		      if(map != NULL && map->game_speed == -1)
			{
			  map->game_speed = 3;
			  fprintf(stderr, "Warning, failed to load map '%s': missing game speed, speed set to default %d\n", filename, (int) map->game_speed);
			}		      
		      if(map != NULL && map->ameba_time == -1)
			{
			  fprintf(stderr, "Failed to load map '%s': missing ameba_time\n", filename);
			  map = map_free(map);
			}		      
		      if(map != NULL && map->diamond_score == -1)
			{
			  fprintf(stderr, "Failed to load map '%s': diamond score\n", filename);
			  map = map_free(map);
			}
		      if(map != NULL && map->time_score == -1)
			{
			  fprintf(stderr, "Failed to load map '%s': time score\n", filename);
			  map = map_free(map);
			}
		    }
		  else
		    {
		      fprintf(stderr, "Failed to read map '%s': %s\n", filename, strerror(errno));
		      map = map_free(map);
		    }
		}
	    }
	}
      else
	{
	  fprintf(stderr, "Failed to allocate space for map: %s\n", strerror(errno));
	}

      fclose(fp);
    }
  else
    {
      fprintf(stderr, "Failed to open map '%s': %s\n", filename, strerror(errno));
      map = NULL;
    }

  if(map != NULL)
    {
      for(int y = 0; y < map->height; y++)
	for(int x = 0; x < map->width; x++)
	  map->move_directions[x + y * map->width] = MOVE_NONE;

      map->data[map->start_x + map->start_y * map->width] = MAP_PLAYER;
      map->data[map->exit_x + map->exit_y * map->width] = MAP_BRICK;
    }
  
  return map;
}

void map_save(struct map * map, const char * filename)
{
  FILE * fp;

  fp = fopen(filename, "w");
  if(fp != NULL)
    {
      char glyphs[0xff];
      char start, end;

      for(int i = 0; i < 0xff; i++)
	glyphs[i] = '-';

      glyphs[MAP_DIAMOND] = '!';
      glyphs[MAP_SAND] = '%';
      glyphs[MAP_BOULDER] = '*';
      glyphs[MAP_BRICK] = '#';
      glyphs[MAP_BRICK_EXPANDING] = 'z';
      glyphs[MAP_BRICK_MORPHER] = 'x';
      glyphs[MAP_BRICK_UNBREAKABLE] = 'Z';
      glyphs[MAP_AMEBA] = 'a';
      glyphs[MAP_EMPTY] = '.';
      glyphs[MAP_ENEMY1] = '1';
      glyphs[MAP_ENEMY2] = '2';
      start = 'S';
      end = 'E';
      

      fprintf(fp, "# Diamond Girl map v1.0\n");
      fprintf(fp, "TIME=%d\n", (int) map->time);
      fprintf(fp, "GAME_SPEED=%d\n", (int) map->game_speed);
      fprintf(fp, "AMEBA_TIME=%d\n", (int) map->ameba_time);
      fprintf(fp, "DIAMOND_SCORE=%d\n", (int) map->diamond_score);
      fprintf(fp, "TIME_SCORE=%d\n", (int) map->time_score);
      fprintf(fp, "DIAMONDS_NEEDED=%d\n", (int) map->diamonds_needed);
      fprintf(fp, "WIDTH=%d\n", (int) map->width);
      fprintf(fp, "HEIGHT=%d\n", (int) map->height);
      fprintf(fp, "\n");
      fprintf(fp, "DIAMOND=%c\n", glyphs[MAP_DIAMOND]);
      fprintf(fp, "SAND=%c\n", glyphs[MAP_SAND]);
      fprintf(fp, "BOULDER=%c\n", glyphs[MAP_BOULDER]);
      fprintf(fp, "BRICK=%c\n", glyphs[MAP_BRICK]);
      fprintf(fp, "BRICK_EXPANDING=%c\n", glyphs[MAP_BRICK_EXPANDING]);
      fprintf(fp, "BRICK_MORPHER=%c\n", glyphs[MAP_BRICK_MORPHER]);
      fprintf(fp, "BRICK_UNBREAKABLE=%c\n", glyphs[MAP_BRICK_UNBREAKABLE]);
      fprintf(fp, "AMEBA=%c\n", glyphs[MAP_AMEBA]);
      fprintf(fp, "EMPTY=%c\n", glyphs[MAP_EMPTY]);
      fprintf(fp, "ENEMY1=%c\n", glyphs[MAP_ENEMY1]);
      fprintf(fp, "ENEMY2=%c\n", glyphs[MAP_ENEMY2]);
      fprintf(fp, "START=%c\n", start);
      fprintf(fp, "END=%c\n", end);
      fprintf(fp, "\n");
      fprintf(fp, "DATA=\n");
      for(int y = 0; y < map->height; y++)
	{
	  for(int x = 0; x < map->width; x++)
	    {
	      int c;

	      if(map->start_x == x && map->start_y == y)
		c = start;
	      else if(map->exit_x == x && map->exit_y == y)
		c = end;
	      else
		c = glyphs[(int) map->data[x + y * map->width]];
	      fprintf(fp, "%c", c);
	    }
	  fprintf(fp, "\n");
	}
      
      fclose(fp);
    }
  else
    fprintf(stderr, "Failed to open '%s' for writing: %s\n", filename, strerror(errno));
}
