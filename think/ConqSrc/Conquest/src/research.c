/* Research.c: Procedures pertaining to research */

#include <stdio.h>
#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

void ressum()
{
  char key;
  int value;
  char iline[81];

  printf("esearch field(s):");
  get_line(iline);
  key = get_token(iline,&value);
  clear_left();
  if (key==' ')
  {
    print_res('R');
    print_res('V');
    print_res('W');
  } 
  else 
  {
    do
    {
      print_res(key);
      key = get_token(iline,&value);
    } 
    while (key != ' ');
  }
}

void print_res(char field)
{
  switch (field)
  {
   case 'V':
    point(53,18);
    printf("V:%2d",vel[PLAYER]);
    if (vel[player] < MAX_VELOCITY)
      printf(" res: %3d need:%4d",vel_working[PLAYER], vel_req[vel[PLAYER]+1]);
    else printf("                   ");
    break;
   case 'R':
    point( 53,19);
    printf("R:%2d",range[PLAYER]);
    if (range[player] < MAX_RANGE)
      printf(" res: %3d need:%4d",ran_working[PLAYER], ran_req[range[PLAYER]+1]);
    else printf("                   ");
    break;
   case 'W':
    point(53,20);
    printf("W:%2d",weapons[PLAYER]);
    if (weapons[player] < MAX_WEAPONS)
      printf(" res: %3d need:%4d",weap_working[PLAYER], weap_req[weapons[PLAYER]+1]);
    else printf("                   ");
    break;
  } 
}

/* Research up to next breakthrough. Return amount used */
int research_limited(int team, char field, int max_amt)
{
  int used = 0;

  switch (field)
  {
   case 'W':
    if (weapons[team]<MAX_WEAPONS)
    {
      used = min(max_amt, weap_req[weapons[team]+1]-weap_working[team]);
      weap_working[team] += used;
      if (weap_working[team] >= weap_req[weapons[team]+1])
      {
	weapons[team]++;
	if (team==ENEMY)
	{
	  new_research();
	  field = en_research;
	}
	weap_working[team]=0;
      }
    }
    break;
   case 'R':
    if (range[team] < MAX_RANGE)
    {
      used = min(max_amt, ran_req[range[team]+1]-ran_working[team]);
      ran_working[team] += used;
      if (ran_working[team] >= ran_req[range[team]+1])
      {
	range[team]++;
	if (team==ENEMY) 
	{
	  new_research();
	  field = en_research;
	}
	ran_working[team]=0;
      }
    }
    break;
   case 'V':
    if (vel[team] < max_vel)
    {
      used = min(max_amt, vel_req[vel[team]+1]-vel_working[team]);
      vel_working[team] += used;
      if (vel_working[team] >= vel_req[vel[team]+1])
      {
	vel[team]++;
	vel_working[team]=0;
      }
    }
    break;
   default: 
    printf("error!!! in research field %c\n", field);
  } 
  return(used);
}

/* Maybe automagically redraw research here? */
void research(int team, char field, int amt)
{
  int old_amt;

  do
  {
    old_amt = amt;
    amt -= research_limited(team, field, amt);
    if (team==ENEMY)
    {
      new_research();
      field = en_research;
    }
    if (old_amt == amt)
      /* How stupid - invested beyond the limit */
      amt = 0;
  }
  while (amt > 0);
}

void new_research()
{
  if (weapons[ENEMY] < MAX_WEAPONS)
  {
    if (weapons[PLAYER] - weapons[ENEMY] + 5 > rnd(10))
    {
      en_research = 'W';
      return;
    }
  }
  
  if (vel[ENEMY] < MAX_VELOCITY)
  {
    if (range[ENEMY] / vel[ENEMY] > rnd(3))
    {
      en_research = 'V';
      return;
    }
  }
  
  en_research = 'R';
}
