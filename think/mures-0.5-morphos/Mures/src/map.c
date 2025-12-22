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

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "protocol.h"
#include "sim.h"
#include "lib.h"
#include "map.h"
#include "main.h"
#include "lua.h"

#define MIN_VERSION 1.1
#define MAX_VERSION 1.1

#define TOL .00001

map_entry *first_battle;
map_entry *first_puzzle;

void clear_map(map *m)
{
  int i, j;

  m->type = -1;
  m->max_player = 0;
  m->max_generator = 0;
  m->max_creature = 0;

  for(i=0; i<MAX_DIR; i++)
    m->max_arrow[i] = 0;

  for(i=0; i<NUM_BLOCKS_X; i++)
    for(j=0; j<NUM_BLOCKS_Y; j++) {
      m->hwall[i][j] = m->vwall[i][j] = 0;
  
      m->hole[i][j] = 0;
      
      m->rocket[i][j] = -1;
    }
}

void map_add_creature(map *m, creature_type type, direction dir, grid_int x, grid_int y)
{

  if(m->max_creature >= MAX_CREATURE) {
    fprintf(stderr, "Too many creatures for map!\n");
    return;
  }

  m->creature[m->max_creature].type = type;
  m->creature[m->max_creature].dir = dir;
  m->creature[m->max_creature].pos.x = x;
  m->creature[m->max_creature].pos.y = y;

  m->max_creature++;
}

int map_creature_count(map *m, creature_type type)
{
  int count=0;
  int i;
  
  for(i=0; i<m->max_creature; i++)
    if(m->creature[i].type == type)
      count++;
  
  return count;
}

