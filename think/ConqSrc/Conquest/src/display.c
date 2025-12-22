/* Display.c: Displaying all kinds of information */
#include <stdio.h>
#include <stdarg.h>
#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

/* Display forces in tf battle. Return TRUE if any battle must happen */
boolean display_forces(int ennum, int plnum, float *Enodds, float *Plodds)
{
  float enodds, plodds;
  int en_forces = 0, pl_forces = 0;
  
  zero_tf(ENEMY,ennum);
  zero_tf(player,plnum);

  if (tf[ENEMY][ennum].dest != 0)
    en_forces = ((tf[ENEMY][ennum].c*c_guns + tf[ENEMY][ennum].b*b_guns)
		 * weapons[ENEMY]);

  if (tf[player][plnum].dest !=0)
    pl_forces= ((tf[player][plnum].c*c_guns + tf[player][plnum].b*b_guns)
		* weapons[player]);

  point(50,1);
  if (tf[ENEMY][ennum].dest != 0)
    print_star(tf[ENEMY][ennum].dest);
  else if (tf[player][plnum].dest != 0)
    print_star(tf[player][plnum].dest);

  clear_field();

  if (((en_forces == 0) && (pl_forces == 0)) ||
      (tf[ENEMY][ennum].dest == 0) ||
      (tf[player][plnum].dest == 0))
    return(FALSE);

  enodds = ((float)pl_forces) / 
    (en_forces + tf[ENEMY][ennum].t*t_def + tf[ENEMY][ennum].s*s_def);
  enodds = fmin(14.0, enodds);
  enodds = exp((log(0.8)) * enodds);

  plodds = ((float)en_forces) /
     (pl_forces + tf[player][plnum].t*t_def  + tf[player][plnum].s*s_def);
  plodds = fmin(14.0, plodds);
  plodds = exp((log(0.8)) * plodds);
  
  point(1,19);
  printf("enemy %5d", en_forces);
  if (en_forces > 0)
    printf("(weap %2d)", weapons[ENEMY]);
  else
    printf("         ");
  printf("sur: %4.0f", enodds*100.0);
  
  point(1,20);
  printf("player %5d", pl_forces);
  if (pl_forces > 0)
    printf("(weap %2d)", weapons[player]);
  else
    printf("         ");
  printf("sur: %4.0f", plodds*100.0);

  *Enodds = enodds; 
  *Plodds = plodds; 
  return(TRUE);
}

void disp_tf(struct sttf *taskf)
{
  if (taskf->t > 0) printf("%2dt", taskf->t);
  else printf("   ");
  if (taskf->s > 0) printf("%2ds", taskf->s);
  else printf("   ");
  if (taskf->c > 0) printf("%2dc", taskf->c);
  else printf("   ");
  if (taskf->b > 0) printf("%2db", taskf->b);
  else printf("   ");
}

void printmap()
{
  int i1, i2;

  clear_screen();

  for (i1 = BOARD_Y_SIZE ; i1 >= 1; i1--)
  {
    if ((i1 == 1) || (i1%5 == 0))
      printf("%2d|", i1);
    else
      printf("  |");

    for (i2 = 1; i2 <= BOARD_X_SIZE; i2++)
      printf("%c%c%c",board[i2][i1].enemy,board[i2][i1].star,
	     board[i2][i1].tf);
    printf("|\n");
  }

  printf("   ");
  for (i1 = 1 ; i1 <= BOARD_X_SIZE; i1++ )
    printf("---");
  putchar('\n');

  printf("   ");
  for (i1 = 1 ; i1<=bdsize; i1++)
    if ((i1==1) || (i1%5 == 0))
      printf("%2d ", i1);
    else
      printf("   ");
  putchar('\n');

  point(33,18);
  printf("Turn: %3d",turn);
  point(33,19);
  printf("Production yr: %d",production_year);

  bottom_field = 0;
  for (i1 = 19; i1<=24; i1++)
    left_line[i1] = false;
}

void print_col()
{
  int i; 
  tplanet *pplanet;

  printf("olonies:");
  point(50,1);

  for (i= 1 ; i<=nstars; i++)
  {
    pplanet = stars[i].first_planet;
    while (pplanet != nil) 
    {
      if (pplanet->team == player)
      {
	putchar(i+'A'-1);
	if (((y_cursor > 21) && (x_cursor >= 50)) || (y_cursor > 24))
	{
	  pause();
	  clear_field();
	  point(50,1);
	}

	printf("%d:%2d                         ", pplanet->number, 
	       pplanet->psee_capacity);
	point(x_cursor + 5, y_cursor);
	x_cursor = x_cursor - 5;

	printf("(%2d,/%3d)", pplanet->inhabitants, pplanet->iu);
	if (pplanet->conquered)
	  printf("Con");
	else
	  printf("   ");
	if (pplanet->mb != 0)
	  printf("%2dmb", pplanet->mb);
	else
	  printf("    ");
	if (pplanet->amb != 0)
	  printf("%2damb", pplanet->amb);
	
	point(x_cursor,y_cursor + 1);
	
      }
      pplanet=pplanet->next;
    }
  }
  clear_field();
  clear_left();
}

void starsum()
{
  char iline[81];  
  int i,value;  
  char strs;

  printf("tar summary:");
  clear_left();
  point(1,19);
  putchar(':');
  
  get_line(iline);
  strs = get_token(iline,&value);
  point(50,1);

  if (strs == ' ') 
    for (i = 1 ; i <= nstars; i++) print_star(i);
  else 
    do 
    {
      i = strs-'A'+1;
      print_star(i);
      strs = get_token(iline,&value);
    } 
    while (strs != ' ');

  clear_field();
}

