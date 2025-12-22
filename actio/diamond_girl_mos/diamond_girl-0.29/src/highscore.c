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

#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include "diamond_girl.h"

static struct highscore_entry ** highscores;
static size_t                    highscores_size;


static void highscore_add(time_t timestamp, int score, int level);

void highscores_load(int do_load, const char * map_set)
{
  highscores = NULL;
  highscores_size = 0;

  if(do_load)
    {
      FILE * fp;
      char fn[256];

      if(map_set == NULL)
	snprintf(fn, sizeof fn, "highscores");
      else
	snprintf(fn, sizeof fn, "highscores-%s", map_set);

      fp = fopen(get_save_filename(fn), "rb");
      if(fp != NULL)
	{
	  int done;

	  done = 0;
	  while(!done)
	    {
	      struct highscore_entry tmp;
	      int ok;

	      ok = fread(&tmp.timestamp, sizeof tmp.timestamp, 1, fp);
	      if(ok)
		ok = fread(&tmp.score, sizeof tmp.score, 1, fp);
	      if(ok)
		ok = fread(&tmp.level, sizeof tmp.level, 1, fp);

	      if(ok)
		{
		  highscore_add(tmp.timestamp, tmp.score, tmp.level);
		}
	      else
		{
		  if(!feof(fp))
		    fprintf(stderr, "Failed to read highscores from %s: %s\n", get_save_filename(fn), strerror(errno));
		  done = 1;
		}
	    }
	  fclose(fp);
	}
      else
	fprintf(stderr, "Failed to read highscores from %s: %s\n", get_save_filename(fn), strerror(errno));
    }
}

void highscores_save(int do_save, const char * map_set)
{
  if(do_save)
    {
      FILE * fp;
      char fn[256];

      if(map_set == NULL)
	snprintf(fn, sizeof fn, "highscores");
      else
	snprintf(fn, sizeof fn, "highscores-%s", map_set);
  
      fp = fopen(get_save_filename(fn), "wb");
      if(fp != NULL)
	{
	  int ok;
	  size_t i;
      
	  for(i = 0, ok = 1; i < highscores_size && ok; i++)
	    if(highscores[i] != NULL)
	      {
		ok = fwrite(&highscores[i]->timestamp, sizeof highscores[i]->timestamp, 1, fp);
		if(ok)
		  ok = fwrite(&highscores[i]->score, sizeof highscores[i]->score, 1, fp);
		if(ok)
		  ok = fwrite(&highscores[i]->level, sizeof highscores[i]->level, 1, fp);
	    
		if(!ok)
		  fprintf(stderr, "Failed to write highscores: %s\n", strerror(errno));
	      }

	  if(fclose(fp) != 0)
	    fprintf(stderr, "Failed to write highscores: %s\n", strerror(errno));
	}
      else
	fprintf(stderr, "Failed to write highscores: %s\n", strerror(errno));
    }


  for(size_t i = 0; i < highscores_size; i++)
    if(highscores[i] != NULL)
      free(highscores[i]);

  if(highscores != NULL)
    free(highscores);
  highscores = NULL;
  highscores_size = 0;
}

void highscore_new(int score, int level)
{
  highscore_add(time(NULL), score, level);
}

static void highscore_add(time_t timestamp, int score, int level)
{
  if(highscores_size < 999)
    {
      struct highscore_entry ** tmp;

      tmp = (struct highscore_entry **)realloc(highscores, sizeof(struct highscore_entry *) * (highscores_size + 1));
      if(tmp != NULL)
	{
	  size_t i;
	  
	  i = highscores_size;
	  highscores = tmp;
	  highscores_size++;
	  highscores[i] = (struct highscore_entry *)malloc(sizeof(struct highscore_entry));
	  if(highscores[i] != NULL)
	    {
	      size_t j, pos;
	      
	      highscores[i]->timestamp = timestamp;
	      highscores[i]->score = score;
	      highscores[i]->level = level;
	      
	      /* put it in right position */
	      for(pos = i, j = 0; j < highscores_size; j++)
		if(highscores[j]->score < highscores[i]->score)
		  {
		    pos = j;
		    break;
		  }
	      
	      if(pos != i)
		{
		  struct highscore_entry * tmp;
		  
		  tmp = highscores[i];
		  for(j = highscores_size - 1; j > pos; j--)
		    highscores[j] = highscores[j - 1];
		  highscores[pos] = tmp;
		}
	    }
	  else
	    fprintf(stderr, "Failed to allocate memory for a new highscore entry: %s\n", strerror(errno));
	}
      else
	fprintf(stderr, "Failed to allocate memory for a new highscore entry: %s\n", strerror(errno));
    }
  else
    {
      size_t j, pos;

      for(pos = highscores_size, j = 0; j < highscores_size; j++)
	if(highscores[j]->score < score)
	  {
	    pos = j;
	    break;
	  }
      
      if(pos < highscores_size)
	{
	  for(j = highscores_size - 1; j > pos; j--)
	    highscores[j] = highscores[j - 1];
	  highscores[pos]->timestamp = timestamp;
	  highscores[pos]->score = score;
	  highscores[pos]->level = level;
	}
    }
}


struct highscore_entry ** highscores_get(size_t * size_ptr)
{
  if(size_ptr != NULL)
    *size_ptr = highscores_size;
  return highscores;
}
