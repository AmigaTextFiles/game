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

#include "SDL_net.h"
#include "protocol.h"
#include "sim.h"
#include "main.h"
#include "game.h"

int sim_winner(sim *s)
{
  int i,max,winner;

  if(s->type == BATTLE) {
    
    winner=-1;
    max=-1;
    
    for(i=0; i<MAX_PLAYER; i++) {
      if(s->player[i].score == max) /* tie */
	winner = -1;
      else if(s->player[i].score > max) {
	max = s->player[i].score;
	winner = i;
      }
    }
    
    return winner;
  }
  else if(s->type == PUZZLE) {
    if(s->player[0].score < map_creature_count(&s->map, mouse))
      return -1;
    else
      return 0;
  }
  else {
    fprintf(stderr, "Asking for winner in unknown sim type (lib.c).\n");
    return 0;
  }
  
}

int player_rank(game *g, int p)
{
  int rank[MAX_PLAYER];
  int max_score;
  int max_player;
  int i, j;
  
  for(i=0; i<MAX_PLAYER; i++)
    if(g->sim.player[i].exists && g->sim.player[i].team_leader == i)
      rank[i] = -1;
  
  for(j=1; j<=MAX_PLAYER; j++) {
    max_score=-1;
    max_player=-1;
    for(i=0; i<MAX_PLAYER; i++)
      if(g->sim.player[i].exists && g->sim.player[i].team_leader == i)
	if(rank[i] == -1 && g->sim.player[i].score > max_score) {
	  max_score = g->sim.player[i].score;
	  max_player = i;
	}
    
    if(max_player != -1)
      rank[max_player] = j;

    for(i=0; i<MAX_PLAYER; i++)
      if(g->sim.player[i].exists && g->sim.player[i].team_leader == i)
	if(rank[i] == -1 && g->sim.player[i].score == max_score)
	  rank[i] = j;
  }

  return rank[p];
}
  

char dir_to_char(direction dir)
{
  switch(dir) {
  case UP: return 'U'; break;
  case DOWN: return 'D'; break;
  case LEFT: return 'L'; break;
  case RIGHT: return 'R'; break;
  default: return '?'; break;
  }
}

direction char_to_dir(char dir)
{
  switch(dir) {
  case 'U': return UP; break;
  case 'D': return DOWN; break;
  case 'L': return LEFT; break;
  case 'R': return RIGHT; break;
  default: return MAX_DIR; break;
  }
}

char *game_type_to_s(Uint8 type)
{
  switch(type) {
  case BATTLE: return "Battle"; break;
  case PUZZLE: return "Puzzle"; break;
  default: return "Unknown"; break;
  }
}

int max2(int a, int b)
{
  return a>b?a:b;
}

int min2(int a, int b)
{
  return a<b?a:b;
}

float abs2(float x)
{
  return x>0? x : -x;
}