int map_load(map *m, char *filename)
{
  char buff[MAX_STRING], temp;
  char buff2[MAX_STRING], buff3[MAX_STRING];
  char *line;
  int p,i;
  int got_version = 0, got_type = 0;
  int data_mode = 0;
  int data_line = 0;
  float version;
  FILE *in = fopen(filename, "r");
  int n;
  char c;
  int count;

  printf("Loading map %s...\n", filename);

  if(in==NULL) {
    fprintf(stderr, "Error reading file \"%s\".\n", filename);
    return 0;
  }

  clear_map(m);
  
  p=0;

  while(!feof(in)) { /* for each line */

    /* put line into buff */
    i=0;
    while(1) {
      if(feof(in) || i==MAX_STRING)
	break;

      fscanf(in, "%c", &temp);

      if(temp == '\n')
	break;

      buff[i++] = temp;
    }

    /* trim trailing whitespace */
    while(i>0 && buff[i-1]==' ')
      i--;
    buff[i]=0;
    
    line = &buff[0];
    
    if((*line==0 && !data_mode) || *line=='#')
      continue;
    
    strcpy(&buff2[0], line);

    if(!data_mode) {
      i=0;
      while(buff2[i]!=' ' && buff2[i]!=0)
	i++;

      if(buff2[i]==0) /* no space in line */
	buff3[0] = 0;
      else {
	buff2[i] = 0;
	strcpy(&buff3[0], &buff2[i+1]);
      }

      i=0;
      while(buff2[i]) {
	if(buff2[i]>='A' && buff2[i]<='Z')
	  buff2[i] = buff2[i] - 'A' + 'a';
	i++;
      }
      
      if(!strcmp(buff2, "version")) {
	got_version = 1;
	sscanf(buff3, "%f", &version);
	if(version < MIN_VERSION - TOL) {
	  fprintf(stderr, "Map version %.2f not supported.\n", version);
	  return 0;
	}
	if(version > MAX_VERSION + TOL) {
	  fprintf(stderr, "Map version %.2f not supported.\n", version);
	  return 0;
	}
      }

      if(!strcmp(buff2, "up")) {
	sscanf(buff3, "%d", &count);
	if(count >= 0 && count <= MAX_ARROW)
	  m->max_arrow[UP] = count;
      }
      
      if(!strcmp(buff2, "down")) {
	sscanf(buff3, "%d", &count);
	if(count >= 0 && count <= MAX_ARROW)
	  m->max_arrow[DOWN] = count;
      }
      
      if(!strcmp(buff2, "left")) {
	sscanf(buff3, "%d", &count);
	if(count >= 0 && count <= MAX_ARROW)
	  m->max_arrow[LEFT] = count;
      }
      
      if(!strcmp(buff2, "right")) {
	sscanf(buff3, "%d", &count);
	if(count >= 0 && count <= MAX_ARROW)
	  m->max_arrow[RIGHT] = count;
      }
      
      if(!strcmp(buff2, "type")) {
	got_type = 1;
	i=0;
	while(buff3[i]) {
	  if(buff3[i]>='A' && buff3[i]<='Z')
	    buff3[i] = buff3[i] - 'A' + 'a';
	  i++;
	}
	if(!strcmp(buff3, "battle"))
	  m->type = BATTLE;
	else if(!strcmp(buff3, "puzzle"))
	  m->type = PUZZLE;
	else {
	  fprintf(stderr, "Unsupported map type: %s\n", buff3);
	  return 0;
	}
      }
      
      if(!strcmp(buff2, "data")) {
	if(got_version)
	  data_mode = 1;
	else {
	  fprintf(stderr, "Data started without valid version.\n");
	  return 0;
	}
      }
    }
    else {
      if(data_line%2==0) { /* lines of horizontal walls */
	if(data_line/2 > NUM_BLOCKS_Y)
	  fprintf(stderr, "Too many data lines in file.\n");
	else
	  if(data_line/2 < NUM_BLOCKS_Y)
	    for(i=0; i<NUM_BLOCKS_X; i++)
	      if(buff2[i*2+1]=='-')
		m->hwall[i][data_line/2] = 1;
      }
      else { /* lines of vertical walls, holes, more */
	if((data_line-1)/2 > NUM_BLOCKS_Y)
	  fprintf(stderr, "Too many data lines in file.\n");
	else {
	  /* check vwalls */
	  for(i=0; i<NUM_BLOCKS_X; i++) {
	    if(buff2[i*2]=='|')
	      m->vwall[i][(data_line-1)/2] = 1;
	  }
	    

	  for(i=0; i<NUM_BLOCKS_X; i++) {
	    c = buff2[i*2+1];
	    n = c-'1';
	    if(n >= 0 && n < MAX_PLAYER) {
	      if(n+1 > m->max_player)
		m->max_player = n+1;
	      m->rocket[i][(data_line-1)/2] = n;
	    }
	    else if(c == 'O' || c == 'o')
	      m->hole[i][(data_line-1)/2] = 1;
	    else if(char_to_dir(c) < MAX_DIR) {
	      if(m->max_generator < MAX_GENERATOR) {
		m->generator[m->max_generator].pos = grid_int_pos(i, (data_line-1)/2);
		m->generator[m->max_generator].dir = char_to_dir(c);
		m->max_generator++;
	      }
	    }
	    else if(c == 'l' || c == 'L')
	      map_add_creature(m, mouse, RIGHT, i, (data_line-1)/2);
	    else if(c == 'k' || c == 'K')
	      map_add_creature(m, mouse, DOWN, i, (data_line-1)/2);
	    else if(c == 'j' || c == 'J')
	      map_add_creature(m, mouse, LEFT, i, (data_line-1)/2);
	    else if(c == 'i' || c == 'I')
	      map_add_creature(m, mouse, UP, i, (data_line-1)/2);

	    else if(c == 'd' || c == 'D')
	      map_add_creature(m, cat, RIGHT, i, (data_line-1)/2);
	    else if(c == 's' || c == 'S')
	      map_add_creature(m, cat, DOWN, i, (data_line-1)/2);
	    else if(c == 'a' || c == 'A')
	      map_add_creature(m, cat, LEFT, i, (data_line-1)/2);
	    else if(c == 'w' || c == 'W')
	      map_add_creature(m, cat, UP, i, (data_line-1)/2);
	  }
	}
      }

      data_line++;
    }
  }
  
  fclose(in);

  if(m->type == PUZZLE)
    m->max_player = MAX_PLAYER;
  
  if(!data_mode) {
    fprintf(stderr, "Map contains no data.\n");
    return 0;
  }

  /* for safety */

  return 1;
}

