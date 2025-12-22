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
#include <stdio.h>
#include "SDL.h"
#include "gui.h"
#include "menu.h"
#include "main.h"
#include "output.h"
#include "game_output.h"
#include "map.h"

void menu_start(menu *m);

void menu_finish(void *v)
{
  menu *m = (menu *)v;
  
  gui_clear();
  
  m->finished = 1;
}

void menu_quit(void *v)
{
  root_quit();
}

void menu_reset(void *v)
{
  gui_clear();

  menu_start((menu *)v);
}

void menu_std_buttons(menu *m)
{
  gui_add_button(.1, .95, .2, .1, "Quit", menu_quit, NULL);
  gui_add_button(.9, .95, .2, .1, "Reset", menu_reset, m);
}

void menu_humans_click(void *v)
{
  menu *m = (menu *)v;
  m->ps.local_player_count++;
  m->ps.local_player_count %= (m->ps.map->max_player+1);

  if(m->ps.local_ai_count + m->ps.local_player_count > m->ps.map->max_player)
    m->ps.local_ai_count = m->ps.map->max_player-m->ps.local_player_count;
}

void menu_computers_click(void *v)
{
  menu *m = (menu *)v;
  m->ps.local_ai_count++;
  m->ps.local_ai_count %= (m->ps.map->max_player+1);

  if(m->ps.local_ai_count + m->ps.local_player_count > m->ps.map->max_player)
    m->ps.local_player_count = m->ps.map->max_player-m->ps.local_ai_count;
}

void menu_ask_players(menu *m)
{
  static char buff[50], buff2[50];
  
  sprintf(&buff[0], "Humans");
  sprintf(&buff2[0], "Computers");

  gui_add_text(.33, .4, &buff[0]);
  gui_add_number(.33, .5, &m->ps.local_player_count, menu_humans_click, (void *)m);

  if(m->ps.type == BATTLE) {
    gui_add_text(.67, .4, &buff2[0]);
    gui_add_number(.67, .5, &m->ps.local_ai_count, menu_computers_click, (void *)m);
  }
}  

void menu_choose_map_callback(void *v, map *mp)
{
  menu *m = (menu *)v;
  
  m->ps.map = mp;

  if(m->last_state != NULL) {
    gui_clear();
    m->last_state(m);
  }
}

int cols_from_rows(int count, int rows)
{
  return (count+rows-1)/rows;
}

float fw_from_rows(int count, int rows)
{
  int cols = cols_from_rows(count, rows);
  float fw;
  
  fw = (1/(float)cols);
  
  if(fw > .7/rows)
    fw = .7/rows;
  
  return fw;
}

void menu_choose_map(void *v, map *junk)
{
  menu *m = (menu *)v;
  int i;
  map_entry *me;
  float fw, bestfw=0;
  int rows, bestrows=2, cols;
  int row, col;
  
  gui_clear();

  menu_std_buttons(m);

  gui_add_text(.5, .1, "Select map.");
  
  if(map_count(m->ps.type)==0)
    return;

  /* search for best row number */
  
  for(rows=1; rows<10; rows++) {
    cols = cols_from_rows(map_count(m->ps.type), rows);
    fw = fw_from_rows(map_count(m->ps.type), rows);
    
    if(fw > bestfw) {
      bestfw = fw;
      bestrows = rows;
    }
  }
  
  rows = bestrows;
  cols = cols_from_rows(map_count(m->ps.type), rows);
  fw   = bestfw;
  
  /* draw it out */

  me = first_map(m->ps.type);
  
  row = 0;
  col = 0;
  
  for(i=0; i<map_count(m->ps.type); i++, col++) {
    if(i >= cols*(row+1)) {
      col = 0;
      row++;
    }
    gui_add_map(fw*col + fw/2 + (1-fw*cols)/2, .2 + fw*row + fw/2, fw, &me->map, menu_choose_map_callback, (void *)m);
    me = me->next;
  }
}

void menu_map_preview(menu *m)
{
  gui_add_map(.8, .2, .3, m->ps.map, menu_choose_map, (void *)m);
}

void menu_local_battle(void *v)
{
  menu *m = (menu *)v;
  
  printf("Starting local game menu.\n");
  
  gui_clear();
  
  m->ps.client = 0;
  m->ps.server = 0;
  m->ps.type = BATTLE;
  if(m->ps.map->type != BATTLE)
    m->ps.map = &first_map(BATTLE)->map;
  
  menu_ask_players(m);
  gui_add_checkbox(.5, .25, &m->ps.teams, "Use teams", NULL, NULL);
  
  menu_std_buttons(m);
  menu_map_preview(m);
  
  gui_add_button(.5, .8, .2, .1, "Start", menu_finish, m);
  
  m->last_state = menu_local_battle;
}

void menu_local_puzzle(void *v)
{
  menu *m = (menu *)v;
  
  printf("Starting local puzzle menu.\n");
  
  gui_clear();
  
  m->ps.client = 0;
  m->ps.server = 0;
  m->ps.type = PUZZLE;
  if(m->ps.map->type != PUZZLE)
    m->ps.map = &first_map(PUZZLE)->map;

  m->ps.local_player_count = 1;
  m->ps.local_ai_count = 0;

  menu_ask_players(m);
  
  menu_std_buttons(m);
  menu_map_preview(m);
  
  gui_add_button(.5, .8, .2, .1, "Start", menu_finish, m);
  
  m->last_state = menu_local_puzzle;
}

void menu_server(void *v)
{
  menu *m = (menu *)v;
  
  gui_clear();
  
  m->ps.server = 1;
  m->ps.client = 0;

  gui_add_text(.1, .05, "Server");

  menu_ask_players(m);
  gui_add_checkbox(.5, .25, &m->ps.teams, "Use teams", NULL, NULL);

  menu_std_buttons(m);
  menu_map_preview(m);

  gui_add_button(.5, .8, .2, .1, "Start", menu_finish, m);
  
  m->last_state = menu_server;
}

void menu_client(void *v)
{
  menu *m = (menu *)v;
  
  gui_clear();
  
  m->ps.client = 1;
  m->ps.server = 0;
  m->ps.local_ai_count = 0;
  
  gui_add_text(.1, .05, "Client");
  
  menu_ask_players(m);
  menu_std_buttons(m);
  
  gui_add_button(.5, .8, .2, .1, "Start", menu_finish, m);
  
  m->last_state = menu_client;
}

void menu_start(menu *m)
{
  static char buff3[100], buff4[20];
  
  printf("Starting menu.\n");
  
  m->finished = 0;
  
  gui_add_text(.5, .1, "Mures");
  
  sprintf(&buff4[0], "v%s", VERSION);
  
  gui_add_text(.5, .9, &buff4[0]);
  
  if(m->ps.client) {
    sprintf(&buff3[0], "Client to %s", m->ps.host);
    gui_add_text(.5, .6, &buff3[0]);
  }
  
  gui_add_button(.5, .3, .5, .1, "Local battle", menu_local_battle, m);
  gui_add_button(.5, .4, .5, .1, "Local puzzle", menu_local_puzzle, m);
  if(m->ps.client)
    gui_add_button(.5, .5, .5, .1, "Client", menu_client, m);
  gui_add_button(.5, .7, .5, .1, "Server", menu_server, m);

  menu_std_buttons(m);
}

