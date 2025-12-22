/* Utils.c: Diverse small utility funcitons that shouldn't lie all over */

#include <stdio.h>
#include <stdlib.h>

#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

double fmin(double a, double b)
{
  return(a<b?a:b);
}

void point(int col, int row)
{
  switch ( terminal_type )
  {
   case adm3: 
    printf("\33=%c%c", row+31, col+31);
    break;
   case vt52: 
    printf("\33[%d;%dH", row, col);
    break;
   case vis400:
    printf("\33[%d;%dH", row, col);
    break;
   case concept:
    printf("\33a%c%c", row+31, col+31);
    break;
   default: 
    putchar('\n');
  }
  x_cursor = col;
  y_cursor = row;
  if ( (x_cursor < 20) && (y_cursor != 18) )
    left_line[y_cursor] = true;
}

/* Relative (dis)placement. Doesn't set x_cursor & y_cursor */
void move(int cols, int rows)
{
  if ((terminal_type == vt52) || (terminal_type == vis400))
  {
    if (cols > 0)
      printf("\33[%dC", cols);
    else if (cols < 0)
      printf("\33[%dD", cols);
  }
}

/* Random integer in [1..i] */
int rnd(int i)
{
  return(rand()%i+1);
}

int round(float x)
{
  return(x<0.0?(int)(x-0.5):(int)(x+.5));
}

int min(int x1, int x2)
{
  return(x1>x2?x2:x1);
}

int max(int x1, int x2)
{
  return(x1<x2?x2:x1);
}

/* Are there any battlestars or cruisers at this star? */
boolean any_bc(tteam team, int starnum)
{
  boolean any;  
  int tf_number;
  
  any = FALSE;
  if (tf_stars[starnum][team]>0) 
  {
    for (tf_number = 1;(!any) && (tf_number <= MAX_FLEETS); tf_number++)
    {
      any = ((tf[team][tf_number].dest==starnum) &&
	     (tf[team][tf_number].eta==0) &&
	     ((tf[team][tf_number].c>0) || (tf[team][tf_number].b>0)));
    }
  }
  return (any);
}

double fact(int k)
{ 
  int res;

  for (res = 1; k > 1; res *= k, k--);
  
  return(res);
}

void swap(int *a, int *b)
{
  int t;
  
  t = *a;
  *a = *b;
  *b = t;
}

int conv_bcd(int nibble, char byte)
{
  if (nibble == 1) return (byte & 0x0f);
  return((byte >> 4) & 0x0f);
}
