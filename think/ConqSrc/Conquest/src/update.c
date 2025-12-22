/* Update.c: Routines for updating */
#include <stdio.h>
#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

void update_board(int x, int y, toption option)
{
  int screen_x, screen_y;

  if (terminal_type != hardcopy) 
  {
    screen_x = 3*x + 1;
    screen_y = 16 - y;
    switch (option)
    {
     case left:
      point(screen_x,screen_y);
      putchar(board[x][y].enemy);
      break;
      
     case right:
      point(screen_x+2,screen_y);
      putchar(board[x][y].tf);
      break;
      
     case both:
      point(screen_x, screen_y);
      printf("%c%c%c", board[x][y].enemy,board[x][y].star, board[x][y].tf);
      break;
    }
  }
}

void up_year()
{
  point(39,18);
  turn++;
  if (terminal_type == hardcopy)
    printf("Year ");
  printf("%3d", turn);

  point(48,19);
  production_year++;
  if (terminal_type == hardcopy)
    printf("Production year ");
  printf("%d", production_year);
}

/* Remove empty taskforces */
void zero_tf(tteam tm, int tf_num)
{
  int x, y, i;

  if (tf[tm][tf_num].dest != 0) 
  {
    x = tf[tm][tf_num].x;  
    y = tf[tm][tf_num].y;
    if ((tf[tm][tf_num].s+tf[tm][tf_num].t+
	 tf[tm][tf_num].c+tf[tm][tf_num].b) == 0)
    {
      if (tf[tm][tf_num].eta == 0) 
	tf_stars[tf[tm][tf_num].dest][tm]--;

      tf[tm][tf_num].dest=0;

      if (tm==player)
      {
	board[x][y].tf=' ';

	for(i=1; i<=26; i++) 
	{
	  if ((tf[player][i].dest !=0) &&
	      (tf[player][i].x == x) && (tf[player][i].y == y))
	  {
	    if (board[x][y].tf == ' ')
	      board[x][y].tf = i + 'a' - 1;
	    else if (board[x][y].tf != i + 'a' - 1)
	      board[x][y].tf = '*';
	  }
	}
	update_board(x,y,right);
      }
    }
  }
}

void check_game_over()
{
  boolean dead[2];
  boolean quit_game;
  int total[2], transports[2], inhabs[2];
  tteam team; 
  int tfnum, starnum; 
  struct stplanet *pplan;
  
  quit_game = game_over;
  for (team = ENEMY; team <= player; team++) 
  {
    transports[team] = 0;
    inhabs[team] = 0;
    for (tfnum = 1 ; tfnum<=26; tfnum++)
    {
      if (tf[team][tfnum].dest != 0)
	transports[team] += tf[team][tfnum].t;
    }
  }
  for (starnum = 1 ; starnum<=nstars; starnum++)
  {
    pplan = stars[starnum].first_planet;
    while (pplan != nil)
    {
      switch (pplan->team)
      {
       case player: 
	inhabs[player] += pplan->iu;
	break;
       case ENEMY: 
	inhabs[ENEMY] += pplan->iu;
	break;
      }
      pplan = pplan->next;
    }
  }

  for (team = ENEMY ; team<=player; team++)
  {
    total[team] = inhabs[team] + transports[team];
    dead[team] = (total[team]==0);
  }
  if ((!dead[player]) && (!dead[ENEMY]) && (turn >= 40)) 
  {
    dead[ENEMY] = total[player] / total[ENEMY] >= 8;
    dead[player] = total[ENEMY] / total[player] >= 8;
  }

  game_over = (dead[player] || dead[ENEMY] || (turn>100) || quit_game);
  if (game_over) 
  {
    clear_screen();
    printf("*** Game over ***\n");
    printf("Player: Population in transports:%3d", transports[player]);
    printf("  IU's on colonies: %3d  TOTAL: %3d\n", inhabs[player], total[player]);
    putchar('\n');
    printf("Enemy:  Population in transports:%3d", transports[ENEMY]);
    printf("  IU's on colonies: %3d  TOTAL: %3d\n", inhabs[ENEMY], total[ENEMY]);
    if ((total[ENEMY] > total[player]) || quit_game)
      printf("**** THE ENEMY HAS CONQUERED THE GALAXY ***\n");
    else if ((total[player] > total[ENEMY]))
      printf("*** PLAYER WINS- YOU HAVE SAVED THE GALAXY! ***\n");
    else
      printf("*** DRAWN ***\n");
    get_char();
  }
}

void revolt(int starnum)
{
  tplanet *pplan;
  
  if (col_stars[starnum][ENEMY]+col_stars[starnum][player] == 0)
    return;
  
  for (pplan = stars[starnum].first_planet; pplan; pplan = pplan->next)
  {
    if ((pplan->conquered) && (!any_bc(pplan->team, starnum)))
    {
      col_stars[starnum][pplan->team]--;
      col_stars[starnum][OTHER_PLAYER(pplan->team)]++;
      pplan->team = OTHER_PLAYER(pplan->team);
      pplan->conquered = false;
      pplan->psee_capacity = pplan->capacity;
      on_board(stars[starnum].x,stars[starnum].y);
    }
  }
}

void invest()
{
  int newborn,starnum; 
  struct stplanet  *pplan;

  production_year = 0;
  point(33,20);
  printf("* investment *  ");
 
  for (starnum = 1; starnum<=nstars; starnum++)
  {
    for (pplan = stars[starnum].first_planet; pplan; pplan=pplan->next)
    {
      if ((pplan->esee_team == player) &&
	  (pplan->capacity > 10) &&
	  (pplan->esee_def < 12))
	pplan->esee_def++;

      if ((pplan->team) != none) 
      {
	newborn = round((pplan->inhabitants) * growth_rate[pplan->team] *
			(1-((pplan->inhabitants)/(pplan->capacity))));
	if (pplan->conquered)
	  newborn = newborn / 2;

	pplan->inhabitants= (pplan->inhabitants) + newborn;
	pplan->iu = pplan->iu + newborn;

	if (pplan->team==ENEMY)
	  inv_enemy(stars[starnum].x, stars[starnum].y,pplan);
	else
	  inv_player(stars[starnum].x, stars[starnum].y,pplan);
      }
    }
  }
  battle();
}