void tfsum()
{
  int i, value;  
  char tfs;
  char iline[81];  

  printf("f summary :");
  get_line(iline);
  tfs = get_token(iline,&value);
  point(50,1);

  if (tfs==' ') 
    for (i = 1 ; i<=26; i++) print_tf(i);
  else 
    do 
    {
      i = tfs - 'A' + 1;
      print_tf(i);
      tfs = get_token(iline,&value);
    } 
    while (tfs != ' ');

  clear_field();
  clear_left();
}

void clear_field()
{
  int new_bottom, y;

  new_bottom = y_cursor - 1;
  if (new_bottom < bottom_field)
  {
    for (y = new_bottom + 1; y<=bottom_field; y++) 
    {
      point(50,y);
      switch (terminal_type)
      {
       case adm3:
	printf(blank_line);
	break;
       case vis400:
       case vt52:
	printf("\33[K");
	break;
      }
    }
  }

  bottom_field = new_bottom;
}

void clear_left()
{
  int i;

  if (terminal_type != hardcopy) 
    for (i = 19 ; i<=24; i++)
      if (left_line[i]) 
      {
	switch (terminal_type)
	{
	 case vt52:
	  point(1,i);
	  printf(blank_line);
	  break;
	}
	left_line[i] = false;
      }
}

void clear_screen()
{
  switch (terminal_type) 
  {
   case vis400:
    printf("\33[2J");
    break;
   case vt52: 
    printf("\33[H\33[J");
    break;
   case adm3: 
    putchar('\32'); 
    break;
  }
  point(1,1);
}

void error(char *fmt, ...)
{
  va_list args;

  point(1,24);
  va_start(args, fmt);
  vprintf(fmt, args);
}

void error_message()
{
  point(1,24);
}

void print_tf(int i)
{
  int x, y;

  if ((i!=0) && (i<27)) 
  {
    if (tf[player][i].dest != 0) 
    {
      printf("TF%c:", i+'a'-1);

      x=tf[player][i].x; 
      y=tf[player][i].y;
      if (tf[player][i].eta==0)
	putchar(tf[player][i].dest+'A'-1);
      else
	putchar(' ');
      printf("(%2d,%2d)               ",x,y);

      point(x_cursor + 14, y_cursor);
      x_cursor = x_cursor - 14;
      disp_tf(&tf[player][i]);

      if (tf[player][i].eta != 0)
      {
	printf("%c2m", 0x9b); /* FOO? */
	printf("%c%d", tf[player][i].dest+'A'-1, tf[player][i].eta);
	printf("%c0m", 0x9b);
      }
      point(x_cursor, y_cursor+1);
    }
  }
}

void print_star(int stnum)
{
  boolean see;
  int i, x, y;
  tplanet *p;
  
  if ((stnum != 0) && (stnum <= nstars)) 
  {
    /* FOO: A bit too long? */
    if ((y_cursor+3+tf_stars[stnum][player]+tf_stars[stnum][ENEMY]) > 19) 
    {
      clear_field();
      pause();
      point(50,1);
    }

    if (stars[stnum].visit[player] == true)
    {
      see = false;
      printf("----- star %c -----            ", stnum+'A'-1);
      point(50, y_cursor + 1);

      x = stars[stnum].x;
      y = stars[stnum].y;

      /* Print taskforces */
      if (tf_stars[stnum][player] != 0) 
      {
	see = true;
	for (i=1; i<=26; i++)
	{
	  if ((tf[player][i].dest == stnum) && (tf[player][i].eta == 0))
	  {
	    printf("TF%c                           ", i+'a'-1);
	    point(55,y_cursor);
	    disp_tf(&tf[player][i]);
	    point(50, y_cursor + 1);
	  }
	}
      }

      see |= (col_stars[stnum][player] != 0);

      if (see && (tf_stars[stnum][ENEMY] != 0))
      {
	for (i=1; ((tf[ENEMY][i].eta != 0) ||
		   (tf[ENEMY][i].dest != stnum)); i++)
	  ;

	printf(" EN:                          ");
	point(55,y_cursor);
	disp_tf(&tf[ENEMY][i]);
	point( 50, y_cursor + 1);
      }

      p = stars[stnum].first_planet;

      if (p == NULL) 
      {
	printf("  no useable planets          ");
	point(50,y_cursor + 1);
	return;
      }

      for (;p != NULL; p=p->next, point(x_cursor, y_cursor + 1))
      {
	putchar(' ');
	if (((y_cursor > 21) && (x_cursor >= 50)) ||
	    (y_cursor > 24))
	{
	  pause();
	  clear_field();
	  point(50,1);
	}

	printf("%d:%2d                         ", p->number, p->psee_capacity);
	point(x_cursor + 5, y_cursor);
	x_cursor = x_cursor - 5;

	if (p->psee_capacity == 0)
	{
	  printf(" Decimated");
	  continue;
	}
	switch (p->team)
	{
	 case none:
	  if (see)
	    printf(" No colony");
	  break;
	 case player:
	  printf("(%2d,/%3d)", p->inhabitants, p->iu);

	  if (p->conquered)
	    printf("Con");
	  else
	    printf("   ");

	  if (p->mb != 0)
	    printf("%2dmb", p->mb);
	  else
	    printf("    ");
	  if (p->amb!=0)
	    printf("%2damb", p->amb);
	  break;
	 case ENEMY:
	  if (see)
	  {
	    printf("*EN*");
	    if (p->conquered)
	    {
	      printf("Conquered");
	    } 
	    else
	      printf("   ");

	    if (p->under_attack)
	    {
	      if (p->mb != 0)
		printf("%2dmb", p->mb);
	      else
		printf("    ");
	      if (p->amb != 0)
		printf("%2damb", p->amb);
	    }
	  }
	}
      }
    }
  }
}
