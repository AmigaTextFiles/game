/* Taskforce.c: Routines for taskforces */

#include <stdio.h>
#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

void make_tf()
{
  int tf_num, new_tf; 

  printf("ew tf- from tf:");
  tf_num = get_char()-'A'+1;
  clear_left();

  if ((tf_num<1) || (tf_num>26) || (tf[player][tf_num].eta!=0) || 
      (tf[player][tf_num].dest==0))
  {
    error("  !illegal tf");
    return;
  }

  if (tf[player][tf_num].blasting) 
  {
    error(" !Tf is blasting a planet     ");
    return;
  }

  point(1,19);
  new_tf = split_tf(tf_num);
  point(1,20);
  print_tf(new_tf);
  point(1,21);
  print_tf(tf_num);
}

int split_tf(int tf_num)
{
  int new_tf;
  char ships; 
  int x,y,n_ships;
  char iline[81];

  new_tf = get_tf(player,tf[player][tf_num].dest);
  tf_stars[tf[player][tf_num].dest][player]++;

  printf(" ships:");
  point(8,y_cursor);

  get_line(iline);
  ships = get_token(iline,&n_ships);

  if (ships==' ') /* Split entire fleet */
  {
    tf[player][new_tf].s=tf[player][tf_num].s;
    tf[player][new_tf].t=tf[player][tf_num].t;
    tf[player][new_tf].c=tf[player][tf_num].c;
    tf[player][new_tf].b=tf[player][tf_num].b;
    tf[player][tf_num].s=0;
    tf[player][tf_num].t=0;
    tf[player][tf_num].c=0;
    tf[player][tf_num].b=0;
  } 
  else
  {
    do
    {
      switch (ships) 
      {
       case 'T': 
	if (tf[player][tf_num].t < n_ships)
	  n_ships= tf[player][tf_num].t;
	tf[player][tf_num].t=tf[player][tf_num].t-n_ships;
	tf[player][new_tf].t=tf[player][new_tf].t+n_ships;
	break;
       case 'S': 
	if (tf[player][tf_num].s < n_ships)
	  n_ships=tf[player][tf_num].s;
	tf[player][tf_num].s=tf[player][tf_num].s-n_ships;
	tf[player][new_tf].s=tf[player][new_tf].s+n_ships;
	break;
       case 'C': 
	if (tf[player][tf_num].c < n_ships)
	  n_ships=tf[player][tf_num].c;
	tf[player][tf_num].c=tf[player][tf_num].c-n_ships;
	tf[player][new_tf].c=tf[player][new_tf].c+n_ships;
	break;
       case 'B': 
	if (tf[player][tf_num].b < n_ships)
	  n_ships=tf[player][tf_num].b;
	tf[player][tf_num].b=tf[player][tf_num].b-n_ships;
	tf[player][new_tf].b=tf[player][new_tf].b+n_ships;
	break;
       default:
	error("  ! Illegal field %c",ships);
      } /*switch (*/
      ships = get_token(iline,&n_ships);
    } 
    while (ships != ' ');
  }

  x = tf[player][tf_num].x; 
  y = tf[player][tf_num].y;

  zero_tf(player,tf_num);
  zero_tf(player,new_tf);

  on_board(x,y);

  return(new_tf);
}

void join_tf()
{
  char tf1,tf2; 
  int tf1n,tf2n,value;
  char iline[81];

  printf("oin tfs:");
  get_line(iline);
  clear_left();
  tf1 = get_token(iline,&value);
  tf1n=tf1-'A'+1;

  if ((tf1n<1) || (tf1n>26)) 
  {
    error("  ! illegal tf %c",tf1);
    return;
  }
  if ((tf[player][tf1n].eta)>0) 
  {
    error("  !tf%c is not in normal space ", tf1);
    return;
  }
  if (tf[player][tf1n].dest==0) 
  {
    error("  !nonexistent tf");
    return;
  }
  if (tf[player][tf1n].blasting)
  {
    error("  !Tf is blasting a planet    ");
    return;
  }

  while ((tf2 = get_token(iline, &value)) != ' ')
  {
    tf2n = tf2-'A'+1;
    if ((tf2n<1) || (tf2n>26)) 
    {
      error("  !illegal tf %c",tf2);
      continue;
    }
    if (tf2n == tf1n) 
    {
      error("!Duplicate tf %c",tf2);
      continue;
    }
    else if ((tf[player][tf2n].dest == 0)) 
    {
      error("!Nonexistant TF%c",tf2);
      continue;
    }
    if ((tf[player][tf2n].x!=tf[player][tf1n].x) ||
	(tf[player][tf2n].y!= tf[player][tf2n].y))
    {
      error("  !tf%c bad location", tf2);
      continue;
    }
    else if (tf[player][tf2n].eta != 0)
    {
      error("  !tf%c is not in normal space ", tf2);
      continue;
    }
    if (tf[player][tf2n].blasting) 
    {
      error(" !Tf%c is blasting a planet    ", tf2);
      continue;
    }
    joinsilent(player,&tf[player][tf1n],&tf[player][tf2n]);
  }
  on_board(tf[player][tf1n].x,tf[player][tf1n].y);
  point(1,19);
  print_tf(tf1n);
}

int get_tf(tteam tm, int starnum)
{
  int i;

  for (i=1; (i<=MAX_FLEETS) && (tf[tm][i].dest != 0); i++);
  if (i==27) return(0);

  tf[tm][i].s = 0;
  tf[tm][i].t = 0;
  tf[tm][i].c = 0;
  tf[tm][i].b = 0;
  tf[tm][i].eta = 0;
  tf[tm][i].x = stars[starnum].x;
  tf[tm][i].y = stars[starnum].y;
  tf[tm][i].xf = tf[tm][i].x;
  tf[tm][i].yf = tf[tm][i].y;
  tf[tm][i].dest = starnum;
  tf[tm][i].origeta = 0;
  tf[tm][i].blasting = false;
  
  return(i);
}

void joinsilent(tteam team, struct sttf *parent, struct sttf *child)
{
  parent->t = parent->t + child->t;
  parent->s = parent->s + child->s;
  parent->c = parent->c + child->c;
  parent->b = parent->b + child->b;

  if ((parent->dest!=0) && (child->dest!=0))
    tf_stars[parent->dest][team]--;

  child->dest = 0;
}