map_entry *first_map(int map_type)
{
  switch(map_type) {
  case BATTLE: return first_battle; break;
  case PUZZLE: return first_puzzle; break;
  default: fprintf(stderr, "No first map of type %d\n", map_type); return 0;
  }
}

void set_first_map(int map_type, map_entry *me)
{
  switch(map_type) {
  case BATTLE: first_battle = me; break;
  case PUZZLE: first_puzzle = me; break;
  default: fprintf(stderr, "No first map of type %d\n", map_type); break;
  }
}  

int map_count(int map_type)
{
  int count = 0;
  map_entry *me = first_map(map_type);

  while(me != NULL) {
    me = me->next;
    count++;
  }

  return count;
}

int map_save(map *m, char *location)
{
  int x,y,i,done;
  FILE *out = fopen(location, "w");
  if(out==NULL) {
    fprintf(stderr, "Error writing file \"%s\".\n", location);
    return 0;
  }

  fprintf(out, "# Mures map\n");
  fprintf(out, "Version %.2f\n", MAX_VERSION);
  fprintf(out, "Type %s\n", game_type_to_s(m->type));
  fprintf(out, "Data\n");

  for(y=0; y<NUM_BLOCKS_Y+1; y++) {
    for(x=0; x<NUM_BLOCKS_X+1; x++) {
      fprintf(out, "+");
      if(x < NUM_BLOCKS_X)
	fprintf(out, m->hwall[x][y%NUM_BLOCKS_Y] ? "-" : " ");
    }
    fprintf(out, "\n");
    
    if(y < NUM_BLOCKS_Y) {
      for(x=0; x < NUM_BLOCKS_X+1; x++) {
	fprintf(out, m->vwall[x%NUM_BLOCKS_X][y]?"|":" ");
	if(x<NUM_BLOCKS_X) {
	  
	  done = 0;
	  
	  if(m->rocket[x][y] >= 0) {
	    fprintf(out, "%d", m->rocket[x][y]+1);
	    done = 1;
	  }
	  else
	    for(i=0; i<m->max_generator; i++)
	      if(m->generator[i].pos.x == x && m->generator[i].pos.y == y) {
		fprintf(out, "%c", dir_to_char(m->generator[i].dir));
		done = 1;
	      }
	  
	  if(!done)
	    fprintf(out, m->hole[x][y]?"O":" ");
	}
      }
      fprintf(out, "\n");
    }
  }

  fclose(out);

  return 1;
}

static int lua_load_map(lua_State *L)
{
  map_entry *temp;
  char *fn;

  if(lua_gettop(L) != 1)
    lua_error(L, "Wrong number of arguments to loadmap (should be 1)");

  if(!lua_isstring(L, 1))
    lua_error(L, "Bad first argument to loadmap (should be string)");

  fn = (char *)lua_tostring(L, 1);

  temp = (map_entry *) malloc(sizeof(map_entry));
  
  if(map_load(&temp->map, fn)) {
    temp->next = first_map(temp->map.type);
    set_first_map(temp->map.type, temp);
  }
  else {
    fprintf(stderr, "Map load failed.\n");
    free(temp);
  }
  
  return 0;
}
  
int map_init()
{
  lua_register(L, "loadmap", lua_load_map);

  first_battle = first_puzzle = NULL;
  
  /* load maps */

  if(lua_dofile(L, "load_maps.lua") != 0) {
    fprintf(stderr, "Couldn't execute map loading script \"load_maps.lua\".\n");
    return 0;
  }

  return 1;
}

void free_map_entry(map_entry *me)
{
  if(me == NULL)
    return;

  free_map_entry(me->next);
  
  free(me);
}

void map_exit()
{
  printf("Freeing maps.\n");

  free_map_entry(first_battle);
  free_map_entry(first_puzzle);
}
