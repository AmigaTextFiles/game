/* Movement.c: Routines for moving fleets around */
#include <stdio.h>
#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

boolean lose(int *ships, int typ, float percent)
{
  int i,sleft;
  boolean any_losses = FALSE;

  sleft = *ships;
  for (i = 1; i<=*ships; i++) 
  {
    if (rnd(100)/100.0 > percent)
    {
      any_losses = TRUE;
      sleft = sleft - 1;
    }
  }
  if (sleft < *ships) 
  {
    printf(" %2d%c", *ships-sleft, typ);
    *ships = sleft;
  }

  return(any_losses);
}

void fleet_explore(int fleet)
{
  int loss;
  float prob;

  left_line[20] = true;
  clear_left();
  point(1,19);
  printf("Task force %c exploring %c.\n", '`'+fleet, 
	 tf[PLAYER][fleet].dest + '@');

  if (tf[PLAYER][fleet].t != 0)
    prob = (t_e_prob + rnd(t_e_var) * tf[PLAYER][fleet].t) / 100.0;
  if (tf[PLAYER][fleet].s != 0)
    prob = (s_e_prob + rnd(s_e_var) * tf[PLAYER][fleet].s) / 100.0;
  if (tf[PLAYER][fleet].c != 0)
    prob = (c_e_prob + rnd(c_e_var) * tf[PLAYER][fleet].c) / 100.0;
  if (tf[PLAYER][fleet].b != 0)
    prob = (b_e_prob + rnd(b_e_var) * tf[PLAYER][fleet].b) / 100.0;
  if (prob > 100) prob=100;

  loss = FALSE;
  loss |= lose(&tf[PLAYER][fleet].t, 't', prob);
  loss |= lose(&tf[PLAYER][fleet].s, 's', prob);
  loss |= lose(&tf[PLAYER][fleet].c, 'c', prob);
  loss |= lose(&tf[PLAYER][fleet].b, 'b', prob);
  if (!loss) printf("No ships");
  printf(" destroyed.");

  tf[PLAYER][fleet].eta = 1;      /* fool zero tf */
  zero_tf(PLAYER, fleet);
  tf[PLAYER][fleet].eta = 0;      /* fool zero tf */

  left_line[23] = TRUE;

  if (tf[PLAYER][fleet].dest) /* Anything left? */
  {
    tf_stars[tf[PLAYER][fleet].dest][PLAYER]++;
    board[tf[PLAYER][fleet].x][tf[PLAYER][fleet].y].enemy=' ';
    update_board(tf[PLAYER][fleet].x,tf[PLAYER][fleet].y,left);
    stars[tf[PLAYER][fleet].dest].visit[PLAYER]=TRUE;
    point(50,1);
    print_star(tf[PLAYER][fleet].dest);
    clear_field();
  }
  pause();
}

