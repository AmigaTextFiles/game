/* Input.c: Inputting routines */
#include <stdio.h>
#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

char get_char()
{
  char result;

  fread(&result, 1, 1, raw_fd);
  if (result == 0x0d)
    result = '\n';

  printf("%c", toupper(result));

  return(toupper(result));
}

void get_line(char *iline)
{
  char ch;
  int ind;
  
  ind=0;
  do
  {
    ch = get_char();
    if (ch == '\b') 
    { /*backspace*/
      if (ind > 0)
      {
	putchar(' ');
	putchar('\b');
	/* Erase old char */
	putchar(' ');
	putchar('\b');
	ind = ind - 1;
      }
      else
	move(1,0);
    } 
    else if (ch != '\n') 
    {
      iline[ind] = ch;
      ind = ind + 1;
    }
  }
  while (ind < 25 && ch != '\n');

  iline[ind] = 0;
}

float dist(int star1, int star2)
{
  register int square;

  square = 
    abs(stars[star1].x-stars[star2].x)*abs(stars[star1].x-stars[star2].x)+
      abs(stars[star1].y-stars[star2].y)*abs(stars[star1].y-stars[star2].y);

  return(sqrt((float)square));
}

int get_stars(int s_star, float slist[])
{
  int starnum, count;
  
  count = 0;
  for (starnum = 1 ; starnum <= nstars; starnum++) 
  {
    /* Fudge a bit to avoid doing long squareroots */
    if (range[0] >= (slist[starnum] = dist(s_star,starnum)))
      count++;
    else
      slist[starnum] = 0;
  }
  return(count);
}

char get_token(char *line, int *Value)
{
  int index, value; 
  char token;

  index = 0;
  value = 0;
  token = ' ';
  while (isspace(line[index])) index++;

  if (line[index])
  {
    if ((line[index] < '0') || (line[index] > '9'))
      value = 1;
    else 
    {
      while ((line[index] >= '0') && (line[index] <= '9')) 
      {
	value = 10*value + line[index] - '0';
	index++;
      }
    }
    token = line[index];
    index++;
  }

  while (isspace(line[index])) index++;
  if (line[index]) /* Still something left */
    strcpy(line, &line[index]);
  else
    line[0] = 0;

  *Value = value; 
  return(token);
}