void move_ships()
{
  float ratio;
  int there,dx,dy,i; 
  tteam tm; 
  struct stplanet *pplanet;
  boolean any;
  
  /* clear the board */
  for (i = 1; i<=MAX_FLEETS; i++)
  {
    if ((tf[player][i].dest != 0) && (tf[player][i].eta != 0))
    {
      board[tf[player][i].x][tf[player][i].y].tf = ' ';
      update_board(tf[player][i].x,tf[player][i].y,right);
    }
  }

  /* move ships of both teams */
  for (tm = ENEMY; tm < NONE; tm++)
  {
    for (i=1; i<=MAX_FLEETS; i++)
    {
      if ((tf[tm][i].dest != 0) && (tf[tm][i].eta != 0))
      {
	tf[tm][i].eta--;

	if (tm==player)
	{
	  dx = stars[tf[tm][i].dest].x;
	  dy = stars[tf[tm][i].dest].y;
	  ratio = 1.0 - ((float)tf[tm][i].eta / tf[tm][i].origeta);
	  tf[tm][i].x = tf[tm][i].xf + round(ratio*(dx-tf[tm][i].xf));
	  tf[tm][i].y = tf[tm][i].yf + round(ratio*(dy-tf[tm][i].yf));
	  
	  if (tf[tm][i].eta == 0) /* Update for arrival */
	  {
	    if (!stars[tf[tm][i].dest].visit[tm])
	      fleet_explore(i);
	    else
	      /* Already knew this planet */
	      tf_stars[tf[tm][i].dest][tm]++;
	    if (tf[tm][i].dest != 0) /* Any survivors ? */
	    {
	      pplanet = stars[tf[tm][i].dest].first_planet;
	      while (pplanet != nil) 
	      {
		pplanet->psee_capacity = pplanet->capacity;
		pplanet = pplanet->next;
	      }
	      player_arrivals[tf[tm][i].dest]=true;
	    }
	  }
	}
	if ((tm==ENEMY) && (tf[tm][i].eta==0))
	{
	  pplanet=stars[tf[tm][i].dest].first_planet;
	  stars[tf[tm][i].dest].visit[ENEMY]=true;
	  while (pplanet!=nil)
	  {
	    pplanet->esee_team = pplanet->team;
	    pplanet=pplanet->next;
	  }
	  if (tf_stars[tf[tm][i].dest][ENEMY]>0)
	  {
	    for (there = 1; (tf[ENEMY][there].dest != tf[ENEMY][i].dest) || 
		 (tf[ENEMY][there].eta != 0) || (there == i); there++);
	    joinsilent(ENEMY,&tf[ENEMY][i],&tf[ENEMY][there]);
	  }
	  if ((tf_stars[tf[tm][i].dest][player] > 0) ||
	      (col_stars[tf[tm][i].dest][player] > 0))
	    enemy_arrivals[tf[tm][i].dest]=true;
	  tf_stars[tf[tm][i].dest][tm]++;
	}
      }
    }
  } 

  /* put the good guys on the board */
  for (i=1; i<=MAX_FLEETS; i++)
  {
    if (tf[player][i].dest != 0)
    {
      tf[player][i].blasting = false;
      dx = tf[player][i].x;
      dy = tf[player][i].y;
      if (board[dx][dy].tf == ' ')
	board[dx][dy].tf = i+'a'-1;
      else if (board[dx][dy].tf != i+'a'-1)
	board[dx][dy].tf='*';
      update_board(dx,dy,right);
    }
  }
  any = false;
  for (i = 1; i<=nstars; i++)
  {
    if (player_arrivals[i])
    {
      if (!any)
      {
	point(33,21);
	printf("Player arrivals :               ");
	point(50,21);
	any = true;
      }
      putchar(i+'A'-1);
      player_arrivals[i]=false;
    }
  }
  if ((!any) && (terminal_type != hardcopy))
  {
    point(33,21);
    printf(blank_line);
  }

  any = false;
  for (i = 1; i<=nstars; i++)
  {
    if (enemy_arrivals[i])
    {
      if (!any)
      {
	point(33,22);
	printf("Enemy arrivals  :               ");
	point(50,22);
	any = true;
      }
      putchar(i+'A'-1);
      enemy_arrivals[i]=false;
    }
  }
  if ((! any) && (terminal_type != hardcopy))
  {
    point(33,22);
    printf(blank_line);
  }

  any = false;
  for (i = 1; i<=nstars; i++)
  {
    if (en_departures[i])
    {
      if (!any)
      {
	point(33,23);
	printf("Enemy departures:               ");
	point(50,23);
	any = true;
      }
      putchar(i+'A'-1);
      en_departures[i]=false;
    }
  }
  if ((!any) && (terminal_type != hardcopy))
  {
    point(33,23);
    printf(blank_line);
  }

  for (i = 1; i<=nstars; i++)
    revolt(i);
}

boolean set_des(int tf_num)
{
  int st_num, min_eta, dst, from_star; 
  char istar; 
  float r;

  if (tf[player][tf_num].eta != 0)
  { /* Cancelling previous orders */
    tf[player][tf_num].eta = 0;

    from_star = board[tf[player][tf_num].x][tf[player][tf_num].y].star-'A'+1;
    tf[player][tf_num].dest = from_star;
    tf_stars[from_star][player]++;

    printf("(Cancelling previous orders)");
    point(1,y_cursor + 1);
  }

  printf(" to star:");
  point(10,y_cursor);

  istar = get_char();
  st_num = istar-'A'+1;

  if ((st_num < 0) || (st_num > NUM_STARS))
  {
    error("  !illegal star");
    return(TRUE);
  }

  r = dist(st_num, tf[1][tf_num].dest);
/*
  r=sqrt((float) (((stars[st_num].x-tf[1][tf_num].x)*
		   (stars[st_num].x-tf[1][tf_num].x)) +
		  ((stars[st_num].y-tf[1][tf_num].y) * 
		   (stars[st_num].y-tf[1][tf_num].y))));
*/
  point(1,y_cursor + 1);
  printf("   distance:%5.1f", r);
  dst = r - 0.049 + 1;
  
  /* Only scout can fly so far */
  if ((dst > range[player]) &&
      ((tf[1][tf_num].b != 0) ||
       (tf[1][tf_num].c != 0) ||
       (tf[1][tf_num].t != 0))) 
  {
    error("  !maximum range is %2d", range[player]);
    return(TRUE);
  }
  
  if (r < 0.5)
  {
    point(1, y_cursor + 1);
    printf("Tf remains at star");
    return(TRUE);
  }

  min_eta = ((dst-1) / vel[player]) + 1;
  point(1,y_cursor + 1);
  printf("eta in %2d turns", min_eta);

  tf_stars[tf[player][tf_num].dest][player]--;
  tf[player][tf_num].dest=st_num;
  tf[player][tf_num].eta = min_eta;
  tf[player][tf_num].origeta= tf[player][tf_num].eta;
  tf[player][tf_num].xf= tf[player][tf_num].x;
  tf[player][tf_num].yf=tf[player][tf_num].y;

  return(FALSE);
}
